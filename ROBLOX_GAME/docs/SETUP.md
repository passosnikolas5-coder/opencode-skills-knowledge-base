# 🚀 Egg Empire - Setup & Deploy Guide

> **Guia completo para configurar e publicar o jogo**

---

## 📋 Pré-requisitos

### Contas Necessárias
- [ ] Conta Roblox (verificada para publicar)
- [ ] Roblox Studio instalado
- [ ] Git instalado (opcional, para versionamento)

### Ferramentas
- [ ] Roblox Studio (última versão)
- [ ] VS Code ou editor de código (recomendado)
- [ ] Git (opcional)

---

## 🛠️ Passo 1: Criar o Place

### 1.1 Abrir Roblox Studio
```
1. Abra o Roblox Studio
2. Clique em "New" → "Baseplate"
3. Aguarde carregar
```

### 1.2 Configurar o Place
```
1. File → Game Settings
2. Nome: "Egg Empire"
3. Descrição: "O melhor jogo de roubo de ovos do Roblox!"
4. Icon: Faça upload de um ícone (512x512)
5. Clique em "Save"
```

### 1.3 Habilitar Recursos
```
1. Game Settings → Security
2. Allow HTTP Requests: ✅
3. Allow Third Party Sales: ✅
4. Allow Third Party Teleports: ✅

5. Game Settings → Permissions
6. API Services: ✅
7. Enable Studio Access to API Services: ✅
```

---

## 📂 Passo 2: Importar Scripts

### 2.1 Estrutura de Pastas
```
game
├── ServerScriptService
│   ├── DataStoreManager.lua
│   ├── CurrencyManager.lua
│   ├── InventoryManager.lua
│   ├── CombatSystem.lua
│   ├── BaseBuildingSystem.lua
│   └── EggEmpire_Server.lua
├── ReplicatedStorage
│   └── (criado automaticamente)
├── StarterPlayerScripts
│   └── ClientController.lua
├── StarterGui
│   └── (UI será criada pelo script)
└── Workspace
    └── (bases serão criadas aqui)
```

### 2.2 Criar Scripts no Studio

#### Criar Server Scripts
```
1. No Explorer, clique com botão direito em ServerScriptService
2. Insert → Script
3. Renomeie para "DataStoreManager"
4. Cole o código do arquivo DataStoreManager.lua
5. Repita para os outros scripts
```

#### Criar Local Scripts
```
1. No Explorer, clique com botão direito em StarterPlayerScripts
2. Insert → LocalScript
3. Renomeie para "ClientController"
4. Cole o código do arquivo ClientController.lua
```

### 2.3 Criar RemoteEvents (Automático)
Os scripts criarão automaticamente os RemoteEvents necessários:
- DataStoreRemote
- CurrencyEvents
- InventoryEvents
- CombatEvents
- BaseEvents
- GameEvents

---

## 🗺️ Passo 3: Criar o Mapa

### 3.1 Terreno Básico
```
1. Clique em "Terrain" na toolbar
2. Use o editor de terreno para criar:
   - Planície verde (spawn)
   - Montanhas ao redor
   - Rio ou lago
   - Floresta em uma área
```

### 3.2 Adicionar Áreas
```
1. Crie Parts grandes para representar biomas:
   - Planície Verde: Part verde grande
   - Deserto Dourado: Part amarela
   - Floresta Sombria: Part roxa
   - Montanha Gelada: Part azul
   - Vulcão Infernal: Part vermelha

2. Posicione ao redor do mapa
3. Ancore todas as Parts
```

### 3.3 Pontos de Interesse
```
1. Spawn Point central
2. Loja (casa com NPC)
3. Banco (prédio grande)
4. Torre do Ranking (torre alta)
5. Portal Dimensional (portal brilhante)
```

---

## 🎨 Passo 4: Configurar Visual

### 4.1 Lighting
```
1. Selecione "Lighting" no Explorer
2. Propriedades:
   - Ambient: 128, 128, 128
   - Brightness: 2
   - ClockTime: 14 (horário do dia)
   - ColorShift_Bottom: 0, 0, 0
   - ColorShift_Top: 0, 0, 0
   - EnvironmentDiffuseScale: 1
   - EnvironmentSpecularScale: 1
   - GlobalShadows: true
   - OutdoorAmbient: 128, 128, 128
   - ShadowSoftness: 0.2
   - Technology: Future
```

### 4.2 Sky
```
1. Adicione um Sky ao Lighting
2. Configure:
   - CelestialBodiesShown: true
   - StarCount: 3000
   - SunAngularSize: 11
   - MoonAngularSize: 11
```

### 4.3 Atmosfera
```
1. Adicione uma Atmosphere ao Lighting
2. Configure:
   - Density: 0.3
   - Offset: 0
   - Color: 199, 216, 255
   - Decay: 92, 107, 130
   - Glare: 0
   - Haze: 0
```

---

## 🔧 Passo 5: Configurar DataStore

### 5.1 Verificar API Services
```
1. File → Game Settings → Security
2. Certifique-se que "Allow HTTP Requests" está habilitado
3. Certifique-se que "API Services" está habilitado
```

### 5.2 Testar DataStore
```
1. Pressione F5 para testar
2. Verifique o Output para mensagens de sucesso
3. Deve ver: "[DataStoreManager] Inicializado com sucesso!"
4. Deve ver: "[DataStoreManager] Novo jogador: SeuNome"
```

---

## 🎮 Passo 6: Testar o Jogo

### 6.1 Teste Básico
```
1. Pressione F5
2. Aguarde carregar
3. Verifique se o menu principal aparece
4. Clique em "JOGAR"
5. Verifique se o HUD aparece
6. Teste movement (WASD)
```

### 6.2 Testar Sistemas
```
1. Colete ovos (aproxime-se e pressione E)
2. Construa na base (pressione B)
3. Teste habilidades (1-5)
4. Teste combate (clique esquerdo)
```

### 6.3 Verificar Logs
```
1. Abra o Output (View → Output)
2. Procure por erros (vermelho)
3. Verifique se todos os sistemas inicializaram
```

---

## 📦 Passo 7: Publicar

### 7.1 Preparar para Publicação
```
1. File → Publish to Roblox
2. Preencha:
   - Name: Egg Empire
   - Description: O melhor jogo de roubo de ovos!
   - Genre: Adventure
   - Devices: Computer, Phone, Tablet, Console
   - Max Players: 32
   - Genre: All
```

### 7.2 Configurar Thumbnail
```
1. Faça upload de imagens:
   - Icon (512x512)
   - Thumbnail (1920x1080)
   - Screenshots (1920x1080)
```

### 7.3 Configurar Monetização (Opcional)
```
1. Game Settings → Monetization
2. Enable Paid Access: ❌ (gratuito)
3. Enable In-Game Purchases: ✅
4. Enable Developer Products: ✅
```

### 7.4 Publicar
```
1. Clique em "Publish"
2. Aguarde upload
3. Anote o Place ID
4. Compartilhe o link!
```

---

## 🔄 Passo 8: Atualizações

### 8.1 Criar Versão
```
1. File → Publish to Roblox (novamente)
2. Adicione notas de versão
3. Clique em "Publish"
4. A versão anterior fica salva
```

### 8.2 Voltar Versão
```
1. Game Settings → Versions
2. Selecione a versão desejada
3. Clique em "Revert to this version"
```

---

## 🐛 Troubleshooting

### Problema: DataStore não funciona
```
Causa: API Services não habilitado
Solução: Game Settings → Security → Enable API Services
```

### Problema: Scripts não rodam
```
Causa: Scripts em LocalScripts ou vice-versa
Solução: Verifique se cada script está no local correto
- Server Scripts → ServerScriptService
- Local Scripts → StarterPlayerScripts
```

### Problema: UI não aparece
```
Causa: ScreenGui não criada
Solução: O script ClientController cria a UI automaticamente
Verifique se o script está em StarterPlayerScripts
```

### Problema: Bases não aparecem
```
Causa: Workspace não está sincronizado
Solução: Verifique se os scripts estão criando as bases
```

### Problema: Erro "DataStore error"
```
Causa: Nome de DataStore inválido ou limite atingido
Solução: Verifique o nome do DataStore no script
```

---

## 📊 Métricas

### Ver Métricas
```
1. Acesse create.roblox.com
2. Selecione seu jogo
3. Vá em "Analytics"
4. Veja: DAU, Retenção, Receita, etc.
```

### Configurar Analytics
```
1. Game Settings → Analytics
2. Enable Analytics: ✅
3. Custom Events: Configure eventos personalizados
```

---

## 🛡️ Segurança

### Boas Práticas
```
1. NUNCA confie no cliente
2. SEMPRE verifique no servidor
3. Use RemoteEvents com validação
4. Limite requisições por jogador
5. Use rate limiting
```

### Anti-Cheat
```
1. Valide todas as ações no servidor
2. Verifique distâncias
3. Limite velocidade
4. Detecte anomalias
5. Ban players suspeitos
```

---

## 📈 Crescimento

### Marketing
```
1. Crie trailer no YouTube
2. Poste em redes sociais
3. Colabore com YouTubers
4. Crie eventos especiais
5. Mantenha atualizações frequentes
```

### Comunidade
```
1. Crie Discord server
2. Adicione grupo no Roblox
3. Responda feedback
4. Ouça sugestões
5. Recompense jogadores leais
```

---

## 📚 Recursos

| Recurso | URL |
|---------|-----|
| **Roblox Studio** | https://create.roblox.com |
| **Documentação** | https://create.roblox.com/docs |
| **Fórum** | https://devforum.roblox.com |
| **API Reference** | https://create.roblox.com/docs/reference |

---

*Setup Guide v1.0 - Setembro 2026*