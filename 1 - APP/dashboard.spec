# -*- mode: python ; coding: utf-8 -*-

import os
from PyInstaller.utils.hooks import copy_metadata

block_cipher = None

datas = [
    ('auth_simple.py', '.'),
    ('usuarios_padrao.json', '.'),
    ('usuarios.json', '.'),
    ('KE5Z', 'KE5Z'),
    ('pages', 'pages'),
    ('.streamlit', '.streamlit'),
    ('dashboard_main.py', '.'),
]

datas += copy_metadata('streamlit')
datas += copy_metadata('pandas')
datas += copy_metadata('altair')
datas += copy_metadata('plotly')

a = Analysis(
    ['start_dashboard.py'],
    pathex=['c:\\Dash-V2\\1 - APP'],
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
        'altair',
        'plotly',
        'plotly.graph_objects',
        'importlib.metadata',
        'importlib.metadata._adapters',
        'importlib.metadata._collections',
        'importlib.metadata._functools',
        'importlib.metadata._itertools',
        'importlib.metadata._meta',
        'importlib.metadata._text',
        'pkg_resources',
        'tornado',
        'tornado.web',
        'tornado.ioloop',
        'tornado.httpserver',
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
    name='KE5Z_Desktop_New',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon=None,
)

# -*- mode: python ; coding: utf-8 -*-
import sys
import os
from PyInstaller.utils.hooks import copy_metadata

block_cipher = None

# Coletar metadados do streamlit e outras dependências
datas = [
    ('auth_simple.py', '.'),
    ('usuarios_padrao.json', '.'),
    ('usuarios.json', '.'),
    ('KE5Z', 'KE5Z'),
    ('pages', 'pages'),
    ('.streamlit', '.streamlit'),
    ('dashboard_main.py', '.'),
]
datas += copy_metadata('streamlit')
datas += copy_metadata('altair')
datas += copy_metadata('plotly')
datas += copy_metadata('pandas')

a = Analysis(
    ['dashboard_main.py'],
    pathex=['c:\\Dash-V2\\1 - APP'],
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
        'altair',
        'plotly',
        'plotly.graph_objects',
        'hashlib',
        'datetime',
        'json',
        'os',
        'sys',
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
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon=None,
)
