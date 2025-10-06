#!/usr/bin/env python3
"""
Teste simples para verificar execução do Extracao.py
"""
import subprocess
import sys
import os

print("=== TESTE DE EXECUÇÃO DO EXTRACAO.PY ===")

# Obter diretório base
if hasattr(sys, '_MEIPASS'):
    base_dir = sys._MEIPASS
    print(f"Executando dentro do PyInstaller: {base_dir}")
else:
    base_dir = os.getcwd()
    print(f"Executando normalmente: {base_dir}")

# Caminho para o script
script_path = os.path.join(base_dir, "Extracao.py")
print(f"Script: {script_path}")
print(f"Existe: {os.path.exists(script_path)}")

if os.path.exists(script_path):
    print("\n=== EXECUTANDO SCRIPT ===")
    try:
        # Executar o script
        result = subprocess.run(
            [sys.executable, script_path],
            cwd=base_dir,
            capture_output=True,
            text=True,
            timeout=30
        )
        
        print(f"Código de retorno: {result.returncode}")
        print(f"STDOUT:\n{result.stdout}")
        if result.stderr:
            print(f"STDERR:\n{result.stderr}")
            
    except subprocess.TimeoutExpired:
        print("❌ Script demorou mais de 30 segundos - possivelmente travou")
    except Exception as e:
        print(f"❌ Erro ao executar: {e}")
else:
    print("❌ Script Extracao.py não encontrado!")

print("\n=== TESTE CONCLUÍDO ===")
