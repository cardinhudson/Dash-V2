# -*- mode: python ; coding: utf-8 -*-

import os
import sys
from PyInstaller.utils.hooks import copy_metadata

block_cipher = None

# Coletar metadados do streamlit e outras dependências
datas = [
    ('auth_simple.py', '.'),
    ('usuarios_padrao.json', '.'),
    ('usuarios.json', '.'),
    ('dados_equipe.json', '.'),
    ('KE5Z', 'KE5Z'),
    ('pages', 'pages'),
    ('.streamlit', '.streamlit'),
    ('app.py', '.'),
    ('Extracao.py', '.'),
    ('Dados SAPIENS.xlsx', '.'),
    ('Fornecedores.xlsx', '.'),
    ('Extracoes', 'Extracoes'),
    ('arquivos', 'arquivos'),
    ('streamlit_desktop_config.py', '.'),
]

datas += copy_metadata('streamlit')
datas += copy_metadata('pandas')
datas += copy_metadata('altair')
datas += copy_metadata('plotly')
datas += copy_metadata('streamlit-desktop-app')
datas += copy_metadata('pywebview')
datas += copy_metadata('numpy')
datas += copy_metadata('openpyxl')
datas += copy_metadata('xlrd')
datas += copy_metadata('pyarrow')

a = Analysis(
    ['streamlit_desktop_config.py'],
    pathex=[os.path.abspath('.')],
    binaries=[],
    datas=datas,
    hiddenimports=[
        'auth_simple',
        'streamlit',
        'streamlit.web',
        'streamlit.web.cli',
        'streamlit.runtime',
        'streamlit.runtime.scriptrunner',
        'streamlit.runtime.state',
        'streamlit.components',
        'streamlit.components.v1',
        'pandas',
        'pandas.io.excel',
        'pandas.io.parquet',
        'altair',
        'plotly',
        'plotly.graph_objects',
        'plotly.express',
        'numpy',
        'openpyxl',
        'xlrd',
        'pyarrow',
        'pyarrow.parquet',
        'hashlib',
        'datetime',
        'json',
        'os',
        'sys',
        'pathlib',
        'importlib.metadata',
        'importlib.metadata._adapters',
        'importlib.metadata._collections',
        'importlib.metadata._functools',
        'importlib.metadata._itertools',
        'importlib.metadata._meta',
        'importlib.metadata._text',
        'pkg_resources',
        'webbrowser',
        'socket',
        'threading',
        'tornado',
        'tornado.web',
        'tornado.ioloop',
        'tornado.httpserver',
        'streamlit_desktop_app',
        'pywebview',
        'webview',
        'pywebview.platforms.cef',
        'pywebview.platforms.edgehtml',
        'pywebview.platforms.mshtml',
        'pywebview.platforms.gtk',
        'pywebview.platforms.qt',
        'pywebview.platforms.cocoa',
        'pywebview.platforms.android',
        'pywebview.platforms.winforms',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='Dashboard_KE5Z_Desktop',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,  # Temporariamente True para debug
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch='x86_64',
    codesign_identity=None,
    entitlements_file=None,
    icon=None,
)
