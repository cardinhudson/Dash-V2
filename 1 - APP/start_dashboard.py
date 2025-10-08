import os
import sys
from pathlib import Path

# Inicializador oficial via CLI do Streamlit em modo headless
def main() -> None:
    # Resolve caminho do app tanto em dev quanto dentro do PyInstaller
    if hasattr(sys, "_MEIPASS") and sys._MEIPASS:
        app_path = Path(sys._MEIPASS) / "dashboard_main.py"
    else:
        app_path = Path(__file__).with_name("dashboard_main.py")

    # Configuração mínima e estável
    os.environ["STREAMLIT_BROWSER_GATHER_USAGE_STATS"] = "false"
    os.environ["STREAMLIT_SERVER_ADDRESS"] = "localhost"
    os.environ["STREAMLIT_SERVER_ENABLECORS"] = "false"
    os.environ["STREAMLIT_SERVER_ENABLE_XSRF_PROTECTION"] = "false"
    os.environ["STREAMLIT_GLOBAL_DEVELOPMENT_MODE"] = "false"
    os.environ["BROWSER"] = "none"

    from streamlit.web.cli import main as stcli

    # Sem porta fixa (evita conflitos). Streamlit escolhe automaticamente.
    sys.argv = [
        "streamlit",
        "run",
        str(app_path),
        "--server.headless",
        "true",
        "--server.address",
        "localhost",
    ]

    stcli()


if __name__ == "__main__":
    main()
