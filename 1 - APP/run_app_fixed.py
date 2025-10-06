# Launcher para o Dashboard KE5Z - Sem emojis para evitar problemas de encoding
import os
import sys

def run_streamlit_app(app_path: str) -> None:
    """Executa o Streamlit via API programática."""
    try:
        from streamlit.web import bootstrap as st_bootstrap
        st_bootstrap.run(app_path, command_line="", args=[], flag_options={})
    except Exception:
        # Fallback: chama via CLI
        os.execvp(sys.executable, [sys.executable, "-m", "streamlit", "run", app_path])

def main() -> None:
    base_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Adicionar diretório atual ao path para imports locais
    if base_dir not in sys.path:
        sys.path.insert(0, base_dir)
    
    # Procurar o script principal
    app_script = os.path.join(base_dir, "dashboard_main.py")
    
    if not os.path.exists(app_script):
        print("ERRO: Arquivo dashboard_main.py nao encontrado!")
        sys.exit(1)
    
    print("Iniciando Dashboard KE5Z...")
    run_streamlit_app(app_script)

if __name__ == "__main__":
    main()

