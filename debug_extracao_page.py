#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Debug detalhado da página de extração
"""

import os
import sys
import traceback
import subprocess

def debug_extracao_page():
    """Debug detalhado da página de extração"""
    print("🔍 DEBUG DETALHADO DA PÁGINA DE EXTRAÇÃO")
    print("=" * 60)
    
    # 1. Verificar encoding do arquivo
    print("1. Verificando encoding do arquivo...")
    try:
        with open('pages/6_Extracao_Dados.py', 'rb') as f:
            content = f.read()
        print(f"   Tamanho do arquivo: {len(content)} bytes")
        
        # Tentar diferentes encodings
        encodings = ['utf-8', 'cp1252', 'latin1', 'iso-8859-1']
        for encoding in encodings:
            try:
                with open('pages/6_Extracao_Dados.py', 'r', encoding=encoding) as f:
                    test_content = f.read()
                print(f"   ✅ Encoding {encoding}: OK")
                break
            except Exception as e:
                print(f"   ❌ Encoding {encoding}: {e}")
    except Exception as e:
        print(f"   ❌ Erro ao ler arquivo: {e}")
    
    # 2. Verificar se há caracteres problemáticos
    print("\n2. Verificando caracteres problemáticos...")
    try:
        with open('pages/6_Extracao_Dados.py', 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Procurar por caracteres não-ASCII
        non_ascii = []
        for i, char in enumerate(content):
            if ord(char) > 127:
                non_ascii.append((i, char, ord(char)))
                if len(non_ascii) > 10:  # Limitar para não sobrecarregar
                    break
        
        if non_ascii:
            print(f"   ⚠️  Encontrados {len(non_ascii)} caracteres não-ASCII:")
            for pos, char, code in non_ascii[:5]:
                print(f"     Posição {pos}: '{char}' (código {code})")
        else:
            print("   ✅ Nenhum caractere problemático encontrado")
    except Exception as e:
        print(f"   ❌ Erro ao verificar caracteres: {e}")
    
    # 3. Testar importação da página
    print("\n3. Testando importação da página...")
    try:
        # Adicionar o diretório atual ao path
        sys.path.insert(0, '.')
        
        # Tentar importar módulo por módulo
        print("   Testando importações básicas...")
        import streamlit as st
        print("   ✅ streamlit importado")
        
        import pandas as pd
        print("   ✅ pandas importado")
        
        import os
        print("   ✅ os importado")
        
        # Tentar importar a página
        print("   Testando importação da página...")
        import importlib.util
        spec = importlib.util.spec_from_file_location("extracao_page", "pages/6_Extracao_Dados.py")
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        print("   ✅ Página importada com sucesso")
        
    except Exception as e:
        print(f"   ❌ Erro na importação: {e}")
        print("   Traceback completo:")
        traceback.print_exc()
    
    # 4. Testar execução do Extração.py via subprocess
    print("\n4. Testando execução do Extração.py...")
    try:
        result = subprocess.run(
            [sys.executable, "Extração.py"],
            capture_output=True,
            text=True,
            timeout=10,
            encoding='cp1252',
            errors='replace'
        )
        print(f"   Código de saída: {result.returncode}")
        if result.returncode == 0:
            print("   ✅ Extração.py executou com sucesso")
        else:
            print("   ❌ Extração.py falhou")
            print(f"   Stderr: {result.stderr[:300]}...")
    except subprocess.TimeoutExpired:
        print("   ⏰ Extração.py demorou mais de 10 segundos (pode ser normal)")
    except Exception as e:
        print(f"   ❌ Erro ao executar Extração.py: {e}")
    
    # 5. Verificar se o dashboard está rodando
    print("\n5. Verificando status do dashboard...")
    try:
        import requests
        response = requests.get("http://localhost:8502", timeout=5)
        print(f"   Status HTTP: {response.status_code}")
        if response.status_code == 200:
            print("   ✅ Dashboard está respondendo")
        else:
            print("   ❌ Dashboard não está respondendo corretamente")
    except ImportError:
        print("   ⚠️  requests não disponível, verificando via netstat...")
        try:
            result = subprocess.run(["netstat", "-an"], capture_output=True, text=True)
            if ":8502" in result.stdout:
                print("   ✅ Dashboard está rodando na porta 8502")
            else:
                print("   ❌ Dashboard não está rodando")
        except Exception as e:
            print(f"   ❌ Erro ao verificar netstat: {e}")
    except Exception as e:
        print(f"   ❌ Erro ao verificar dashboard: {e}")
    
    print("\n" + "=" * 60)
    print("DEBUG CONCLUÍDO")

if __name__ == "__main__":
    debug_extracao_page()
