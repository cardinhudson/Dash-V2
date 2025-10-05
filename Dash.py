# %%
import streamlit as st
import pandas as pd
import os
import altair as alt
# Plotly removido devido a problemas de compatibilidade com Python 3.13
PLOTLY_AVAILABLE = False
from auth_simple import (verificar_autenticacao, exibir_header_usuario,
                         eh_administrador, verificar_status_aprovado,
                         get_usuarios_cloud, adicionar_usuario_simples, criar_hash_senha,
                         get_modo_operacao, is_modo_cloud)
from datetime import datetime

# Configuração otimizada da página para melhor performance
st.set_page_config(
    page_title="Dashboard KE5Z",
    page_icon="📊",
    layout="wide",
    initial_sidebar_state="collapsed"
)

# Configurações para otimizar conexão e performance
if 'connection_optimized' not in st.session_state:
    # Configurar pandas para usar menos memória
    pd.set_option('display.max_columns', 50)
    pd.set_option('display.max_rows', 1000)
    
    # Marcar como otimizado
    st.session_state.connection_optimized = True

# Verificar autenticação - OBRIGATÓRIO no início de cada página
verificar_autenticacao()

# Verificar se o usuário está aprovado
if 'usuario_nome' in st.session_state and not verificar_status_aprovado(st.session_state.usuario_nome):
    st.warning("⏳ Sua conta ainda está pendente de aprovação. "
               "Aguarde o administrador aprovar seu acesso.")
    st.info("📧 Você receberá uma notificação quando sua conta for "
            "aprovada.")
    st.stop()

# Usar modo selecionado no login (substitui detecção automática)
is_cloud = is_modo_cloud()

# Indicador de navegação no topo
st.sidebar.markdown("📋 **NAVEGAÇÃO:** Menu de páginas acima ⬆️")
st.sidebar.markdown("---")

# Informar sobre modo selecionado (COMPACTO)
modo_atual = get_modo_operacao()
if modo_atual == 'cloud':
    st.sidebar.info("☁️ **Modo Cloud**")
else:
    st.sidebar.info("💻 **Modo Completo**")

# Sistema de cache inteligente para otimização de memória e conexão
@st.cache_data(
    ttl=3600,
    max_entries=3,  # Aumentar para cachear os 3 arquivos
    show_spinner=True,
    persist="disk"
)
def load_data_optimized(arquivo_tipo="completo"):
    """Carrega dados com otimização inteligente de memória
    
    Args:
        arquivo_tipo: "completo", "main" (sem Others), ou "others"
    """
    
    # Definir qual arquivo carregar
    arquivos_disponiveis = {
        "completo": "KE5Z.parquet",
        "main": "KE5Z_main.parquet", 
        "others": "KE5Z_others.parquet",
        "main_filtered": "KE5Z.parquet"  # Usa arquivo completo mas filtra Others
    }
    
    nome_arquivo = arquivos_disponiveis.get(arquivo_tipo, "KE5Z.parquet")
    arquivo_parquet = os.path.join("KE5Z", nome_arquivo)
    
    try:
        if not os.path.exists(arquivo_parquet):
            # Se arquivo específico não existe, tentar arquivo completo
            if arquivo_tipo != "completo":
                st.warning(f"⚠️ Arquivo {nome_arquivo} não encontrado, carregando dados completos...")
                return load_data_optimized("completo")
            raise FileNotFoundError(f"Arquivo não encontrado: {arquivo_parquet}")
        
        # Verificar tamanho do arquivo
        file_size_mb = os.path.getsize(arquivo_parquet) / (1024 * 1024)
        
        # Carregar dados
        df = pd.read_parquet(arquivo_parquet)
        
        # Aplicar filtro especial para main_filtered (cloud mode)
        if arquivo_tipo == "main_filtered" and 'USI' in df.columns:
            # Filtrar para remover Others, simulando arquivo main
            df = df[df['USI'] != 'Others'].copy()
            st.sidebar.info(f"🔄 Filtro aplicado: {len(df):,} registros (Others removidos)")
        
        # Otimizar tipos de dados para economizar memória (sem alterar conteúdo)
        original_memory = df.memory_usage(deep=True).sum() / (1024 * 1024)
        
        for col in df.columns:
            if df[col].dtype == 'object':
                unique_ratio = df[col].nunique() / len(df)
                if unique_ratio < 0.5:  # Menos de 50% valores únicos
                    df[col] = df[col].astype('category')
        
        # Converter floats para tipos menores
        for col in df.select_dtypes(include=['float64']).columns:
            df[col] = pd.to_numeric(df[col], downcast='float')
        
        # Converter ints para tipos menores
        for col in df.select_dtypes(include=['int64']).columns:
            df[col] = pd.to_numeric(df[col], downcast='integer')
        
        # Calcular economia de memória
        optimized_memory = df.memory_usage(deep=True).sum() / (1024 * 1024)
        saved_memory = original_memory - optimized_memory
        
        if saved_memory > 1:  # Economia significativa
            st.sidebar.success(f"💾 Memória economizada: {saved_memory:.1f}MB")
        
        return df
        
    except Exception as e:
        raise e

# Interface para seleção de dados (COMPACTO)
st.sidebar.markdown("---")
st.sidebar.markdown("**🗂️ Dados**")

# Verificar quais arquivos estão disponíveis
arquivos_status = {}
for tipo, nome in [("completo", "KE5Z.parquet"), ("main", "KE5Z_main.parquet"), ("others", "KE5Z_others.parquet")]:
    caminho = os.path.join("KE5Z", nome)
    arquivos_status[tipo] = os.path.exists(caminho)

# Opções disponíveis baseadas nos arquivos existentes
opcoes_dados = []

# Priorizar arquivos otimizados sempre
if arquivos_status.get("main", False):
    opcoes_dados.append(("📊 Dados Principais (sem Others)", "main"))

# Apenas Others: OCULTAR no modo cloud
if arquivos_status.get("others", False) and not is_cloud:
    opcoes_dados.append(("📋 Apenas Others", "others"))

# Dados completos: APENAS no modo local E quando não há arquivos otimizados
if not is_cloud and arquivos_status.get("completo", False):
    # Se há arquivos otimizados, mostrar completo como opção adicional
    # Se não há arquivos otimizados, será a única opção
    opcoes_dados.append(("📁 Dados Completos", "completo"))

# Tratamento especial para Streamlit Cloud
if is_cloud:
    if not opcoes_dados:  # Não há arquivos otimizados no cloud
        if arquivos_status.get("completo", False):
            # No cloud, usar arquivo completo como "dados principais" temporariamente
            # mas filtrar internamente para remover Others
            opcoes_dados = [("📊 Dados Otimizados (filtrados)", "main_filtered")]
            st.sidebar.warning("⚠️ **Modo Cloud Temporário**\nUsando arquivo completo com filtro interno.\nPara melhor performance, gere arquivos separados localmente.")
        else:
            st.error("❌ **Erro no Streamlit Cloud**: Nenhum arquivo de dados encontrado!")
            st.error("Faça upload dos arquivos parquet para o repositório.")
            st.stop()

# Fallback para modo local sem arquivos otimizados
if not opcoes_dados and not is_cloud:
    if arquivos_status.get("completo", False):
        opcoes_dados = [("📁 Dados Completos", "completo")]
    else:
        st.error("❌ **Erro**: Nenhum arquivo de dados encontrado!")
        st.error("Execute a extração de dados para gerar os arquivos necessários.")
        st.stop()

# Widget de seleção com prioridade para dados principais
def get_default_index():
    """Retorna o índice padrão priorizando dados principais"""
    opcoes_values = [op[1] for op in opcoes_dados]
    
    # Prioridade: main > main_filtered > others > completo
    if "main" in opcoes_values:
        return opcoes_values.index("main")
    elif "main_filtered" in opcoes_values:
        return opcoes_values.index("main_filtered")
    elif "others" in opcoes_values:
        return opcoes_values.index("others")
    else:
        return 0  # Primeiro disponível

opcao_selecionada = st.sidebar.selectbox(
    "Escolha o conjunto de dados:",
    options=[op[1] for op in opcoes_dados],
    format_func=lambda x: next(op[0] for op in opcoes_dados if op[1] == x),
    index=get_default_index()  # Priorizar dados principais
)

# Mostrar informações sobre a seleção (COMPACTO)
if opcao_selecionada == "main":
    st.sidebar.info("🎯 **Dados Principais** (sem Others)")
elif opcao_selecionada == "main_filtered":
    st.sidebar.info("🎯 **Dados Filtrados** (Cloud)")
elif opcao_selecionada == "others":
    st.sidebar.info("🔍 **Apenas Others**")
else:
    st.sidebar.info("📊 **Dados Completos**")

# Carregar dados
try:
    df_total = load_data_optimized(opcao_selecionada)
    st.sidebar.success("✅ Dados carregados com sucesso")
    
    # Log informativo
    if not is_cloud:
        st.sidebar.info(f"📊 {len(df_total)} registros carregados")
        
except FileNotFoundError:
    st.error("❌ Arquivo de dados não encontrado!")
    st.error(f"🔍 Procurando por: `KE5Z/KE5Z.parquet`")
    st.info("💡 **Soluções:**")
    st.info("1. Verifique se o arquivo `KE5Z.parquet` está na pasta `KE5Z/`")
    st.info("2. Execute a extração de dados localmente")
    st.info("3. Faça commit do arquivo no repositório")
    
    if is_cloud:
        st.warning("☁️ **No Streamlit Cloud:** Certifique-se que o arquivo "
                  "foi enviado para o repositório")
    
    st.stop()
    
except Exception as e:
    st.error(f"❌ Erro ao carregar dados: {str(e)}")
    st.info("🔧 **Possíveis causas:**")
    st.info("• Arquivo corrompido ou formato inválido")
    st.info("• Problema de permissões")
    st.info("• Arquivo muito grande")
    
    if is_cloud:
        st.info("☁️ **No Cloud:** Verifique se o arquivo tem menos de 100MB")
    
    st.stop()

# Filtrar o df_total com a coluna 'USI' que não seja nula (incluindo 'Others')
df_total = df_total[df_total['USI'].notna()]

# Header com informações do usuário e botão de logout
col1, col2, col3 = st.columns([2, 1, 1])
with col1:
    st.title("📊 Dashboard - Visualização de Dados TC - KE5Z")
st.subheader("Somente os dados com as contas do Perímetro TC")

# Exibir header do usuário
exibir_header_usuario()

st.markdown("---")

# Filtros (COMPACTO)
st.sidebar.markdown("---")
st.sidebar.markdown("**🔍 Filtros**")

# Cache para opções de filtros (otimização de performance)
@st.cache_data(ttl=1800, max_entries=3)
def get_filter_options(df, column_name):
    """Obtém opções de filtro com cache para melhor performance"""
    if column_name in df.columns:
        return ["Todos"] + sorted(df[column_name].dropna().astype(str).unique().tolist())
    return ["Todos"]

# Filtro 1: USINA (com cache otimizado)
usina_opcoes = get_filter_options(df_total, 'USI')
default_usina = ["Veículos"] if "Veículos" in usina_opcoes else ["Todos"]
usina_selecionada = st.sidebar.multiselect("Selecione a USINA:", usina_opcoes, default=default_usina)

# Filtrar o DataFrame com base na USI
if "Todos" in usina_selecionada or not usina_selecionada:
    df_filtrado = df_total.copy()
else:
    df_filtrado = df_total[df_total['USI'].astype(str).isin(usina_selecionada)]

# Filtro 2: Período (com cache otimizado) - usar df_total para opções completas
periodo_opcoes = get_filter_options(df_total, 'Período')
periodo_selecionado = st.sidebar.selectbox("Selecione o Período:", periodo_opcoes)
# Guardar seleção para outros gráficos usarem de forma consistente
st.session_state['filtro_periodo_selecionado'] = periodo_selecionado
if periodo_selecionado != "Todos":
    # Converter para float para comparação correta com valores numéricos
    try:
        periodo_valor = float(periodo_selecionado)
        df_filtrado = df_filtrado[df_filtrado['Período'] == periodo_valor]
    except Exception:
        pass

# Filtro 3: Centro cst (com cache otimizado)
if 'Centro cst' in df_filtrado.columns:
    centro_cst_opcoes = get_filter_options(df_total, 'Centro cst')
    centro_cst_selecionado = st.sidebar.selectbox("Selecione o Centro cst:", centro_cst_opcoes)
    if centro_cst_selecionado != "Todos":
        # Comparação robusta que funciona com qualquer tipo de dados
        df_filtrado = df_filtrado[df_filtrado['Centro cst'].astype(str) == str(centro_cst_selecionado)]

# Filtro 4: Conta contábil (com cache otimizado)
if 'Nº conta' in df_filtrado.columns:
    conta_contabil_opcoes = get_filter_options(df_total, 'Nº conta')[1:]  # Remove "Todos" para multiselect
    conta_contabil_selecionadas = st.sidebar.multiselect("Selecione a Conta contábil:", conta_contabil_opcoes)
    if conta_contabil_selecionadas:
        df_filtrado = df_filtrado[df_filtrado['Nº conta'].astype(str).isin(conta_contabil_selecionadas)]

# Filtros principais (com cache otimizado)
filtros_principais = [
    ("Type 05", "Type 05", "multiselect"),
    ("Type 06", "Type 06", "multiselect"), 
    ("Type 07", "Type 07", "multiselect"),
    ("Fornecedor", "Fornecedor", "multiselect"),
    ("Fornec.", "Fornec.", "multiselect"),
    ("Tipo", "Tipo", "multiselect")
]

for col_name, label, widget_type in filtros_principais:
    if col_name in df_filtrado.columns:
        opcoes = get_filter_options(df_total, col_name)
        if widget_type == "multiselect":
            selecionadas = st.sidebar.multiselect(f"Selecione o {label}:", opcoes, default=["Todos"])
            if selecionadas and "Todos" not in selecionadas:
                df_filtrado = df_filtrado[df_filtrado[col_name].astype(str).isin(selecionadas)]

# Filtros avançados (expansível)
with st.sidebar.expander("🔍 Filtros Avançados"):
    filtros_avancados = [
        ("Oficina", "Oficina", "multiselect"),
        ("Usuário", "Usuário", "multiselect"),
        ("Denominação", "Denominação", "multiselect"),
        ("Dt.lçto.", "Data Lançamento", "multiselect")
    ]
    
    for col_name, label, widget_type in filtros_avancados:
        if col_name in df_filtrado.columns:
            opcoes = get_filter_options(df_total, col_name)
            # Limitar opções para melhor performance
            if len(opcoes) > 101:  # 100 + "Todos"
                opcoes = opcoes[:101]
                st.caption(f"⚠️ {label}: Limitado a 100 opções para performance")
            
            if widget_type == "multiselect":
                selecionadas = st.multiselect(f"Selecione o {label}:", opcoes, default=["Todos"])
                if selecionadas and "Todos" not in selecionadas:
                    df_filtrado = df_filtrado[df_filtrado[col_name].astype(str).isin(selecionadas)]

# Resumo (COMPACTO)
st.sidebar.markdown("---")
st.sidebar.markdown("**📊 Resumo**")
st.sidebar.write(f"**Linhas:** {df_filtrado.shape[0]:,}")
st.sidebar.write(f"**Total:** R$ {df_filtrado['Valor'].sum():,.2f}")

# Status do Sistema (COMPACTO)
if not is_cloud:  # Só mostrar em modo local para economizar espaço
    st.sidebar.markdown("---")
    st.sidebar.markdown("**💾 Sistema**")
    
    try:
        import sys
        df_size_mb = sys.getsizeof(df_filtrado) / (1024 * 1024)
        st.sidebar.write(f"**Memória:** {df_size_mb:.1f}MB")
        
        if st.sidebar.button("🧹 Cache", help="Limpar cache"):
            st.cache_data.clear()
            import gc
            gc.collect()
            st.sidebar.success("✅ Limpo!")
            st.rerun()
    except Exception:
        pass

# Área administrativa (COMPACTO)
if eh_administrador():
    st.sidebar.markdown("---")
    st.sidebar.markdown("**👑 Admin**")

    usuarios = get_usuarios_cloud()
    total_usuarios = len(usuarios)
    usuarios_aprovados = len([u for u in usuarios.values() if u.get('status') == 'aprovado'])
    usuarios_pendentes = len([u for u in usuarios.values() if u.get('status') == 'pendente'])

    st.sidebar.write(f"**Usuários:** {total_usuarios} ({usuarios_aprovados} ✅, {usuarios_pendentes} ⏳)")
    
    # Botão para expandir detalhes
    if st.sidebar.button("📋 Ver Usuários"):
        st.sidebar.markdown("**Cadastrados:**")
        for usuario, dados in usuarios.items():
            tipo_icon = "👑" if dados.get('tipo') == 'administrador' else "👥"
            status_icon = "✅" if dados.get('status') == 'aprovado' else "⏳"
            st.sidebar.write(f"{tipo_icon} {status_icon} {usuario}")

# Gráfico de barras para a soma dos valores por 'Período'
@st.cache_data(ttl=900, max_entries=2)
def create_period_chart(df_data):
    """Cria gráfico otimizado"""
    try:
        chart_data = df_data.groupby('Período')['Valor'].sum().reset_index()
        
        grafico_barras = alt.Chart(chart_data).mark_bar().encode(
            x=alt.X('Período:N', title='Período'),
            y=alt.Y('Valor:Q', title='Soma do Valor'),
            color=alt.Color('Valor:Q', title='Valor', scale=alt.Scale(scheme='redyellowgreen', reverse=True)),
            tooltip=['Período:N', 'Valor:Q']
        ).properties(
            title='Soma do Valor por Período'
        )
        
        return grafico_barras
    except Exception as e:
        st.error(f"Erro ao criar gráfico: {e}")
        return None

# Criar e exibir gráfico
grafico_barras = create_period_chart(df_filtrado)
if grafico_barras:
    # Adicionar rótulos com valores nas barras
    rotulos = grafico_barras.mark_text(
        align='center',
        baseline='middle',
        dy=-10,  # Ajuste vertical
        color='black',
        fontSize=12
    ).encode(
        text=alt.Text('Valor:Q', format=',.2f')
    )
    
    # Combinar gráfico com rótulos
    grafico_completo = grafico_barras + rotulos
    st.altair_chart(grafico_completo, use_container_width=True)

# Gráficos adicionais por Type
st.subheader("📊 Análise por Categorias")

# Gráfico por Type 05
if 'Type 05' in df_filtrado.columns:
    @st.cache_data(ttl=900, max_entries=2)
    def create_type05_chart(df_data):
        try:
            # Aplicar filtro de mês consistente (caso a filtragem global falhe)
            sel = st.session_state.get('filtro_periodo_selecionado', 'Todos')
            if sel != 'Todos' and 'Período' in df_data.columns:
                try:
                    df_data = df_data[pd.to_numeric(df_data['Período'], errors='coerce') == float(sel)]
                except Exception:
                    pass
            type05_data = df_data.groupby('Type 05')['Valor'].sum().reset_index()
            type05_data = type05_data.sort_values('Valor', ascending=False)
            
            chart = alt.Chart(type05_data).mark_bar().encode(
                x=alt.X('Type 05:N', title='Type 05', sort='-y'),
                y=alt.Y('Valor:Q', title='Soma do Valor'),
                color=alt.Color('Valor:Q', title='Valor', scale=alt.Scale(scheme='redyellowgreen', reverse=True)),
                tooltip=['Type 05:N', 'Valor:Q']
            ).properties(
                title=f"Soma do Valor por Type 05{'' if sel=='Todos' else f' - Mês {sel:g}'}",
                height=400
            )
            
            return chart
        except Exception as e:
            st.error(f"Erro no gráfico Type 05: {e}")
            return None
    
    chart_type05 = create_type05_chart(df_filtrado)
    if chart_type05:
        st.altair_chart(chart_type05, use_container_width=True)

# Gráfico por Type 06
if 'Type 06' in df_filtrado.columns:
    @st.cache_data(ttl=900, max_entries=2)
    def create_type06_chart(df_data):
        try:
            # Aplicar filtro de mês consistente (caso a filtragem global falhe)
            sel = st.session_state.get('filtro_periodo_selecionado', 'Todos')
            if sel != 'Todos' and 'Período' in df_data.columns:
                try:
                    df_data = df_data[pd.to_numeric(df_data['Período'], errors='coerce') == float(sel)]
                except Exception:
                    pass
            type06_data = df_data.groupby('Type 06')['Valor'].sum().reset_index()
            type06_data = type06_data.sort_values('Valor', ascending=False)
            
            chart = alt.Chart(type06_data).mark_bar().encode(
                x=alt.X('Type 06:N', title='Type 06', sort='-y'),
                y=alt.Y('Valor:Q', title='Soma do Valor'),
                color=alt.Color('Valor:Q', title='Valor', scale=alt.Scale(scheme='redyellowgreen', reverse=True)),
                tooltip=['Type 06:N', 'Valor:Q']
            ).properties(
                title=f"Soma do Valor por Type 06{'' if sel=='Todos' else f' - Mês {sel:g}'}",
                height=400
            )
            
            return chart
        except Exception as e:
            st.error(f"Erro no gráfico Type 06: {e}")
            return None
    
    chart_type06 = create_type06_chart(df_filtrado)
    if chart_type06:
        st.altair_chart(chart_type06, use_container_width=True)

# Gráfico por Texto (mesmo modelo e cores)
texto_col = None
for candidate in ['Texto', 'Texto breve', 'Descrição Material']:
    if candidate in df_filtrado.columns:
        texto_col = candidate
        break

if texto_col:
    # Controles específicos acima do gráfico
    col_mes, col_t7, col_top = st.columns([1, 2, 1])

    # Filtro de mês (Período)
    meses_opcoes = ["Todos"]
    if 'Período' in df_filtrado.columns:
        try:
            meses = sorted([m for m in pd.to_numeric(df_filtrado['Período'], errors='coerce').dropna().unique().tolist()])
            meses_opcoes += meses
        except Exception:
            pass
    mes_sel = col_mes.selectbox("Mês (Período)", meses_opcoes, index=0)

    # Filtro de Type 07
    type07_opcoes = ["Todos"]
    if 'Type 07' in df_filtrado.columns:
        type07_opcoes += sorted(df_filtrado['Type 07'].dropna().astype(str).unique().tolist())
    type07_sel = col_t7.multiselect("Type 07", type07_opcoes, default=["Todos"]) 

    # Limitador (Pareto)
    top_map = {"Top 10": 10, "Top 15": 15, "Top 20": 20, "Total": None}
    top_label = col_top.selectbox("Limite (Pareto)", list(top_map.keys()), index=0)
    top_n = top_map[top_label]

    @st.cache_data(ttl=900, max_entries=2)
    def create_texto_chart(df_data, col_name, top_n_param):
        try:
            texto_data = (
                df_data.assign(**{col_name: df_data[col_name].astype(str)})
                .groupby(col_name)['Valor']
                .sum()
                .reset_index()
                .sort_values('Valor', ascending=False)
            )
            if top_n_param is not None and len(texto_data) > top_n_param:
                texto_data = texto_data.head(top_n_param)

            chart = alt.Chart(texto_data).mark_bar().encode(
                x=alt.X(f'{col_name}:N', title=col_name, sort='-y'),
                y=alt.Y('Valor:Q', title='Soma do Valor'),
                color=alt.Color('Valor:Q', title='Valor', scale=alt.Scale(scheme='redyellowgreen', reverse=True)),
                tooltip=[f'{col_name}:N', 'Valor:Q']
            ).properties(
                title=f'Soma do Valor por {col_name}',
                height=400
            )
            return chart
        except Exception as e:
            st.error(f"Erro no gráfico {col_name}: {e}")
            return None

    # Aplicar filtros locais para o gráfico
    df_texto = df_filtrado.copy()
    if mes_sel != "Todos" and 'Período' in df_texto.columns:
        try:
            df_texto = df_texto[pd.to_numeric(df_texto['Período'], errors='coerce') == float(mes_sel)]
        except Exception:
            pass
    if type07_sel and "Todos" not in type07_sel and 'Type 07' in df_texto.columns:
        df_texto = df_texto[df_texto['Type 07'].astype(str).isin(type07_sel)]

    chart_texto = create_texto_chart(df_texto, texto_col, top_n)
    if chart_texto:
        st.altair_chart(chart_texto, use_container_width=True)

# Tabela dinâmica com cores
df_pivot = df_filtrado.pivot_table(
    index='USI', columns='Período', values='Valor', aggfunc='sum',
    margins=True, margins_name='Total', fill_value=0
)

# Remover linhas totalmente zeradas (exceto a linha Total) para compactar a visualização
if not df_pivot.empty:
    colunas_sem_total = [c for c in df_pivot.columns if c != 'Total']
    if colunas_sem_total:
        mask_totalmente_zero = (df_pivot[colunas_sem_total].sum(axis=1) == 0)
    else:
        mask_totalmente_zero = (df_pivot.sum(axis=1) == 0)
    df_pivot_compact = df_pivot.loc[~((df_pivot.index != 'Total') & mask_totalmente_zero)]
else:
    df_pivot_compact = df_pivot
st.subheader("Tabela Dinâmica - Soma do Valor por USI e Período")

# Aplicar formatação com cores (verde para positivo, vermelho para negativo)
def colorir_valores(val):
    if isinstance(val, (int, float)):
        if val < 0:
            return 'color: #e74c3c; font-weight: bold;'  # Vermelho para negativo
        elif val > 0:
            return 'color: #27ae60; font-weight: bold;'  # Verde para positivo
    return ''

styled_pivot = df_pivot_compact.style.format('R$ {:,.2f}').map(colorir_valores, subset=pd.IndexSlice[:, :])

# Altura dinâmica para evitar "linhas vazias" visuais
num_rows = len(df_pivot_compact)
altura = max(220, min(600, 64 + 32 * num_rows))  # cabeçalho + altura por linha
st.dataframe(styled_pivot, use_container_width=True, height=altura)

# Botão de download da Tabela Dinâmica (logo abaixo da tabela)
if st.button("📥 Baixar Tabela Dinâmica (Excel)", use_container_width=True, key="download_pivot"):
    with st.spinner("Gerando arquivo da tabela dinâmica..."):
        # Função para exportar para Excel
        def exportar_excel_pivot(df, nome_arquivo):
            from io import BytesIO
            output = BytesIO()
            with pd.ExcelWriter(output, engine='openpyxl') as writer:
                df.to_excel(writer, index=True, sheet_name='Tabela_Dinamica')
            output.seek(0)
            return output.getvalue()
        
        excel_data_pivot = exportar_excel_pivot(df_pivot, 'KE5Z_tabela_dinamica.xlsx')
        
        # Forçar download usando JavaScript
        import base64
        b64 = base64.b64encode(excel_data_pivot).decode()
        href = f'<a href="data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,{b64}" download="KE5Z_tabela_dinamica.xlsx">💾 Clique aqui para baixar a Tabela Dinâmica</a>'
        st.markdown(href, unsafe_allow_html=True)
        st.success("✅ Tabela Dinâmica gerada! Clique no link acima para baixar.")

# Exibir o DataFrame filtrado (limitado para performance)
st.subheader("Tabela Filtrada")
display_limit = 500 if is_cloud else 2000
if len(df_filtrado) > display_limit:
    st.info(f"📊 Mostrando {display_limit:,} de {len(df_filtrado):,} registros para otimizar performance")
    df_display = df_filtrado.head(display_limit)
else:
    df_display = df_filtrado

st.dataframe(df_display, use_container_width=True, height=600)

# Botão de download da Tabela Filtrada (logo abaixo da tabela)
if st.button("📥 Baixar Tabela Filtrada (Excel)", use_container_width=True, key="download_filtered"):
    with st.spinner("Gerando arquivo da tabela filtrada..."):
        # Função para exportar tabela filtrada
        def exportar_excel_filtrada(df, nome_arquivo):
            from io import BytesIO
            output = BytesIO()
            with pd.ExcelWriter(output, engine='openpyxl') as writer:
                df.to_excel(writer, index=False, sheet_name='Dados_Filtrados')
            output.seek(0)
            return output.getvalue()
        
        excel_data_filtrada = exportar_excel_filtrada(df_filtrado, 'KE5Z_tabela_filtrada.xlsx')
        
        # Forçar download usando JavaScript
        import base64
        b64 = base64.b64encode(excel_data_filtrada).decode()
        href = f'<a href="data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,{b64}" download="KE5Z_tabela_filtrada.xlsx">💾 Clique aqui para baixar a Tabela Filtrada</a>'
        st.markdown(href, unsafe_allow_html=True)
        st.success("✅ Tabela Filtrada gerada! Clique no link acima para baixar.")

## Tabela de soma por Types (Type 05, Type 06, Type 07)
if all(col in df_filtrado.columns for col in ['Type 05', 'Type 06', 'Type 07']):
    st.markdown("---")
    st.subheader("📊 Soma por Type 05, Type 06 e Type 07")

    # Opções
    ocultar_zeros = st.checkbox("Ocultar linhas com valor R$ 0,00", value=True, key="agg_hide_zero_types")

    # Preparar dados SEMPRE do arquivo waterfall
    caminho_wf = os.path.join('KE5Z', 'KE5Z_waterfall.parquet')
    if not os.path.exists(caminho_wf):
        st.error('❌ Arquivo waterfall não encontrado: KE5Z/KE5Z_waterfall.parquet')
        st.info('Execute a extração para gerar o arquivo waterfall.')
        tabela_final = pd.DataFrame({'Type 05': [], 'Type 06': [], 'Type 07': [], 'Valor': []})
    else:
        df_w = pd.read_parquet(caminho_wf, columns=['Período','USI','Type 05','Type 06','Type 07','Valor'])
        # Aplicar filtros básicos equivalentes (USI e Período) conforme df_filtrado atual
        try:
            if 'USI' in df_filtrado.columns and not df_filtrado.empty:
                usi_vals = df_filtrado['USI'].dropna().unique().tolist()
                if len(usi_vals) > 0:
                    df_w = df_w[df_w['USI'].astype(str).isin([str(v) for v in usi_vals])]
            if 'Período' in df_filtrado.columns and not df_filtrado.empty:
                per_vals = df_filtrado['Período'].dropna().unique().tolist()
                if len(per_vals) > 0:
                    df_w = df_w[df_w['Período'].isin(per_vals)]
        except Exception:
            pass

        df_w['Valor'] = pd.to_numeric(df_w.get('Valor'), errors='coerce').fillna(0)
        for col_name in ['Type 05', 'Type 06', 'Type 07']:
            if col_name in df_w.columns:
                df_w[col_name] = df_w[col_name].astype('string').fillna('(vazio)')

        soma_por_type = (
            df_w.groupby(['Type 05', 'Type 06', 'Type 07'], dropna=False)['Valor']
            .sum()
            .reset_index()
        )

    if ocultar_zeros:
        soma_por_type = soma_por_type[soma_por_type['Valor'].abs() > 0.0049]

    # Ordenar por valor desc para leitura
    if not soma_por_type.empty:
        soma_por_type = soma_por_type.sort_values('Valor', ascending=False)

    # Linha de total
    total_val = float(soma_por_type['Valor'].sum()) if not soma_por_type.empty else 0.0
    soma_total = pd.DataFrame({
        'Type 05': ['Total'], 'Type 06': [''], 'Type 07': [''], 'Valor': [total_val]
    })
    tabela_final = pd.concat([soma_por_type, soma_total], ignore_index=True)

    # Exibir
    def colorir_valores(val):
        if isinstance(val, (int, float)):
            if val < 0:
                return 'color: #e74c3c; font-weight: bold;'
            elif val > 0:
                return 'color: #27ae60; font-weight: bold;'
        return ''

    styled = tabela_final.style.format({'Valor': 'R$ {:,.2f}'}).map(colorir_valores, subset=['Valor'])
    st.dataframe(styled, use_container_width=True, height=500)

    # Download
    if st.button("📥 Baixar Soma por Types (Excel)", use_container_width=True, key="agg_download_types"):
        with st.spinner("Gerando arquivo da soma por types..."):
            from io import BytesIO
            output = BytesIO()
            with pd.ExcelWriter(output, engine='openpyxl') as writer:
                tabela_final.to_excel(writer, index=False, sheet_name='Soma_por_Types')
            output.seek(0)
            import base64
            b64 = base64.b64encode(output.getvalue()).decode()
            href = f'<a href="data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,{b64}" download="KE5Z_soma_por_types.xlsx">💾 Clique aqui para baixar a Soma por Types</a>'
            st.markdown(href, unsafe_allow_html=True)

# Footer
st.markdown("---")
st.info("💡 Dashboard KE5Z com otimizações de cache e memória")

# Informações de funcionalidades restauradas
col1, col2, col3 = st.columns(3)
with col1:
    st.success("✅ Exportação Excel")
with col2:
    st.success("✅ Gráficos Coloridos")
with col3:
    st.success("✅ Tabelas com Cores")

if is_cloud:
    st.success("☁️ Executando no Streamlit Cloud com otimizações")
else:
    st.success("💻 Executando localmente com performance máxima")