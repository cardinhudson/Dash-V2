#!/usr/bin/env python3
"""
Verificar colunas dos arquivos .txt
"""
import pandas as pd
import os

pasta = "Extracoes/KE5Z"
arquivos_txt = [f for f in os.listdir(pasta) if f.endswith('.txt')]

print(f"Arquivos encontrados: {len(arquivos_txt)}")

for arquivo in arquivos_txt[:1]:  # Verificar apenas o primeiro
    caminho = os.path.join(pasta, arquivo)
    print(f"\n=== {arquivo} ===")
    
    # Ler apenas as primeiras linhas para ver as colunas
    df = pd.read_csv(
        caminho, 
        sep='\t', 
        skiprows=9,
        encoding='latin1', 
        nrows=5  # Apenas 5 linhas
    )
    
    print(f"Colunas ({len(df.columns)}):")
    for i, col in enumerate(df.columns):
        print(f"  {i}: '{col}'")
    
    print(f"\nPrimeiras linhas:")
    print(df.head())
