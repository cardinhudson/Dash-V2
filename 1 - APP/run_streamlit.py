"""
Script para executar o Dashboard KE5Z via Streamlit
"""
import os
import sys
import subprocess

def run_streamlit():
    """Executa o Streamlit"""
    # Obter o diretório do script
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Arquivo principal do dashboard
    dashboard_file = os.path.join(script_dir, "dashboard_main.py")
    
    # Verificar se o arquivo existe
    if not os.path.exists(dashboard_file):
        print(f"ERRO: {dashboard_file} não encontrado!")
        input("Pressione ENTER para sair...")
        sys.exit(1)
    
    # Executar Streamlit
    try:
        subprocess.run([
            sys.executable,
            "-m",
            "streamlit",
            "run",
            dashboard_file,
            "--server.port",
            "8501"
        ])
    except Exception as e:
        print(f"ERRO ao executar Streamlit: {e}")
        input("Pressione ENTER para sair...")
        sys.exit(1)

if __name__ == "__main__":
    run_streamlit()

