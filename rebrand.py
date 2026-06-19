import os
import glob
import re

components_dir = 'components'
files = glob.glob(os.path.join(components_dir, '*.tsx'))

for filepath in files:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    # Name replacements
    content = content.replace('Gigante Produtos Médicos', 'Grupo Abucci')
    content = content.replace('Gigante Pneus', 'Grupo Abucci')
    content = content.replace('Carreiras Gigante', 'Carreiras Grupo Abucci')
    content = content.replace('equipe da Gigante', 'equipe do Grupo Abucci')
    content = content.replace('Como chegar na Gigante', 'Como chegar no Grupo Abucci')
    content = content.replace('@gigante.com.br', '@grupoabucci.com.br')
    content = content.replace('estilo Gigante', 'estilo Grupo Abucci')
    
    # Specific sentence replacement
    content = content.replace(
        'A Gigante conecta pessoas a oportunidades e impulsiona tecnologia para o setor da saude em todo o Brasil.',
        'No Grupo Abucci, valorizamos pessoas, impulsionamos talentos e construímos juntos o melhor em soluções automotivas.'
    )

    # Color replacements (teal -> yellow)
    # We will do a generic replacement for teal-X to yellow-X, but for 600 we use 500
    content = content.replace('teal-600', 'yellow-500')
    content = content.replace('teal-700', 'yellow-600')
    content = content.replace('teal-500', 'yellow-400')
    content = content.replace('teal-800', 'yellow-700')
    content = content.replace('teal-900', 'yellow-800')
    
    content = content.replace('teal-50', 'yellow-50')
    content = content.replace('teal-100', 'yellow-100')
    content = content.replace('teal-200', 'yellow-200')
    content = content.replace('teal-300', 'yellow-300')
    content = content.replace('teal-400', 'yellow-400')
    
    # Fix contrast: white text on yellow-500 is bad. 
    # Change text-white to text-zinc-900 if bg-yellow-500 is in the same class string.
    # We will find class="..." strings and do a replace inside them.
    def class_replacer(match):
        class_str = match.group(1)
        if 'bg-yellow-500' in class_str and 'text-white' in class_str:
            class_str = class_str.replace('text-white', 'text-zinc-900')
        if 'bg-yellow-600' in class_str and 'text-white' in class_str:
            class_str = class_str.replace('text-white', 'text-zinc-900')
        return f'className="{class_str}"'
    
    content = re.sub(r'className="([^"]+)"', class_replacer, content)

    # Write back
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

print("Rebranding applied successfully.")
