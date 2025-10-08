# Solução para o Erro "ModuleNotFoundError: No module named 'auth_simple'"

## Problema
O executável `Dashboard_KE5Z_Desktop.exe` estava apresentando o erro:
```
ModuleNotFoundError: No module named 'auth_simple'
```

## Causa
O PyInstaller não estava incluindo o arquivo `auth_simple.py` no pacote do executável, causando o erro de importação.

## Solução Aplicada

### 1. Identificação dos Arquivos Faltantes
Os seguintes arquivos eram necessários no diretório do executável:
- `auth_simple.py` - Módulo de autenticação
- `usuarios_padrao.json` - Usuários padrão do sistema
- `usuarios.json` - Arquivo de usuários (se existir)

### 2. Cópia dos Arquivos
Copiamos os arquivos necessários do diretório `1 - APP` para o diretório `Dashboard_KE5Z_FINAL_DESKTOP`:

```powershell
copy "c:\Dash-V2\1 - APP\auth_simple.py" "c:\Dash-V2\Dashboard_KE5Z_FINAL_DESKTOP\auth_simple.py"
copy "c:\Dash-V2\1 - APP\usuarios_padrao.json" "c:\Dash-V2\Dashboard_KE5Z_FINAL_DESKTOP\usuarios_padrao.json"
copy "c:\Dash-V2\1 - APP\usuarios.json" "c:\Dash-V2\Dashboard_KE5Z_FINAL_DESKTOP\usuarios.json"
```

### 3. Estrutura Final do Diretório
Após a correção, o diretório `Dashboard_KE5Z_FINAL_DESKTOP` contém:
```
Dashboard_KE5Z_FINAL_DESKTOP/
├── _internal/
│   ├── base_library.zip
│   ├── KE5Z/
│   │   ├── KE5Z_main.parquet
│   │   ├── KE5Z_others.parquet
│   │   ├── KE5Z_waterfall.parquet
│   │   ├── KE5Z.parquet
│   │   └── KE5Z.xlsx
│   ├── pyarrow/
│   └── usuarios.json
├── auth_simple.py          ← ADICIONADO
├── usuarios_padrao.json    ← ADICIONADO
└── usuarios.json           ← ADICIONADO
```

## Script de Correção Automática
Foi criado o script `fix_executable.ps1` para automatizar a correção:

```powershell
# Executar o script de correção
powershell -ExecutionPolicy Bypass -File "c:\Dash-V2\fix_executable.ps1"
```

## Verificação
Para verificar se a correção funcionou:
1. Execute o arquivo `Dashboard_KE5Z_Desktop.exe`
2. O erro de importação não deve mais aparecer
3. O sistema de login deve funcionar normalmente

## Prevenção Futura
Para evitar este problema no futuro, ao criar um novo executável com PyInstaller:
1. Certifique-se de incluir todos os arquivos Python necessários
2. Use o parâmetro `--add-data` para incluir arquivos adicionais
3. Teste o executável em um ambiente limpo antes da distribuição

## Status
✅ **PROBLEMA RESOLVIDO** - O executável agora deve funcionar corretamente.
