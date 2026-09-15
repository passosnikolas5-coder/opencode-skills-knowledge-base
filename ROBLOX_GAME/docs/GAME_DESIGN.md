# 🥚 Egg Empire - Game Design Document

> **O melhor jogo de roubo de ovos do Roblox**

---

## 📊 Resumo Executivo

| Campo | Valor |
|-------|-------|
| **Nome** | Egg Empire |
| **Gênero** | Stealth + Strategy + Social |
| **Plataforma** | Roblox (Mobile, Desktop, Console) |
| **Jogadores** | 16-32 por servidor |
| **Partida** | 10-15 minutos |
| **Monetização** | Cosméticos + Game Passes |
| **Meta** | Construir o maior império de ovos |

---

## 🎯 Conceito Central

**Egg Empire** é um jogo onde jogadores:
1. 🥚 Coletam ovos em um mapa dinâmico
2. 🏰 Constroem bases para proteger seus ovos
3. 🗡️ Roubam ovos de outros jogadores
4. 📈 Progressionam com upgrades e desbloqueios
5. 🏆 Competem pelo ranking de impérios

### Diferencial
- **Sistema de Base Construível** - Não é só roubar, é construir
- **Stealth Real** - Invisibilidade, disfarces, armadilhas
- **Economia Dinâmica** - Preços baseados em oferta/demanda
- **Eventos Globais** - Bônus de ovos raros em horários específicos

---

## 🎮 Core Loop

```
┌─────────────────────────────────────────────────────────┐
│                    CORE LOOP                            │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   ┌─────────┐    ┌─────────┐    ┌─────────┐           │
│   │ EXPLORAR│───▶│COLETAR  │───▶│PROTEGER │           │
│   │ Mapa    │    │ Ovos    │    │ Base    │           │
│   └─────────┘    └─────────┘    └─────────┘           │
│        │                              │                │
│        │         ┌─────────┐         │                │
│        └────────▶│ ROUBAR  │◀────────┘                │
│                  │ Ovos de │                          │
│                  │ Outros  │                          │
│                  └─────────┘                          │
│                       │                               │
│                       ▼                               │
│                  ┌─────────┐                          │
│                  │PROGRESSÃO│                          │
│                  │ Upgrades │                          │
│                  └─────────┘                          │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 🗺️ Mapa

### Dimensões
- **Tamanho:** 2000x2000 studs (4x4 quilômetros)
- **Biomas:** 5 áreas temáticas

### Biomas

| Bioma | Cor | Tipo de Ovo | Perigo |
|-------|-----|-------------|--------|
| **Planície Verde** | Verde | Comum (branco) | Baixo |
| **Deserto Dourado** | Amarelo | Incomum (dourado) | Médio |
| **Floresta Sombria** | Roxo | Raro (prateado) | Alto |
| **Montanha Gelada** | Azul | Épico (cristal) | Muito Alto |
| **Vulcão Infernal** | Vermelho | Lendário (fogo) | Extremo |

### Pontos de Interesse
- **Spawn Central** - Área segura para início
- **Loja do Viajante** - Comprar itens
- **Banco Central** - Depositar ovos com segurança
- **Torre do Ranking** - Ver ranking global
- **Portal Dimensional** - Acesso a eventos especiais

---

## 🥚 Sistema de Ovos

### Tipos de Ovos

| Tipo | Cor | Valor | Raridade | Peso |
|------|-----|-------|----------|------|
| **Branco** | ⚪ | 1 moeda | 50% | Leve |
| **Dourado** | 🟡 | 10 moedas | 25% | Médio |
| **Prateado** | ⚪ | 50 moedas | 15% | Pesado |
| **Cristal** | 🔵 | 200 moedas | 8% | Muito Pesado |
| **Fogo** | 🔴 | 1000 moedas | 2% | Extremo |

### Mecânicas de Coleta
- **Proximidade** - Pegar ovos ao perto
- **Tempo** - Ovos levam tempo para coletar
- **Ruído** - Coletar faz som (alerta jogadores próximos)
- **Peso** - Ovos pesados reduzem velocidade

### Mecânicas de Roubo
- **Stealth** - Ficar invisível para roubar
- **Distração** - Usar itens para distrair
- **Hackear** - Desativar alarmes da base
- **Fugir** - Escapar com o ovo roubado

---

## 🏰 Sistema de Base

### Níveis da Base

| Nível | Custo | Slots | Defesas | Desbloqueios |
|-------|-------|-------|---------|--------------|
| 1 | Início | 5 | Parede básica | Nenhum |
| 2 | 500 | 10 | Torre de vigia | Alarme |
| 3 | 2000 | 20 | Canhão | Campo de força |
| 4 | 10000 | 40 | Torre de luz | Invisibilidade |
| 5 | 50000 | 80 | Shield Generator | Teletransporte |

### Peças da Base

#### Defesas
| Peça | Custo | Efeito |
|------|-------|--------|
| **Parede** | 50 | Bloqueia acesso |
| **Torre de Vigia** | 200 | Detecta intrusos |
| **Canhão** | 500 | Dano a invasores |
| **Campo de Força** | 1000 | Escudo temporário |
| **Torre de Luz** | 2000 | Revela invisíveis |

#### Utilidades
| Peça | Custo | Efeito |
|------|-------|--------|
| **Armadilha** | 100 | Prende invasores |
| **Alarme** | 150 | Alerta quando invadido |
| **Cofre** | 300 | Guarda ovos com segurança |
| **Gerador** | 400 | Fornece energia |
| **Teletransporte** | 5000 | Viajar pela base |

### Construção
- **Modo Construção** - Arrastar e soltar peças
- **Rotação** - Girar peças 90°
- **Snap** - Encaixe automático
- **Preview** - Ver como ficará antes de colocar

---

## ⚔️ Sistema de Combate

### Habilidades

| Habilidade | Custo | Efeito | Cooldown |
|------------|-------|--------|----------|
| **Ataque Básico** | 0 | 10 dano | 0.5s |
| **Dash** | 0 | Avanço rápido | 3s |
| **Escudo** | 50 | Bloqueia 50% dano | 10s |
| **Bomba** | 100 | 30 dano em área | 15s |
| **Invisibilidade** | 200 | Fica invisível | 20s |

### Power-ups

| Power-up | Efeito | Duração |
|----------|--------|---------|
| **Velocidade** | +50% velocidade | 10s |
| **Força** | +100% dano | 10s |
| **Escudo** | Imune a dano | 5s |
| **Radar** | Vê todos no mapa | 15s |
| **Magnet** | Atrai ovos próximos | 10s |

### Morte
- Perde metade dos ovos carregados
- Respawn após 5 segundos
- Invulnerabilidade por 3 segundos

---

## 📈 Sistema de Progressão

### Níveis

| Nível | XP Necessário | Recompensa |
|-------|---------------|------------|
| 1 | 0 | 100 moedas |
| 2 | 100 | Desbloqueia Armadilha |
| 3 | 300 | Desbloqueia Escudo |
| 4 | 600 | Desbloqueia Bomba |
| 5 | 1000 | Desbloqueia Invisibilidade |
| 10 | 5000 | Skin rara |
| 20 | 20000 | Mount especial |
| 50 | 100000 | Título lendário |

### Ranking

| Posição | Título | Bônus |
|---------|--------|-------|
| 1-10 | **Lenda** | +50% moedas |
| 11-50 | **Mestre** | +25% moedas |
| 51-100 | **Expert** | +15% moedas |
| 101-500 | **Veterano** | +10% moedas |
| 501+ | **Novato** | +0% moedas |

---

## 💰 Economia

### Fontes de Renda

| Fonte | Moedas por Minuto | Descrição |
|-------|-------------------|-----------|
| **Coletar ovos brancos** | 10-20 | Básico |
| **Coletar ovos dourados** | 50-100 | Intermediário |
| **Roubar ovos** | 200-500 | Avançado |
| **Completar quests** | 100-1000 | Variável |
| **Vencer eventos** | 500-5000 | Temporário |

### Loja

#### Itens
| Item | Preço | Efeito |
|------|-------|--------|
| **Pocão de Velocidade** | 50 | +50% vel por 30s |
| **Pocão de Força** | 75 | +100% dano por 30s |
| **Pocão de Invisibilidade** | 100 | Invisível por 15s |
| **Kit de Reparo** | 150 | Conserta base |
| **Teletransporte** | 200 | Viaja para qualquer ponto |

#### Skins
| Skin | Preço | Visual |
|------|-------|--------|
| **Ovo de Ouro** | 500 | Brilho dourado |
| **Ovo de Cristal** | 1000 | Translúcido |
| **Ovo de Fogo** | 2000 | Chamas |
| **Ovo de Gelo** | 2000 | Cristais de gelo |
| **Ovo Cósmico** | 5000 | Estrelas |

---

## 🎪 Eventos

### Eventos Semanais

| Evento | Dia | Duração | Recompensa |
|--------|-----|---------|------------|
| **Ovos de Páscoa** | Domingo | 2h | 5x ovos |
| **Noite de Roubo** | Segunda | 3h | 3x roubo |
| **Construção Livre** | Terça | 24h | Peças grátis |
| **Batalha Royale** | Quarta | 1h | Skins raras |
| **Missão Stealth** | Quinta | 2h | Power-ups |
| **Corrida Maluca** | Sexta | 1h | Moedas extras |
| **Fim de Semana Épico** | Sábado | 24h | Tudo 2x |

### Eventos Especiais

| Evento | Frequência | Descrição |
|--------|------------|-----------|
| **Natal** | Dezembro | Ovos de Natal, Presentes |
| **Halloween** | Outubro | Ovos Assustadores, Eventos |
| **Aniversário** | Julho | Bônus gigante, Competições |
| **Torneio Global** | Mensal | Competição entre servidores |

---

## 🎨 Visual e Áudio

### Estilo Visual
- **Gráfico:** Cartoon/Stylized
- **Paleta:** Cores vibrantes
- **Iluminação:** Dinâmica (dia/noite)
- **Partículas:** Efeitos para ovos, poderes, construções

### Áudio
- **Música:** Ambiental dinâmica
- **Efeitos:** Coleta, roubo, construção, combate
- **UI:** Cliques, hover, sucesso, erro

---

## 📱 UX/UI

### Telas

| Tela | Função |
|------|--------|
| **Main Menu** | Jogar, Loja, Configurações |
| **HUD** | Moedas, Ovos, Vida, Minimapa |
| **Inventário** | Itens, Skins, Upgrades |
| **Loja** | Comprar itens e cosméticos |
| **Base** | Construir/Editar base |
| **Ranking** | Ver posição global |
| **Configurações** | Áudio, Gráficos, Controles |

### Fluxo do Jogador

```
1. Abre o jogo
2. Vê Main Menu animado
3. Clica "Jogar"
4. Escolhe servidor
5. Entra no jogo
6. Coleta ovos
7. Constrói base
8. Rouba ovos de outros
9. Progressiona
10. Compara ranking
```

---

## 🔧 Requisitos Técnicos

### Performance
- **FPS Mínimo:** 30 em mobile
- **FPS Ideal:** 60 em desktop
- **Carregamento:** < 5 segundos
- **Memória:** < 500MB

### Compatibilidade
- **Mobile:** iOS 12+, Android 8+
- **Desktop:** Windows 10+, macOS
- **Console:** Xbox, PlayStation
- **Browser:** Chrome, Firefox, Edge

### Servidor
- **Jogadores:** 16-32 por servidor
- **Tick Rate:** 60Hz (server)
- **Rede:** Otimizada para mobile

---

## 📊 Métricas de Sucesso

| Métrica | Meta |
|---------|------|
| **DAU** | 10.000+ |
| **Retenção D1** | 40%+ |
| **Retenção D7** | 20%+ |
| **Retenção D30** | 10%+ |
| **Sessão Média** | 15+ minutos |
| **ARPU** | $0.50+ |
| **Conversão** | 5%+ |

---

## 🚀 Plano de Lançamento

### Fase 1: Alpha (2 semanas)
- [ ] Core loop funcional
- [ ] Sistema de ovos básico
- [ ] 1 bioma
- [ ] Base nível 1

### Fase 2: Beta (2 semanas)
- [ ] 5 biomas
- [ ] Sistema de base completo
- [ ] Combate
- [ ] UI completa

### Fase 3: Lançamento (1 semana)
- [ ] Eventos
- [ ] Monetização
- [ ] Marketing
- [ ] Otimização

### Fase 4: Pós-Lançamento (contínuo)
- [ ] Novos biomas
- [ ] Novos eventos
- [ ] Balanço
- [ ] Comunidade

---

## 📚 Referências

| Jogo | Inspiração |
|------|------------|
| **Steal An Egg** | Mecânica de roubo |
| **Adopt Me** | Social e colecionáveis |
| **Tycoon games** | Progressão de base |
| **Bedwars** | Combate e estratégia |
| **Murder Mystery 2** | Stealth e suspense |

---

*Egg Empire GDD v1.0 - Setembro 2026*