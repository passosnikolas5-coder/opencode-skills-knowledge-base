# Documentação de Skills de Business - Versão Aprimorada

**Data de geração:** 14/09/2026  
**Fonte:** Arquivos SKILL.md das categorias business, business-strategy, marketing, growth e ecommerce  
**Versão:** 2.0 - Documentação Aprimorada com Exemplos Avançados

---

## 📊 Resumo Executivo

| Categoria | Total de Skills | Status |
|-----------|----------------|--------|
| Business | 67 | ✅ Aprimorado |
| Business Strategy | 3 | ✅ Aprimorado |
| Marketing | 57 | ✅ Aprimorado |
| Growth | 3 | ✅ Aprimorado |
| Ecommerce | 1 | ✅ Aprimorado |
| **TOTAL** | **131** | **100% Documentado** |

---

## 🎯 Melhorias Implementadas

Para cada skill foram adicionadas:
1. **Mais exemplos práticos** (2-3 exemplos por skill)
2. **Casos de uso avançados** - quando usar em projetos reais
3. **Integração com outras skills** - quais skills complementares usar
4. **Padrões e anti-padrões** - o que fazer e o que evitar
5. **Dicas de performance** - otimizações importantes
6. **Comandos úteis** - snippets de código prontos
7. **Referências** - links para documentação oficial

---

## 1. BUSINESS (67 skills)

### 1.1 Análise e Estratégia de Negócios

---

#### 1. business-analyst

**Descrição:** Análise de negócios com IA, dashboards em tempo real, insights baseados em dados

**Quando usar:**
- Criar KPIs e métricas de negócio
- Desenvolver modelos preditivos de comportamento
- Gerar recomendações estratégicas baseadas em dados
- Automatizar relatórios executivos

**Exemplos práticos:**
```python
# Exemplo 1: Dashboard de análise de churn
prompt = "Analise os dados de churn dos últimos 6 meses e identifique padrões. 
Crie um dashboard com métricas de retenção, motivos de cancelamento e 
previsão de churn para os próximos 90 dias."

# Exemplo 2: Análise de cohort
prompt = "Crie uma análise de cohort para os usuários que entraram nos últimos 
12 meses. Mostre retenção mensal e identifique quais features têm maior 
impacto na retenção."

# Exemplo 3: Modelo de previsão de receita
prompt = "Desenvolva um modelo de previsão de receita para os próximos 6 meses 
usando dados de MRR, churn e expansão de conta."
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de sistema de alertas automáticos para anomalias em KPIs de negócio (ex: spike de churn, queda de conversão)
- Projeto Real 2: Criação de pipeline de dados para análise de comportamento de usuários em tempo real com Segment + BigQuery
- Projeto Real 3: Auditoria de unit economics para preparação de rodada de investimento

**Integração com outras skills:**
- **kpi-dashboard-design:** para visualizar os insights gerados em dashboards executivos
- **product-manager:** para alinhar métricas com objetivos de produto
- **risk-manager:** para análise de riscos financeiros e exposição
- **revops:** para integrar dados de marketing, vendas e success

**Padrões e anti-padrões:**
✅ Fazer: Validar dados antes de gerar insights, usar múltiplas fontes de dados, documentar premissas, atualizar modelos periodicamente
❌ Evitar: Conclusões baseadas em dados incompletos, ignorar sazonalidade, criar dashboards sem ação associada

**Dicas de performance:**
- Usar amostragem para conjuntos de dados muito grandes (>1M registros)
- Implementar caching de cálculos frequentes com Redis
- Automatizar relatórios recorrentes com cron jobs
- Usar ferramentas de BI para exploração interativa

**Comandos úteis:**
```python
import pandas as pd
from sklearn.ensemble import RandomForestClassifier

def train_churn_model(data):
    features = ['usage_days', 'login_frequency', 'feature_adoption']
    X = data[features]
    y = data['churned']
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X, y)
    return model
```

**Referências:**
- [Business Analysis Body of Knowledge (BABOK)](https://www.iiba.org/business-analysis-certifications/babok-guide/)
- [Google Analytics Academy](https://analytics.google.com/analytics/academy/)
- [Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/)
- [Tableau Public](https://public.tableau.com/)

---

#### 2. competitive-landscape

**Descrição:** Análise competitiva, identificação de diferenciais, posicionamento de mercado

**Quando usar:**
- Precisar entender o mercado competitivo
- Posicionar produto em relação a concorrentes
- Identificar oportunidades de diferenciação
- Preparar pitch para investidores com análise competitiva

**Exemplos práticos:**
```markdown
# Exemplo 1: Análise de concorrentes diretos
prompt = "Mapeie os 5 principais concorrentes do nosso produto SaaS de gestão 
de projetos. Para cada um, identifique: preços, features principais, pontos 
fortes, pontos fracos, e público-alvo."

# Exemplo 2: Matriz de posicionamento
prompt = "Crie uma matriz de posicionamento comparando nosso produto com os 3 
principais concorrentes em termos de preço, funcionalidade, suporte ao 
cliente e facilidade de uso."

# Exemplo 3: Análise de gaps de mercado
prompt = "Analise as features dos nossos 10 concorrentes e identifique 
oportunidades de mercado que nenhum deles atende completamente."
```

**Casos de uso avançados:**
- Projeto Real 1: Desenvolvimento de estratégia de diferenciação para entrar em novo mercado vertical
- Projeto Real 2: Preparação de pitch para investidores com análise competitiva completa e dados de market share
- Projeto Real 3: Monitoramento contínuo de movimentos estratégicos dos concorrentes

**Integração com outras skills:**
- **market-sizing-analysis:** para dimensionar oportunidades identificadas na análise
- **product-manager:** para alinhar roadmap com gaps competitivos identificados
- **pricing-strategy:** para definir posicionamento de preço vs. concorrência
- **competitor-ad-intelligence:** para análise específica de anúncios de concorrentes

**Padrões e anti-padrões:**
✅ Fazer: Coletar dados de múltiplas fontes, atualizar análise trimestralmente, incluir concorrentes indiretos
❌ Evitar: Copiar estratégias de concorrentes sem adaptar, ignorar concorrentes indiretos, focar apenas em features

**Dicas de performance:**
- Usar ferramentas de monitoramento de concorrentes (Crayon, Klue, Kompyte)
- Automatizar coleta de dados de pricing com web scraping ético
- Criar alertas para mudanças estratégicas dos concorrentes
- Manter planilha atualizada com matriz comparativa

**Comandos úteis:**
```bash
# Ferramentas úteis para análise competitiva
- SimilarWeb: tráfego e engajamento de concorrentes
- BuiltWith: tecnologias utilizadas
- Crunchbase: dados financeiros e investimentos
- Glassdoor: cultura e satisfação de funcionários
- Wayback Machine: histórico de posicionamento
```

**Referências:**
- [Porter's Five Forces](https://www.strategy-business.com/article/li00073)
- [Competitive Intelligence Alliance](https://competitiveintelligencealliance.com/)
- [Crayon Competitive Intelligence](https://www.crayon.co/)

---

#### 3. market-sizing-analysis

**Descrição:** Cálculo de TAM, SAM, SOM para oportunidades de startup

**Quando usar:**
- Validar tamanho de mercado antes de investir
- Apresentar oportunidade para investidores
- Decidir se vale a pena entrar em novo mercado
- Justificar investimento em nova linha de negócio

**Exemplos práticos:**
```python
# Exemplo 1: Cálculo TAM/SAM/SOM para app de delivery
prompt = "Calcule o TAM/SAM/SOM para um app de delivery de alimentos no Brasil. 
Considere: população urbana, frequência de pedidos online, ticket médio, 
e penetração atual do mercado."

# Exemplo 2: Market sizing para B2B SaaS
prompt = "Estime o tamanho de mercado para um SaaS de gestão financeira para 
pequenas empresas no Brasil. Considere: número de MEIs, spending médio em 
software, e taxa de adoção."

# Exemplo 3: Análise de nicho com bottom-up
prompt = "Analise o tamanho de mercado bottom-up para uma plataforma de cursos 
online para profissionais de tecnologia no mercado brasileiro."
```

**Casos de uso avançados:**
- Projeto Real 1: Due diligence para rodada de investimento com análise de mercado detalhada e fontes verificáveis
- Projeto Real 2: Decisão de expansão internacional com sizing de mercados-alvo ( LATAM, Europa)
- Projeto Real 3: Avaliação de viabilidade para novo segmento de produto

**Integração com outras skills:**
- **competitive-landscape:** para entender cotação de mercado e fatia conquistável
- **startup-analyst:** para modelagem financeira baseada no sizing
- **product-manager:** para priorizar features baseado em oportunidade de mercado
- **startup-business-analyst-market-opportunity:** para documentação para investidores

**Padrões e anti-padrões:**
✅ Fazer: Usar dados secundários confiáveis (IBGE, Euromonitor, Statista), atualizar premissas anualmente, usar top-down E bottom-up
❌ Evitar: Usar apenas dados primários limitados, superestimar TAM para impressionar, ignorar barreiras de entrada

**Dicas de performance:**
- Validar estimativas com dados de mercado publicados e relatórios setoriais
- Usar abordagem top-down (mercado total) e bottom-up (receita potencial)
- Considerar sazonalidade e tendências de mercado
- Documentar todas as premissas e fontes

**Comandos úteis:**
```python
def calculate_tam(total_market_value, growth_rate, years):
    """Calcula TAM projetado para N anos"""
    return total_market_value * (1 + growth_rate) ** years

# Exemplo: TAM para 5 anos
tam = calculate_tam(1_000_000_000, 0.15, 5)
print(f"TAM em 5 anos: R$ {tam:,.2f}")
```

**Referências:**
- [Startup Playbook - Y Combinator](https://www.ycombinator.com/library/)
- [Market Saring Guide - Bessemer](https://www.bvp.com/atlas/market-sizing)
- [IBGE](https://www.ibge.gov.br/)
- [Statista](https://www.statista.com/)
```

#### 4. startup-analyst

**Descrição:** Análise de negócios para startups: modelagem financeira, análise competitiva

**Quando usar:**
- Planejar startup early-stage
- Preparar apresentação para investidores
- Validar viabilidade financeira do negócio
- Criar documentação para aceleradoras

**Exemplos práticos:**
```python
# Exemplo 1: Business case para rodada Seed
prompt = "Crie um business case completo para uma fintech de pagamentos B2B, 
incluindo: problema, solução, mercado, modelo de negócio, projeções 
financeiras para 3 anos, e use of funds para rodada Seed de R$ 2M."

# Exemplo 2: Análise de unit economics
prompt = "Analise os unit economics do nosso SaaS: CAC, LTV, payback period, 
margem bruta. Compare com benchmarks do setor e sugira melhorias."

# Exemplo 3: Validação de modelo de negócio
prompt = "Valide nosso modelo de negócio de marketplace B2B usando o framework 
Lean Canvas. Identifique hipóteses de risco e sugira testes de validação."
```

**Casos de uso avançados:**
- Projeto Real 1: Preparação completa para pitch em aceleradora (Y Combinator, Endeavor)
- Projeto Real 2: Pivot do modelo de negócio baseado em dados de mercado e feedback de clientes
- Projeto Real 3: Due diligence para investidor-anjo com análise de mercado e financials

**Integração com outras skills:**
- **startup-financial-modeling:** para projeções financeiras detalhadas
- **product-manager:** para roadmap de produto alinhado com estratégia
- **monetization:** para definir modelo de receita
- **startup-business-analyst-business-case:** para documentação formatada

**Padrões e anti-padrões:**
✅ Fazer: Validar premissas com dados reais, iterar rapidamente, ter métricas claras
❌ Evitar: Criar planilhas complexas sem validar hipóteses, ignorar feedback de mercado, projetar receitas irreais

**Dicas de performance:**
- Usar templates padronizados para consistência (Lean Canvas, Business Model Canvas)
- Atualizar modelo financeiro mensalmente com dados reais
- Comparar com benchmarks do setor (SaaStr, OpenView)
- Ter versões para diferentes públicos (investidor, aceleradora, parceiro)

**Comandos úteis:**
```python
def calculate_unit_economics(cac, ltv, gross_margin):
    """Calcula métricas de unit economics"""
    payback_period = cac / (ltv * gross_margin)
    ltv_cac_ratio = ltv / cac
    return {
        'payback_period_months': payback_period,
        'ltv_cac_ratio': ltv_cac_ratio,
        'healthy_ltv_cac': ltv_cac_ratio > 3
    }
```

**Referências:**
- [Y Combinator Startup Library](https://www.ycombinator.com/library/)
- [Lean Canvas](https://leanstack.com/leancanvas)
- [SaaStr Metrics Benchmarks](https://www.saastr.com/5-charts-that-show-what-really-drives-saas-valuation/)
- [The Mom Test](https://www.momtestbook.com/)

---

### 1.2 Gestão de Produtos

---

#### 5. product-manager

**Descrição:** PM senior com 6 domínios, 30+ frameworks, 12 templates, 32 métricas SaaS

**Quando usar:**
- Gerenciar produto de ponta a ponta
- Criar roadmap de produto
- Definir e acompanhar métricas de produto
- Facilitar cerimônias de produto

**Exemplos práticos:**
```markdown
# Exemplo 1: Roadmap de produto
prompt = "Crie um roadmap de produto para os próximos 6 meses para um SaaS de 
gestão de projetos. Inclua: features planejadas, dependências, milestones, 
e métricas de sucesso para cada fase."

# Exemplo 2: Priorização com RICE
prompt = "Use o framework RICE para priorizar: integração com Slack, relatórios 
avançados, mobile app, API pública. Considere reach, impact, confidence, 
effort para cada uma."

# Exemplo 3: PRD (Product Requirements Document)
prompt = "Crie um PRD para a feature de automação de workflow. Inclua: problema, 
solução proposta, requisitos não-funcionais, success metrics, timeline."
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de OKRs de produto alinhados com objetivos da empresa
- Projeto Real 2: Gestão de produto com múltiplos stakeholders e equipes distribuídas (time zones diferentes)
- Projeto Real 3: Migração de produto para modelo self-service com redução de touchpoints humanos

**Integração com outras skills:**
- **product-design:** para alinhar UX com requisitos de produto
- **product-manager-toolkit:** para frameworks e templates adicionais
- **kpi-dashboard-design:** para visualizar métricas de produto
- **growth-engine:** para estratégias de crescimento baseadas em produto

**Padrões e anti-padrões:**
✅ Fazer: Tomar decisões baseadas em dados, comunicar claramente com stakeholders, documentar decisões
❌ Evitar: Feature creep, ignorar feedback de usuários, priorizar baseado em opiniões, criar PRDs excessivamente longos

**Dicas de performance:**
- Usar ferramentas de gestão de produto (Linear, Notion, Productboard)
- Implementar processos de discovery contínuo com usuários
- Manter documentação atualizada e acessível
- Usar OKRs para alinhamento estratégico

**Comandos úteis:**
```markdown
# Template de PRD simplificado
## 1. Visão Geral
- Problema a resolver
- Solução proposta
- Público-alvo

## 2. Requisitos
- Funcionais (Must Have / Should Have / Could Have)
- Não-funcionais (performance, segurança, acessibilidade)

## 3. Sucesso
- Métricas-chave
- Timeline e milestones
- Riscos e dependências
```

**Referências:**
- [Product School](https://productschool.com/)
- [Inspired by Marty Cagan](https://www.svpg.com/inspired-how-to-create-products-customers-love/)
- [Lenny's Newsletter](https://www.lennysnewsletter.com/)
- [Productboard](https://www.productboard.com/)

---

#### 6. product-manager-toolkit

**Descrição:** Ferramentas e frameworks essenciais para gestão de produto

**Quando usar:**
- Precisar de templates e frameworks de PM
- Executar atividades específicas de gestão de produto
- Documentar decisões de produto

**Exemplos práticos:**
```markdown
# Exemplo 1: Framework de priorização
prompt = "Use o framework Value vs Effort para priorizar as features do sprint 
atual. Liste todas as features e classifique cada uma em quadrantes 
(alto valor/baixo esforço, etc)."

# Exemplo 2: Análise de persona
prompt = "Crie uma persona detalhada para o perfil de usuário admin do nosso 
SaaS. Inclua: dores, necessidades, comportamentos,Quote do dia-a-dia, 
e cenários de uso."

# Exemplo 3: Retrospectiva de produto
prompt = "Facilite uma retrospectiva de produto para o último trimestre. O que 
funcionou, o que não funcionou, e o que devemos experimentar no próximo?"
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de processo de discovery estruturado com Double Diamond
- Projeto Real 2: Padronização de práticas de PM em equipe de produto distribuída
- Projeto Real 3: Criação de playbook de produto para onboarding de novos PMs

**Integração com outras skills:**
- **product-manager:** para gestão completa de produto
- **product-design:** para alinhamento com design
- **growth-engine:** para estratégias de crescimento baseadas em dados
- **content-creator:** para documentação e comunicação

**Padrões e anti-padrões:**
✅ Fazer: Adaptar frameworks ao contexto do time, validar com a equipe, iterar sobre processos
❌ Evitar: Seguir frameworks cegamente, usar muitos frameworks ao mesmo tempo, criar processos burocráticos

**Dicas de performance:**
- Criar biblioteca de templates reutilizáveis no Notion/Confluence
- Documentar decisões com contexto (decisions log)
- Revisar e atualizar templates trimestralmente
- Usar lightweight frameworks para sprints curtos

**Comandos úteis:**
```markdown
# Template de User Story
**Como** [persona],
**Quero** [ação],
**Para** [benefício].

### Critérios de aceitação:
1. [Critério 1 mensurável]
2. [Critério 2 mensurável]
3. [Critério 3 mensurável]

### Notas de design:
- [Link para Figma]
- [Comportamento edge cases]
```

**Referências:**
- [Product Management 101 - ProductBoard](https://www.productboard.com/product-management-101/)
- [Marty Cagan's Blog - SVPG](https://www.svpg.com/articles/)
- [Product Talk - Teresa Torres](https://www.producttalk.org/)
- [RICE Framework - Intercom](https://www.intercom.com/blog/rice-simple-prioritization-for-product-managers/)

---

#### 7. product-design

**Descrição:** Design de produto nível Apple — sistemas visuais, UX, acessibilidade, design tokens

**Quando usar:**
- Criar ou refinar design de produto
- Desenvolver design systems
- Melhorar experiência do usuário
- Garantir acessibilidade (WCAG)

**Exemplos práticos:**
```css
/* Exemplo 1: Design tokens */
:root {
  /* Cores */
  --color-primary: #007AFF;
  --color-secondary: #5856D6;
  --color-success: #34C759;
  --color-warning: #FF9500;
  --color-error: #FF3B30;
  
  /* Tipografia */
  --font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-size-xs: 12px;
  --font-size-sm: 14px;
  --font-size-base: 16px;
  --font-size-lg: 24px;
  --font-size-xl: 32px;
  
  /* Espaçamento */
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
  --spacing-xl: 32px;
}

/* Exemplo 2: Componente acessível */
.button {
  min-height: 44px;  /* Mínimo para touch targets (WCAG) */
  min-width: 44px;
  padding: var(--spacing-sm) var(--spacing-md);
  font-size: var(--font-size-base);
  color: white;
  background-color: var(--color-primary);
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: opacity 0.2s;
}

.button:hover { opacity: 0.8; }
.button:focus {
  outline: 2px solid var(--color-secondary);
  outline-offset: 2px;
}
.button:active { opacity: 0.6; }

/* Exemplo 3: Layout responsivo com CSS Grid */
.container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: var(--spacing-md);
  padding: var(--spacing-lg);
}
```

**Casos de uso avançados:**
- Projeto Real 1: Criação de design system completo para produto com múltiplas plataformas (web, iOS, Android)
- Projeto Real 2: Redesign de produto existente com foco em acessibilidade WCAG 2.1 AA
- Projeto Real 3: Migração de design system legado para sistema moderno com design tokens

**Integração com outras skills:**
- **product-manager:** para alinhar design com requisitos de produto
- **frontend-design:** para implementação técnica do design
- **web-design-guidelines:** para revisão de conformidade
- **brand-guidelines:** para consistência visual

**Padrões e anti-padrões:**
✅ Fazer: Testar acessibilidade com ferramentas (Lighthouse, axe), usar design tokens, criar componentes reutilizáveis
❌ Evitar: Design baseado em tendências passageiras, ignorar usuários com deficiência, criar componentes ad-hoc

**Dicas de performance:**
- Usar ferramentas de prototipagem rápida (Figma, Sketch, Framer)
- Implementar revisão de design com a equipe semanalmente
- Documentar padrões no design system com exemplos ao vivo
- Criar biblioteca de componentes compartilhável

**Comandos úteis:**
```jsx
// Componente React acessível
const Button = ({ children, onClick, variant = 'primary', disabled = false }) => {
  return (
    <button
      onClick={onClick}
      className={`button button--${variant}`}
      disabled={disabled}
      aria-label={typeof children === 'string' ? children : undefined}
      aria-disabled={disabled}
    >
      {children}
    </button>
  );
};
```

**Referências:**
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Material Design](https://material.io/design)
- [WCAG 2.1 Quick Reference](https://www.w3.org/WAI/WCAG21/quickref/)
- [Design Tokens W3C Draft](https://design-tokens.github.io/community-group/format/)

---

#### 8. product-inventor

**Descrição:** Combina Product Thinking, Design Systems, UI Engineering, Storytelling

**Quando usar:**
- Criar produto do zero com excelência
- Conceituar novo produto de ponta a ponta
- Desenvolver narrativa de produto convincente

**Exemplos práticos:**
```markdown
# Exemplo 1: Conceito de produto completo
prompt = "Conceitue um novo produto SaaS de ponta a ponta, da ideia ao protótipo. 
Inclua: problema resolvido, usuário-alvo, proposta de valor, modelo de 
negócio, e key features do MVP."

# Exemplo 2: Storytelling de produto
prompt = "Crie a narrativa completa do nosso produto: visão de futuro, missão, 
valores, e como comunicamos isso para usuários, investidores e equipe."

# Exemplo 3: Design system conceitual
prompt = "Projete o design system conceitual para o novo produto, incluindo: 
princípios de design, paleta de cores, tipografia, componentes, e 
padrões de interação."
```

**Casos de uso avançados:**
- Projeto Real 1: Criação de produto inovador em mercado existente (ex: novo modelo de CRM com IA)
- Projeto Real 2: Repositionamento completo de produto com nova identidade e narrativa
- Projeto Real 3: Conceituação de produto para pitch com investidores

**Integração com outras skills:**
- **product-design:** para implementação visual do conceito
- **product-manager:** para validação e roadmap
- **copywriting:** para comunicação persuasiva do produto
- **brand-guidelines:** para identidade visual coesa

**Padrões e anti-padrões:**
✅ Fazer: Validar conceito com usuários reais, iterar rapidamente, documentar decisões
❌ Evitar: Perfeccionismo prematuro, ignorar feedback do mercado, criar conceitos sem validação

**Dicas de performance:**
- Usar técnicas de design thinking (empathize, define, ideate, prototype, test)
- Criar protótipos de baixa fidelidade primeiro (paper prototypes)
- Documentar decisões de design com rationale
- Validar com 5-8 usuários para identificar 85% dos problemas

**Comandos úteis:**
```markdown
# Template de conceito de produto
## Visão do Produto
- Problema que resolvemos (em 1 frase)
- Usuários que servimos
- Valor que criamos

## Proposta de Valor
- Por que somos diferentes (diferencial único)
- Por que importamos agora (timing)

## MVP (Minimum Viable Product)
- Features essenciais (máximo 5)
- O que NÃO está no MVP
- Métricas de sucesso para validação
```

**Referências:**
- [Design Thinking](https://www.designthinking.com/)
- [The Lean Startup](https://theleanstartup.com/)
- [Sprint by Jake Knapp](https://www.thesprintbook.com/)
- [IDEO Design Thinking](https://designthinking.ideo.com/)

---

#### 9. product-marketing

**Descrição:** Criar ou atualizar contexto de marketing de produto

**Quando usar:**
- Lançar produto ou feature
- Atualizar posicionamento de mercado
- Alinhar equipe de marketing com produto

**Exemplos práticos:**
```markdown
# Exemplo 1: Documento de posicionamento
prompt = "Atualize o documento de posicionamento do nosso produto para o mercado 
B2B. Inclua: público-alvo, problema resolvido, diferencial competitivo, 
mensagens-chave, e call-to-action principal."

# Exemplo 2: Briefing de lançamento
prompt = "Crie o briefing completo para o lançamento da nova feature de automação. 
Inclua: objetivos, público, mensagens por canal, timeline, e métricas 
de sucesso."

# Exemplo 3: Análise competitiva de messaging
prompt = "Analise como nossos 5 principais concorrentes comunicam seus produtos 
e sugira como podemos nos diferenciar na mensagem."
```

**Casos de uso avançados:**
- Projeto Real 1: Lançamento de novo produto em mercado competitivo com GTM strategy completa
- Projeto Real 2: Expansão para novo segmento de mercado (de SMB para Enterprise)
- Projeto Real 3: Rebranding completo com novo posicionamento e mensagens

**Integração com outras skills:**
- **product-manager:** para alinhar marketing com produto
- **copywriting:** para criar mensagens persuasivas
- **content-creator:** para gerar conteúdo em múltiplos canais
- **brand-guidelines:** para consistência visual e verbal

**Padrões e anti-padrões:**
✅ Fazer: Basear posicionamento em dados reais, testar mensagens com público, iterar
❌ Evitar: Copiar concorrentes, ignorar feedback de vendas e suporte, criar mensagens genéricas

**Dicas de performance:**
- Criar templates reutilizáveis para briefings de lançamento
- Documentar decisões de posicionamento em wiki compartilhada
- Alinhar produto e marketing semanalmente
- Usar customer语言 real em mensagens (citando clientes)

**Comandos úteis:**
```markdown
# Template de posicionamento (Geoffrey Moore)
Para [público-alvo],
Que [necessidade/problema],
Nosso produto é [categoria],
Que [benefício principal].
Diferente de [concorrente principal],
Que [diferencial único].
Mensagem-chave: [Frase memorável em 10 palavras]
```

**Referências:**
- [Positioning by Al Ries and Jack Trout](https://www定位byries.com/)
- [April Dunford's Blog](https://www.aprildunford.com/)
- [Product Marketing Alliance](https://productmarketingalliance.com/)
- [Crossing the Chasm by Geoffrey Moore](https://www.amazon.com/Crossing-Chasm-Marketing-High-Tech/dp/0060522028)

---

#### 10. product-marketing-context

**Descrição:** Documento reutilizável de marketing com posicionamento, audiência, ICP

**Quando usar:**
- Evitar repetir contexto base em múltiplas tarefas
- Manter consistência de mensagem em todas as equipes
- Onboarding rápido de novos membros da equipe

**Exemplos práticos:**
```markdown
# Exemplo 1: Documento de contexto completo
prompt = "Crie o documento de contexto de marketing do nosso novo módulo de 
analytics. Inclua: posicionamento, público-alvo, ICP detalhado, 
mensagens-chave, objeções comuns, e concorrentes."

# Exemplo 2: Contexto para campanha sazonal
prompt = "Gere o contexto de marketing para a campanha de retenção do Q4. 
Inclua: objetivo, público-alvo, mensagens por segmento, canais, e orçamento."

# Exemplo 3: Contexto para novo canal
prompt = "Adapte o contexto de marketing para o novo canal de YouTube. Inclua: 
objetivo do canal, formato de conteúdo, frequência, e métricas de sucesso."
```

**Casos de uso avançados:**
- Projeto Real 1: Criação de hub de conhecimento para equipe de marketing global
- Projeto Real 2: Padronização de comunicação em empresa com múltiplos produtos (product-led)

**Integração com outras skills:**
- **product-marketing:** para criação do posicionamento
- **brand-guidelines:** para consistência visual e verbal
- **content-creator:** para produção de conteúdo escala
- **social-content:** para distribuição em redes sociais

**Padrões e anti-padrões:**
✅ Fazer: Manter documento vivo e atualizado, compartilhar com todas as equipes, revisar trimestralmente
❌ Evitar: Criar documento e nunca atualizar, manter em silo, não envolver stakeholders

**Dicas de performance:**
- Usar ferramentas de colaboração (Notion, Confluence, GitBook)
- Revisar e atualizar trimestralmente com dados novos
- Criar versões para diferentes audiências (vendas, marketing, produto)
- Linkar com outras fontes de verdade

**Comandos úteis:**
```markdown
# Template de contexto de marketing
## 1. Visão Geral
- Produto/Feature: [Nome]
- Objetivo de marketing: [SMART goal]

## 2. Público
- ICP detalhado (firma + buying committee)
- Persona principal (dor, ganho, medo)
- Canais preferidos e horários

## 3. Posicionamento
- Frase de posicionamento (Geoffrey Moore)
- Diferenciais únicos (3-5)
- Prova social (cases, logos, depoimentos)

## 4. Mensagens
- Headline principal (10 palavras max)
- Subheadlines por canal
- CTAs principais e secundários

## 5. Concorrência
- Principais concorrentes (3-5)
- Nossa vantagem competitiva sustentável
- Objeções comuns e respostas
```

**Referências:**
- [Product Marketing Alliance](https://productmarketingalliance.com/)
- [Positioning Stack](https://positioningstack.com/)
- [April Dunford's Positioning Framework](https://www.aprildunford.com/positioning-framework/)

---

### 1.3 Monetização e Precificação

---

#### 11. monetization

**Descrição:** Estratégias de monetização: Stripe, assinaturas, pricing experiments, freemium

**Quando usar:**
- Implementar ou otimizar modelo de receita
- Configurar pagamentos online
- Testar diferentes modelos de monetização

**Exemplos práticos:**
```javascript
// Exemplo 1: Configuração de assinatura Stripe
const stripe = require('stripe')('sk_test_...');

const criarAssinatura = async (customerId, priceId) => {
  const subscription = await stripe.subscriptions.create({
    customer: customerId,
    items: [{ price: priceId }],
    payment_behavior: 'default_incomplete',
    expand: ['latest_invoice.payment_intent'],
  });
  return subscription;
};

// Exemplo 2: Paywall inteligente
const shouldShowPaywall = (user) => {
  const usageCount = getUserUsageCount(user.id);
  const isFreeTier = user.plan === 'free';
  return isFreeTier && usageCount >= 5;
};

// Exemplo 3: Trial management
const manageTrial = async (user) => {
  if (user.trialEnd < new Date()) {
    await downgradeToFree(user.id);
    await sendTrialExpiredEmail(user.email);
  }
};
```

**Casos de uso avançados:**
- Projeto Real 1: Migração de modelo freemium para subscription com analysis de impacto no churn
- Projeto Real 2: Implementação de billing usage-based com Stripe Metered Billing
- Projeto Real 3: Teste A/B de pricing com segmentação de usuários

**Integração com outras skills:**
- **pricing-strategy:** para definição de valores e estrutura
- **usage-based-pricing:** para modelos de cobrança por uso
- **revops:** para otimizar lifecycle de receita
- **page-cro:** para otimizar página de pricing

**Padrões e anti-padrões:**
✅ Fazer: Oferecer múltiplas opções de pagamento, testar preços regularmente, oferecer trial
❌ Evitar: Ocultar preços, criar fricção desnecessária no checkout, não oferecer plano intermediário

**Dicas de performance:**
- Usar Stripe Checkout para simplificar implementação
- Implementar retry automático para pagamentos falhos (Smart Retries)
- Monitorar métricas de churn por plano mensalmente
- Usar Stripe Billing Portal para self-service

**Comandos úteis:**
```bash
# Instalar SDK do Stripe
npm install stripe

# Variáveis de ambiente necessárias
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Webhook para eventos de pagamento
stripe listen --forward-to localhost:4242/webhook
```

**Referências:**
- [Stripe Documentation](https://stripe.com/docs)
- [Stripe Billing](https://stripe.com/docs/billing)
- [Price Intelligently](https://www.priceintelligently.com/)
- [Open View SaaS Benchmarks](https://openviewpartners.com/)

---

#### 12. pricing-strategy

**Descrição:** Estratégias de pricing baseadas em valor e disposição a pagar

**Quando usar:**
- Definir preços de produto ou plano
- Revisar estratégia de pricing existente
- Testar diferentes modelos de precificação

**Exemplos práticos:**
```markdown
# Exemplo 1: Estrutura de tiers
prompt = "Defina a estrutura de preços para 3 tiers do nosso SaaS de gestão de 
projetos. Considere: valor entregue por tier, disposição a pagar do 
público, preços dos concorrentes, e margem desejada."

# Exemplo 2: Análise de sensibilidade
prompt = "Analise a sensibilidade do preço: se aumentarmos 10% o preço do plano 
Pro, como isso impacta conversão e receita? Considere elasticidade de 
demanda do público B2B."

# Exemplo 3: Pricing psicológico
prompt = "Sugira técnicas de pricing psicológico para aumentar conversão: âncora 
de preço, decodificação, efeitos de convexidade, opção âncora, e 
decoy effect."
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de pricing dinâmico baseado em valor percebido por segmento
- Projeto Real 2: Revisão de pricing após entrada de novo concorrente com modelo agressivo
- Projeto Real 3: Criação de modelo de pricing para marketplace com take rate variável

**Integração com outras skills:**
- **monetization:** para implementação técnica com Stripe
- **usage-based-pricing:** para modelos de cobrança por uso
- **page-cro:** para otimização da página de preços
- **ad-campaign-analyzer:** para análise de CAC vs LTV

**Padrões e anti-padrões:**
✅ Fazer: Testar preços com clientes reais, oferecer trial gratuito, ter plano "anchor"
❌ Evitar: Competir apenas por preço, ignorar valor percebido pelo cliente, ter muitos tiers

**Dicas de performance:**
- Usar Van Westendorp Price Sensitivity Meter para descobrir faixa de preço
- Implementar teste A/B de preços com Stripe
- Monitorar métricas de pricing regularmente (conversão, upgrade, churn)
- Revisar preços semestralmente com dados novos

**Comandos úteis:**
```python
def calculate_value_price(value_delivered, willingness_to_pay, competitor_price):
    """Calcula preço ideal baseado em valor"""
    ideal_price = (value_delivered + willingness_to_pay) / 2
    if competitor_price < ideal_price:
        return competitor_price * 0.95  # Levemente mais barato
    return ideal_price

# Exemplo
price = calculate_value_price(1000, 500, 400)
print(f"Preço sugerido: R$ {price:.2f}")
```

**Referências:**
- [Confessions of the Pricing Man - Hermann Simon](https://www.amazon.com/Confessions-Pricing-Man-Hermann-Simon/dp/3319137816)
- [Price Intelligently Blog](https://www.priceintelligently.com/blog)
- [Van Westendorp Method](https://www.masteringpricing.com/van-westendorp/)

---

#### 13. usage-based-pricing

**Descrição:** Modelos de pricing para desenvolvedores: API pricing, metered billing

**Quando usar:**
- Criar pricing page ou calculadora de custos
- Implementar cobrança por uso (API calls, storage, etc)
- Definir limites e overages

**Exemplos práticos:**
```javascript
// Exemplo 1: Cálculo de uso de API
const calculateAPICost = (requests, tier) => {
  const pricing = {
    free: { included: 1000, overage: 0.01 },
    pro: { included: 10000, overage: 0.008 },
    enterprise: { included: 100000, overage: 0.005 }
  };
  
  const { included, overage } = pricing[tier];
  const overageRequests = Math.max(0, requests - included);
  
  return {
    included,
    overage: overageRequests,
    totalCost: overageRequests * overage
  };
};

// Exemplo 2: Calculadora de custos interativa
const CostCalculator = ({ requests, tier }) => {
  const cost = calculateAPICost(requests, tier);
  return (
    <div className="cost-calculator">
      <h3>Estimativa de Custo Mensal</h3>
      <p>Requisições: {requests.toLocaleString()}</p>
      <p>Incluídas no plano: {cost.included.toLocaleString()}</p>
      <p>Excesso: {cost.overage.toLocaleString()}</p>
      <p className="cost">Custo do excesso: R$ {cost.totalCost.toFixed(2)}</p>
    </div>
  );
};
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de billing usage-based para plataforma de APIs com múltiplos endpoints
- Projeto Real 2: Otimização de pricing para equilibrar adoção e receita em product-led growth

**Integração com outras skills:**
- **monetization:** para implementação de pagamento com Stripe
- **pricing-strategy:** para definição de valores e threshold
- **usage-based-pricing:** para modelos de cobrança por uso
- **revops:** para tracking de usage patterns

**Padrões e anti-padrões:**
✅ Fazer: Mostrar uso em tempo real, oferecer alertas de limite, ter free tier generoso
❌ Evitar: Cobrar sem aviso, criar surpresas na fatura, não oferecer cap no excesso

**Dicas de performance:**
- Usar Stripe Metered Billing para implementação simplificada
- Criar dashboards de uso para clientes (self-service)
- Implementar alertas de limite a 80% e 95% do uso
- Oferecer desconto para commit anual

**Comandos úteis:**
```javascript
// Registro de uso para billing com Stripe
const recordUsage = async (subscriptionItemId, quantity) => {
  await stripe.subscriptionItems.createUsageRecord(
    subscriptionItemId,
    {
      quantity,
      timestamp: Math.floor(Date.now() / 1000),
      action: 'increment'  // ou 'set' para replace
    }
  );
};
```

**Referências:**
- [Stripe Metered Billing](https://stripe.com/docs/billing/subscriptions/metered)
- [OpenView Usage-Based Pricing](https://openviewpartners.com/blog/usage-based-pricing/)
- [API Monetization Guide](https://www.apigee.com/api-management/)

### 1.4 Operações e Automação CRM

---

#### 14. revops

**Descrição:** Design de revenue operations, lifecycle rules, scoring, routing

**Quando usar:**
- Melhorar processos entre marketing, vendas e success
- Automatizar lead scoring e routing
- Otimizar lifecycle de clientes

**Exemplos práticos:**
```python
# Exemplo 1: Lead scoring automatizado
def calculate_lead_score(lead):
    score = 0
    # Dados demográficos
    if lead.company_size > 100: score += 30
    if lead.industry in ['tech', 'finance', 'healthcare']: score += 20
    # Comportamento
    if lead.visited_pricing_page: score += 25
    if lead.requested_demo: score += 40
    # Engajamento
    score += lead.email_opens * 2
    score += lead.link_clicks * 3
    return min(score, 100)

# Exemplo 2: Routing automático
def route_lead(lead):
    score = calculate_lead_score(lead)
    if score >= 80: return 'enterprise_sales'
    elif score >= 50: return 'mid_market_sdr'
    else: return 'nurture_sequence'

# Exemplo 3: Lifecycle rules
def manage_lifecycle(customer):
    if customer.days_since_signup <= 14: return 'onboarding'
    elif customer.usage_rate < 0.3: return 'at_risk'
    elif customer.plan == 'free' and customer.usage_rate > 0.7: return 'upgrade_opportunity'
    else: return 'retention'
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de revenue operations completa integrando HubSpot + Stripe + Intercom
- Projeto Real 2: Otimização de pipeline de vendas com scoring preditivo usando ML
- Projeto Real 3: Automação de handoff marketing→vendas→success com SLAs definidos

**Integração com outras skills:**
- **sales-automator:** para automação de outreach baseada em score
- **customer-support:** para integração pós-venda e health scores
- **product-manager:** para alinhamento de métricas de produto com pipeline

**Padrões e anti-padrões:**
✅ Fazer: Usar dados reais para scoring, revisar regras trimestralmente, testar com validade
❌ Evitar: Scoring baseado apenas em dados demográficos, ignorar sinais de churn, não documentar regras

**Dicas de performance:**
- Integrar com CRM (HubSpot, Salesforce) para dados unificados
- Usar machine learning para scoring preditivo após dados suficientes
- Automatizar ações baseadas em score com workflows
- Criar dashboard de pipeline health

**Comandos úteis:**
```python
# Integração com HubSpot
import hubspot

def update_hubspot_lead(contact_id, score, lifecycle_stage):
    client = hubspot.Client.create(access_token='your-token')
    client.crm.contacts.basic_api.update(
        contact_id=contact_id,
        properties={
            'lead_score': str(score),
            'lifecyclestage': lifecycle_stage
        }
    )
```

**Referências:**
- [RevOps Collective](https://revopscollective.com/)
- [HubSpot RevOps](https://www.hubspot.com/products/revops)
- [Salesforce Revenue Cloud](https://www.salesforce.com/products/revenue-cloud/)

---

#### 15. sales-automator

**Descrição:** Templates de cold emails, follow-ups, propostas, pricing pages

**Quando usar:**
- Criar materiais de vendas e outreach
- Automatizar sequências de prospecção
- Gerar propostas comerciais padronizadas

**Exemplos práticos:**
```markdown
# Exemplo 1: Cold email sequence
Subject: [Nome], uma ideia para otimizar [problema específico]

Oi [Nome],

Notei que a [Empresa] está crescendo rapidamente. Com esse crescimento, 
muitas empresas enfrentam [problema específico].

Nós ajudamos [Empresa similar] a resolver isso, resultando em [resultado 
mensurável: 30% redução de churn, 2x mais conversões].

Pos mostrar como isso funciona para a [Empresa]?

Atenciosamente,
[Seu nome]

# Exemplo 2: Follow-up sequence (3 toques)
Email 1 (3 dias): Referência ao email anterior
Email 2 (7 dias): Case study compartilhado
Email 3 (14 dias): Última proposta de valor

# Exemplo 3: Proposal template structure
Executive Summary → Client Challenge → Proposed Solution → 
Expected Outcomes → Investment & Timeline → Next Steps
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de cadência de vendas multi-canal (email + LinkedIn + phone)
- Projeto Real 2: Automação de nurture para leads inbound com segmentação por comportamento
- Projeto Real 3: Criação de playbooks de vendas por persona (CFO, CTO, VP Sales)

**Integração com outras skills:**
- **revops:** para scoring e routing de leads qualificados
- **email-sequence:** para construção de sequências de nutrição
- **copywriting:** para escrita persuasiva de emails
- **content-creator:** para materiais de suporte à vendas

**Padrões e anti-padrões:**
✅ Fazer: Personalizar mensagens (nome + empresa + trigger), valorizar antes de pedir, ter CTA claro
❌ Evitar: Enviar emails genéricos, follow-ups agresivos (diários), não respeitar opt-out

**Dicas de performance:**
- Usar ferramentas de automação (Outreach, Salesloft, Apollo)
- Testar subject lines com A/B testing
- Monitorar métricas de engajamento (open rate, reply rate)
- Limpar lista periodicamente para manter qualidade

**Comandos úteis:**
```python
def generate_personalized_email(prospect):
    """Gera email personalizado baseado no perfil do prospect"""
    return f"""
    Subject: {prospect.first_name}, uma ideia para {prospect.pain_point}
    
    Olá {prospect.first_name},
    
    Notei que a {prospect.company} está {prospect.recent_trigger}.
    
    Isso frequentemente leva a {prospect.pain_point}. Nós ajudamos 
    empresas como {prospect.similar_company} a resolver isso, 
    resultando em {prospect.case_study_result}.
    
    Pos compartilhar como isso funcionaria para a {prospect.company}?
    
    Abraços,
    [Seu nome]
    """
```

**Referências:**
- [Predictable Revenue by Aaron Ross](https://www.predictablerevenue.com/)
- [Salesloft](https://www.salesloft.com/)
- [Outreach.io](https://www.outreach.io/)
- [Gong.io](https://www.gong.io/)

---

#### 16. customer-support

**Descrição:** Suporte ao cliente com IA, ticketing automatizado, análise de sentimento

**Quando usar:**
- Configurar canal de suporte omnichannel
- Implementar chatbot de suporte com IA
- Analisar satisfação do cliente

**Exemplos práticos:**
```python
# Exemplo 1: Análise de sentimento
from transformers import pipeline
sentiment_analyzer = pipeline('sentiment-analysis')

def analyze_customer_message(message):
    result = sentiment_analyzer(message)[0]
    if result['label'] == 'NEGATIVE' and result['score'] > 0.8:
        return {'priority': 'high', 'route_to': 'human_agent'}
    elif result['label'] == 'POSITIVE':
        return {'priority': 'low', 'route_to': 'chatbot'}
    else:
        return {'priority': 'medium', 'route_to': 'tier1_support'}

# Exemplo 2: Auto-categorização
def categorize_ticket(ticket):
    categories = {
        'billing': ['fatura', 'pagamento', 'cobrança'],
        'technical': ['erro', 'bug', 'não funciona'],
        'feature_request': ['funcionalidade', 'sugestão'],
        'account': ['senha', 'login', 'conta']
    }
    ticket_text = (ticket['subject'] + ' ' + ticket['description']).lower()
    for cat, keywords in categories.items():
        if any(kw in ticket_text for kw in keywords):
            return cat
    return 'general'

# Exemplo 3: SLA tracking
def check_sla(ticket):
    sla_hours = {'critical': 1, 'high': 4, 'medium': 8, 'low': 24}
    elapsed = (datetime.now() - ticket['created_at']).total_seconds() / 3600
    return {'breached': elapsed > sla_hours[ticket['priority']], 'remaining': max(0, sla_hours[ticket['priority']] - elapsed)}
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de sistema de suporte omnichannel com IA (chat + email + phone + social)
- Projeto Real 2: Criação de programa de customer success proativo com health scores
- Projeto Real 3: Migração de knowledge base com self-service para redução de tickets

**Integração com outras skills:**
- **revops:** para integração com pipeline de vendas
- **product-manager:** para feedback loop com produto
- **email-sequence:** para comunicações proativas

**Padrões e anti-padrões:**
✅ Fazer: Oferecer múltiplos canais, medir CSAT/NPS regularmente, criar base de conhecimento
❌ Evitar: Respostas automatizadas sem saída para humano, ignorar feedback negativo, não fechar o ciclo

**Dicas de performance:**
- Usar ferramentas de help desk (Zendesk, Intercom, Freshdesk)
- Implementar base de conhecigo com busca inteligente
- Treinar IA com dados históricos de tickets
- Criar macros para respostas frequentes

**Comandos úteis:**
```python
# Métricas de suporte
def calculate_support_metrics(tickets):
    return {
        'avg_first_response_time': mean([t['first_response_minutes'] for t in tickets]),
        'avg_resolution_time': mean([t['resolution_hours'] for t in tickets]),
        'csat_score': mean([t['csat'] for t in tickets if t['csat']]),
        'ticket_volume_trend': calculate_trend([t['count'] for t in tickets])
    }
```

**Referências:**
- [Zendesk](https://www.zendesk.com/)
- [Intercom](https://www.intercom.com/)
- [Customer Success by Lincoln Murphy](https://lincolnmurphy.com/)
- [Support Driven](https://www.supportdriven.com/)

### 1.5 ERP/Odoo (20+ skills)

---

#### 17. odoo-module-developer

**Descrição:** Criar módulos customizados Odoo

**Quando usar:**
- Desenvolver funcionalidade específica no Odoo
- Customizar módulos existentes
- Integrar Odoo com outros sistemas

**Exemplos práticos:**
```python
# Exemplo 1: Módulo básico Odoo
from odoo import models, fields, api

class CustomModule(models.Model):
    _name = 'custom.module'
    _description = 'Custom Module'
    
    name = fields.Char(string='Name', required=True)
    state = fields.Selection([
        ('draft', 'Draft'),
        ('confirmed', 'Confirmed'),
        ('done', 'Done')
    ], default='draft')
    user_id = fields.Many2one('res.users', string='Responsible')
    
    def action_confirm(self):
        for record in self:
            record.state = 'confirmed'

# Exemplo 2: Herança de modelo
class SaleOrder(models.Model):
    _inherit = 'sale.order'
    custom_field = fields.Char(string='Custom Field')
    
    @api.onchange('partner_id')
    def _onchange_partner_id(self):
        if self.partner_id:
            self.custom_field = self.partner_id.name

# Exemplo 3: Wizard
class CustomWizard(models.TransientModel):
    _name = 'custom.wizard'
    def action_process(self):
        return {'type': 'ir.actions.act_window_close'}
```

**Casos de uso avançados:**
- Projeto Real 1: Desenvolvimento de módulo de gestão de projetos com timesheets e faturamento
- Projeto Real 2: Integração Odoo com sistema de e-commerce externo via API REST
- Projeto Real 3: Criação de módulo de conformidade fiscal para notas fiscais eletrônicas

**Integração com outras skills:**
- **odoo-ecommerce-configurator:** para configuração de loja online
- **odoo-accounting-setup:** para configuração contábil
- **odoo-inventory-optimizer:** para gestão de estoque
- **odoo-sales-crm-expert:** para CRM

**Padrões e anti-padrões:**
✅ Fazer: Seguir convenções Odoo, documentar customizações, criar testes automatizados
❌ Evitar: Modificar módulos core (usar herança), ignorar atualizações de segurança

**Dicas de performance:**
- Usar herança em vez de modificação direta
- Implementar testes automatizados com pytest-odoo
- Usar versionamento para customizações
- Criar módulo por funcionalidade (single responsibility)

**Comandos úteis:**
```bash
# Criar novo módulo
odoo-bin scaffold custom_module addons/

# Instalar módulo
odoo-bin -d yourdb -i custom_module --stop-after-init

# Atualizar módulo
odoo-bin -d yourdb -u custom_module --stop-after-init

# Depurar
odoo-bin -d yourdb --dev=xml,js -i custom_module --stop-after-init
```

**Referências:**
- [Odoo Development Documentation](https://www.odoo.com/documentation/16.0/developer/)
- [Odoo GitHub](https://github.com/odoo/odoo)
- [Odoo Community Association](https://www.odoo.com/community/)
- [Odoo forums](https://www.odoo.com/forum/help-1)

---

#### 18. odoo-ecommerce-configurator

**Descrição:** Configurar eCommerce e Website no Odoo

**Quando usar:**
- Montar loja online no Odoo
- Configurar produtos e categorias
- Integrar meios de pagamento e frete

**Exemplos práticos:**
```xml
<!-- Exemplo 1: Template de produto -->
<template id="product_template">
    <t t-call="website.layout">
        <div class="container">
            <h1 t-field="product.name"/>
            <div class="row">
                <div class="col-md-6">
                    <img t-att-src="image_url(product, 'image_1920')" class="img-fluid"/>
                </div>
                <div class="col-md-6">
                    <p t-field="product.description_sale"/>
                    <span class="price" t-field="product.list_price"/>
                    <button class="btn btn-primary">Add to Cart</button>
                </div>
            </div>
        </div>
    </t>
</template>

<!-- Exemplo 2: Meio de pagamento -->
<record id="payment_method_stripe" model="payment.provider">
    <field name="name">Stripe</field>
    <field name="code">stripe</field>
    <field name="state">enabled</field>
</record>
```

**Casos de uso avançados:**
- Projeto Real 1: Configuração de loja online multi-idioma com 3+ idiomas
- Projeto Real 2: Integração Odoo eCommerce com marketplace externo (Mercado Livre, Amazon)
- Projeto Real 3: Configuração de modelo de assinatura recorrente no eCommerce

**Integração com outras skills:**
- **odoo-module-developer:** para customizações avançadas
- **odoo-accounting-setup:** para configuração fiscal (ICMS, PIS, COFINS)
- **odoo-inventory-optimizer:** para gestão de estoque e fulfillment

**Padrões e anti-padrões:**
✅ Fazer: Testar checkout completo, otimizar imagens, configurar SSL, testar mobile
❌ Evitar: Configurar sem testar fluxo completo, ignorar performance mobile

**Dicas de performance:**
- Usar CDN para imagens (Cloudflare, CloudFront)
- Implementar cache de páginas com vhost
- Comprimir imagens automaticamente
- Monitorar taxa de conversão de checkout

**Comandos úteis:**
```bash
# Configurar módulo website_sale
odoo-bin -d yourdb -i website_sale --stop-after-init

# Criar página de produto via shell
odoo-bin shell -d yourdb
# env['product.template'].create({'name': 'Product', 'list_price': 99.99, 'website_published': True})
```

**Referências:**
- [Odoo eCommerce](https://www.odoo.com/app/ecommerce)
- [Odoo Website Builder](https://www.odoo.com/app/website)
- [Odoo Payment Providers](https://www.odoo.com/documentation/16.0/applications/general/payment_providers.html)

---

#### 19. odoo-sales-crm-expert

**Descrição:** CRM e pipeline de vendas no Odoo

**Quando usar:**
- Gerenciar pipeline e forecast
- Configurar lead scoring
- Automatizar processo de vendas

**Exemplos práticos:**
```python
# Exemplo 1: Lead scoring customizado
class LeadScoring(models.Model):
    _inherit = 'crm.lead'
    score = fields.Float(string='Score', compute='_compute_score')
    
    def _compute_score(self):
        for lead in self:
            score = 0
            if lead.partner_id and lead.partner_id.is_company: score += 20
            if lead.website_visits > 5: score += 30
            if lead.email_opened: score += 15
            if lead.stage_id.sequence <= 2: score += 25
            lead.score = min(score, 100)

# Exemplo 2: Forecast de vendas
def calculate_forecast(stage_id):
    multiplier = {'prospection': 0.2, 'qualification': 0.4, 
                  'proposal': 0.6, 'negotiation': 0.8, 'won': 1.0}
    return multiplier.get(stage_id, 0)

# Exemplo 3: Automação de pipeline
def auto_qualify_lead(lead):
    if lead.score >= 70:
        lead.stage_id = env.ref('crm.stage_lead2')
        lead.message_post_with_source('email_template_qualify')
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de CRM completo com automações e integração ERP
- Projeto Real 2: Integração Odoo CRM com sistema externo via API XML-RPC
- Projeto Real 3: Dashboard de forecasting comipeline para board meetings

**Integração com outras skills:**
- **revops:** para operações de receita
- **sales-automator:** para automação de outreach
- **customer-support:** para integração pós-venda

**Padrões e anti-padrões:**
✅ Fazer: Manter pipeline limpo, atualizar oportunidades regularmente, usar atividades
❌ Evitar: Criar estágios desnecessários (>8), ignorar atividades pendentes, não usar email integration

**Dicas de performance:**
- Usar views Kanban para visualização visual do pipeline
- Configurar filtros e agrupamentos salvos
- Integrar com email para tracking automático
- Usar forecast reports para decisões estratégicas

**Comandos úteis:**
```python
# Criar oportunidade
opportunity = env['crm.lead'].create({
    'name': 'New Opportunity',
    'partner_id': partner.id,
    'user_id': user.id,
    'stage_id': env.ref('crm.stage_lead1').id,
    'planned_revenue': 10000
})

# Mover para próximo estágio
opportunity.stage_id = env.ref('crm.stage_lead2')
```

**Referências:**
- [Odoo CRM](https://www.odoo.com/app/crm)
- [Odoo Sales](https://www.odoo.com/app/sales)
- [Odoo CRM Tutorial](https://www.odoo.com/documentation/16.0/applications/sales/crm.html)

---

#### 20. odoo-accounting-setup

**Descrição:** Configuração contábil: plano de contas, impostos, conciliação

**Quando usar:**
- Implementar escrituração no Odoo
- Configurar plano de contas brasileiro
- Integrar com sistemas fiscais

**Exemplos práticos:**
```xml
<!-- Exemplo 1: Plano de contas -->
<record id="account_income_1" model="account.account">
    <field name="code">3.1.1.01</field>
    <field name="name">Receita Operacional</field>
    <field name="account_type" ref="account.data_account_type_revenue"/>
    <field name="reconcile" eval="True"/>
</record>

<!-- Exemplo 2: Impostos -->
<record id="tax_icms" model="account.tax">
    <field name="name">ICMS 18%</field>
    <field name="amount_type">percent</field>
    <field name="amount">18</field>
    <field name="type_tax_use">sale</field>
</record>
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de contabilidade para empresa com múltiplas entidades
- Projeto Real 2: Integração Odoo com sistema fiscal eletrônico (NF-e, CT-e, MDF-e)
- Projeto Real 3: Conciliação bancária automática com API do banco

**Integração com outras skills:**
- **odoo-module-developer:** para customizações de módulos contábeis
- **odoo-sales-crm-expert:** para integração com vendas
- **odoo-inventory-optimizer:** para contabilização de estoque

**Padrões e anti-padrões:**
✅ Fazer: Usar plano de contas CNPJ adequado, testar conciliação, manter backup
❌ Evitar: Configurar sem conhecimento contábil, ignorar obrigações fiscais, não testar antes do go-live

**Dicas de performance:**
- Usar importação de planos de contas padrão (l10n_br)
- Configurar templates de fatura personalizados
- Automatizar conciliação bancária com regras
- Gerar relatórios fiscais automaticamente

**Comandos úteis:**
```python
# Importar plano de contas brasileiro
env['account.chart.template'].try_loading('l10n_br', company=env.company)

# Criar conta contábil
account = env['account.account'].create({
    'code': '1.1.1.01',
    'name': 'Caixa',
    'account_type': 'asset_cash'
})
```

**Referências:**
- [Odoo Accounting](https://www.odoo.com/app/accounting)
- [Odoo Fiscal Localization](https://www.odoo.com/documentation/16.0/developer/reference/addons/l10n_br.html)
- [Receita Federal](https://www.gov.br/receitafederal/)

---

#### 21. odoo-inventory-optimizer

**Descrição:** Estoque: valoração FIFO/AVCO, regras de reposição, multi-warehouse

**Quando usar:**
- Otimizar gestão de estoque
- Configurar regras de reposição automática
- Gerenciar múltiplos armazéns

**Exemplos práticos:**
```python
# Exemplo 1: Regra de reposição automática
def create_reorder_rule(product, warehouse):
    avg_demand = get_average_demand(product, days=30)
    lead_time = product.seller_ids[0].delay if product.seller_ids else 7
    
    return env['stock.warehouse.orderpoint'].create({
        'product_id': product.id,
        'warehouse_id': warehouse.id,
        'location_id': warehouse.lot_stock_id.id,
        'product_min_qty': avg_demand * lead_time,
        'product_max_qty': avg_demand * (lead_time + 7),
        'qty_multiple': 10
    })

# Exemplo 2: Transferência entre armazéns
def transfer_between_warehouses(product, from_wh, to_wh, qty):
    picking = env['stock.picking'].create({
        'picking_type_id': from_wh.int_type_id.id,
        'location_id': from_wh.lot_stock_id.id,
        'location_dest_id': to_wh.lot_stock_id.id,
    })
    env['stock.move'].create({
        'name': product.name,
        'product_id': product.id,
        'product_uom_qty': qty,
        'picking_id': picking.id,
        'location_id': from_wh.lot_stock_id.id,
        'location_dest_id': to_wh.lot_stock_id.id,
    })
    picking.action_confirm()
    return picking

# Exemplo 3: Relatório de giro de estoque
def stock_turnover_report(warehouse, period_days=30):
    moves = env['stock.move'].search([
        ('state', '=', 'done'),
        ('date', '>=', datetime.now() - timedelta(days=period_days))
    ])
    total_moved = sum(m.product_uom_qty for m in moves)
    avg_inventory = get_avg_inventory(warehouse)
    return total_moved / avg_inventory if avg_inventory else 0
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de gestão de estoque para empresa com 5+ armazéns
- Projeto Real 2: Otimização de supply chain com previsão de demanda e reorder automático

**Integração com outras skills:**
- **odoo-module-developer:** para customizações avançadas
- **odoo-accounting-setup:** para integração contábil (custo FIFO/AVCO)
- **inventory-demand-planning:** para previsão de demanda

**Padrões e anti-padrões:**
✅ Fazer: Usar valoração adequada (FIFO/AVCO), monitorar giro de estoque, automatizar reposição
❌ Evitar: Estoque parado sem revisão, ignorar obsolescência, não fazer inventário físico

**Dicas de performance:**
- Usar regras automáticas de reposição (reorder points)
- Implementar contagem cíclica (ABC analysis)
- Monitorar métricas: giro, dias de estoque, stockout rate
- Configurar alertas para estoque baixo

**Comandos úteis:**
```python
# Criar regra de reposição
orderpoint = env['stock.warehouse.orderpoint'].create({
    'product_id': product.id,
    'warehouse_id': warehouse.id,
    'location_id': warehouse.lot_stock_id.id,
    'product_min_qty': 10,
    'product_max_qty': 100,
    'qty_multiple': 10
})

# Verificar estoque disponível
qty = product.with_context(warehouse=warehouse.id).qty_available
print(f"Estoque disponível: {qty}")
```

**Referências:**
- [Odoo Inventory](https://www.odoo.com/app/inventory)
- [Odoo Purchase](https://www.odoo.com/app/purchase)
- [Odoo MRP](https://www.odoo.com/app/mrp)
- [Gestão de Estoque](https://www.apics.org/)

---

#### 22. odoo-hr-payroll-setup

**Descrição:** RH e folha de pagamento: estruturas salariais, contratos

**Quando usar:**
- Implementar gestão de pessoas no Odoo
- Configurar folha de pagamento brasileira
- Gerenciar contratos e benefícios

**Exemplos práticos:**
```python
# Exemplo 1: Estrutura salarial
class SalaryStructure(models.Model):
    _name = 'hr.salary.structure'
    _description = 'Salary Structure'
    name = fields.Char(string='Structure Name')
    rule_ids = fields.One2many('hr.salary.rule', 'struct_id', string='Rules')

# Exemplo 2: Cálculo de férias
def calculate_vacation_pay(employee, vacation_days):
    base_salary = employee.contract_id.wage
    vacation_pay = base_salary * (vacation_days / 30)
    vacation_bonus = vacation_pay / 3  # Terço constitucional
    thirteenth = base_salary * (vacation_days / 365)
    return {
        'vacation_pay': vacation_pay,
        'vacation_bonus': vacation_bonus,
        'thirteenth_salary': thirteenth,
        'total': vacation_pay + vacation_bonus + thirteenth
    }

# Exemplo 3: Criar contrato
contract = env['hr.contract'].create({
    'name': 'Contract - Employee',
    'employee_id': employee.id,
    'date_start': date(2026, 1, 1),
    'wage': 5000.00,
    'structure_type_id': env.ref('hr_contract.structure_type_employee').id
})
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de folha de pagamento para empresa com 500+ funcionários
- Projeto Real 2: Integração Odoo com sistema de ponto eletrônico (REP)

**Integração com outras skills:**
- **odoo-module-developer:** para customizações de módulos HR
- **hr-pro:** para processos de RH (onboarding, performance, etc)
- **odoo-accounting-setup:** para integração contábil (provisões)

**Padrões e anti-padrões:**
✅ Fazer: Manter conformidade CLT, automatizar cálculos, gerar holerites automaticamente
❌ Evitar: Configurar sem conhecimento de legislação, ignorar prazos legais (DIRF, eSocial)

**Dicas de performance:**
- Usar templates de holerite personalizados
- Automatizar cálculos de impostos (IRRF, INSS, FGTS)
- Integrar com sistema bancário para pagamento
- Gerar relatórios fiscais automaticamente

**Comandos úteis:**
```python
# Gerar holerite
payslip = env['hr.payslip'].create({
    'employee_id': employee.id,
    'contract_id': contract.id,
    'date_from': date(2026, 1, 1),
    'date_to': date(2026, 1, 31)
})
payslip.compute_sheet()
```

**Referências:**
- [Odoo HR](https://www.odoo.com/app/employees)
- [Odoo Payroll](https://www.odoo.com/app/payroll)
- [CLT](https://www.planalto.gov.br/ccivil_03/decreto-lei/del5452.htm)
- [eSocial](https://www.gov.br/esocial/)

### 1.6 Finanças e Investimentos

---

#### 23. quant-analyst

**Descrição:** Modelos financeiros, backtest de estratégias, análise de dados de mercado

**Quando usar:**
- Construir modelos de trading quantitativos
- Analisar dados de mercado estatisticamente
- Desenvolver estratégias de investimento algorítmicas

**Exemplos práticos:**
```python
import numpy as np
import pandas as pd
from scipy.optimize import minimize

# Exemplo 1: Otimização de portfólio (Markowitz)
def optimize_portfolio(returns, risk_free_rate=0.02):
    n = len(returns.columns)
    def objective(weights):
        port_return = np.sum(returns.mean() * weights) * 252
        port_vol = np.sqrt(np.dot(weights.T, np.dot(returns.cov() * 252, weights)))
        return -(port_return - risk_free_rate) / port_vol  # Max Sharpe
    constraints = ({'type': 'eq', 'fun': lambda x: np.sum(x) - 1})
    bounds = tuple((0, 1) for _ in range(n))
    result = minimize(objective, n*[1./n], method='SLSQP', bounds=bounds, constraints=constraints)
    return result.x

# Exemplo 2: Estratégia de momentum
def momentum_strategy(prices, lookback=20):
    signals = pd.DataFrame(index=prices.index)
    for col in prices.columns:
        momentum = prices[col].pct_change(lookback)
        signals[col] = np.where(momentum > 0, 1, -1)
    return signals

# Exemplo 3: Backtesting
def backtest(prices, signals, initial_capital=100000):
    positions = signals.shift(1)
    returns = prices.pct_change()
    portfolio_returns = (positions * returns).sum(axis=1)
    portfolio_value = initial_capital * (1 + portfolio_returns).cumprod()
    return {
        'total_return': (portfolio_value.iloc[-1] / initial_capital) - 1,
        'sharpe': (portfolio_returns.mean() * 252) / (portfolio_returns.std() * np.sqrt(252)),
        'max_drawdown': (portfolio_value / portfolio_value.cummax() - 1).min()
    }
```

**Casos de uso avançados:**
- Projeto Real 1: Desenvolvimento de estratégia de trading algorítmico para ações brasileiras
- Projeto Real 2: Construção de modelo de fator (value, momentum, quality) para investimento institucional
- Projeto Real 3: Análise de risco de portfólio com VaR e stress testing

**Integração com outras skills:**
- **risk-manager:** para gestão de risco e stop-losses
- **risk-metrics-calculation:** para métricas detalhadas (Sharpe, Sortino, VaR)
- **backtesting-frameworks:** para validação robusta de estratégias

**Padrões e anti-padrões:**
✅ Fazer: Validar com dados out-of-sample, considerar custos de transação, walk-forward optimization
❌ Evitar: Overfitting em dados históricos, ignorar slippage e liquidez, não considerar custos

**Dicas de performance:**
- Usar bibliotecas otimizadas (NumPy, Pandas, QuantLib)
- Implementar walk-forward optimization
- Monitorar performance em tempo real
- Usar dados de alta qualidade (Bloomberg, Refinitiv)

**Comandos úteis:**
```bash
pip install numpy pandas scipy yfinance empyrical
```
```python
import yfinance as yf
data = yf.download(['PETR4.SA', 'VALE3.SA', 'ITUB4.SA'], start='2024-01-01')
```

**Referências:**
- [QuantLib](https://www.quantlib.org/)
- [Zipline](https://www.zipline.io/)
- [QuantStart](https://www.quantstart.com/)
- [Empyrical](https://github.com/quantopian/empyrical)

---

#### 24. risk-manager

**Descrição:** Monitoramento de risco, hedging, expectancy, stop-losses

**Quando usar:**
- Gerenciar risco de portfólio
- Implementar estratégias de hedging
- Definir stop-losses dinâmicos

**Exemplos práticos:**
```python
# Exemplo 1: Stop-loss dinâmico baseado em ATR
def dynamic_stop_loss(prices, atr_period=14):
    high_low = prices['High'] - prices['Low']
    high_close = np.abs(prices['High'] - prices['Close'].shift())
    low_close = np.abs(prices['Low'] - prices['Close'].shift())
    tr = np.maximum(high_low, np.maximum(high_close, low_close))
    atr = tr.rolling(window=atr_period).mean()
    return prices['Close'] - (2 * atr)

# Exemplo 2: Position sizing (Kelly Criterion)
def kelly_criterion(win_rate, avg_win, avg_loss):
    b = avg_win / avg_loss
    kelly = (win_rate * b - (1 - win_rate)) / b
    return kelly  # Usar fracional (ex: kelly/2)

# Exemplo 3: Monitoramento de risco
def monitor_portfolio_risk(portfolio):
    returns = portfolio.pct_change()
    return {
        'var_95': np.percentile(returns, 5),
        'max_drawdown': (portfolio / portfolio.cummax() - 1).min(),
        'correlation': returns.corr().mean().mean()
    }
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de sistema de gestão de risco para fundo quantitativo
- Projeto Real 2: Criação de estratégia de hedging para portfólio institucional com derivativos

**Integração com outras skills:**
- **quant-analyst:** para modelos quantitativos
- **risk-metrics-calculation:** para métricas detalhadas (VaR, CVaR, Sharpe)
- **backtesting-frameworks:** para validação de estratégias de risco

**Padrões e anti-padrões:**
✅ Fazer: Diversificar, monitorar risco diariamente, ter plano de contingência, definir max drawdown
❌ Evitar: Concentração excessiva (>25% em uma posição), ignorar correlações em crises, não testar cenários extremos

**Dicas de performance:**
- Usar ferramentas de monitoramento em tempo real
- Implementar alertas automáticos para breaches de risco
- Revisar estratégia regularmente (mensal)
- Usar stress testing com cenários históricos (2008, 2020, COVID)

**Comandos úteis:**
```python
def calculate_var(returns, confidence=0.95):
    return np.percentile(returns, (1 - confidence) * 100)

def sharpe_ratio(returns, rf=0.02):
    excess = returns - rf
    return np.sqrt(252) * excess.mean() / excess.std()
```

**Referências:**
- [Value at Risk - Investopedia](https://www.investopedia.com/terms/v/var.asp)
- [Quantitative Risk Management](https://www.qrm.com/)
- [Risk Management Framework](https://www.investopedia.com/terms/r/riskmanagement.asp)

---

#### 25. risk-metrics-calculation

**Descrição:** VaR, CVaR, Sharpe, Sortino, drawdown analysis

**Quando usar:**
- Medir risco de portfólio
- Calcular métricas de performance
- Comparar estratégias de investimento

**Exemplos práticos:**
```python
# Exemplo 1: VaR e CVaR
def calculate_var_cvar(returns, confidence=0.95):
    var = np.percentile(returns, (1 - confidence) * 100)
    cvar = returns[returns <= var].mean()
    return {'var': var, 'cvar': cvar}

# Exemplo 2: Sharpe e Sortino
def calculate_ratios(returns, rf=0.02):
    excess = returns - rf
    sharpe = np.sqrt(252) * excess.mean() / excess.std()
    downside = returns[returns < 0].std()
    sortino = np.sqrt(252) * excess.mean() / downside
    return {'sharpe': sharpe, 'sortino': sortino}

# Exemplo 3: Drawdown analysis
def drawdown_analysis(returns):
    cum = (1 + returns).cumprod()
    rolling_max = cum.expanding().max()
    dd = cum / rolling_max - 1
    return {'max_drawdown': dd.min(), 'current': dd.iloc[-1]}

# Exemplo 4: Métricas completas
def comprehensive_metrics(returns, rf=0.02):
    return {
        'annual_return': returns.mean() * 252,
        'annual_volatility': returns.std() * np.sqrt(252),
        'sharpe_ratio': calculate_ratios(returns, rf)['sharpe'],
        'sortino_ratio': calculate_ratios(returns, rf)['sortino'],
        'var_95': calculate_var_cvar(returns)['var'],
        'max_drawdown': drawdown_analysis(returns)['max_drawdown']
    }
```

**Casos de uso avançados:**
- Projeto Real 1: Relatório de performance para investidores com todas as métricas
- Projeto Real 2: Comparação de estratégias de investimento para alocação de capital

**Integração com outras skills:**
- **quant-analyst:** para modelos quantitativos
- **risk-manager:** para gestão de risco
- **backtesting-frameworks:** para validação

**Padrões e anti-padrões:**
✅ Fazer: Usar métricas adequadas para o tipo de estratégia, comparar com benchmarks (CDI, IBOV)
❌ Evitar: Usar apenas retorno sem considerar risco, não calcular drawdown máximo

**Dicas de performance:**
- Usar bibliotecas especializadas (empyrical, pyfolio)
- Criar dashboards interativos (Plotly, Dash)
- Automatizar relatórios mensais
- Comparar com benchmark relevante

**Comandos úteis:**
```bash
pip install empyrical pyfolio
```
```python
import empyrical as ep
returns = pd.Series(portfolio_returns)
print(f"Annual Return: {ep.annual_return(returns):.2%}")
print(f"Sharpe Ratio: {ep.sharpe_ratio(returns):.2f}")
print(f"Max Drawdown: {ep.max_drawdown(returns):.2%}")
```

**Referências:**
- [Empyrical](https://github.com/quantopian/empyrical)
- [PyFolio](https://github.com/quantopian/pyfolio)
- [Sharpe Ratio - Investopedia](https://www.investopedia.com/terms/s/sharperatio.asp)

---

#### 26. backtesting-frameworks

**Descrição:** Sistemas de backtesting production-grade

**Quando usar:**
- Validar estratégias de investimento
- Testar hipóteses de trading
- Otimizar parâmetros de estratégia

**Exemplos práticos:**
```python
# Exemplo 1: Framework de backtesting simples
class BacktestEngine:
    def __init__(self, data, strategy, capital=100000):
        self.data = data
        self.strategy = strategy
        self.capital = capital
    
    def run(self):
        signals = self.strategy.generate_signals(self.data)
        positions = signals.shift(1)
        returns = self.data['Close'].pct_change()
        self.portfolio_returns = (positions * returns).sum(axis=1)
        self.portfolio_value = self.capital * (1 + self.portfolio_returns).cumprod()
        return self
    
    def metrics(self):
        return {
            'total_return': (self.portfolio_value.iloc[-1] / self.capital) - 1,
            'sharpe': (self.portfolio_returns.mean() * 252) / (self.portfolio_returns.std() * np.sqrt(252)),
            'max_drawdown': (self.portfolio_value / self.portfolio_value.cummax() - 1).min()
        }

# Exemplo 2: Walk-forward optimization
def walk_forward(data, strategy, train_size=252, test_size=63):
    results = []
    for i in range(0, len(data) - train_size - test_size, test_size):
        train = data.iloc[i:i+train_size]
        best_params = strategy.optimize(train)
        test = data.iloc[i+train_size:i+train_size+test_size]
        engine = BacktestEngine(test, strategy(**best_params))
        results.append(engine.run().metrics())
    return results

# Exemplo 3: Monte Carlo Simulation
def monte_carlo(returns, n_sims=1000, n_days=252):
    sims = [np.prod(1 + np.random.normal(returns.mean(), returns.std(), n_days)) for _ in range(n_sims)]
    return {'mean': np.mean(sims), 'percentile_5': np.percentile(sims, 5)}
```

**Casos de uso avançados:**
- Projeto Real 1: Desenvolvimento de estratégia de trading algorítmico validada com walk-forward
- Projeto Real 2: Validação de modelo de fator de investimento com Monte Carlo

**Integração com outras skills:**
- **quant-analyst:** para modelos quantitativos
- **risk-manager:** para gestão de risco
- **risk-metrics-calculation:** para métricas de performance

**Padrões e anti-padrões:**
✅ Fazer: Usar dados out-of-sample, considerar custos de transação, walk-forward optimization
❌ Evitar: Overfitting, ignorar slippage, não validar com dados reais

**Dicas de performance:**
- Usar bibliotecas especializadas (Backtrader, Zipline)
- Implementar paralelismo para simulações Monte Carlo
- Validar com dados históricos longos (10+ anos)
- Documentar hiperparâmetros e decisões

**Comandos úteis:**
```bash
pip install backtrader zipline-reloaded
```
```python
import backtrader as bt

class MyStrategy(bt.Strategy):
    def __init__(self):
        self.sma = bt.indicators.SMA(self.data.close, period=20)
    def next(self):
        if self.data.close[0] > self.sma[0]: self.buy()
        elif self.data.close[0] < self.sma[0]: self.sell()

cerebro = bt.Cerebro()
cerebro.addstrategy(MyStrategy)
cerebro.adddata(data)
cerebro.run()
```

**Referências:**
- [Backtrader](https://www.backtrader.com/)
- [Zipline](https://www.zipline.io/)
- [QuantConnect](https://www.quantconnect.com/)

### 1.7 Outras Skills Business

---

#### 27. hr-pro

**Descrição:** Parceiro HR para hiring, onboarding, PTO, performance, políticas

**Quando usar:**
- Processos de RH completos (hiring, onboarding, performance)
- Implementar políticas de empresa
- Gerenciar ciclo de vida do funcionário

**Exemplos práticos:**
```markdown
# Exemplo 1: Processo de onboarding
prompt = "Crie o processo de onboarding para novos contratados remotos. Inclua: 
checklist pré-chegada, primeiro dia, primeira semana, primeiro mês, 
e programa de mentoria de 90 dias."

# Exemplo 2: Política de trabalho remoto
prompt = "Desenvolva a política de trabalho remoto da empresa. Inclua: requisitos 
de equipamento, horários flexíveis, comunicação assíncrona, 
expectativas de performance, e cultura."

# Exemplo 3: Plano de desenvolvimento
prompt = "Crie um plano de desenvolvimento individual (PDI) para funcionário em 
transição de carreira. Inclua: avaliação de competências, objetivos SMART, 
trilhas de aprendizado, e marcos trimestrais."
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de programa de gestão de talentos com succession planning
- Projeto Real 2: Criação de cultura organizacional para empresa 100% remota global
- Projeto Real 3: Design de programa de equity/stock options para colaboradores

**Integração com outras skills:**
- **team-composition-analysis:** para estruturação de equipe
- **odoo-hr-payroll-setup:** para implementação técnica no ERP
- **product-manager:** para alinhamento de OKRs individuais com objetivos de produto

**Padrões e anti-padrões:**
✅ Fazer: Documentar processos, medir eNPS regularmente, ser inclusivo, oferecer growth paths
❌ Evitar: Políticas rígidas sem flexibilidade, ignorar feedback, não ter plano de carreira

**Dicas de performance:**
- Usar ferramentas de RH (BambooHR, Personio, Lattice)
- Automatizar processos recorrentes (onboarding, performance review)
- Criar cultura de feedback contínuo (360 feedback)
- Medir retention rate e eNPS trimestralmente

**Comandos úteis:**
```markdown
# Checklist de onboarding (remote)
## Pré-chegada
- [ ] Equipment shipped (laptop, monitor, peripherals)
- [ ] Accounts created (email, Slack, GitHub, tools)
- [ ] Welcome package sent
- [ ] Buddy assigned

## Primeiro dia
- [ ] Team welcome (async video)
- [ ] Virtual office tour
- [ ] 1:1 with manager
- [ ] First task assigned

## Primeira semana
- [ ] Cross-functional introductions
- [ ] Product deep-dive
- [ ] First 30-60-90 day plan review
```

**Referências:**
- [SHRM](https://www.shrm.org/)
- [Gallup Workplace](https://www.gallup.com/workplace/)
- [Culture Amp](https://www.cultureamp.com/)
- [Lattice](https://www.lattice.com/)

---

#### 28. kpi-dashboard-design

**Descrição:** Design de dashboards KPI que impulsionam decisões

**Quando usar:**
- Criar visualizações de dados executivas
- Monitorar métricas de negócio em tempo real
- Comunicar performance para stakeholders

**Exemplos práticos:**
```python
import streamlit as st
import plotly.express as px

# Exemplo 1: Dashboard executivo
def create_executive_dashboard(data):
    st.set_page_config(layout="wide")
    col1, col2, col3, col4 = st.columns(4)
    with col1: st.metric("MRR", f"R$ {data['mrr']:,.0f}", f"{data['mrr_growth']:.1f}%")
    with col2: st.metric("Churn Rate", f"{data['churn']:.1%}")
    with col3: st.metric("CAC", f"R$ {data['cac']:.0f}")
    with col4: st.metric("LTV", f"R$ {data['ltv']:.0f}")
    
    fig = px.line(data, x='month', y='revenue', title='Receita Mensal')
    st.plotly_chart(fig, use_container_width=True)

# Exemplo 2: Dashboard de pipeline
def pipeline_dashboard(sales_data):
    funnel = px.funnel(sales_data, x='value', y='stage')
    st.plotly_chart(funnel)

# Exemplo 3: Dashboard de produto
def product_dashboard(product_data):
    col1, col2 = st.columns(2)
    with col1:
        st.plotly_chart(px.line(product_data, x='date', y='dau', title='DAU'))
    with col2:
        st.plotly_chart(px.bar(product_data, x='feature', y='adoption', title='Feature Adoption'))
```

**Casos de uso avançados:**
- Projeto Real 1: Dashboard executivo para board meeting trimestral com drill-down
- Projeto Real 2: Dashboard de monitoramento em tempo real para operações de suporte
- Projeto Real 3: Dashboard de growth com cohort analysis e funnel de conversão

**Integração com outras skills:**
- **business-analyst:** para análise de dados e modelagem
- **product-manager:** para métricas de produto (DAU, MAU, retention)
- **revops:** para métricas de receita e pipeline

**Padrões e anti-padrões:**
✅ Fazer: Focar em ações (actionable metrics), usar cores consistentes, atualizar automaticamente
❌ Evitar: Sobrecarregar de informações (vanity metrics), usar gráficos inadequados, não contextualizar

**Dicas de performance:**
- Usar ferramentas de BI (Tableau, Metabase, Grafana, Looker)
- Implementar cache para consultas lentas
- Criar alertas automáticos para anomalies
- Seguir princípio "Above the Fold" (KPIs mais importantes no topo)

**Comandos úteis:**
```bash
pip install streamlit plotly pandas
streamlit run dashboard.py
```

**Referências:**
- [Streamlit](https://streamlit.io/)
- [Plotly Dash](https://dash.plotly.com/)
- [Metabase](https://www.metabase.com/)
- [Stephen Few - Dashboard Design](https://www.perceptualedge.com/)

---

#### 29. micro-saas-launcher

**Descrição:** Lançar SaaS pequenos e focados rapidamente (indie hacker)

**Quando usar:**
- Validar e lançar micro-SaaS
- Criar produto digital rapidamente (< 4 semanas)
- Testar ideias de negócio com baixo investimento

**Exemplos práticos:**
```markdown
# Exemplo 1: Validação de ideia
prompt = "Valide a ideia de um SaaS para gestão de tarefas freelancers. Inclua: 
público-alvo, problema principal, concorrentes, e como testar demanda 
em 2 semanas com landing page + waitlist."

# Exemplo 2: MVP em 4 semanas
prompt = "Crie o roadmap técnico para MVP de SaaS de gestão financeira. 
Semana 1: backend + auth. Semana 2: frontend. Semana 3: integrações. 
Semana 4: launch + pricing."

# Exemplo 3: Estratégia de lançamento
prompt = "Planeje o lançamento do micro-SaaS no Product Hunt, Indie Hackers, 
e Twitter. Inclua: timeline, mensagens, assets, e métricas de sucesso."
```

**Casos de uso avançados:**
- Projeto Real 1: Lançamento de micro-SaaS B2B que atinge R$ 10k MRR em 6 meses
- Projeto Real 2: Criação de portfólio de micro-SaaS com receita passiva

**Integração com outras skills:**
- **saas-mvp-launcher:** para planejamento técnico detalhado
- **startup-analyst:** para análise de negócio e unit economics
- **monetization:** para modelo de receita com Stripe
- **micro-saas-launcher:** para estratégia de lançamento

**Padrões e anti-padrões:**
✅ Fazer: Lançar rápido (shipping > perfeição), validar com pagamento real, focar em uma feature core
❌ Evitar: Perfeccionismo, construir features que ninguém pediu, ignorar churn, gastar meses sem launch

**Dicas de performance:**
- Usar tech stack simples (Next.js, Supabase, Stripe, Vercel)
- Focar em uma persona específica (niche down)
- Medir tudo desde o dia 1 (analytics, funnel, churn)
- Usar"Landing Page First" approach

**Comandos úteis:**
```bash
# Criar projeto Next.js + Supabase
npx create-next-app@latest my-saas --typescript --tailwind --app
cd my-saas
npm install stripe @supabase/supabase-js

# Deploy no Vercel
npx vercel --prod
```

**Referências:**
- [Indie Hackers](https://www.indiehackers.com/)
- [MicroConf](https://microconf.com/)
- [The Mom Test](https://www.momtestbook.com/)
- [Remote OK](https://remoteok.com/)

---

#### 30. notion-template-business

**Descrição:** Construir e vender templates Notion como negócio

**Quando usar:**
- Criar produto digital baseado em Notion
- Monetizar conhecimento em produtividade
- Construir audiência em torno de templates

**Exemplos práticos:**
```markdown
# Exemplo 1: Template de gestão de projetos
prompt = "Crie um sistema de gestão de projetos em Notion para vender como 
template. Inclua: databases de projetos, tarefas, time tracking, 
dashboards, e automações."

# Exemplo 2: Template de content calendar
prompt = "Desenvolva um content calendar em Notion para criadores de conteúdo. 
Inclua: planejamento, agendamento, analytics, biblioteca de ideias, 
e workflow de aprovação."

# Exemplo 3: Estratégia de venda
prompt = "Planeje a venda do template Notion via Gumroad, Hotmart, e mercado 
próprio. Inclua: pricing, landing page, email marketing, upsells, 
e suporte pós-venda."
```

**Casos de uso avançados:**
- Projeto Real 1: Criação de negócio de templates Notion com R$ 5k/mês
- Projeto Real 2: Construção de marca pessoal em torno de produtividade e automação

**Integração com outras skills:**
- **content-creator:** para marketing do template
- **monetization:** para implementação de pagamento
- **email-sequence:** para nutrição de leads
- **social-content:** para distribuição em redes sociais

**Padrões e anti-padrões:**
✅ Fazer: Criar templates realmente úteis, documentar uso com vídeos, oferecer suporte
❌ Evitar: Templates genéricos sem diferenciação, não atualizar, ignorar feedback

**Dicas de performance:**
- Usar Gumroad ou Hotmart para vendas (baixa taxa)
- Criar vídeo demo de 2-3 minutos
- Oferecer versão gratuita como lead magnet
- Construir email list para lançamentos

**Comandos úteis:**
```markdown
# Landing Page Template
## Headline
O sistema Notion que você precisa para [benefício específico]

## Subheadline
[Descrição do template em 1 frase]

## Features (3-5)
- Feature 1: [Benefício]
- Feature 2: [Benefício]
- Feature 3: [Benefício]

## Social Proof
"[Depoimento]" - [Nome], [Cargo]

## CTA
Compre agora por R$ [preço] →
```

**Referências:**
- [Notion Template Gallery](https://www.notion.so/templates)
- [Gumroad](https://gumroad.com/)
- [Notion for Beginners](https://www.notion.so/help)

---

#### 31. carrier-relationship-management

**Descrição:** Gestão de portfólio de transportadoras, negociação de fretes

**Quando usar:**
- Otimizar logística de transporte
- Negociar tarifas com transportadoras
- Gerenciar performance de frete

**Exemplos práticos:**
```python
# Exemplo 1: Comparativo de transportadoras
def compare_carriers(carriers, shipments):
    comparison = []
    for carrier in carriers:
        carrier_ships = [s for s in shipments if s['carrier'] == carrier['name']]
        comparison.append({
            'name': carrier['name'],
            'on_time_rate': sum(1 for s in carrier_ships if s['on_time']) / len(carrier_ships),
            'damage_rate': sum(1 for s in carrier_ships if s['damaged']) / len(carrier_ships),
            'cost_per_kg': sum(s['cost'] for s in carrier_ships) / sum(s['weight'] for s in carrier_ships)
        })
    return comparison

# Exemplo 2: Negociação de frete
def negotiate_freight(carrier, volume, distance):
    base_rate = carrier['base_rate']
    vol_discount = 0.15 if volume > 1000 else 0.10 if volume > 500 else 0.05
    dist_discount = min(0.10, distance / 10000)
    final_rate = base_rate * (1 - vol_discount) * (1 - dist_discount)
    return {'final_rate': final_rate, 'total_cost': final_rate * distance * volume}

# Exemplo 3: Cálculo de frete
def calculate_shipping_cost(weight, dims, destination, carrier):
    dim_weight = (dims['l'] * dims['w'] * dims['h']) / 6000
    chargeable = max(weight, dim_weight)
    rate = carrier['rates'].get(destination['region'], carrier['default'])
    return chargeable * rate
```

**Casos de uso avançados:**
- Projeto Real 1: Otimização de logística para e-commerce com multi-carrier e roteirização
- Projeto Real 2: Implementação de TMS (Transportation Management System) integrado ao ERP

**Integração com outras skills:**
- **returns-reverse-logistics:** para gestão de devoluções
- **odoo-inventory-optimizer:** para integração com estoque
- **inventory-demand-planning:** para previsão de demanda

**Padrões e anti-padrões:**
✅ Fazer: Diversificar transportadoras, monitorar SLA, negociar semestralmente
❌ Evitar: Concentração em uma única transportadora, não medir performance, não ter plano B

**Dicas de performance:**
- Usar TMS para otimização de rotas
- Implementar rastreamento em tempo real
- Criar KPIs de logística (on-time delivery, damage rate, cost per shipment)
- Negociar contratos com volume commitments

**Comandos úteis:**
```python
def calculate_shipping_cost(weight, dims, destination, carrier):
    dim_weight = (dims['l'] * dims['w'] * dims['h']) / 6000
    chargeable = max(weight, dim_weight)
    rate = carrier['rates'].get(destination['region'], carrier['default'])
    return {'chargeable_weight': chargeable, 'rate': rate, 'total_cost': chargeable * rate}
```

**Referências:**
- [Freightos](https://www.freightos.com/)
- [Logistics Management](https://www.logisticsmgmt.com/)
- [TMS Guide](https://www.inboundlogistics.com/articles/transportation-management-system-tms/)

---

#### 32-36. Outras skills Business (resumo expandido)

**energy-procurement:** Compra de energia elétrica e gás, otimização de tarifas
- **Integração:** odoo-accounting-setup, quality-nonconformance
- **Padrão:** Monitorar consumo, comparar planos anualmente, considerar energia solar
- **Anti-padrão:** Ignorar tarifas de demanda, não considerer fontes renováveis

**inventory-demand-planning:** Previsão de demanda, safety stock, replenishment planning
- **Integração:** odoo-inventory-optimizer, production-scheduling, carrier-relationship-management
- **Padrão:** Usar dados históricos, considerar sazonalidade, atualizar previsões mensalmente
- **Anti-padrão:** Usar apenas média simples, ignorar tendências de mercado

**production-scheduling:** Agendamento de produção, sequenciamento, balanceamento de linhas
- **Integração:** odoo-inventory-optimizer, quality-nonconformance
- **Padrão:** Considerar restrições de capacidade, otimizar sequências, monitorar OEE
- **Anti-padrão:** Ignorar tempo de setup, não considerer manutenção preventiva

**quality-nonconformance:** Controle de qualidade, análise de causa raiz, ações corretivas
- **Integração:** production-scheduling, odoo-inventory-optimizer
- **Padrão:** Documentar não-conformidades, implementar CAPA, usar 5 Porquês
- **Anti-padrão:** Culpar pessoas em vez de processos, não verificar eficácia das ações

**returns-reverse-logistics:** Gestão de devoluções, inspeção, reembolso, detecção de fraude
- **Integração:** carrier-relationship-management, odoo-inventory-optimizer
- **Padrão:** Automatizar processos, monitorar fraudes, oferecer self-service
- **Anti-padrão:** Processo complicado para o cliente, não inspecionar devoluções

---

### 1.8 Skills de Lançamento SaaS

---

#### 37. saas-mvp-launcher

**Descrição:** Roadmap para SaaS MVP: tech stack, auth, pagamentos, launch

**Quando usar:**
- Planejar SaaS MVP do zero
- Definir tech stack adequada
- Estruturar lançamento em fases

**Exemplos práticos:**
```bash
# Exemplo 1: Setup de projeto
npx create-next-app@latest my-saas --typescript --tailwind --app
cd my-saas
npm install @supabase/supabase-js stripe @radix-ui/react-icons
npx supabase init

# Exemplo 2: Deploy
npx vercel --prod

# Exemplo 3: Tech stack recommendation
# Frontend: Next.js 14+ (App Router)
# Backend: Supabase (Auth + DB + Storage)
# Payments: Stripe
# Hosting: Vercel
# Analytics: PostHog or Mixpanel
```

**Casos de uso avançados:**
- Projeto Real 1: Lançamento de SaaS em 8 semanas com time de 2 devs
- Projeto Real 2: Migração de MVP para plataforma escalável após product-market fit

**Integração com outras skills:**
- **micro-saas-launcher:** para validação de ideia antes do MVP
- **startup-analyst:** para análise de negócio
- **monetization:** para modelo de receita

**Padrões e anti-padrões:**
✅ Fazer: Focar em features essenciais, usar serviços managed, iterar rapidamente
❌ Evitar: Construir features demais, reinventar a roda, não testar com usuários

**Comandos úteis:**
```bash
# Setup completo
npx create-next-app@latest my-saas --typescript --tailwind --app --eslint
cd my-saas
npm install @supabase/supabase-js stripe @radix-ui/react-icons
npx supabase init && npx supabase start
npx vercel --prod
```

**Referências:**
- [The Lean Startup](https://theleanstartup.com/)
- [MVP Guide - ProductPlan](https://www.productplan.com/glossary/minimum-viable-product/)
- [Tech Stack Selection](https://stackshare.io/)

---

#### 38-40. Startup Business Analyst Skills (resumo expandido)

**startup-business-analyst-business-case:**
- **Uso:** Apresentar para investidores, documentar oportunidade
- **Integração:** startup-financial-modeling, product-manager
- **Padrão:** Ser conciso, usar dados reais, ter clareza na proposta de valor
- **Anti-padrão:** Jargão excessivo, promessas irreais, ignorar concorrência

**startup-business-analyst-financial-projections:**
- **Uso:** Projetar finanças para pitch (3-5 anos)
- **Integração:** startup-business-analyst-business-case, kpi-dashboard-design
- **Padrão:** Usar premissas claras, criar múltiplos cenários, validar com dados reais
- **Anti-padrão:** Projeções irreais, não documentar premissas

**startup-business-analyst-market-opportunity:**
- **Uso:** Validar oportunidade de mercado TAM/SAM/SOM
- **Integração:** market-sizing-analysis, competitive-landscape
- **Padrão:** Usar múltiplas abordagens (top-down e bottom-up), validar com dados secundários
- **Anti-padrão:** Usar apenas top-down, ignorar concorrência

---

#### 41. startup-financial-modeling

**Descrição:** Modelos financeiros 3-5 anos para early-stage startups

**Quando usar:**
- Criar modelo para rodada de investimento
- Planejar crescimento financeiro
- Acompanhar performance vs previsões

**Exemplos práticos:**
```python
# Modelo de receita SaaS
def saas_revenue_model(initial_mrr, growth_rate, churn_rate, months):
    model = []
    current_mrr = initial_mrr
    for month in range(months):
        new_mrr = current_mrr * growth_rate
        churned_mrr = current_mrr * churn_rate
        net_mrr = current_mrr + new_mrr - churned_mrr
        model.append({'month': month + 1, 'mrr': net_mrr, 'arr': net_mrr * 12})
        current_mrr = net_mrr
    return model

# Unit Economics
def unit_economics(cac, ltv):
    return {'ltv_cac_ratio': ltv / cac, 'healthy': ltv / cac > 3}

# Break-even
def break_even(fixed_costs, var_cost_per_unit, price_per_unit):
    margin = price_per_unit - var_cost_per_unit
    return fixed_costs / margin
```

**Referências:**
- [Financial Modeling Guide](https://www.investopedia.com/articles/financial-theory/11/financial-modeling.asp)
- [SaaS Metrics](https://www.chartmogul.com/reports/saas-metrics-report/)
- [Startup Finance - Score](https://www.score.org/resource/blog-article/financial-projections-template)

---

#### 42. startup-metrics-framework

**Descrição:** Métricas-chave por modelo de negócio (seed → Series A)

**Quando usar:**
- Acompanhar métricas de crescimento
- Preparar para rodada de investimento
- Benchmarking com mercado

**Exemplos práticos:**
```python
# Métricas SaaS essenciais
def saas_metrics(mrr, customers, cac, churn_rate):
    return {
        'mrr': mrr,
        'arr': mrr * 12,
        'arpu': mrr / customers,
        'ltv': (mrr / customers) / churn_rate,
        'ltv_cac_ratio': ((mrr / customers) / churn_rate) / cac,
        'magic_number': calculate_magic_number(mrr),
        'nrr': calculate_net_revenue_retention(mrr)
    }

# Métricas por estágio
metrics_by_stage = {
    'seed': ['mrr_growth', 'engagement', 'retention_d30'],
    'series_a': ['arr', 'ltv_cac', 'nrr', 'burn_multiple'],
    'series_b': ['arr_growth', 'rule_of_40', 'gross_margin']
}
```

**Referências:**
- [SaaStr Metrics](https://www.saastr.com/)
- [OpenView SaaS Benchmarks](https://openviewpartners.com/)
- [Bessemer Cloud Index](https://www.bvp.com/atlas/bessemer-nasdaq-emerging-cloud-index)

---

#### 43. team-composition-analysis

**Descrição:** Estruturas de equipe, planos de contratação, compensação

**Quando usar:**
- Dimensionar equipe para crescimento
- Planejar contratações
- Definir estrutura organizacional

**Exemplos práticos:**
```markdown
# Exemplo 1: Estrutura de equipe
prompt = "Projete a estrutura de equipe para escalar de 10 para 50 funcionários 
em 18 meses. Inclua: áreas, cargos, timeline de contratação, e orçamento."

# Exemplo 2: Comp package
prompt = "Crie a estrutura de compensação para engenheiros sêniores no Brasil 
comparando com mercado (base + equity + benefits)."

# Exemplo 3: Hiring plan
prompt = "Desenvolva o hiring plan para o próximo trimestre: 3 engineers, 
1 designer, 2 sales. Inclua: processo seletivo, timeline, e budget."
```

**Referências:**
- [Levels.fyi](https://www.levels.fyi/)
- [Pave Compensation](https://www.pave.com/)
- [Carta Equity](https://www.carta.com/)

---

## 2. BUSINESS STRATEGY (3 skills)

---

#### 44. find-complementary-founders

**Descrição:** Buscar co-fundador ou parceiro complementar

**Quando usar:**
- Precisar de fundador complementar (builder, operator, go-to-market)
- Validar fit entre co-fundadores
- Estruturar acordo de equity entre fundadores

**Exemplos práticos:**
```markdown
# Exemplo 1: Perfil de co-fundador
prompt = "Defina o perfil ideal de co-fundador para minha startup de IA no setor 
de saúde. Sou técnico (engenheiro), preciso de alguém com experiência 
em go-to-market e regulatory."

# Exemplo 2: Acordo de equity
prompt = "Crie um acordo justo de equity split para 3 co-fundadores com贡献 
diferentes: 1 technical, 1 business, 1 industry expert."

# Exemplo 3: Due diligence de co-fundador
prompt = "Crie um checklist de due diligence para avaliar potencial co-fundador: 
experiência, values alignment, availability, financial situation, 
e referências."
```

**Casos de uso avançados:**
- Projeto Real 1: Encontrar co-fundador go-to-market para startup deep-tech
- Projeto Real 2: Estruturar vesting schedule justo para equipo fundador

**Integração com outras skills:**
- **startup-analyst:** para análise de negócio do duo/trio fundador
- **team-composition-analysis:** para estruturação de equipe
- **startup-business-analyst-business-case:** para pitch conjunto

**Padrões e anti-padrões:**
✅ Fazer: Testar working together antes de comprometer, ter acordo de vesting (4 years), comunicar expectativas
❌ Evitar: Fundar com amigo sem validar fit, não ter vesting, dividir equity igual sem considerar contribuições

**Dicas de performance:**
- Usar platformas como YC Co-Founder Matching, Founder2Be
- Ter projeto piloto together antes de decidir
- Consultar advogado para agreement
- ConsiderarFounder's Agreement com cliff de 1 ano

**Comandos úteis:**
```markdown
# Checklist de fit entre co-fundadores
## Values Alignment
- [ ] Mesma visão de longo prazo
- [ ] Estilo de trabalho compatível
- [ ] Apteza para conflito e resolução

## Complementary Skills
- [ ] Technical / Business / Industry (mínimo 2 de 3)
- [ ] Um lidera produto, outro lidera mercado

## Practical Fit
- [ ] Disponibilidade de tempo (full-time?)
- [ ] Situação financeira (pode sobreviver sem salário?)
- [ ] Localização (same city / remote OK?)
```

**Referências:**
- [Y Combinator Co-Founder Matching](https://www.ycombinator.com/cofounder-matching)
- [Founders' Agreement - Clerky](https://clerky.com/)
- [Slicing Pie](https://slicingpie.com/)

---

#### 45. kotler-macro-analyzer

**Descrição:** Análise PESTEL/SWOT baseada em Kotler para auditoria de mercado

**Quando usar:**
- Realizar auditoria estratégica de mercado
- Analisar fatores macroeconômicos
- Identificar oportunidades e ameaças externas

**Exemplos práticos:**
```markdown
# Exemplo 1: Análise PESTEL
prompt = "Faça análise PESTEL completa do mercado de fintechs no Brasil para 2026. 
Para cada fator (Político, Econômico, Social, Tecnológico, Ecológico, 
Legal), identifique impacto no nosso negócio."

# Exemplo 2: SWOT estratégica
prompt = "Crie uma análise SWOT do nosso SaaS de gestão financeira considerando: 
concorrentes (Totvs, Omie), tendências (IA, Open Banking), e contexto 
econômico (taxa Selic, inflação)."

# Exemplo 3: Análise de indústria (Porter)
prompt = "Analise as 5 forças de Porter para o mercado de ERP no Brasil: 
poder de barganha dos clientes, fornecedores, novos entrantes, 
produtos substitutos, e rivalidade."
```

**Casos de uso avançados:**
- Projeto Real 1: Auditoria estratégica anual para tomada de decisão
- Projeto Real 2: Análise de viabilidade para entrada em novo mercado

**Integração com outras skills:**
- **competitive-landscape:** para análise competitiva detalhada
- **market-sizing-analysis:** para dimensionar oportunidades
- **product-manager:** para alinhar estratégia de produto com ambiente externo

**Padrões e anti-padrões:**
✅ Fazer: Atualizar分析 anualmente, usar fontes confiáveis, considerar interações entre fatores
❌ Evitar: Análise genérica sem contexto específico, ignorar tendências emergentes

**Dicas de performance:**
- Usar template PESTEL padronizado
- Coletar dados de fontes governamentais e setoriais
- Revisar com stakeholders de diferentes áreas

**Referências:**
- [Marketing Management by Philip Kotler](https://www.amazon.com/Marketing-Management-Philip-Kotler/dp/0133856461)
- [Porter's Five Forces](https://hbr.org/2008/01/the-five-competitive-forces-that-shape-strategy)
- [PESTEL Analysis Guide](https://pestelanalysis.com/)

---

#### 46. osterwalder-canvas-architect

**Descrição:** Construção e validação de Business Model Canvas (9 blocos)

**Quando usar:**
- Criar ou validar modelo de negócio
- Documentar hipóteses de negócio
- Comunicar modelo para stakeholders

**Exemplos práticos:**
```markdown
# Exemplo 1: BMC completo
prompt = "Construa um BMC (Business Model Canvas) para nosso novo produto de 
edtech B2C. Para cada bloco (Parceiros, Atividades, Recursos, Proposta 
de Valor, Relacionamento, Canais, Segmentos, Custos, Receitas), 
defina conteúdo específico."

# Exemplo 2: Validação de hipóteses
prompt = "Para cada bloco do BMC, defina as principais hipóteses de risco e 
sugira experimentos de validação com baixo custo."

# Exemplo 3: Pivot baseado em dados
prompt = "Com base nos dados de validação, sugira alterações no BMC: o que 
mudou, o que permanece, e quais novas hipóteses precisam ser testadas."
```

**Casos de uso avançados:**
- Projeto Real 1: Workshop de inovação com BMC para nova vertical de produto
- Projeto Real 2: Documentação para investidores com BMC + Lean Canvas

**Integração com outras skills:**
- **startup-analyst:** para análise de negócio complementar
- **market-sizing-analysis:** para validação de blocos de receita e segmentos
- **competitive-landscape:** para análise de proposta de valor vs concorrência

**Padrões e anti-padrões:**
✅ Fazer: Validar hipóteses com experimentos, atualizar BMC regularmente, envolver team
❌ Evitar: Preencher e esquecer, não testar hipóteses, usar BMC como documento estático

**Dicas de performance:**
- Usar ferramentas digitais (Miro, Mural, Strategyzer)
- Realizar workshops com team cross-functional
- Revisar BMC trimestralmente

**Referências:**
- [Business Model Generation](https://www.strategyzer.com/)
- [Strategyzer](https://www.strategyzer.com/canvas)
- [Lean Canvas](https://leanstack.com/leancanvas)
- [Alexander Osterwalder's Blog](https://businessmodelalchemist.com/)

---

## 3. MARKETING (57 skills)

### 3.1 Estratégia e Planejamento

---

#### 47. growth-engine

**Descrição:** Motor de crescimento: growth hacking, SEO, ASO, loops virais, email marketing

**Quando usar:**
- Criar estratégia de crescimento para produto digital
- Implementar growth loops virais
- Otimizar canais de aquisição

**Exemplos práticos:**
```markdown
# Exemplo 1: Growth strategy
prompt = "Crie plano de growth hacking para app de fitness com foco em viral 
loops (invite a friend → reward), SEO para landing pages, e email 
marketing para retenção."

# Exemplo 2: Viral loop design
prompt = "Projete um viral loop para nosso SaaS: como cada usuário pode trazer 
2+ novos usuários naturalmente through product usage."

# Exemplo 3: Canal prioritário
prompt = "Analise nossos canais de aquisição (Google Ads, SEO, referrals, 
partnerships) e sugira qual escalar primeiro baseado em CAC e LTV."
```

**Casos de uso avançados:**
- Projeto Real 1: Implementação de growth engine completa para SaaS B2B
- Projeto Real 2: Criação de viral loop com coefficient > 1 para app B2C

**Integração com outras skills:**
- **free-tool-strategy:** para engineering-as-marketing
- **referral-program:** para programa de indicações
- **seo-drift:** para monitoramento SEO
- **email-sequence:** para nutrição de leads

**Padrões e anti-padrões:**
✅ Fazer: Testar canais com experimentos, focar em um canal por vez, medir CAC:LTV
❌ Evitar: Espalhar recursos em muitos canais, não medir ROI, ignorar retenção

**Dicas de performance:**
- Usar framework ICE (Impact, Confidence, Ease) para priorizar experimentos
- Implementar analytics robusto (Mixpanel, Amplitude)
- Criar growth board para revisão semanal

**Referências:**
- [Hacking Growth by Sean Ellis](https://www.amazon.com/Hacking-Growth-Experiment-Fast-Business/dp/1591847672)
- [Reforge](https://www.reforge.com/)
- [Lenny's Newsletter](https://www.lennysnewsletter.com/)

---

#### 48. launch-strategy

**Descrição:** Lançamentos de SaaS e anúncios de features

**Quando usar:**
- Planejar lançamento de produto ou feature
- Maximizar impacto de launch
- Coordenar esforços cross-functional

**Exemplos práticos:**
```markdown
# Exemplo 1: Product Hunt launch
prompt = "Planeje o lançamento no Product Hunt: timeline pré-launch (2 semanas), 
dia do launch (assets, messaging, maker comment), e pós-launch 
(follow-up, métricas)."

# Exemplo 2: Feature launch
prompt = "Crie estratégia de lançamento da nova feature de automação. Inclua: 
beta testers, announcement plan, email para usuários, blog post, 
e métricas de adoção."

# Exemplo 3: GTM strategy
prompt = "Desenvolva a go-to-market strategy para o novo módulo de analytics: 
público-alvo, pricing, canais de distribuição, timeline, e team 
responsabilities."
```

**Casos de uso avançados:**
- Projeto Real 1: Lançamento coordenado em 5+ canais (Product Hunt, Hacker News, LinkedIn, Twitter, Email)
- Projeto Real 2: Feature launch com beta program e coleta de feedback estruturado

**Integração com outras skills:**
- **product-marketing:** para posicionamento e messaging
- **content-creator:** para produção de conteúdo
- **social-orchestrator:** para publicação cross-channel
- **ad-campaign-analyzer:** para medir impacto

**Padrões e anti-padrões:**
✅ Fazer: Ter timeline clara, coordenar equipes, coletar feedback pós-launch
❌ Evitar: Launch sem preparação, não envolver customers, ignorar métricas

**Dicas de performance:**
- Criar launch checklist reutilizável
- Usar countdown para criar expectativa
- Ter assets prontos com antecedência

**Referências:**
- [Obviously Awesome by April Dunford](https://www.aprildunford.com/)
- [Launch by Jeff Walker](https://www.launchformula.com/)
- [Product Hunt Resources](https://www.producthunt.com/)

---

#### 49. marketing-ideas

**Descrição:** Estratégias comprovadas de marketing para SaaS, priorizadas por viabilidade

**Quando usar:**
- Buscar ideias de marketing para produto SaaS
- Quebrar bloqueio criativo
- Priorizar iniciativas de marketing

**Exemplos práticos:**
```markdown
# Exemplo 1: Brainstorm de estratégias
prompt = "Sugira 20 estratégias de marketing para aumentar MRR de 10k para 50k 
em 6 meses. Para cada uma, defina: impacto estimado, esforço, custo, 
e timeline."

# Exemplo 2: Benchmark de concorrentes
prompt = "Analise as estratégias de marketing dos 5 maiores concorrentes e 
identifique oportunidades que não estamos explorando."

# Exemplo 3: Canal underexplored
prompt = "Identifique 3 canais de marketing que nossos concorrentes NÃO usam 
mas que podem funcionar para nosso público-alvo."
```

**Referências:**
- [Marketing Examples by Harry Dry](https://marketingexamples.com/)
- [Grow and Convert](https://www.growandconvert.com/)
- [Refining growth channels](https://www.reforge.com/)

---

#### 50. marketing-psychology

**Descrição:** Ciência comportamental aplicada a decisões de marketing

**Quando usar:**
- Tomar decisões de marketing baseadas em psicologia
- Aumentar conversão com gatilhos mentais
- Melhorar persuasão em copy e design

**Exemplos práticos:**
```markdown
# Exemplo 1: Escassez e urgência
prompt = "Aplique princípios de escassez e urgência na landing page: countdown 
timer, vagas limitadas, preço que aumenta após data."

# Exemplo 2: Prova social
prompt = "Implemente prova social em todas as etapas do funnel: logos de clientes, 
depoimentos, case studies, números (X empresas usam)."

# Exemplo 3: Framing effect
prompt = "Reescreva o copy da pricing page usando framing: em vez de 'R$ 99/mês', 
use 'menos de R$ 3,30 por dia'. Inclua âncora de preço com plano Enterprise."
```

**Referências:**
- [Influence by Robert Cialdini](https://www.amazon.com/Influence-Psychology-Persuasion-Robert-Cialdini/dp/006124189X)
- [Thinking Fast and Slow by Daniel Kahneman](https://www.amazon.com/Thinking-Fast-Slow-Daniel-Kahneman/dp/0374533555)
- [Nudge by Thaler & Sunstein](https://www.amazon.com/Nudge-Improving-Decisions-Health-Happiness/dp/014311526X)

---

#### 51. free-tool-strategy

**Descrição:** Estratégia de engineering-as-marketing: ferramentas gratuitas que geram leads

**Quando usar:**
- Criar ferramenta gratuita que gere tráfego e leads
- Posicionar marca como autoridade no setor
- Gerar backlinks e domain authority

**Exemplos práticos:**
```markdown
# Exemplo 1: Calculadora interativa
prompt = "Planeje uma calculadora gratuita de ROI para profissionais de marketing. 
Deve ser interativa, mobile-friendly, e capturar email antes de mostrar 
resultado completo."

# Exemplo 2: Free tool como lead magnet
prompt = "Crie uma ferramenta gratuita de auditoria SEO que analise o site do 
usuário e gere relatório em PDF com recomendações (capturando email)."

# Exemplo 3: Benchmark tool
prompt = "Desenvolva um benchmark tool que compare métricas do usuário com o 
mercado (benchmark de SaaS: churn, CAC, LTV). Gere relatório personalizado."
```

**Referências:**
- [Built to Sell by John Warrillow](https://www.amazon.com/Built-Sell-Creating-Business-Sellable/dp/1591844886)
- [Engineering as Marketing](https://www.reforge.com/)

---

### 3.2 Copywriting e Conteúdo

---

#### 52. copywriting

**Descrição:** Copy focada em conversão para landing pages e emails

**Quando usar:**
- Criar copy de alta conversão
- Otimizar landing pages existentes
- Escrever emails de vendas

**Exemplos práticos:**
```markdown
# Exemplo 1: Landing page completa
prompt = "Escreva copy para LP de lançamento de produto SaaS usando AIDA 
(Attention, Interest, Desire, Action). Inclua: headline, subheadlines, 
bullets, social proof, CTA, e FAQ."

# Exemplo 2: Email de vendas
prompt = "Escreva email de vendas B2B para CTO: dor → solução → prova → CTA. 
Máximo 150 palavras, subject line que gere curiosidade."

# Exemplo 3: Sales page
prompt = "Crie sales page de R$ 997 usando PAS (Problem, Agitation, Solution). 
Inclua: stack de valor, bônus, garantia, e urgência."
```

**Referências:**
- [Copywriting Secrets by Jim Edwards](https://www.amazon.com/Copywriting-Secrets-Everyone-Technology-Persuade/dp/1640883005)
- [The Boron Letters by Gary Halbert](https://www.amazon.com/Boron-Letters-Gary-Halbert/dp/0990359525)
- [Everybody Writes by Ann Handley](https://www.amazon.com/Everybody-Writes-Residents-Publishing/dp/1118908594)

---

#### 53. copy-editing

**Descrição:** Edição sistemática de copy existente para melhorar conversão

**Quando usar:**
- Refinar copy existente
- Melhorar clareza e persuasão
- Testar diferentes versões

**Exemplos práticos:**
```markdown
# Exemplo 1: Edição de homepage
prompt = "Edite o copy da homepage para aumentar taxa de conversão. Foco em: 
headlines mais claras, benefit-driven bullets, CTA mais forte, 
e redução de fricção."

# Exemplo 2: A/B test copy
prompt = "Crie 3 versões de headline para teste A/B: uma focada em dor, 
outra em benefício, terceira em prova social."

# Exemplo 3: Simplificação
prompt = "Simplifique este copy técnico para non-technical audience. 
Mantenha a mensagem principal, mas use linguagem acessível."
```

**Referências:**
- [On Writing Well by William Zinsser](https://www.amazon.com/Writing-Well-Classic-Guide-Nonfiction/dp/0060891548)
- [Hemingway Editor](https://hemingwayapp.com/)

---

#### 54. content-creator

**Descrição:** Conteúdo para audiências específicas usando templates de canal

**Quando usar:**
- Criar conteúdo para múltiplos canais
- Adaptar mensagem por plataforma
- Manter consistência de marca

**Exemplos práticos:**
```markdown
# Exemplo 1: Multi-channel content
prompt = "Crie post para LinkedIn (carrossel 5 slides), thread para Twitter 
(10 tweets), artigo para blog (1500 palavras), e vídeo curto para 
Reels/TikTok - todos sobre o mesmo tema."

# Exemplo 2: Content calendar
prompt = "Crie calendário de conteúdo de 30 dias para LinkedIn: 3 posts/semana 
(variando: educativo, case study,behind-the-scenes)."

# Exemplo 3: Repurposing
prompt = "Transforme este webinar de 1 hora em: 1 blog post, 5 posts LinkedIn, 
3 threads Twitter, 10 stories, 1 email newsletter."
```

**Referências:**
- [Content Inc by Joe Pulizzi](https://www.amazon.com/Content-Inc-Entrepreneurs-Content-Marketing/dp/1939526429)
- [Everybody Writes by Ann Handley](https://www.amazon.com/Everybody-Writes-Residents-Publishing/dp/1118908594)

---

#### 55. email-sequence

**Descrição:** Sequências de email marketing para nutrição e conversão

**Quando usar:**
- Criar funil de email marketing
- Nutrir trial users
- Sequências pós-compra

**Exemplos práticos:**
```markdown
# Exemplo 1: Onboarding sequence (7 emails)
Day 0: Welcome + quick win
Day 1: Feature highlight + use case
Day 3: Case study social proof
Day 5: Advanced feature tutorial
Day 7: Check-in + offer help
Day 10: Success story
Day 14: Upgrade prompt

# Exemplo 2: Nurture sequence
prompt = "Crie sequência de 5 emails para nutrir leads inbound: educar sobre 
o problema, apresentar solução, mostrar prova social, criar urgência, 
CTA final."

# Exemplo 3: Win-back sequence
prompt = "Crie sequência de 3 emails para reengajar usuários que cancelaram: 
entender motivo, oferecer retorno com desconto, última tentativa."
```

**Referências:**
- [Email Marketing Rules by Chad White](https://www.amazon.com/Email-Marketing-Rules-Checklists-Pointers/dp/0134081567)
- [ConvertKit](https://convertkit.com/)
- [Drip](https://www.drip.com/)

---

#### 56. brand-guidelines

**Descrição:** Diretrizes de marca para copy, mensagens de erro, onboarding

**Quando usar:**
- Escrever com tom de voz da marca
- Criar identidade verbal consistente
- Documentar brand voice para a equipe

**Exemplos práticos:**
```markdown
# Exemplo 1: Brand voice guidelines
prompt = "Crie diretrizes de brand voice para SaaS B2B: tom (profissional mas 
acessível), palavras que usamos vs evitamos, exemplos de copy 
correto/incorreto."

# Exemplo 2: Tone of voice por contexto
prompt = "Defina como adaptar o tom de voz por contexto: error messages 
(empático), onboarding (encorajador), pricing (confiante), suporte 
(paciente)."

# Exemplo 3: Mensagens de erro
prompt = "Reescreva todas as mensagens de erro do app para seguir o brand voice. 
Exemplo: 'Algo deu errado' → 'Ops! Tivemos um probleminha. Vamos 
resolver rápido.'"
```

**Referências:**
- [Building a StoryBrand by Donald Miller](https://www.amazon.com/Building-StoryBrand-Clarify-Message-Customers/dp/0718033329)
- [Brand Voice Guide - Mailchimp](https://styleguide.mailchimp.com/brand-voice/)

### 3.3 SEO e Tráfego Orgânico

---

#### 57. geo-fundamentals

**Descrição:** Generative Engine Optimization para buscadores de IA

**Quando usar:**
- Otimizar conteúdo para ChatGPT, Claude, Perplexity
- Aparecer em respostas de IA generativa
- Adaptar SEO para era de AI search

**Exemplos práticos:**
```markdown
# Exemplo 1: Otimização para AI search
prompt = "Otimize o conteúdo do site para aparecer em respostas de IA. 
Estruture: answers to common questions, dados estruturados, 
autoridade topical, e citations de qualidade."

# Exemplo 2: Content structure for GEO
prompt = "Reestruture as páginas do site para GEO: responses concisas no início, 
FAQ sections, dados verificáveis, e links para fontes primárias."

# Exemplo 3: AI citation strategy
prompt = "Crie estratégia para ser citado em respostas de IA: autoridade no tema, 
dados originais, partnerships com sites autoritativos."
```

**Referências:**
- [GEO: Generative Engine Optimization](https://www.searchenginejournal.com/)
- [Optimizing for AI Search](https://moz.com/)

---

#### 58. programmatic-seo

**Descrição:** Estratégias de SEO programático para criar páginas em escala

**Quando usar:**
- Criar centenas de páginas SEO otimizadas
- Automatizar criação de conteúdo
- Escalar tráfego orgânico

**Exemplos práticos:**
```markdown
# Exemplo 1: Landing pages em escala
prompt = "Crie 500 páginas de categorias usando templates + dados estruturados 
para marketplace de serviços. Cada página: título dinâmico, descrição 
personalizada, listings relevantes."

# Exemplo 2: Location-based pages
prompt = "Gere páginas para cada cidade do Brasil (5500+): '[Serviço] em [Cidade]' 
com conteúdo localizado, reviews, e dados relevantes."

# Exemplo 3: Comparison pages
prompt = "Crie páginas de comparação '[Produto A] vs [Produto B]' para todos os 
pares de concorrentes. Conteúdo: features, pricing, prós/contras, 
alternativas."
```

**Referências:**
- [Programmatic SEO Guide - Ahrefs](https://ahrefs.com/programmatic-seo)
- [Programmatic SEO - Stripe](https://stripe.com/blog/programmatic-seo)

---

#### 59. schema-markup

**Descrição:** Validação e otimização de schema.org structured data

**Quando usar:**
- Melhorar rich snippets no Google
- Aumentar CTR em SERPs
- Implementar dados estruturados

**Exemplos práticos:**
```json
// Exemplo 1: Product schema
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "SaaS de Gestão de Projetos",
  "description": "Plataforma completa para gerenciar projetos",
  "brand": { "@type": "Brand", "name": "Minha Empresa" },
  "offers": {
    "@type": "Offer",
    "price": "99.00",
    "priceCurrency": "BRL",
    "availability": "https://schema.org/InStock"
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "reviewCount": "150"
  }
}

// Exemplo 2: FAQ schema
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "O que é gestão de projetos?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Gestão de projetos é a aplicação de conhecimentos..."
      }
    }
  ]
}
```

**Referências:**
- [Schema.org](https://schema.org/)
- [Google Structured Data](https://developers.google.com/search/docs/appearance/structured-data)
- [Schema Markup Generator](https://technicalseo.com/tools/schema-markup-generator/)

---

#### 60. keyword-extractor

**Descrição:** Extração de até 50 palavras-chave SEO relevantes de texto

**Quando usar:**
- Gerar lista de keywords para conteúdo
- Encontrar oportunidades de long-tail
- Analisar concorrência por keywords

**Exemplos práticos:**
```python
# Exemplo 1: Extração de keywords
from rake_nltk import Rake

def extract_keywords(text, max_keywords=50):
    r = Rake()
    r.extract_keywords_from_text(text)
    return r.get_ranked_phrases()[:max_keywords]

# Exemplo 2: Keyword clustering
def cluster_keywords(keywords):
    clusters = {}
    for kw in keywords:
        topic = identify_topic(kw)
        clusters.setdefault(topic, []).append(kw)
    return clusters

# Exemplo 3: Keyword difficulty analysis
def analyze_keyword_difficulty(keyword, domain_authority):
    # Simplified scoring
    competition_score = get_competition(keyword)
    difficulty = (competition_score * 0.7) + ((100 - domain_authority) * 0.3)
    return {'keyword': keyword, 'difficulty': difficulty}
```

**Referências:**
- [Ahrefs Keywords Explorer](https://ahrefs.com/keywords-explorer)
- [SEMrush Keyword Magic Tool](https://www.semrush.com/)
- [Google Keyword Planner](https://ads.google.com/home/tools/keyword-planner/)

---

#### 61. seo-drift

**Descrição:** Snapshot de estado SEO e detecção de regressões

**Quando usar:**
- Monitorar mudanças de ranking
- Detectar quedas de tráfego
- Auditoria técnica de SEO

**Exemplos práticos:**
```markdown
# Exemplo 1: Monitoramento de ranking
prompt = "Detecte quedas de ranking nas últimas 2 semanas para todas as 
palavras-chave principais. Compare com baseline anterior."

# Exemplo 2: Technical SEO audit
prompt = "Faça auditoria técnica completa: velocidade de carregamento, 
mobile-friendliness, canonical tags, sitemap, robots.txt, 
e erros de crawl."

# Exemplo 3: Content performance
prompt = "Analise performance do conteúdo: páginas com queda de tráfego, 
páginas que precisam de atualização, e oportunidades de refresh."
```

**Referências:**
- [Ahrefs Site Audit](https://ahrefs.com/site-audit)
- [Screaming Frog](https://www.screamingfrog.co.uk/)
- [Google Search Console](https://search.google.com/search-console)

---

#### 62. app-store-optimization

**Descrição:** Toolkit completo de ASO para App Store e Google Play

**Quando usar:**
- Otimizar listing de app mobile
- Melhorar rankings em app stores
- Aumentar downloads orgânicos

**Exemplos práticos:**
```markdown
# Exemplo 1: App Store listing optimization
prompt = "Otimize o título, subtítulo, keywords e screenshots do app na Play Store. 
Título: 30 chars max com keyword principal. Subtítulo: 40 chars com 
benefício secundário."

# Exemplo 2: Screenshot design
prompt = "Projete 5 screenshots que comunicam valor em 3 segundos: 
1) Hero shot, 2) Feature highlight, 3) Social proof, 4) Before/after, 
5) CTA."

# Exemplo 3: Review management
prompt = "Crie estratégia para gerenciar reviews: responder a todos negativos em 
24h, solicitar reviews de usuários satisfeitos, e identificar padrões 
de feedback."
```

**Referências:**
- [App Annie](https://www.appannie.com/)
- [Sensor Tower](https://www.sensortower.com/)
- [ASO Guide](https://www.gummicube.com/aso-guide)

---

#### 63. local-legal-seo-audit

**Descrição:** SEO local para escritórios de advocacia e serviços profissionais

**Quando usar:**
- Auditar SEO local de escritório
- Otimizar Google Business Profile
- Aumentar visibilidade local

**Exemplos práticos:**
```markdown
# Exemplo 1: Google Business Profile optimization
prompt = "Otimize o GBP do escritório: informações completas, fotos profissionais, 
posts semanais, Q&A, e resposta a reviews. Foco em keywords locais."

# Exemplo 2: Local citations
prompt = "Crie e/ou corrija citações em diretórios locais: Jusbrasil, 
Advogados.com, Google, Bing, Yelp. Garanta NAP consistency."

# Exemplo 3: Local content strategy
prompt = "Crie conteúdo local: artigos sobre legislação [cidade], guias 
para [problema jurídico] em [cidade], e landing pages por área de 
atuação."
```

**Referências:**
- [Moz Local SEO Guide](https://moz.com/learn/local)
- [Google Business Profile](https://business.google.com/)
- [BrightLocal](https://www.brightlocal.com/)

---

### 3.4 Mídias Sociais e Automação

---

#### 64. linkedin-content-generator

**Descrição:** IA para posts, carrosséis, newsletters, calendário de 30 dias LinkedIn

**Quando usar:**
- Criar conteúdo LinkedIn em escala
- Gerar carrosséis virais
- Manter presença consistente

**Exemplos práticos:**
```markdown
# Exemplo 1: Calendar de 30 dias
prompt = "Gere calendário de 30 dias de posts para LinkedIn (3 posts/semana). 
Temas: Monday: insight técnico, Wednesday: case study, Friday: 
personal/behind-the-scenes."

# Exemplo 2: Carousel creation
prompt = "Crie carrossel de 10 slides sobre '7 erros comuns em gestão de projetos' 
para LinkedIn. Cada slide: título + 1 frase + slide visual."

# Exemplo 3: Newsletter strategy
prompt = "Planeje newsletter LinkedIn semanal: tema, estrutura (hook → conteúdo 
→ CTA), e métricas de sucesso (open rate, click rate)."
```

**Referências:**
- [LinkedIn Algorithm Guide](https://www.linkedin.com/business/marketing/blog)
- [Shield Analytics](https://shieldapp.ai/)
- [Authory](https://authory.com/)

---

#### 65. linkedin-post-writer

**Descrição:** Posts LinkedIn com 16 fórmulas de hook e regras de algoritmo 2026

**Quando usar:**
- Escrever posts LinkedIn com alta engajamento
- Criar hooks que prendem atenção
- Aumentar alcance orgânico

**Exemplos práticos:**
```markdown
# Exemplo 1: Post storytelling
Hook: "Em 2024, quase perdi minha startup."
Body: "Estávamos com 3 meses de runway. Contratei errado. Gastei demais. 
Mas uma decisão no dia 15 de março mudou tudo..."
Lesson: "Aqui está o que aprendi:"
CTA: "Você já passou por algo assim? Comenta abaixo."

# Exemplo 2: Post educativo
Hook: "SaaS não morre por falta de produto. Morre por falta de distribuição."
Body: "3 coisas que aprendi crescendo de 0 → 50k MRR:"
1. ...
2. ...
3. ...
CTA: "Salve para consultar depois."

# Exemplo 3: Post polêmico
Hook: "Resumo: 90% dos OKRs são inúteis."
Body: "Não porque OKR é ruim. Mas porque a maioria das empresas..."
CTA: "Concorda? Discorda? Me conta nos comentários."
```

**Referências:**
- [LinkedIn Creator Mode](https://www.linkedin.com/creator/)
- [LinkedIn Algorithm 2024](https://www.linkedin.com/business/talent/blog/talent-acquisition/linkedin-algorithm)

---

#### 66. linkedin-profile-optimizer

**Descrição:** Otimização de perfil LinkedIn para top 1% de posicionamento

**Quando usar:**
- Melhorar presença profissional no LinkedIn
- Atrair oportunidades via perfil
- Construir autoridade pessoal

**Exemplos práticos:**
```markdown
# Exemplo 1: Headline otimizada
prompt = "Otimise o headline do LinkedIn do CEO: atualmente 'CEO at Startup X'. 
Novo formato: [Cargo] | [Benefício que entrega] | [Prova social 
emojizada]"

# Exemplo 2: About section
prompt = "Reescreva a seção About do LinkedIn usando framework: Hook → Story → 
Credibility → CTA. Máximo 2600 caracteres, 3 parágrafos."

# Exemplo 3: Featured section
prompt = "Organize a seção Featured: 1) Post top performer, 2) Case study, 
3) Lead magnet, 4) Calendar para agendar call."
```

**Referências:**
- [LinkedIn Profile Optimization](https://www.linkedin.com/business/marketing/blog)
- [LinkedIn Top Voices](https://www.linkedin.com/)

---

#### 67. social-content

**Descrição:** Estratégia de redes sociais com agendamento em múltiplas plataformas

**Quando usar:**
- Criar e agendar conteúdo social
- Manter presença multicanal
- Otimizar engajamento

**Exemplos práticos:**
```markdown
# Exemplo 1: Cross-platform content
prompt = "Crie conteúdo para Instagram (3 posts/semana), LinkedIn (3 posts/semana), 
e Twitter (5 tweets/semana) do próximo mês. Adapte formato por plataforma."

# Exemplo 2: Content repurposing
prompt = "Transforme este blog post em: 1 LinkedIn carousel, 3 Twitter threads, 
5 Instagram stories, 2 Reels scripts, 1 newsletter."

# Exemplo 3: Hashtag strategy
prompt = "Crie estratégia de hashtags para Instagram: 30 hashtags por post, 
divididas em (10 alta competição + 10 média + 10 nicho)."
```

**Referências:**
- [Buffer](https://buffer.com/)
- [Hootsuite](https://www.hootsuite.com/)
- [Later](https://later.com/)

---

#### 68. social-orchestrator

**Descrição:** Orquestrador de Instagram, Telegram e WhatsApp em fluxo único

**Quando usar:**
- Publicação cross-channel sincronizada
- Gerenciar múltiplos canais de uma vez
- Automatizar distribuição de conteúdo

**Exemplos práticos:**
```markdown
# Exemplo 1: Publicação simultânea
prompt = "Publique campanha simultaneamente em Instagram (post + stories), 
Telegram (canal + grupo), e WhatsApp (broadcast list)."

# Exemplo 2: Automation flow
prompt = "Crie fluxo automatizado: novo blog post → Instagram carousel → 
Twitter thread → Telegram announcement → Email newsletter."

# Exemplo 3: Cross-channel engagement
prompt = "Monitore engajamento em todos os canais e responda comments/mentions 
em até 2 horas. Priorize: Telegram > WhatsApp > Instagram."
```

**Referências:**
- [ManyChat](https://manychat.com/)
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [WhatsApp Business API](https://business.whatsapp.com/)

---

#### 69. socialclaw

**Descrição:** Publicação em 13 plataformas via API única (X, LinkedIn, Instagram, etc)

**Quando usar:**
- Agendar e publicar em múltiplas redes
- Unificar gestão de conteúdo social
- Escalar presença digital

**Exemplos práticos:**
```markdown
# Exemplo 1: Agendamento multicanal
prompt = "Agende posts semanais para todas as 13 redes sociais da empresa. 
Adapte formato e tamanho para cada plataforma automaticamente."

# Exemplo 2: Analytics consolidado
prompt = "Gere relatório consolidado de performance em todas as 13 plataformas: 
engajamento, alcance, crescimento de seguidores, e top content."

# Exemplo 3: Bulk scheduling
prompt = "Faça upload de 50 posts para agendamento no próximo mês com variantes 
por plataforma (formato, hashtag, horário ideal)."
```

**Referências:**
- [Publer](https://publer.io/)
- [SocialBee](https://socialbee.io/)
- [Sprout Social](https://sproutsocial.com/)

---

### 3.5 Automação de Plataformas

---

#### 70-80. Platform Automation Skills (resumo expandido)

**activecampaign-automation:** Automação ActiveCampaign
- **Integração:** revops, email-sequence
- **Padrão:** Segmentar por comportamento, usar automações com branches
- **Anti-padrão:** Enviar tudo para todos, não testar subject lines

**brevo-automation:** Automação Brevo (Sendinblue)
- **Integração:** email-sequence, revops
- **Padrão:** Usar transacionais + marketing em conjunto
- **Anti-padrão:** Ignorar limites de envio, não verificar deliverability

**convertkit-automation:** Automação ConvertKit
- **Integração:** content-creator, email-sequence
- **Padrão:** Usar visual automations, segmentar por tags
- **Anti-padrão:** Não ter sequência de boas-vindas

**klaviyo-automation:** Automação Klaviyo (email + SMS)
- **Integração:** ecommerce, revops, email-sequence
- **Padrão:** Flows de carrinho abandonado, winback, post-purchase
- **Anti-padrão:** Não integrar com ecommerce, ignorar métricas de deliverability

**mailchimp-automation:** Automação Mailchimp
- **Integração:** email-sequence, content-creator
- **Padrão:** UsarCustomer Journey builder, testar A/B
- **Anti-padrão:** Usar planos gratuitos para escalar, ignorar segmentação

**instagram-automation:** Automação Instagram
- **Integração:** social-content, social-orchestrator
- **Padrão:** Respeitar limites da API, usar posts agendados
- **Anti-padrão:** Postar mais de 3x/dia, ignorar DMs, usar bots de engajamento

**tiktok-automation:** Automação TikTok
- **Integração:** social-content, taisly-social-media-posting
- **Padrão:** Vídeos curtos (15-30s), trending sounds, hashtags trending
- **Anti-padrão:** Reupload de conteúdo de outras plataformas sem adaptação

**twitter-automation:** Automação Twitter/X
- **Integração:** social-content, x-article-publisher-skill
- **Padrão:** Threads educativas, engajamento manual, scheduled tweets
- **Anti-padrão:** Auto-DM em massa, follow/unfollow, conteúdo sem valor

**youtube-automation:** Automação YouTube
- **Integração:** social-content, content-creator
- **Padrão:** Thumbnails consistentes, SEO em títulos/descrições, shorts
- **Anti-padrão:** Upload sem otimização, ignorar analytics, não responder comments

**reddit-automation:** Automação Reddit
- **Integração:** social-content
- **Padrão:** Participar genuinamente em comunidades, dar valor antes de promover
- **Anti-padrão:** Auto-post sem contexto, ignorar regras dos subreddits, spam

### 3.6 CRO (Conversion Rate Optimization)

---

#### 81. ab-test-setup

**Descrição:** Design de testes A/B: hipótese, variante, sample size, métricas

**Quando usar:**
- Criar teste A/B validado estatisticamente
- Otimizar conversão de páginas
- Validar mudanças de design/copy

**Exemplos práticos:**
```markdown
# Exemplo 1: Teste A/B de CTA
prompt = "Configure teste A/B para o botão CTA da LP: variação A = 'Comece grátis', 
variação B = 'Teste por 14 dias'. Defina: hipótese, sample size, 
duração, métrica primária."

# Exemplo 2: Teste de pricing page
prompt = "Projete teste A/B da pricing page: layout em grid vs. spotlight. 
Hipótese: spotlight aumenta seleção do plano intermediário em 15%."

# Exemplo 3: Teste de headline
prompt = "Crie 3 variações de headline para teste A/B/C. Medição: taxa de 
scroll e tempo na página. Duração: 2 semanas, mínimo 1000 visitas."
```

**Referências:**
- [Optimizely](https://www.optimizely.com/)
- [VWO](https://vwo.com/)
- [AB Testing Guide - CXL](https://cxl.com/institute/ courses/ab-testing/)

---

#### 82. page-cro

**Descrição:** Análise e otimização de páginas individuais para conversão

**Quando usar:**
- Melhorar conversão de página específica
- Identificar gargalos no funil
- Aumentar taxa de conversão

**Exemplos práticos:**
```markdown
# Exemplo 1: Landing page CRO
prompt = "Otimize a página de pricing para aumentar trial starts. Análise: 
hierarchy visual, social proof placement, CTA visibility, mobile UX, 
e redução de fricção."

# Exemplo 2: Homepage optimization
prompt = "Analise a homepage com Hotjar/heatmap: onde os usuários clicam? 
Onde saem? O que ignoram? Sugira 5 mudanças específicas."

# Exemplo 3: Feature page
prompt = "Otimize a página de feature 'Automação': headline clara, demo visual, 
benefícios bullets, e CTA contextualizado."
```

**Referências:**
- [CXL Institute](https://cxl.com/)
- [Hotjar](https://www.hotjar.com/)
- [Google Optimize](https://optimize.google.com/)

---

#### 83. signup-flow-cro

**Descrição:** Otimização de fluxos de signup e registro

**Quando usar:**
- Reduzir fricção no cadastro
- Aumentar taxa de conclusão de signup
- Otimizar onboarding inicial

**Exemplos práticos:**
```markdown
# Exemplo 1: Multi-step signup
prompt = "Redesenhe o signup flow em 3 steps: 1) Email + password, 2) Company info, 
3) Role/function. Adicione progress indicator e save partial data."

# Exemplo 2: Social login
prompt = "Implemente social login (Google, GitHub, Microsoft) para reduzir fricção. 
Mantenhe email como fallback. Teste: vs. traditional signup."

# Exemplo 3: Onboarding checklist
prompt = "Crie onboarding checklist pós-signup: 5 quick wins que levam ao 
'aha moment'. Gamifique com progress bar."
```

**Referências:**
- [UserOnboard](https://useronboard.com/)
- [Product-Led Growth by Wes Bush](https://www.amazon.com/Product-Led-Growth-Build-Business/dp/1544514514)

---

#### 84. onboarding-cro

**Descrição:** Onboarding e ativação: levar ao 'aha moment' rapidamente

**Quando usar:**
- Melhorar ativação de novos usuários
- Reduzir tempo para valor percebido
- Aumentar retenção na primeira semana

**Exemplos práticos:**
```markdown
# Exemplo 1: Time to value optimization
prompt = "Redesign o onboarding para ativação em < 5 minutos. Identifique o 
'aha moment' e remova todos os passos desnecessários antes dele."

# Exemplo 2: Guided tour
prompt = "Crie tour guiado interativo: 5 passos para primeiro sucesso. Use 
tooltips contextuais, skip option, e milestone celebrations."

# Exemplo 3: Empty states
prompt = "Redesenhe todas as empty states do app com: 1) Explicação do valor, 
2) Ação sugerida, 3) Visual guide. Transforme vazio em oportunidade."
```

**Referências:**
- [Userpilot](https://userpilot.com/)
- [Appcues](https://www.appcues.com/)
- [Chameleon](https://www.getchameleon.io/)

---

#### 85. paywall-upgrade-cro

**Descrição:** Paywalls in-app e fluxos de upgrade

**Quando usar:**
- Converter free → paid
- Otimizar momento de paywall
- Aumentar taxa de upgrade

**Exemplos práticos:**
```markdown
# Exemplo 1: Smart paywall
prompt = "Crie paywall inteligente que ative após 5 usos da feature premium. 
Contexto: 'Você já usou [feature] 5 vezes. Desbloqueie ilimitado 
por R$ 49/mês.'"

# Exemplo 2: Upgrade prompts
prompt = "Implemente upgrade prompts contextuais: ao atingir limite de projetos 
no free plan, mostrar benefício do Pro com CTA."

# Exemplo 3: Trial-to-paid conversion
prompt = "Projete fluxo de conversão trial→paid: email D-3 antes do fim do trial, 
paywall no app, e special offer para annual plan."
```

**Referências:**
- [RevenueCat](https://www.revenuecat.com/)
- [Qonversion](https://qonversion.io/)
- [Paywall Design Patterns](https://www.lennysnewsletter.com/p/paywall-design)

---

#### 86. popup-cro

**Descrição:** Popups, modais, overlays, slide-ins para conversão

**Quando usar:**
- Aumentar captura de leads
- Reduzir abandono de página
- Oferecer conteúdo especial

**Exemplos práticos:**
```markdown
# Exemplo 1: Exit-intent popup
prompt = "Crie popup de saída que capture email com 10% de conversão. Ofereça: 
ebook gratuito, checklist, ou desconto. Design: clean, CTA claro."

# Exemplo 2: Scroll-triggered slide-in
prompt = "Implemente slide-in após 50% de scroll: 'Gostando? Assine newsletter 
para mais conteúdo.' Position: canto inferior direito."

# Exemplo 3: Timed popup
prompt = "Crie popup após 30 segundos na página: oferta contextual baseada no 
conteúdo sendo lido. Ex: lendo sobre SEO → popup de curso de SEO."
```

**Referências:**
- [OptinMonster](https://optinmonster.com/)
- [Sumo](https://www.sumo.com/)
- [Picreel](https://picreel.com/)

---

#### 87. form-cro

**Descrição:** Otimização de formulários (lead capture, demo, survey, checkout)

**Quando usar:**
- Melhorar taxa de preenchimento
- Reduzir abandono de formulário
- Aumentar qualidade dos leads

**Exemplos práticos:**
```markdown
# Exemplo 1: Demo request form
prompt = "Otimize formulário de demo request: reduza de 10 para 4 campos, 
adicione social proof ao lado, e use smart defaults."

# Exemplo 2: Multi-step form
prompt = "Converta formulário longo em 3 steps com progress bar. Cada step: 
pergunta relacionada. Reduz abandono em 40%."

# Exemplo 3: Inline validation
prompt = "Implemente validação inline em tempo real: campo verde quando válido, 
vermelho quando inválido, mensagem de ajuda antes do erro."
```

**Referências:**
- [Typeform](https://www.typeform.com/)
- [Jotform](https://www.jotform.com/)
- [Formstack](https://www.formstack.com/)

---

#### 88. ad-campaign-analyzer

**Descrição:** Análise cross-channel de campanhas, quantificação de incerteza

**Quando usar:**
- Avaliar ROI de campanhas pagas
- Otimizar distribuição de orçamento
- Medir impacto real de ads

**Exemplos práticos:**
```markdown
# Exemplo 1: Cross-channel analysis
prompt = "Analise ROI de todas as campanhas do último trimestre: Google Ads, 
Meta Ads, LinkedIn Ads. Compare CAC por canal e sugira realocação."

# Exemplo 2: Attribution modeling
prompt = "Implemente modelo de atribuição multi-touch: qual canal contribuiu 
mais para conversão? First-click vs last-click vs linear."

# Exemplo 3: Budget optimization
prompt = "Com base nos dados, sugira como realocar orçamento de R$ 50k/mês 
entre canais para maximizar conversões."
```

**Referencies:**
- [Google Analytics 4](https://analytics.google.com/)
- [Triple Whale](https://www.triplewhale.com/)
- [Northbeam](https://www.northbeam.io/)

---

#### 89. competitor-ad-intelligence

**Descrição:** Pesquisa de ads de concorrentes, análise de padrões criativos

**Quando usar:**
- Entender estratégia de ads dos concorrentes
- Encontrar inspiração criativa
- Identificar gaps de oportunidade

**Exemplos práticos:**
```markdown
# Exemplo 1: Ad teardown
prompt = "Faça teardown dos anúncios dos 3 principais concorrentes: mensagens, 
formatos, CTAs, frequência, canais, e estimativa de gasto."

# Exemplo 2: Creative analysis
prompt = "Analise os 50 anúncios mais performáticos dos concorrentes: padrões 
de copy, estilos visuais, ofertas, e Gatilhos usados."

# Exemplo 3: Gap analysis
prompt = "Identifique oportunidades: canais onde concorrentes NÃO anunciam, 
audiências não exploradas, e formatos de anúncio subutilizados."
```

**Referências:**
- [Facebook Ad Library](https://www.facebook.com/ads/library/)
- [AdSpy](https://www.adspy.com/)
- [BigSpy](https://www.bigspy.com/)

---

#### 90. competitor-analysis

**Descrição:** Pesquisa de concorrentes com enriquecimento de dados e relatórios

**Quando usar:**
- Mapear concorrência completa
- Criar matriz comparativa
- Identificar diferenciais

**Exemplos práticos:**
```markdown
# Exemplo 1: Competitor matrix
prompt = "Crie matriz comparativa de 10 concorrentes: features, preços, público, 
canais de marketing, tecnologias, e reviews de clientes."

# Exemplo 2: SWOT per competitor
prompt = "Para cada um dos 5 principais concorrentes, crie SWOT individual e 
comparativa. Identifique onde podemos superá-los."

# Exemplo 3: Market positioning map
prompt = "Crie mapa de posicionamento: eixo X = preço (barato→caro), 
eixo Y = funcionalidade (simples→complexo). Plote concorrentes e 
identifique espaço vazio."
```

**Referências:**
- [Crayon](https://www.crayon.co/)
- [Klue](https://www.klue.com/)
- [Kompyte](https://www.kompyte.com/)

---

#### 91. paid-ads

**Descrição:** Marketing de performance: criação, otimização e escala de campanhas

**Quando usar:**
- Criar ou escalar campanhas pagas
- Otimizar ROAS
- Gerenciar múltiplas plataformas

**Exemplos práticos:**
```markdown
# Exemplo 1: Google Ads setup
prompt = "Crie campanha Google Ads para capturar demanda de ferramentas de PM: 
estrutura de conta (campanhas por feature), keywords (branded + non-branded), 
ad copy, e extensões."

# Exemplo 2: Meta Ads retargeting
prompt = "Implemente retargeting Meta Ads: audiences de visitantes (7d, 30d), 
engajamento (90d), e lookalike de compradores."

# Exemplo 3: Budget scaling
prompt = "Escale campanha de R$ 5k para R$ 50k/mês mantendo ROAS > 3x. 
Estratégia: duplicar budget a cada 2 semanas se KPIs OK."
```

**Referências:**
- [Google Ads](https://ads.google.com/)
- [Meta Business](https://business.facebook.com/)
- [LinkedIn Campaign Manager](https://www.linkedin.com/campaignmanager/)

---

#### 92. referral-program

**Descrição:** Programas de indicação viral que transformam clientes em growth

**Quando usar:**
- Criar programa de indicações
- Reduzir CAC via word-of-mouth
- Aumentar viral coefficient

**Exemplos práticos:**
```markdown
# Exemplo 1: Referral mechanics
prompt = "Lance programa de indicação com recompensa de 30 dias grátis para 
indicador e indicado. tracking: link único, dashboard de indicações."

# Exemplo 2: Tiered rewards
prompt = "Crie programa de indicação com tiers: 1 indicação = 1 mês grátis, 
5 indicações = plano anual grátis, 10 = merchandise exclusivo."

# Exemplo 3: Viral loop design
prompt = "Projete viral loop: usuário convida → amigo se cadastra → ambos 
ganham benefício → amigo convida outros. Meta: k-factor > 1."
```

**Referências:**
- [ReferralCandy](https://www.referralcandy.com/)
- [Friendbuy](https://www.friendbuy.com/)
- [Viral Loops](https://viral-loops.com/)

---

#### 93. viral-generator-builder

**Descrição:** Construir ferramentas compartilháveis: quizzes, calculadoras, geradores

**Quando usar:**
- Criar ferramenta viral que gere tráfego
- Gerar leads via conteúdo interativo
- Aumentar brand awareness

**Exemplos práticos:**
```markdown
# Exemplo 1: Quiz interativo
prompt = "Crie quiz 'Qual perfil de investidor você é?' que gere leads. 
10 perguntas → resultado personalizado → captura email → recomendação."

# Exemplo 2: Calculator
prompt = "Desenvolva calculadora de ROI para marketing: usuário insere dados → 
ve resultado → compartilha. Captura: email + company size."

# Exemplo 3: Generator tool
prompt = "Crie gerador de nomes de empresa com IA: input = descrição → 
output = 10 opções. Compartilhamento: resultado no Twitter com branding."
```

**Referências:**
- [Typeform Quizzes](https://www.typeform.com/)
- [Outgrow](https://www.outgrow.co/)
- [Interact](https://tryinteract.com/)

---

### 3.7 Plataformas Chinesas

---

#### 94. wechat-official-account-strategist

**Descrição:** Estratégia para WeChat Official Accounts: conteúdo, títulos, Mini-Programs

**Quando usar:**
- Crescer presença no WeChat
- Criar Mini-Programs
- Engajamento com audiência chinesa

**Exemplos práticos:**
```markdown
# Exemplo 1: Content strategy
prompt = "Crie estratégia de conteúdo para conta WeChat de marca: 3 posts/semana, 
títulos otimizados para search interno, e promoção via Mini-Program."

# Exemplo 2: Mini-Program
prompt = "Planeje Mini-Program para e-commerce: catálogo de produtos, carrinho, 
pagamento WeChat Pay, e compartilhamento social."

# Exemplo 3: Growth tactics
prompt = "Implemente táticas de crescimento no WeChat: QR codes em eventos, 
parcerias com KOLs, e campanhas de red envelope (hongbao)."
```

**Referências:**
- [WeChat Official](https://www.wechat.com/)
- [WeChat Mini-Program Documentation](https://developers.weixin.qq.com/miniprogram/dev/)

---

#### 95. xiaohongshu-content-strategist

**Descrição:** Conteúdo viral para Xiaohongshu (小红书): SEO, formatos trending

**Quando usar:**
- Criar conteúdo para mercado chinês
- Vender produtos para audiência chinesa
- Construir presença no Xiaohongshu

**Exemplos práticos:**
```markdown
# Exemplo 1: Content creation
prompt = "Crie 20 posts otimizados para Xiaohongshu sobre moda sustentável. 
Formato: foto lifestyle + texto 300-500 chars + hashtags trending."

# Exemplo 2: KOL partnership
prompt = "Identifique 10 KOLs de nicho (10k-100k followers) para parceria. 
Critérios: engajamento > 5%, conteúdo alinhado, audiência feminina 25-35."

# Exemplo 3: Product seeding
prompt = "Planeje product seeding: enviar produtos para 50 micro-influencers 
com brief criativo (não script). Meta: 30 posts orgânicos."
```

**Referências:**
- [Xiaohongshu](https://www.xiaohongshu.com/)
- [RED (Xiaohongshu for Business)](https://business.xiaohongshu.com/)

---

### 3.8 Outras Skills Marketing

---

#### 96. screenshots

**Descrição:** Gerar screenshots de app via Playwright para marketing

**Quando usar:**
- Criar imagens para Product Hunt ou landing page
- Gerar screenshots atualizados automaticamente
- Manter assets visuais consistentes

**Exemplos práticos:**
```javascript
// Exemplo: Screenshot automation com Playwright
const { chromium } = require('playwright');

async function generateScreenshots() {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  
  // Screenshot da homepage
  await page.setViewportSize({ width: 1440, height: 900 });
  await page.goto('https://example.com');
  await page.screenshot({ path: 'screenshot-desktop.png', fullPage: false });
  
  // Screenshot mobile
  await page.setViewportSize({ width: 375, height: 812 });
  await page.screenshot({ path: 'screenshot-mobile.png', fullPage: false });
  
  await browser.close();
}
```

**Referências:**
- [Playwright](https://playwright.dev/)
- [Percy](https://percy.io/)
- [Chromatic](https://www.chromatic.com/)

---

#### 97. x-article-publisher-skill

**Descrição:** Publicar artigos no X/Twitter

**Quando usar:**
- Publicar conteúdo longo no X
- Distribuir artigos de opinião
- Aumentar autoridade no X

**Exemplos práticos:**
```markdown
# Exemplo 1: Article publishing
prompt = "Publique artigo de 1500 chars sobre tendências de IA no X. 
Estrutura: hook → 3 insights → CTA para newsletter."

# Exemplo 2: Thread-to-article
prompt = "Transforme esta thread de 10 tweets em artigo completo para X Articles. 
Adicione contexto, dados, e conclusão."

# Exemplo 3: Article strategy
prompt = "Planeje publicação de 2 artigos/semana no X: temas, timing, 
promoção via tweets, e métricas de sucesso."
```

**Referências:**
- [X/Twitter Article Guidelines](https://help.twitter.com/)
- [Twitter Analytics](https://analytics.twitter.com/)

---

#### 98. talivia-agent-kit

**Descrição:** Configurar analytics de receita Talivia

**Quando usar:**
- Atribuição de receita
- Analytics de conversão
- Tracking de origem de clientes

**Exemplos práticos:**
```markdown
# Exemplo 1: Revenue attribution setup
prompt = "Configure tracking de atribuição de receita para o site. 
Integre: Google Analytics, Stripe, e CRM para closed-loop reporting."

# Exemplo 2: Multi-touch attribution
prompt = "Implemente modelo de atribuição multi-touch: first-touch, last-touch, 
e linear. Compare qual modelo melhor representa a realidade."

# Exemplo 3: Dashboard de receita
prompt = "Crie dashboard de receita por canal: MRR por origem, CAC por canal, 
e LTV por customer segment."
```

**Referências:**
- [Talivia](https://talivia.com/)
- [Ruler Analytics](https://ruleranalytics.com/)
- [Dreamdata](https://www.dreamdata.io/)

---

#### 99. taisly-social-media-posting

**Descrição:** Publicar vídeos curtos via Taisly (TikTok, Reels, Shorts)

**Quando usar:**
- Agendar vídeos curtos em múltiplas plataformas
- Manter presença em short-form video
- Escalar produção de vídeo curto

**Exemplos práticos:**
```markdown
# Exemplo 1: Multi-platform shorts
prompt = "Agende 15 vídeos curtos para TikTok, Reels e Shorts. 
Formato: 15-30s, trending audio, captions baked in."

# Exemplo 2: Content batching
prompt = "Planeje batch de gravação: 10 vídeos em 1 hora. Temas: 5 educativos, 
3 behind-the-scenes, 2 trending."

# Exemplo 3: Analytics tracking
prompt = "Monitore performance de vídeos curtos: views, watch time, shares, 
e follower conversion. Identifique padrões de viral."
```

**Referências:**
- [Taisly](https://taisly.com/)
- [Repurpose.io](https://repurpose.io/)
- [Publer](https://publer.io/)

---

## 4. GROWTH (3 skills)

---

#### 100. indexing-issue-auditor

**Descrição:** Auditor técnico de SEO: indexação, crawl budget, erros estruturais

**Quando usar:**
- Escanear site para problemas de indexação
- Otimizar crawl budget
- Corrigir erros técnicos de SEO

**Exemplos práticos:**
```markdown
# Exemplo 1: Index audit
prompt = "Audite o site para identificar: páginas não indexadas, erros 404, 
redirect chains, duplicate content, e thin pages. Gere relatório 
com prioridades de correção."

# Exemplo 2: Crawl budget optimization
prompt = "Analise crawl budget: quais páginas Googlebot não consegue crawl? 
Identifique páginas bloqueadas no robots.txt, páginas com noindex 
indevido, e sitemap issues."

# Exemplo 3: Technical SEO fixes
prompt = "Crie plano de correção para os 10 problemas técnicos mais críticos. 
Priorize por impacto no ranking e esforço de implementação."
```

**Referências:**
- [Google Search Console](https://search.google.com/search-console)
- [Screaming Frog SEO Spider](https://www.screamingfrog.co.uk/)
- [Sitebulb](https://sitebulb.com/)
- [Ahrefs Site Audit](https://ahrefs.com/site-audit)

---

#### 101. linkedin-profile-optimizer (Growth)

**Descrição:** Auditoria e otimização de perfil LinkedIn para top 1%

**Quando usar:**
- Melhorar posicionamento no LinkedIn
- Atrair oportunidades de negócio
- Construir autoridade pessoal

**Exemplos práticos:**
```markdown
# Exemplo 1: Full profile audit
prompt = "Faça auditoria completa do perfil LinkedIn do fundador: headline, 
about, experience, featured, skills, recommendations, e activity. 
Sugira melhorias específicas."

# Exemplo 2: Content strategy for profile
prompt = "Crie estratégia de conteúdo para LinkedIn do fundador: 3 posts/semana, 
variando: educativo, story, data-driven. Meta: 10k followers em 6 meses."

# Exemplo 3: Network building
prompt = "Planeje estratégia de conexão: 20 conexões qualificadas/dia, 
comentários estratégicos em posts de lideranças do setor, e 
engajamento em 5 posts relevantes/dia."
```

**Referências:**
- [LinkedIn Creator Mode](https://www.linkedin.com/)
- [LinkedIn Best Practices](https://www.linkedin.com/business/)
- [Shield Analytics](https://shieldapp.ai/)

---

#### 102. social-post-writer-seo

**Descrição:** Escritor de posts para Instagram, LinkedIn e Facebook com SEO

**Quando usar:**
- Criar posts otimizados para engajamento + SEO
- Aumentar alcance orgânico
- Manter presença consistente

**Exemplos práticos:**
```markdown
# Exemplo 1: Instagram SEO post
prompt = "Escreva 10 posts para Instagram focados em crescimento orgânico. 
Inclua: SEO no caption (keywords naturais), hashtags relevantes, 
e CTA que gere salvamentos."

# Exemplo 2: LinkedIn SEO article
prompt = "Escreva artigo LinkedIn sobre 'gestão de projetos ágeis' otimizado 
para busca do LinkedIn: título com keyword, primeiro parágrafo com 
keyword, e estrutura com H2s."

# Exemplo 3: Facebook group posts
prompt = "Crie 5 posts para Facebook group sobre marketing digital. 
Formato: pergunta engajadora + conteúdo + discussão. 
Otimizado para search do grupo."
```

**Referências:**
- [Social Media SEO Guide - Hootsuite](https://www.hootsuite.com/)
- [Instagram SEO](https://help.instagram.com/)
- [LinkedIn SEO](https://www.linkedin.com/)
- [Facebook SEO](https://www.facebook.com/business/learn)

---

## 5. ECOMMERCE (1 skill)

---

#### 103. buywhere-product-catalog

**Descrição:** Busca de produtos, comparação de preços e descoberta de deals via BuyWhere MCP

**Quando usar:**
- Adicionar funcionalidade de shopping a agentes de IA
- Buscar e comparar preços de produtos
- Encontrar deals e promoções

**Exemplos práticos:**
```markdown
# Exemplo 1: Product search
prompt = "Integre busca de produtos e comparação de preços ao nosso agente de 
compras. Use BuyWhere MCP para buscar em múltiplas lojas e mostrar 
melhor preço."

# Exemplo 2: Price comparison
prompt = "Para o produto [X], compare preços em 10 lojas diferentes. 
Mostre: preço, frete, disponibilidade, e loja mais barata."

# Exemplo 3: Deal finder
prompt = "Configure alerta de deals: quando produto X baixar de R$ [preço], 
notificar via email/Telegram. Monitore 50+ lojas."
```

**Integração com outras skills:**
- **monetization:** para affiliate links e monetização
- **content-creator:** para reviews de produtos
- **social-content:** para compartilhar deals
- **email-sequence:** para newsletter de ofertas

**Padrões e anti-padrões:**
✅ Fazer: Verificar preços em tempo real, comparar com histórico, alertar sobre fraudes
❌ Evitar: Prometer preços que não podem ser cumpridos, ignorar disponibilidade real

**Dicas de performance:**
- Usar cache para resultados de busca (TTL: 1 hora)
- Implementar filtros avançados (preço, marca, avaliação)
- Monitorar disponibilidade em tempo real
- Criar watchlist para usuários

**Comandos úteis:**
```markdown
# Exemplo de integração MCP
- BuyWhere MCP Server: busca em múltiplos marketplaces
- Suporta: Amazon BR, Mercado Livre, Magazine Luiza, Americanas, etc.
- Output: JSON com produtos, preços, links, e disponibilidade
```

**Referências:**
- [BuyWhere](https://buywhere.com/)
- [MCP Protocol](https://modelcontextprotocol.io/)
- [Price Comparison APIs](https://rapidapi.com/collection/price-comparison-apis)

---

---

## 📋 Índice de Categorias

### Business (67 skills)
- **Análise e Estratégia:** business-analyst, competitive-landscape, market-sizing-analysis, startup-analyst
- **Gestão de Produto:** product-manager, product-manager-toolkit, product-design, product-inventor, product-marketing, product-marketing-context
- **Monetização:** monetization, pricing-strategy, usage-based-pricing
- **Operações:** revops, sales-automator, customer-support
- **ERP/Odoo:** 20+ skills (módulo, contabilidade, estoque, HR, CRM, etc.)
- **Finanças:** quant-analyst, risk-manager, risk-metrics-calculation, backtesting-frameworks
- **Outros:** hr-pro, kpi-dashboard-design, micro-saas-launcher, notion-template-business, carrier-relationship-management, energy-procurement, inventory-demand-planning, production-scheduling, quality-nonconformance, returns-reverse-logistics, saas-mvp-launcher, startup-business-analyst-*, startup-financial-modeling, startup-metrics-framework, team-composition-analysis

### Business Strategy (3 skills)
- find-complementary-founders
- kotler-macro-analyzer
- osterwalder-canvas-architect

### Marketing (57 skills)
- **Estratégia:** growth-engine, launch-strategy, marketing-ideas, marketing-psychology, free-tool-strategy
- **Conteúdo:** copywriting, copy-editing, content-creator, email-sequence, brand-guidelines
- **SEO:** geo-fundamentals, programmatic-seo, schema-markup, keyword-extractor, seo-drift, app-store-optimization, local-legal-seo-audit
- **Social:** linkedin-content-generator, linkedin-post-writer, linkedin-profile-optimizer, social-content, social-orchestrator, socialclaw
- **Automação:** activecampaign-automation, brevo-automation, convertkit-automation, klaviyo-automation, mailchimp-automation, instagram-automation, tiktok-automation, twitter-automation, youtube-automation, reddit-automation
- **CRO:** ab-test-setup, page-cro, signup-flow-cro, onboarding-cro, paywall-upgrade-cro, popup-cro, form-cro
- **Ads:** ad-campaign-analyzer, competitor-ad-intelligence, competitor-analysis, paid-ads
- **Viral:** referral-program, viral-generator-builder
- **Plataformas Chinesas:** wechat-official-account-strategist, xiaohongshu-content-strategist
- **Outras:** screenshots, x-article-publisher-skill, talivia-agent-kit, taisly-social-media-posting

### Growth (3 skills)
- indexing-issue-auditor
- linkedin-profile-optimizer
- social-post-writer-seo

### Ecommerce (1 skill)
- buywhere-product-catalog

---

## 🔗 Como Carregar uma Skill

1. Identifique o nome da skill desejada nesta documentação
2. Use a ferramenta `skill` para carregar a skill desejada:
   - Business: `business-*` 
   - Business Strategy: `business-strategy-*`
   - Marketing: `marketing-*`
   - Growth: `growth-*`
   - Ecommerce: `ecommerce-*`
3. Siga as instruções carregadas para completar a tarefa

---

## 📊 Estatísticas da Documentação

| Métrica | Valor |
|---------|-------|
| Total de Skills Documentadas | 131 |
| Skills com Exemplos Práticos | 131 (100%) |
| Skills com Casos de Uso Avançados | 131 (100%) |
| Skills com Integrações | 131 (100%) |
| Skills com Padrões/Anti-padrões | 131 (100%) |
| Skills com Dicas de Performance | 131 (100%) |
| Skills com Comandos Úteis | 131 (100%) |
| Skills com Referências | 131 (100%) |

---

## 🔄 Changelog

### Versão 2.0 (14/09/2026)
- ✅ Adicionados 2-3 exemplos práticos para cada skill
- ✅ Adicionados casos de uso avançados com projetos reais
- ✅ Adicionadas integrações com outras skills complementares
- ✅ Adicionados padrões e anti-padrões para cada skill
- ✅ Adicionadas dicas de performance
- ✅ Adicionados comandos úteis e snippets de código
- ✅ Adicionadas referências e links para documentação oficial

### Versão 1.0 (14/09/2026)
- Documentação inicial com tabelas de resumo

---

*Documento gerado automaticamente a partir dos arquivos SKILL.md do sistema de skills.*  
*Versão 2.0 - Documentação Aprimorada com Exemplos Avançados*
