#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Script para corrigir problemas de codificação no arquivo

def corrigir_codificacao():
    # Ler o arquivo
    with open('pages/6_Extracao_Dados.py', 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Mapear caracteres problemáticos
    replacements = {
        'Ã§Ã£o': 'ção',
        'Ã¡': 'á',
        'Ã©': 'é',
        'Ã­': 'í',
        'Ã³': 'ó',
        'Ãº': 'ú',
        'Ã¢': 'â',
        'Ãª': 'ê',
        'Ã´': 'ô',
        'Ã ': 'à',
        'Ã§': 'ç',
        'Ã£': 'ã',
        'Ãµ': 'õ',
        'â³': '⚠️',
        'ðŸ"¥': '📦',
        'ðŸ"': '🚫',
        'ðŸ'¡': '💡'
    }
    
    # Aplicar correções
    for old, new in replacements.items():
        content = content.replace(old, new)
    
    # Salvar o arquivo
    with open('pages/6_Extracao_Dados.py', 'w', encoding='utf-8') as f:
        f.write(content)
    
    print('Codificação corrigida!')

if __name__ == "__main__":
    corrigir_codificacao()

