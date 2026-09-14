# 🤝 Guia de Contribuição

Obrigado por interesse em contribuir com o **OpenCode Skills Knowledge Base**! Toda contribuição é muito bem-vinda e ajuda a tornar esta base de conhecimento ainda melhor.

## 📋 Índice

- [Tipos de Contribuição](#tipos-de-contribuição)
- [Como Começar](#como-começar)
- [Diretrizes de Contribuição](#diretrizes-de-contribuição)
- [Estilo de Código](#estilo-de-código)
- [Pull Requests](#pull-requests)
- [Issues](#issues)
- [Comunidade](#comunidade)

---

## 🎯 Tipos de Contribuição

### 🐛 Correção de Bugs
- Corrigir erros de digitação
- Corrigir links quebrados
- Corrigir exemplos de código com erros
- Corrigir formatação Markdown

### ✨ Novas Skills
- Adicionar documentação de novas skills
- Expandir documentação existente
- Adicionar mais exemplos práticos
- Melhorar casos de uso

### 📖 Documentação
- Melhorar文本os e explicações
- Adicionar traduções
- Criar tutoriais
- Escrever guias de uso

### 🎨 Design
- Melhorar a apresentação visual
- Criar ícones e imagens
- Melhorar a experiência do usuário
- Adicionar elementos visuais

### 🧪 Testes
- Testar exemplos de código
- Verificar links e referências
- Testar scripts
- Melhorar a qualidade

---

## 🚀 Como Começar

### 1. Fork o Repositório

```bash
# Clique no botão "Fork" no GitHub
# Ou use o comando:
gh repo fork passosnikolas5-coder/opencode-skills-knowledge-base
```

### 2. Clone o Repositório

```bash
git clone https://github.com/SEU-USUARIO/opencode-skills-knowledge-base.git
cd opencode-skills-knowledge-base
```

### 3. Crie uma Branch

```bash
# Para novas features
git checkout -b feature/nova-skill

# Para correções de bugs
git checkout -b fix/correcao-descricao

# Para melhorias na documentação
git checkout -b docs/melhoria-documentacao
```

### 4. Faça suas Alterações

```bash
# Adicione suas mudanças
git add .

# Faça o commit
git commit -m "Adiciona documentação para skill X"

# Push para o GitHub
git push origin feature/nova-skill
```

### 5. Crie um Pull Request

- Acesse o repositório no GitHub
- Clique em "New Pull Request"
- Selecione sua branch
- Adicione um título descritivo
- Descreva suas mudanças
- Aguarde a revisão

---

## 📝 Diretrizes de Contribuição

### Para Novas Skills

1. **Use o Template**: Copie `templates/skill-template.md`
2. **Siga o Formato**: Mantenha as 7 seções obrigatórias
3. **Seja Específico**: Inclua exemplos práticos reais
4. **Documente Tudo**: Quando usar, como usar, por que usar

### Para Melhorias

1. **Seja Construtivo**: Sugira melhorias, não críticas
2. **Inclua Evidências**: Por que a melhoria é necessária
3. **Teste**: Verifique se as mudanças funcionam
4. **Documente**: Explique o que mudou e por quê

### Para Bugs

1. **Descreva Claramente**: O que aconteceu vs. o que era esperado
2. **Inclua Passos**: Como reproduzir o problema
3. **Adicione Screenshots**: Se aplicável
4. **Sugira Solução**: Se souber como corrigir

---

## 🎨 Estilo de Código

### Markdown

```markdown
# Título Principal (H1)

## Subtítulo (H2)

### Seção (H3)

#### Subseção (H4)

**Negrito**
*Itálico*
`código inline`

```linguagem
// código de bloco
```

- Lista
- Itens

1. Lista numerada
2. Itens

[Link](https://exemplo.com)
![Imagem](url-da-imagem)
```

### Regras

1. **Use heading hierarchy**: H1 → H2 → H3 → H4
2. **Mantenha parágrafos curtos**: Máximo 3-4 linhas
3. **Use listas**: Para informações organizadas
4. **Inclua exemplos**: Sempre que possível
5. **Adicione links**: Para referências

### Código

```javascript
// Use syntax highlighting
function exemplo() {
  return "Olá, Mundo!";
}
```

```bash
# Use comentários explicativos
echo "Executando exemplo"
```

### Imagens

```markdown
![Descrição](caminho/para/imagem.png)
```

- Use nomes descritivos
- Mantenha resolução adequada
- Comprima quando possível

---

## 📋 Pull Requests

### Título

Use o formato:
```
[TIPO] Breve descrição
```

Exemplos:
- `[FEATURE] Adiciona skill react-patterns`
- `[FIX] Corrige link quebrado em backend_skills`
- `[DOCS] Melhora documentação de docker-expert`
- `[STYLE] Ajusta formatação de business_skills`

### Descrição

```markdown
## Descrição
Breve descrição das mudanças

## Tipo de Mudança
- [ ] Nova feature
- [ ] Correção de bug
- [ ] Melhoria na documentação
- [ ] Outro (especifique)

## Como Testar
1. Passo 1
2. Passo 2
3. Passo 3

## Screenshots (se aplicável)
[Adicione screenshots aqui]

## Checklist
- [ ] Minhas mudanças seguem o estilo do projeto
- [ ] Documentei minhas mudanças
- [ ] Testei minhas mudanças
- [ ] Adicionei exemplos práticos
```

### Revisão

1. **Aguarde revisão**: Um mantenedor revisará seu PR
2. **Responda feedback**: Faça as mudanças solicitadas
3. **Tests**: Certifique-se de que tudo funciona
4. **Merge**: Após aprovação, seu PR será merged

---

## 🐛 Issues

### Criar uma Issue

Use os templates disponíveis:
- 🐛 **Bug Report**: Para reportar problemas
- ✨ **Feature Request**: Para sugerir novas features
- 📖 **Documentation**: Para melhorias na documentação
- ❓ **Question**: Para tirar dúvidas

### Formato

```markdown
## Descrição
Descreva claramente o problema ou sugestão

## Comportamento Atual
O que acontece agora

## Comportamento Esperado
O que deveria acontecer

## Passos para Reproduzir
1. Passo 1
2. Passo 2
3. Passo 3

## Ambiente
- Sistema Operacional:
- Navegador:
- Versão:

## Screenshots
[Adicione screenshots se aplicável]

## Contexto
Qualquer outra informação relevante
```

---

## 🌟 Reconhecimento

### Contribuidores

Todos os contribuidores serão listados na seção "Agradecimentos" do README.

### Níveis de Contribuição

| Nível | Contribuição | Recompensa |
|-------|--------------|------------|
| 🥉 Bronze | 1-3 contribuições | Menção no README |
| 🥈 Prata | 4-10 contribuições | Destaque no README |
| 🥇 Ouro | 11+ contribuições | Seção especial |

### Badges

```markdown
![Bronze Contributor](https://img.shields.io/badge/Bronze-Contributor-yellow)
![Silver Contributor](https://img.shields.io/badge/Silver-Contributor-gray)
![Gold Contributor](https://img.shields.io/badge/Gold-Contributor-orange)
```

---

## 📞 Comunidade

### Canais de Comunicação

- **GitHub Discussions**: Para dúvidas e discussões
- **Issues**: Para bugs e sugestões
- **Pull Requests**: Para contribuições

### Código de Conduta

- Seja respeitoso com todos
- Foque no construtivo
- Ajude novos contribuidores
- Mantenha o foco no projeto

### Suporte

- 📖 **Documentação**: Leia os docs antes de perguntar
- 🔍 **Pesquise**: Verifique se já existe uma issue
- 📝 **Seja específico**: Descreva claramente seu problema
- 🙏 **Agradeça**: Reconheça ajuda recebida

---

## 🎓 Recursos

### Aprendizado

- [Guia de Markdown](https://www.markdownguide.org/)
- [GitHub Guides](https://guides.github.com/)
- [OpenCode Documentation](https://opencode.dev/docs)

### Ferramentas

- [VS Code](https://code.visualstudio.com/) - Editor de código
- [GitHub Desktop](https://desktop.github.com/) - Cliente Git
- [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) - Extensão VS Code

---

## 📜 Licença

Ao contribuir, você concorda que suas contribuições serão licenciadas sob a [Licença MIT](LICENSE).

---

## 🙏 Agradecimentos

Obrigado por contribuir com o **OpenCode Skills Knowledge Base**! Sua ajuda faz toda a diferença.

---

**Dúvidas?** Abra uma [issue](https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base/issues) ou entre em contato!

*Última atualização: Setembro 2026*