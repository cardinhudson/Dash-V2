#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
INSTALADOR AUTOMÁTICO - DASHBOARD KE5Z
=====================================

Este script instala automaticamente todas as dependências necessárias
para executar o Dashboard KE5Z.

Autor: Sistema Automático
Data: 2025
"""

import os
import sys
import subprocess
import platform
import urllib.request
import zipfile
import shutil
from pathlib import Path

class DashboardInstaller:
    def __init__(self):
        self.project_dir = Path(__file__).parent
        self.venv_dir = self.project_dir / "venv"
        self.python_exe = None
        self.pip_exe = None
        
    def print_header(self):
        """Imprime o cabeçalho do instalador"""
        print("=" * 60)
        print("🚀 INSTALADOR AUTOMÁTICO - DASHBOARD KE5Z")
        print("=" * 60)
        print("Este instalador irá configurar automaticamente:")
        print("• Ambiente Python virtual")
        print("• Todas as dependências necessárias")
        print("• Configurações do sistema")
        print("• Executável do Dashboard")
        print("=" * 60)
        print()
        
    def check_python(self):
        """Verifica se o Python está instalado"""
        print("🔍 Verificando instalação do Python...")
        
        try:
            version = sys.version_info
            print(f"✅ Python {version.major}.{version.minor}.{version.micro} encontrado")
            
            if version.major < 3 or (version.major == 3 and version.minor < 8):
                print("❌ ERRO: Python 3.8 ou superior é necessário!")
                print("Por favor, instale Python 3.8+ de: https://python.org")
                input("Pressione Enter para sair...")
                sys.exit(1)
                
            return True
            
        except Exception as e:
            print(f"❌ ERRO: Python não encontrado: {e}")
            print("Por favor, instale Python de: https://python.org")
            input("Pressione Enter para sair...")
            sys.exit(1)
    
    def create_virtual_environment(self):
        """Cria o ambiente virtual Python"""
        print("📦 Criando ambiente virtual Python...")
        
        try:
            if self.venv_dir.exists():
                print("🗑️ Removendo ambiente virtual existente...")
                shutil.rmtree(self.venv_dir)
            
            # Criar ambiente virtual
            subprocess.run([
                sys.executable, "-m", "venv", str(self.venv_dir)
            ], check=True, capture_output=True)
            
            # Definir caminhos dos executáveis
            if platform.system() == "Windows":
                self.python_exe = self.venv_dir / "Scripts" / "python.exe"
                self.pip_exe = self.venv_dir / "Scripts" / "pip.exe"
            else:
                self.python_exe = self.venv_dir / "bin" / "python"
                self.pip_exe = self.venv_dir / "bin" / "pip"
            
            print("✅ Ambiente virtual criado com sucesso!")
            return True
            
        except subprocess.CalledProcessError as e:
            print(f"❌ ERRO ao criar ambiente virtual: {e}")
            return False
        except Exception as e:
            print(f"❌ ERRO inesperado: {e}")
            return False
    
    def upgrade_pip(self):
        """Atualiza o pip para a versão mais recente"""
        print("⬆️ Atualizando pip...")
        
        try:
            subprocess.run([
                str(self.python_exe), "-m", "pip", "install", "--upgrade", "pip"
            ], check=True, capture_output=True)
            print("✅ pip atualizado com sucesso!")
            return True
            
        except subprocess.CalledProcessError as e:
            print(f"⚠️ Aviso: Não foi possível atualizar o pip: {e}")
            return True  # Continua mesmo se falhar
    
    def install_requirements(self):
        """Instala as dependências do requirements.txt"""
        print("📚 Instalando dependências...")
        
        requirements_file = self.project_dir / "requirements.txt"
        
        if not requirements_file.exists():
            print("❌ ERRO: Arquivo requirements.txt não encontrado!")
            return False
        
        try:
            # Instalar dependências
            subprocess.run([
                str(self.pip_exe), "install", "-r", str(requirements_file)
            ], check=True)
            
            print("✅ Dependências instaladas com sucesso!")
            return True
            
        except subprocess.CalledProcessError as e:
            print(f"❌ ERRO ao instalar dependências: {e}")
            return False
    
    def create_launcher_scripts(self):
        """Cria scripts de execução"""
        print("🔧 Criando scripts de execução...")
        
        try:
            # Script para Windows
            if platform.system() == "Windows":
                launcher_content = f'''@echo off
title Dashboard KE5Z
echo Iniciando Dashboard KE5Z...
echo.
cd /d "{self.project_dir}"
"{self.python_exe}" dashboard_main.py
pause
'''
                launcher_file = self.project_dir / "EXECUTAR_DASHBOARD.bat"
                with open(launcher_file, 'w', encoding='utf-8') as f:
                    f.write(launcher_content)
                
                # Script alternativo
                launcher_content2 = f'''@echo off
title Dashboard KE5Z - Streamlit
echo Iniciando Dashboard KE5Z via Streamlit...
echo.
cd /d "{self.project_dir}"
"{self.python_exe}" -m streamlit run dashboard_main.py
pause
'''
                launcher_file2 = self.project_dir / "EXECUTAR_STREAMLIT.bat"
                with open(launcher_file2, 'w', encoding='utf-8') as f:
                    f.write(launcher_content2)
                
                print("✅ Scripts de execução criados!")
            
            return True
            
        except Exception as e:
            print(f"❌ ERRO ao criar scripts: {e}")
            return False
    
    def create_desktop_shortcut(self):
        """Cria atalho na área de trabalho (Windows)"""
        if platform.system() != "Windows":
            return True
            
        print("🔗 Criando atalho na área de trabalho...")
        
        try:
            import winshell
            from win32com.client import Dispatch
            
            desktop = winshell.desktop()
            shortcut_path = os.path.join(desktop, "Dashboard KE5Z.lnk")
            
            target = str(self.project_dir / "EXECUTAR_DASHBOARD.bat")
            wDir = str(self.project_dir)
            
            shell = Dispatch('WScript.Shell')
            shortcut = shell.CreateShortCut(shortcut_path)
            shortcut.Targetpath = target
            shortcut.WorkingDirectory = wDir
            shortcut.IconLocation = target
            shortcut.save()
            
            print("✅ Atalho criado na área de trabalho!")
            return True
            
        except ImportError:
            print("⚠️ Aviso: Não foi possível criar atalho (dependências não disponíveis)")
            return True
        except Exception as e:
            print(f"⚠️ Aviso: Não foi possível criar atalho: {e}")
            return True
    
    def verify_installation(self):
        """Verifica se a instalação foi bem-sucedida"""
        print("🔍 Verificando instalação...")
        
        try:
            # Verificar se o ambiente virtual existe
            if not self.venv_dir.exists():
                print("❌ Ambiente virtual não encontrado!")
                return False
            
            # Verificar se o Python do venv funciona
            result = subprocess.run([
                str(self.python_exe), "--version"
            ], capture_output=True, text=True)
            
            if result.returncode != 0:
                print("❌ Python do ambiente virtual não funciona!")
                return False
            
            # Verificar se o Streamlit está instalado
            result = subprocess.run([
                str(self.pip_exe), "show", "streamlit"
            ], capture_output=True, text=True)
            
            if result.returncode != 0:
                print("❌ Streamlit não está instalado!")
                return False
            
            print("✅ Instalação verificada com sucesso!")
            return True
            
        except Exception as e:
            print(f"❌ ERRO na verificação: {e}")
            return False
    
    def run_installation(self):
        """Executa o processo completo de instalação"""
        self.print_header()
        
        steps = [
            ("Verificando Python", self.check_python),
            ("Criando ambiente virtual", self.create_virtual_environment),
            ("Atualizando pip", self.upgrade_pip),
            ("Instalando dependências", self.install_requirements),
            ("Criando scripts de execução", self.create_launcher_scripts),
            ("Criando atalho", self.create_desktop_shortcut),
            ("Verificando instalação", self.verify_installation)
        ]
        
        for step_name, step_func in steps:
            print(f"\n📋 {step_name}...")
            if not step_func():
                print(f"\n❌ FALHA na etapa: {step_name}")
                print("A instalação foi interrompida.")
                input("Pressione Enter para sair...")
                return False
        
        print("\n" + "=" * 60)
        print("🎉 INSTALAÇÃO CONCLUÍDA COM SUCESSO!")
        print("=" * 60)
        print("O Dashboard KE5Z está pronto para uso!")
        print()
        print("📁 Para executar o Dashboard:")
        print("   • Clique duas vezes em 'EXECUTAR_DASHBOARD.bat'")
        print("   • Ou use o atalho na área de trabalho")
        print()
        print("🌐 O Dashboard abrirá automaticamente no seu navegador")
        print("   URL: http://localhost:8501")
        print()
        print("📞 Suporte: Consulte os arquivos README.md para mais informações")
        print("=" * 60)
        
        input("\nPressione Enter para finalizar...")
        return True

def main():
    """Função principal"""
    try:
        installer = DashboardInstaller()
        installer.run_installation()
    except KeyboardInterrupt:
        print("\n\n⚠️ Instalação cancelada pelo usuário.")
    except Exception as e:
        print(f"\n❌ ERRO CRÍTICO: {e}")
        input("Pressione Enter para sair...")

if __name__ == "__main__":
    main()
