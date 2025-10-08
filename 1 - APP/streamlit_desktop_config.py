#!/usr/bin/env python3
"""
Configuração para Streamlit Desktop App
Este arquivo configura o aplicativo para funcionar como um app desktop nativo
"""

import os
import sys
from pathlib import Path

# Configurações específicas para Streamlit Desktop
os.environ['STREAMLIT_SERVER_HEADLESS'] = 'true'
os.environ['STREAMLIT_BROWSER_GATHER_USAGE_STATS'] = 'false'
os.environ['STREAMLIT_SERVER_ADDRESS'] = 'localhost'
os.environ['STREAMLIT_SERVER_ENABLECORS'] = 'false'
os.environ['STREAMLIT_SERVER_ENABLE_XSRF_PROTECTION'] = 'false'
os.environ['STREAMLIT_GLOBAL_DEVELOPMENT_MODE'] = 'false'

# Desabilitar abertura automática do navegador (será controlado pelo desktop app)
os.environ['BROWSER'] = 'none'

# Configurar caminhos para dados
if hasattr(sys, '_MEIPASS'):
    # Dentro do executável PyInstaller
    base_dir = sys._MEIPASS
else:
    # Em desenvolvimento
    base_dir = os.path.dirname(os.path.abspath(__file__))

# Configurar variáveis de ambiente para caminhos
os.environ['DASHBOARD_DATA_DIR'] = base_dir
os.environ['DASHBOARD_EXTRA_DIR'] = os.path.join(base_dir, 'Extracoes')
os.environ['DASHBOARD_KE5Z_DIR'] = os.path.join(base_dir, 'KE5Z')

print(f"Streamlit Desktop configurado - Base dir: {base_dir}")

# Importar e executar o app principal
if __name__ == "__main__":
    import streamlit.web.cli as stcli
    
    # Configurar argumentos para o Streamlit
    sys.argv = [
        "streamlit",
        "run",
        os.path.join(base_dir, "app.py"),
        "--server.headless", "true",
        "--server.address", "localhost",
        "--server.port", "8501",
        "--browser.gatherUsageStats", "false"
    ]
    
    stcli.main()
