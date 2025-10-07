#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
DESINSTALADOR - DASHBOARD KE5Z
=============================

Este script remove completamente o Dashboard KE5Z do sistema.

Autor: Sistema Automático
Data: 2025
"""

import os
import sys
import shutil
import platform
from pathlib import Path

class DashboardUninstaller:
    def __init__(self):
        self.project_dir = Path(__file__).parent
        self.venv_dir = self.project_dir / "venv"
        
    def print_header(self):
        """Imprime o cabeçalho do desinstalador"""
        print("=" * 60)
        print("🗑️ DESINSTALADOR - DASHBOARD KE5Z")
        print("=" * 60)
        print("Este desinstalador irá remover:")
        print("• Ambiente virtual Python")
        print("• Arquivos temporários")
        print("• Atalhos criados")
        print("• Configurações locais")
        print("=" * 60)
        print()
        
    def confirm_uninstall(self):
        """Confirma se o usuário quer desinstalar"""
        print("⚠️ ATENÇÃO: Esta ação irá remover completamente o Dashboard KE5Z!")
        print()
        
        while True:
            response = input("Deseja continuar com a desinstalação? (s/n): ").lower().strip()
            if response in ['s', 'sim', 'y', 'yes']:
                return True
            elif response in ['n', 'não', 'nao', 'no']:
                return False
            else:
                print("Por favor, responda 's' para sim ou 'n' para não.")
    
    def remove_virtual_environment(self):
        """Remove o ambiente virtual"""
        print("🗑️ Removendo ambiente virtual...")
        
        try:
            if self.venv_dir.exists():
                shutil.rmtree(self.venv_dir)
                print("✅ Ambiente virtual removido!")
            else:
                print("ℹ️ Ambiente virtual não encontrado.")
            return True
            
        except Exception as e:
            print(f"❌ ERRO ao remover ambiente virtual: {e}")
            return False
    
    def remove_shortcuts(self):
        """Remove atalhos criados"""
        print("🔗 Removendo atalhos...")
        
        try:
            if platform.system() == "Windows":
                import winshell
                desktop = winshell.desktop()
                shortcut_path = os.path.join(desktop, "Dashboard KE5Z.lnk")
                
                if os.path.exists(shortcut_path):
                    os.remove(shortcut_path)
                    print("✅ Atalho 'Dashboard KE5Z' removido da área de trabalho!")
                    print(f"   📍 Localização removida: {shortcut_path}")
                else:
                    print("ℹ️ Atalho da área de trabalho não encontrado.")
            else:
                print("ℹ️ Sistema não é Windows - nenhum atalho para remover.")
            
            return True
            
        except ImportError:
            print("ℹ️ Módulo para remoção de atalhos não disponível.")
            print("   O atalho pode precisar ser removido manualmente.")
            return True
        except Exception as e:
            print(f"⚠️ Aviso: Não foi possível remover atalhos: {e}")
            print("   O atalho pode precisar ser removido manualmente.")
            return True
    
    def remove_temp_files(self):
        """Remove arquivos temporários"""
        print("🧹 Removendo arquivos temporários...")
        
        try:
            # Remover arquivos __pycache__
            for root, dirs, files in os.walk(self.project_dir):
                for dir_name in dirs[:]:
                    if dir_name == "__pycache__":
                        cache_dir = os.path.join(root, dir_name)
                        shutil.rmtree(cache_dir)
                        dirs.remove(dir_name)
            
            # Remover arquivos .pyc
            for root, dirs, files in os.walk(self.project_dir):
                for file_name in files:
                    if file_name.endswith('.pyc'):
                        os.remove(os.path.join(root, file_name))
            
            print("✅ Arquivos temporários removidos!")
            return True
            
        except Exception as e:
            print(f"⚠️ Aviso: Não foi possível remover alguns arquivos temporários: {e}")
            return True
    
    def remove_logs(self):
        """Remove arquivos de log"""
        print("📝 Removendo arquivos de log...")
        
        try:
            log_files = [
                "nuitka-crash-report.xml",
                "*.log"
            ]
            
            for pattern in log_files:
                for file_path in self.project_dir.glob(pattern):
                    if file_path.is_file():
                        file_path.unlink()
            
            print("✅ Arquivos de log removidos!")
            return True
            
        except Exception as e:
            print(f"⚠️ Aviso: Não foi possível remover alguns logs: {e}")
            return True
    
    def run_uninstall(self):
        """Executa o processo completo de desinstalação"""
        self.print_header()
        
        if not self.confirm_uninstall():
            print("\n❌ Desinstalação cancelada pelo usuário.")
            return False
        
        steps = [
            ("Removendo ambiente virtual", self.remove_virtual_environment),
            ("Removendo atalhos", self.remove_shortcuts),
            ("Removendo arquivos temporários", self.remove_temp_files),
            ("Removendo arquivos de log", self.remove_logs)
        ]
        
        for step_name, step_func in steps:
            print(f"\n📋 {step_name}...")
            step_func()
        
        print("\n" + "=" * 60)
        print("✅ DESINSTALAÇÃO CONCLUÍDA!")
        print("=" * 60)
        print("O Dashboard KE5Z foi removido do sistema.")
        print()
        print("📁 Arquivos mantidos:")
        print("   • Código fonte do projeto")
        print("   • Dados e configurações")
        print("   • Documentação")
        print()
        print("💡 Para reinstalar, execute novamente o instalador.")
        print("=" * 60)
        
        input("\nPressione Enter para finalizar...")
        return True

def main():
    """Função principal"""
    try:
        uninstaller = DashboardUninstaller()
        uninstaller.run_uninstall()
    except KeyboardInterrupt:
        print("\n\n⚠️ Desinstalação cancelada pelo usuário.")
    except Exception as e:
        print(f"\n❌ ERRO CRÍTICO: {e}")
        input("Pressione Enter para sair...")

if __name__ == "__main__":
    main()
