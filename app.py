#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Dashboard KE5Z - Aplicação Principal
====================================

Este arquivo redireciona para o dashboard principal localizado na pasta '1 - APP'.
Para executar o dashboard, use: streamlit run dashboard_main.py

Ou execute diretamente o executável: 1 - APP\dist\Dashboard_KE5Z\Dashboard_KE5Z.exe
"""

import subprocess
import sys
import os

def main():
    """Executa o dashboard principal"""
    # Caminho para o dashboard principal
    dashboard_path = os.path.join("1 - APP", "dashboard_main.py")
    
    if os.path.exists(dashboard_path):
        print("🚀 Iniciando Dashboard KE5Z...")
        print("📁 Usando arquivo principal:", dashboard_path)
        
        # Executa o Streamlit
        subprocess.run([
            sys.executable, "-m", "streamlit", "run", dashboard_path,
            "--server.port", "8501",
            "--server.headless", "false"
        ])
    else:
        print("❌ Arquivo dashboard principal não encontrado!")
        print("📁 Procurado em:", os.path.abspath(dashboard_path))
        print("💡 Execute: streamlit run 1 - APP/dashboard_main.py")

if __name__ == "__main__":
    main()
