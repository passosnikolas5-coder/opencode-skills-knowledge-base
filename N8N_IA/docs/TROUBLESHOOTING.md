# 🔧 Troubleshooting - Solução de Problemas

> **Guia completo para resolver problemas comuns no n8n!**

---

## 📋 Índice

1. [Problemas Gerais](#problemas-gerais)
2. [Webhooks](#webhooks)
3. [Autenticação](#autenticação)
4. [Google Services](#google-services)
5. [Telegram](#telegram)
6. [OpenAI / IA](#openai--ia)
7. [Performance](#performance)
8. [Erros Comuns](#erros-comuns)

---

## Problemas Gerais

### Workflow não executa

**Causas possíveis:**
1. Trigger não está ativo
2. Nós desabilitados
3. Erro em nó anterior
4. Condições não atendidas

**Soluções:**

```json
// 1. Verificar se o trigger está ativo
// Clique no nó e verifique "Active"

// 2. Habilitar nós desabilitados
// Clique com botão direito → Enable

// 3. Testar cada nó individualmente
// Clique no nó → "Test step"

// 4. Verificar condições
// Adicione nó de log antes da condição
```

### Dados não chegam entre nós

**Causas:**
- Expressão incorreta
- Campo não existe
- Formato de dados errado

**Solução:**

```javascript
// Verificar dados do nó anterior
{{$json}}

// Verificar campo específico
{{$json.nome}}

// Verificar se campo existe
={{$json.nome || 'campo não encontrado'}}

// Log para debug
return items.map(item => {
  console.log('Dados:', JSON.stringify(item.json));
  return item;
});
```

### Erro: "No output data"

**Causas:**
- Nós anteriores não retornaram dados
- Conições filtraram todos os items
- Erro silencioso

**Solução:**

```json
// 1. Adicionar nó Set com dados mock
{
  "type": "n8n-nodes-base.set",
  "parameters": {
    "assignments": {
      "assignments": [{
        "name": "testData",
        "value": "test",
        "type": "string"
      }]
    }
  }
}

// 2. Usar Error Trigger para capturar
{
  "type": "n8n-nodes-base.errorTrigger"
}
```

---

## Webhooks

### Webhook não responde

**Verificar:**

1. **URL correta?**
   ```
   https://seu-n8n.com/webhook/NOME_DO_WEBHOOK
   ```

2. **Método HTTP correto?**
   ```json
   {
     "httpMethod": "POST"  // ou GET, PUT, etc.
   }
   ```

3. **Autenticação configurada?**
   ```json
   {
     "authentication": "headerAuth",
     "headerAuth": {
       "name": "Authorization",
       "value": "Bearer {{$env.API_KEY}}"
     }
   }
   ```

### Testar Webhook

```bash
# Usando curl
curl -X POST https://seu-n8n.com/webhook/teste \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SEU_TOKEN" \
  -d '{"nome": "Teste", "email": "teste@email.com"}'
```

### Webhook retorna 404

**Causas:**
- Workflow desabilitado
- Path incorreto
- n8n não está rodando

**Soluções:**

```bash
# 1. Verificar se n8n está rodando
docker ps | grep n8n

# 2. Verificar logs
docker logs n8n

# 3. Testar endpoint de health
curl https://seu-n8n.com/healthz
```

### Webhook retorna 500

**Verificar logs:**

```bash
# Docker
docker logs n8n --tail 100

# npm
# Logs em ~/.n8n/logs/
```

---

## Autenticação

### Google OAuth2: "redirect_uri_mismatch"

**Causa:** URI de redirecionamento não confere

**Solução:**

```
1. Google Cloud Console → Credentials
2. OAuth 2.0 Client IDs → Editar
3. Authorized redirect URIs → Adicionar:
   https://seu-n8n.com/rest/oauth2-credential/callback
4. Salvar
```

### Google: "access_denied"

**Causa:** Permissões insuficientes

**Solução:**

```
1. Google Cloud Console → APIs & Services
2. OAuth consent screen → Scopes
3. Adicionar todos os scopes necessários:
   - gmail.send
   - gmail.readonly
   - spreadsheets
   - calendar
   - drive
4. Reautorizar no n8n
```

### Telegram: "401 Unauthorized"

**Causa:** Token inválido

**Solução:**

```
1. Verificar token com @BotFather
2. /mybots → Seu bot → API Token
3. Copiar token completo
4. Atualizar credencial no n8n
```

### OpenAI: "Invalid API Key"

**Solução:**

```
1. Acessar https://platform.openai.com/api-keys
2. Criar nova chave
3. Copiar chave completa (sk-...)
4. Atualizar credencial no n8n
```

---

## Google Services

### Gmail: "Quota Exceeded"

**Causa:** Limite de requisições atingido

**Solução:**

```json
// Adicionar delay entre requisições
{
  "options": {
    "batching": {
      "batch": {
        "batchSize": 10,
        "batchInterval": 2000
      }
    }
  }
}
```

### Google Sheets: "Unable to parse range"

**Causa:** Referência de planilha incorreta

**Solução:**

```json
{
  "documentId": {
    "mode": "url",
    "value": "https://docs.google.com/spreadsheets/d/PLANILHA_ID/edit"
  },
  "sheetName": {
    "mode": "name",
    "value": "Página1"
  }
}
```

### Google Calendar: "Forbidden"

**Causa:** Calendário não compartilhado

**Solução:**

```
1. Abrir Google Calendar
2. Configurações do calendário
3. Compartilhar com email do service account
4. Conceder permissão "Fazer alterações"
```

### Google Drive: "File not found"

**Verificar:**

```javascript
// ID do arquivo está correto?
{{$json.fileId}}

// Arquivo não foi movido/deletado?
// Verificar no Google Drive manualmente
```

---

## Telegram

### Bot não responde

**Checklist:**

```
1. Bot está ativo? → /start no bot
2. Token está correto? → Verificar com @BotFather
3. Chat ID está correto? → Usar @userinfobot
4. Permissões? → Bot precisa ser adicionado ao grupo
```

### Obter Chat ID

```
1. Adicionar bot ao grupo
2. Enviar mensagem no grupo
3. Acessar:
   https://api.telegram.org/botSEU_TOKEN/getUpdates
4. Procurar "chat": {"id": XXXXXXXX}
```

### Mensagem não chega

**Possíveis causas:**

```json
// 1. Chat ID incorreto
{
  "chatId": "123456789"  // Deve ser número
}

// 2. Mensagem muito longa
// Telegram limita em 4096 caracteres

// 3. Formato inválido
// Verificar HTML/Markdown syntax
```

### Áudio não transcreve

**Verificar:**

```json
{
  "operation": "getFile",
  "fileId": "={{$json.message.voice.file_id}}"
},
{
  "operation": "transcribe",
  "model": "whisper-1",
  "binaryPropertyName": "data"
}
```

**Dicas:**
- Formato: .ogg ou .mp3
- Tamanho máximo: 25MB
- Duração máxima: 24 horas

---

## OpenAI / IA

### Erro: "Context length exceeded"

**Causa:** Muitas mensagens na memória

**Solução:**

```json
{
  "type": "n8n-nodes-base.memoryBufferWindow",
  "parameters": {
    "contextWindow": 5,  // Reduzir janela
    "memoryKey": "chat_history"
  }
}
```

### Resposta muito genérica

**Causa:** Prompt vago

**Solução:**

```markdown
# Prompt melhorado
Você é um consultor financeiro especializado em investimentos de renda fixa.

## Regras:
1. Sempre analise o perfil do investidor
2. Considere o horizonte de tempo
3. Mencione riscos explicitamente
4. Use exemplos práticos

## Formato da Resposta:
- Resumo em 2-3 linhas
- Recomendação específica
- Justificativa
- Próximo passo sugerido
```

### Custo muito alto

**Estratégias:**

```json
// 1. Usar modelo menor para tarefas simples
{
  "model": "gpt-3.5-turbo"  // Não gpt-4
}

// 2. Limitar tokens
{
  "maxTokens": 200
}

// 3. Cache de respostas
{
  "cacheTTL": 3600
}

// 4. Prompt mais conciso
{
  "messages": {
    "values": [{
      "content": "Responda em máximo 50 palavras: {{$json.pergunta}}",
      "role": "user"
    }]
  }
}
```

### Resposta com formato errado

**Solução:**

```markdown
# Definir formato no prompt
Responda APENAS com JSON válido no formato:
{
  "resposta": "sua resposta aqui",
  "confianca": 0.85,
  "proxima_acao": "agendar_reuniao"
}

Não inclua texto antes ou depois do JSON.
```

### Alucinações (respostas inventadas)

**Soluções:**

```markdown
# Adicionar no system prompt
## Regras Importantes:
1. Se não souber a resposta, diga "Não tenho essa informação"
2. Nunca invente dados financeiros ou legais
3. Sempre cite fontes quando possível
4. Em caso de dúvida, encaminhe para um humano
```

---

## Performance

### Workflow lento

**Diagnóstico:**

```json
// 1. Verificar tempo por nó
// Clique no nó → Execution Data → Duration

// 2. Identificar gargalo
// Nó mais lento = gargalo

// 3. Otimizar
// - Reduzir chamadas de API
// - Usar batch processing
// - Implementar cache
```

### Muitos erros de timeout

**Solução:**

```json
{
  "options": {
    "timeout": 60000,  // Aumentar timeout
    "retry": {
      "maxRetries": 3,
      "retryInterval": 2000
    }
  }
}
```

### Uso alto de memória

**Soluções:**

```json
// 1. Processar em batches
{
  "type": "n8n-nodes-base.splitInBatches",
  "parameters": {
    "batchSize": 100
  }
}

// 2. Limitar dados retornados
{
  "options": {
    "maxResults": 1000
  }
}
```

### Webhook com muitas requisições

**Solução:**

```json
// 1. Rate limiting
{
  "options": {
    "batching": {
      "batch": {
        "batchSize": 10,
        "batchInterval": 1000
      }
    }
  }
}

// 2. Fila de processamento
// Usar Redis ou banco de dados
```

---

## Erros Comuns

### "Cannot read property of undefined"

```javascript
// ❌ Ruim
return items.map(item => {
  return {
    json: {
      nome: item.json.user.name  // user pode ser undefined
    }
  };
});

// ✅ Bom
return items.map(item => {
  return {
    json: {
      nome: item.json.user?.name || 'Não informado'
    }
  };
});
```

### "Expression evaluation failed"

```javascript
// Verificar se campo existe
{{$json.campo || ''}}

// Usar optional chaining
={{$json.usuario?.email || 'email não informado'}}

// Verificar tipo
={{typeof $json.valor === 'number' ? $json.valor : 0}}
```

### "Function item could not be serialized"

```javascript
// ❌ Não retornar objetos complexos
return {
  circular: {}  // Referência circular
};

// ✅ Serializar corretamente
return items.map(item => ({
  json: {
    ...item.json,
    data: JSON.parse(JSON.stringify(item.json.data))
  }
}));
```

### "No connection found"

```
1. Verificar se o nó está conectado
2. Arrastar linha de um nó para outro
3. Salvar workflow
4. Testar novamente
```

### "Workflow could not be activated"

```
1. Verificar se há erros no workflow
2. Todos os nós devem estar configurados
3. Credenciais devem estar válidas
4. Verificar logs para detalhes
```

---

## 🛠️ Comandos Úteis

### Verificar Status do n8n

```bash
# Docker
docker ps | grep n8n
docker logs n8n --tail 50

# npm
n8n status
```

### Exportar/Importar Workflows

```bash
# Exportar
n8n export:workflow --id=WORKFLOW_ID --output=./

# Importar
n8n import:workflow --input=./workflow.json
```

### Listar Workflows

```bash
n8n list:workflow
```

### Executar Workflow via CLI

```bash
n8n execute --id=WORKFLOW_ID
```

---

## 📚 Recursos Adicionais

- **n8n Docs**: https://docs.n8n.io
- **n8n Community**: https://community.n8n.io
- **GitHub Issues**: https://github.com/n8n-io/n8n/issues
- **Discord**: https://discord.gg/n8n

---

*Última atualização: Setembro 2026*