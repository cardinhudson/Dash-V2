#!/usr/bin/env python3
"""
Script de teste para verificar se a extração funciona
"""
import sys
import os
import pandas as pd

print("=== TESTE DE EXTRAÇÃO ===")
print(f"Python: {sys.executable}")
print(f"Diretório: {os.getcwd()}")

# Verificar se estamos dentro do executável
if hasattr(sys, '_MEIPASS'):
    print(f"Executando dentro do PyInstaller: {sys._MEIPASS}")
    base_dir = sys._MEIPASS
else:
    print("Executando normalmente")
    base_dir = os.getcwd()

print(f"Diretório base: {base_dir}")

# Verificar arquivos necessários
arquivos_necessarios = [
    "Dados SAPIENS.xlsx",
    "Fornecedores.xlsx",
    "Extracao.py"
]

print("\n=== VERIFICANDO ARQUIVOS ===")
for arquivo in arquivos_necessarios:
    caminho = os.path.join(base_dir, arquivo)
    existe = os.path.exists(caminho)
    print(f"{arquivo}: {'✅' if existe else '❌'} - {caminho}")

# Verificar pastas necessárias
pastas_necessarias = [
    "Extracoes/KE5Z",
    "Extracoes/KSBB",
    "KE5Z",
    "arquivos"
]

print("\n=== VERIFICANDO PASTAS ===")
for pasta in pastas_necessarias:
    caminho = os.path.join(base_dir, pasta)
    existe = os.path.exists(caminho)
    print(f"{pasta}: {'✅' if existe else '❌'} - {caminho}")

print("\n=== TESTE CONCLUÍDO ===")
print("Se todos os arquivos e pastas estão ✅, a extração deve funcionar.")
