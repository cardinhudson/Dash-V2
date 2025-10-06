#!/usr/bin/env python3
"""
Script de extração otimizado para não travar
"""
import sys
import os
import pandas as pd
from pathlib import Path

print("=== EXTRAÇÃO OTIMIZADA ===")

# Obter diretório base
if hasattr(sys, '_MEIPASS'):
    base_dir = sys._MEIPASS
    print(f"Executando dentro do PyInstaller: {base_dir}")
else:
    base_dir = os.getcwd()
    print(f"Executando normalmente: {base_dir}")

# Usar pasta local do projeto: Extracoes\KE5Z
pasta = os.path.join(base_dir, "Extracoes", "KE5Z")

# Verificar se a pasta local existe
if not os.path.exists(pasta):
    print(f"ERRO: Pasta local {pasta} não encontrada!")
    print(f"Pasta procurada: {os.path.abspath(pasta)}")
    print("Criando pasta local...")
    os.makedirs(pasta, exist_ok=True)
    print(f"Pasta local criada: {os.path.abspath(pasta)}")
    print("Coloque os arquivos .txt na pasta Extracoes/KE5Z/ do projeto")
    sys.exit(1)

print(f"Pasta encontrada: {pasta}")

# Lista para armazenar os DataFrames
dataframes = []

# Iterar sobre todos os arquivos na pasta
arquivos_txt = [f for f in os.listdir(pasta) if f.endswith('.txt')]
print(f"Arquivos .txt encontrados: {len(arquivos_txt)}")

if len(arquivos_txt) == 0:
    print("❌ Nenhum arquivo .txt encontrado na pasta Extracoes/KE5Z/")
    print("Coloque os arquivos .txt na pasta e tente novamente.")
    sys.exit(1)

for i, arquivo in enumerate(arquivos_txt, 1):
    caminho_arquivo = os.path.join(pasta, arquivo)
    
    print(f"\n[{i}/{len(arquivos_txt)}] Processando: {arquivo}")
    print(f"Caminho: {caminho_arquivo}")
    
    try:
        # Verificar tamanho do arquivo
        tamanho_mb = os.path.getsize(caminho_arquivo) / (1024 * 1024)
        print(f"Tamanho: {tamanho_mb:.1f} MB")
        
        if tamanho_mb > 500:  # Arquivos muito grandes
            print(f"⚠️ Arquivo muito grande ({tamanho_mb:.1f} MB). Processando em chunks...")
            
            # Processar em chunks para arquivos grandes
            chunk_size = 50000  # 50k linhas por vez
            chunks = []
            
            for chunk in pd.read_csv(
                caminho_arquivo, 
                sep='\t', 
                skiprows=9,
                encoding='latin1', 
                engine='c',
                low_memory=False,
                chunksize=chunk_size
            ):
                # Processar chunk
                if len(chunk) > 0:
                    # Limpar dados
                    if ' Ano' in chunk.columns:
                        chunk = chunk[chunk[' Ano'].notna() & (chunk[' Ano'] != 0)]
                    
                    # Converter colunas numéricas
                    for col in ['         Em MCont.', '         Qtd.']:
                        if col in chunk.columns:
                            chunk[col] = (
                                chunk[col]
                                .astype(str)
                                .str.replace('.', '', regex=False)
                                .str.replace(',', '.', regex=False)
                            )
                            chunk[col] = pd.to_numeric(chunk[col], errors='coerce').fillna(0)
                    
                    chunks.append(chunk)
                    print(f"  Processado chunk: {len(chunk)} registros")
            
            if chunks:
                df = pd.concat(chunks, ignore_index=True)
                print(f"Total processado: {len(df)} registros")
            else:
                print("❌ Nenhum dado válido encontrado no arquivo")
                continue
                
        else:
            # Processar arquivo normalmente
            print("Carregando dados...")
            df = pd.read_csv(
                caminho_arquivo, 
                sep='\t', 
                skiprows=9,
                encoding='latin1', 
                engine='c',
                low_memory=False
            )
            print(f"Carregado: {len(df):,} registros, {len(df.columns)} colunas")
            
            # Filtrar a coluna ' Ano' com valores não nulos e diferentes de 0
            if ' Ano' in df.columns:
                df = df[df[' Ano'].notna() & (df[' Ano'] != 0)]
            print(f"Após filtro Ano: {len(df):,} registros")
            
            # Converter colunas numéricas
            for col in ['         Em MCont.', '         Qtd.']:
                if col in df.columns:
                    df[col] = (
                        df[col]
                        .astype(str)
                        .str.replace('.', '', regex=False)
                        .str.replace(',', '.', regex=False)
                    )
                    df[col] = pd.to_numeric(df[col], errors='coerce').fillna(0)
        
        # Renomear coluna
        if len(df.columns) > 9:
            df.rename(columns={df.columns[9]: 'doc.ref'}, inplace=True)
        
        # Limpar nomes das colunas
        df.columns = df.columns.str.strip()
        
        # Adicionar o DataFrame à lista
        dataframes.append(df)
        print(f"✅ {arquivo} processado com sucesso!")
        
        # Imprimir o valor total da coluna '         Em MCont.'
        if '         Em MCont.' in df.columns:
            total_em_mcont = df['         Em MCont.'].sum()
            print(f"Total Em MCont. em {arquivo}: {total_em_mcont:,.2f}")
        
    except Exception as e:
        print(f"❌ Erro ao processar {arquivo}: {str(e)}")
        continue

# Concatenar todos os DataFrames em um único
if dataframes:
    print(f"\n=== CONCATENANDO {len(dataframes)} DATAFRAMES ===")
    df_total = pd.concat(dataframes, ignore_index=True)
    print(f"Total de registros: {len(df_total):,}")
else:
    print("❌ Nenhum arquivo .txt processado com sucesso.")
    sys.exit(1)

# Renomear coluna
df_total.rename(columns={'         Em MCont.': 'Valor'}, inplace=True)

# Filtrar coluna Nº conta
df_total = df_total[df_total['Nº conta'].notna() & (df_total['Nº conta'] != 0)]
print(f"Após filtro Nº conta: {len(df_total):,} registros")

# Limpar dados problemáticos para parquet
print("Limpando dados para salvar parquet...")
df_total = df_total.fillna('')  # Substituir NaN por string vazia
df_total = df_total.astype(str)  # Converter tudo para string
print("Dados limpos para parquet")

# Salvar arquivo parquet
pasta_parquet = os.path.join(base_dir, "KE5Z")
os.makedirs(pasta_parquet, exist_ok=True)

caminho_saida = os.path.join(pasta_parquet, 'KE5Z.parquet')
df_total.to_parquet(caminho_saida, index=False)
print(f"✅ Arquivo salvo: {caminho_saida}")

# Salvar arquivo Excel (amostra)
caminho_excel = os.path.join(pasta_parquet, 'KE5Z.xlsx')
df_total.head(10000).to_excel(caminho_excel, index=False)
print(f"✅ Arquivo Excel salvo: {caminho_excel}")

print("\n=== EXTRAÇÃO CONCLUÍDA COM SUCESSO! ===")
print(f"Total de registros processados: {len(df_total):,}")
print(f"Arquivos gerados:")
print(f"  - {caminho_saida}")
print(f"  - {caminho_excel}")
