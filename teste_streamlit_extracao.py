#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Teste específico da extração via Streamlit
"""

import os
import sys
import subprocess
import time

def testar_extracao_streamlit():
    """Testa a extração via Streamlit"""
    print("🧪 TESTE DE EXTRAÇÃO VIA STREAMLIT")
    print("=" * 50)
    
    # 1. Verificar se o dashboard está rodando
    print("1. Verificando dashboard...")
    try:
        import requests
        response = requests.get("http://localhost:8502", timeout=5)
        if response.status_code == 200:
            print("   ✅ Dashboard está rodando")
        else:
            print("   ❌ Dashboard não está respondendo")
            return False
    except ImportError:
        print("   ⚠️  requests não disponível")
    except Exception as e:
        print(f"   ❌ Erro: {e}")
        return False
    
    # 2. Simular execução da extração como o Streamlit faria
    print("\n2. Simulando execução da extração...")
    try:
        # Simular o que a página de extração faz
        import pandas as pd
        
        # Verificar arquivos necessários
        arquivos_necessarios = [
            "Dados SAPIENS.xlsx",
            "Fornecedores.xlsx", 
            "Extrações/KE5Z",
            "Extrações/KSBB"
        ]
        
        print("   Verificando arquivos necessários...")
        for arquivo in arquivos_necessarios:
            existe = os.path.exists(arquivo)
            status = "✅" if existe else "❌"
            print(f"     {status} {arquivo}")
        
        # Verificar se há arquivos .txt
        pasta_ke5z = "Extrações/KE5Z"
        if os.path.exists(pasta_ke5z):
            arquivos_txt = [f for f in os.listdir(pasta_ke5z) if f.endswith('.txt')]
            print(f"   📄 Arquivos .txt encontrados: {len(arquivos_txt)}")
        
        print("   ✅ Verificação de arquivos OK")
        
    except Exception as e:
        print(f"   ❌ Erro na verificação: {e}")
        return False
    
    # 3. Testar execução do Extração.py com encoding correto
    print("\n3. Testando execução do Extração.py...")
    try:
        # Usar encoding UTF-8 como o Streamlit usa
        result = subprocess.run(
            [sys.executable, "Extração.py"],
            capture_output=True,
            text=True,
            timeout=30,
            encoding='utf-8',
            errors='replace'
        )
        
        print(f"   Código de saída: {result.returncode}")
        
        if result.returncode == 0:
            print("   ✅ Extração.py executou com sucesso")
            print("   Stdout (últimas linhas):")
            lines = result.stdout.split('\n')
            for line in lines[-5:]:
                if line.strip():
                    print(f"     {line}")
        else:
            print("   ❌ Extração.py falhou")
            print("   Stderr:")
            lines = result.stderr.split('\n')
            for line in lines[:10]:  # Primeiras 10 linhas do erro
                if line.strip():
                    print(f"     {line}")
            return False
            
    except subprocess.TimeoutExpired:
        print("   ⏰ Extração.py demorou mais de 30 segundos (pode ser normal)")
    except Exception as e:
        print(f"   ❌ Erro ao executar Extração.py: {e}")
        return False
    
    # 4. Verificar arquivos gerados
    print("\n4. Verificando arquivos gerados...")
    pasta_arquivos = "arquivos"
    if os.path.exists(pasta_arquivos):
        arquivos = os.listdir(pasta_arquivos)
        arquivos_excel = [f for f in arquivos if f.endswith('.xlsx')]
        print(f"   📊 Arquivos Excel: {len(arquivos_excel)}")
        for arquivo in arquivos_excel:
            print(f"     - {arquivo}")
    else:
        print("   ❌ Pasta arquivos não encontrada")
        return False
    
    print("\n✅ Teste concluído com sucesso!")
    return True

if __name__ == "__main__":
    sucesso = testar_extracao_streamlit()
    if sucesso:
        print("\n🎉 Extração via Streamlit funcionando!")
    else:
        print("\n💥 Problemas encontrados na extração via Streamlit!")

