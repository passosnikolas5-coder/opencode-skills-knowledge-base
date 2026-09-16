# 🧠 Microsoft Semantic Kernel - Skills Avançadas

## 📋 Informações Gerais
- **Fonte**: https://github.com/microsoft/semantic-kernel (28.6k+ estrelas)
- **Descrição**: SDK open-source da Microsoft para construção de agentes de IA com suporte multi-linguagem (C#, Python, Java), plugins, planners, memória vetorial e integração com serviços de IA.
- **Linguagens**: C#, Python, Java
- **Modelos Suportados**: OpenAI, Azure OpenAI, HuggingFace, Google, Ollama

---

## 🎯 Categorias de Skills

### 1. Instalação e Configuração Básica

**Skills:**
1. Instalação via NuGet/PIP/Pip
2. Configuração do Kernel builder
3. Registro de serviços de IA
4. Inicialização do kernel

**Código Exemplo (C#):**
```csharp
using Microsoft.SemanticKernel;

// Configuração do kernel
var builder = Kernel.CreateBuilder()
    .AddAzureOpenAIChatCompletion(
        "deployment-name",
        "https://seu-endpoint.openai.azure.com/",
        "sua-api-key");

var kernel = builder.Build();
```

**Código Exemplo (Python):**
```python
from semantic_kernel import Kernel
from semantic_kernel.connectors.ai.open_ai import OpenAIChatCompletion

kernel = Kernel()
kernel.add_service(OpenAIChatCompletion(
    model_id="gpt-4",
    api_key="sua-api-key"
))
```

**MELHORIA:** Implemente um factory pattern para criar kernels configurados para diferentes ambientes (dev, staging, prod).

---

### 2. Arquitetura do Kernel

**Skills:**
1. Entender a estrutura do kernel
2. Componentes principais (plugins, planners, memory)
3. Ciclo de vida do kernel
4. Injeção de dependências

**Código Exemplo:**
```csharp
// Estrutura do kernel
public class SemanticKernelService
{
    private readonly Kernel _kernel;
    
    public SemanticKernelService(Kernel kernel)
    {
        _kernel = kernel;
    }
    
    public async Task<string> ProcessarAsync(string input)
    {
        var result = await _kernel.InvokePromptAsync(
            $"Analise o seguinte texto: {input}");
        return result.GetValue<string>();
    }
}
```

**MELHORIA:** Crie um container DI que gerencie automaticamente o ciclo de vida do kernel e seus dependências.

---

### 3. Criação de Plugins

**Skills:**
1. Plugins nativos vs customizados
2. Funções com atributo [KernelFunction]
3. Parâmetros e tipos de retorno
4. Plugin metadata

**Código Exemplo:**
```csharp
public class WeatherPlugin
{
    [KernelFunction]
    [Description("Obtém a temperatura atual para uma cidade")]
    public async Task<string> GetTemperatureAsync(
        [Description("Nome da cidade")] string city)
    {
        // Lógica para buscar temperatura
        return $"Temperatura em {city}: 25°C";
    }
}

// Registro do plugin
kernel.Plugins.AddFromType<WeatherPlugin>();
```

**Código Exemplo (Python):**
```python
from semantic_kernel.functions import kernel_function

class WeatherPlugin:
    @kernel_function(description="Obtém a temperatura atual")
    async def get_temperature(self, city: str) -> str:
        return f"Temperatura em {city}: 25°C"
```

**MELHORIA:** Implemente validação automática de parâmetros usando Data Annotations antes da execução das funções.

---

### 4. Function Calling e Tool Use

**Skills:**
1. Chamada de funções pelo modelo
2. Tool use com múltiplos plugins
3. Seleção automática de ferramentas
4. Tratamento de erros em chamadas

**Código Exemplo:**
```csharp
// Habilitar function calling
var settings = new PromptExecutionSettings
{
    FunctionChoiceBehavior = FunctionChoiceBehavior.Auto()
};

var result = await kernel.InvokePromptAsync(
    "Qual a temperatura em São Paulo?",
    new KernelArguments(settings));
```

**MELHORIA:** Implemente um middleware que logue todas as chamadas de funções para debugging e auditoria.

---

### 5. Planificadores (Planners)

**Skills:**
1. Handlebars Planner
2. Stepwise Planner
3. FunctionChoice Planner
4. Seleção do planner ideal

**Código Exemplo:**
```csharp
// Handlebars Planner
var planner = new HandlebarsPlanner();
var plan = await planner.CreatePlanAsync(kernel, 
    "Calcule o imposto de um produto de R$100");

// Executar o plano
var result = await plan.InvokeAsync(kernel);

// Stepwise Planner
var stepwisePlanner = new StepwisePlanner();
var stepwisePlan = await stepwisePlanner.CreatePlanAsync(kernel,
    "Analise as vendas do mês e sugira ações");
```

**MELHORIA:** Crie um comparador de performance entre planners para diferentes tipos de tarefas.

---

### 6. Memória e Embeddings

**Skills:**
1. Vetor Store abstração
2. Embeddings com Azure OpenAI
3. Busca semântica
4. Persistência de memória

**Código Exemplo:**
```csharp
// Configurar memória
var memoryBuilder = new MemoryBuilder();
var memory = memoryBuilder
    .WithOpenAITextEmbeddingGeneration("text-embedding-ada-002", "api-key")
    .WithMemoryStore(new VolatileMemoryStore())
    .Build();

// Salvar na memória
await memory.SaveInformationAsync(
    collection: "produtos",
    id: "produto-1",
    text: "Notebook Dell XPS 15 com 32GB RAM");

// Buscar
var results = memory.SearchAsync("produtos", "notebook potente");
```

**MELHORIA:** Implemente um cache de embeddings para evitar recálculos desnecessários em consultas repetidas.

---

### 7. RAG (Retrieval-Augmented Generation)

**Skills:**
1. Padrão RAG completo
2. Indexação de documentos
3. Chunking inteligente
4. Relevância e ranking

**Código Exemplo:**
```csharp
// RAG Pipeline
public class RAGService
{
    private readonly Kernel _kernel;
    private readonly ISemanticTextMemory _memory;
    
    public async Task<string> PerguntarAsync(string pergunta)
    {
        // Recuperar contexto relevante
        var contextos = new List<string>();
        await foreach (var result in _memory.SearchAsync(
            "documentos", pergunta, limit: 3))
        {
            contextos.Add(result.Metadata.Text);
        }
        
        // Construir prompt com contexto
        var prompt = $"""
        Contexto: {string.Join("\n", contextos)}
        
        Pergunta: {pergunta}
        
        Responda baseado apenas no contexto fornecido.
        """;
        
        var result = await _kernel.InvokePromptAsync(prompt);
        return result.GetValue<string>();
    }
}
```

**MELHORIA:** Implemente hybrid search combinando busca vetorial com busca por palavras-chave para melhor recall.

---

### 8. Chat History e Conversas

**Skills:**
1. Gerenciamento de ChatHistory
2. Janela de contexto
3. Resumo automático
4. Memória de longo prazo

**Código Exemplo:**
```csharp
// Gerenciar histórico
var chatHistory = new ChatHistory();

// Adicionar mensagens
chatHistory.AddUserMessage("Olá, preciso de ajuda");
chatHistory.AddAssistantMessage("Claro! Como posso ajudar?");

// Usar com o kernel
var chatCompletion = kernel.GetRequiredService<IChatCompletionService>();
var response = await chatCompletion.GetChatMessageContentsAsync(
    chatHistory,
    kernel: kernel);

// Resumo automático quando histórico fica grande
if (chatHistory.Count > 20)
{
    var summary = await kernel.InvokePromptAsync(
        $"Resuma esta conversa: {chatHistory}");
    chatHistory.Clear();
    chatHistory.AddSystemMessage(summary.GetValue<string>());
}
```

**MELHORIA:** Implemente persistência do histórico em banco de dados para continuidade entre sessões.

---

### 9. Filtros e Middleware

**Skills:**
1. Function invocation filters
2. Prompt render filters
3. Logging e telemetry
4. Rate limiting

**Código Exemplo:**
```csharp
// Function invocation filter
public class LoggingFilter : IFunctionInvocationFilter
{
    public async Task OnFunctionInvocationAsync(
        FunctionInvocationContext context,
        Func<FunctionInvocationContext, Task> next)
    {
        Console.WriteLine($"Invocando: {context.Function.Name}");
        var stopwatch = Stopwatch.StartNew();
        
        await next(context);
        
        stopwatch.Stop();
        Console.WriteLine($"Tempo: {stopwatch.ElapsedMilliseconds}ms");
    }
}

// Registrar filtro
builder.Services.AddSingleton<IFunctionInvocationFilter, LoggingFilter>();
```

**MELHORIA:** Implemente circuit breaker pattern nos filtros para proteção contra falhas em cascata.

---

### 10. Integração com Azure AI

**Skills:**
1. Azure OpenAI Service
2. Azure AI Search
3. Azure Cognitive Services
4. Managed Identity

**Código Exemplo:**
```csharp
// Azure OpenAI com Managed Identity
var builder = Kernel.CreateBuilder()
    .AddAzureOpenAIChatCompletion(
        deploymentName: "gpt-4",
        endpoint: "https://meu-resource.openai.azure.com/",
        credential: new DefaultAzureCredential());

// Azure AI Search para RAG
var searchClient = new SearchClient(
    new Uri("https://meu-search.search.windows.net"),
    "indice-documentos",
    new AzureKeyCredential("chave"));

kernel.Plugins.Add(new AzureAISearchPlugin(searchClient));
```

**MELHORIA:** Implemente fallback automático entre regiões Azure para alta disponibilidade.

---

### 11. OpenAPI e REST APIs

**Skills:**
1. Importação de specs OpenAPI
2. Geração automática de plugins
3. Invocação de APIs REST
4. Validação de schemas

**Código Exemplo:**
```csharp
// Importar API OpenAPI
var apiPlugin = KernelPluginFactory.CreateFromOpenApi(
    "petstore",
    new Uri("https://petstore.swagger.io/v2/swagger.json"),
    new OpenApiFunctionExecutionParameters());

kernel.Plugins.Add(apiPlugin);

// Invocar endpoint
var result = await kernel.InvokeAsync(
    "petstore", "getInventory",
    new KernelArguments());
```

**MELHORIA:** Crie um cache de specs OpenAPI para evitar download repetido e implemente versionamento automático.

---

### 12. Enterprise Integration

**Skills:**
1. Microsoft 365 connectors
2. Teams bot integration
3. Power Platform plugins
4. Azure DevOps pipelines

**Código Exemplo:**
```csharp
// Microsoft Graph integration
var graphPlugin = KernelPluginFactory.CreateFromType<
    MicrosoftGraphPlugin>(pluginName: "microsoft365");
kernel.Plugins.Add(graphPlugin);

// Teams Bot com Semantic Kernel
public class TeamsBot : ActivityHandler
{
    private readonly Kernel _kernel;
    
    protected override async Task<MessageResponse> OnMessageActivityAsync(
        ITurnContext<IIncomingMessageActivity> turnContext,
        CancellationToken cancellationToken)
    {
        var result = await _kernel.InvokePromptAsync(
            turnContext.Activity.Text);
        return new MessageResponse(result.GetValue<string>());
    }
}
```

**MELHORIA:** Implemente adapter pattern para integração com sistemas legados não-Microsoft.

---

### 13. Segurança e Autenticação

**Skills:**
1. API key management
2. Azure AD/Entra ID integration
3. Token refresh automático
4. Secrets rotation

**Código Exemplo:**
```csharp
// Azure AD integration
var credential = new DefaultAzureCredential();
var token = await credential.GetTokenAsync(
    new TokenRequestContext(new[] { "https://cognitiveservices.azure.com/.default" }));

// Key Vault para secrets
var secretClient = new SecretClient(
    new Uri("https://meu-vault.vault.azure.net/"),
    credential);

var apiKey = await secretClient.GetSecretAsync("openai-api-key");
```

**MELHORIA:** Implemente zero-trust architecture com validação de tokens em cada chamada de função.

---

### 14. Testing e Validação

**Skills:**
1. Unit testing de plugins
2. Mock de serviços de IA
3. Integration testing
4. Semantic Kernel testing utilities

**Código Exemplo:**
```csharp
// Mock do kernel para testes
var mockKernel = new Mock<Kernel>();
var mockChatCompletion = new Mock<IChatCompletionService>();

mockChatCompletion
    .Setup(x => x.GetChatMessageContentsAsync(
        It.IsAny<ChatHistory>(),
        It.IsAny<PromptExecutionSettings>(),
        It.IsAny<Kernel>()))
    .ReturnsAsync(new List<ChatMessageContent>
    {
        new ChatMessageContent(AuthorRole.Assistant, "Resposta mock")
    });

// Teste unitário do plugin
[Fact]
public async Task WeatherPlugin_ReturnsTemperature()
{
    var plugin = new WeatherPlugin();
    var result = await plugin.GetTemperatureAsync("São Paulo");
    Assert.Contains("25°C", result);
}
```

**MELHORIA:** Crie um test harness que simule diferentes cenários de resposta do modelo para validação robusta.

---

### 15. Performance e Otimização

**Skills:**
1. Cache de respostas
2. Batch processing
3. Connection pooling
4. Lazy loading de plugins

**Código Exemplo:**
```csharp
// Cache de respostas
public class CachedSemanticKernel
{
    private readonly IMemoryCache _cache;
    private readonly Kernel _kernel;
    
    public async Task<string> InvokeWithCacheAsync(string prompt)
    {
        var cacheKey = ComputeHash(prompt);
        
        if (_cache.TryGetValue(cacheKey, out string cached))
            return cached;
        
        var result = await _kernel.InvokePromptAsync(prompt);
        var response = result.GetValue<string>();
        
        _cache.Set(cacheKey, response, TimeSpan.FromHours(1));
        return response;
    }
}

// Lazy loading
kernel.Plugins.AddFromType<ExpensivePlugin>(
    pluginName: "expensive",
    lazy: true);
```

**MELHORIA:** Implemente pre-warming de cache baseado em padrões de uso anteriores.

---

### 16. Monitoring e Observabilidade

**Skills:**
1. Application Insights integration
2. Custom metrics e telemetry
3. Distributed tracing
4. Alertas e dashboards

**Código Exemplo:**
```csharp
// Telemetry personalizada
public class SemanticKernelTelemetry
{
    private readonly TelemetryClient _telemetry;
    
    public void TrackInvocation(string plugin, string function, 
        TimeSpan duration, bool success)
    {
        _telemetry.TrackEvent("KernelInvocation",
            properties: new Dictionary<string, string>
            {
                ["Plugin"] = plugin,
                ["Function"] = function
            },
            metrics: new Dictionary<string, double>
            {
                ["Duration"] = duration.TotalMilliseconds,
                ["Success"] = success ? 1 : 0
            });
    }
}
```

**MELHORIA:** Implemente SLO tracking para monitorar latência e taxa de erro das chamadas ao modelo.

---

### 17. Deployment e DevOps

**Skills:**
1. Containerization com Docker
2. Azure Container Apps deployment
3. Kubernetes orchestration
4. Infrastructure as Code (Bicep/Terraform)

**Código Exemplo:**
```dockerfile
# Dockerfile para Semantic Kernel
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MyApp.dll"]
```

```bicep
// Azure Bicep para deployment
resource semanticKernel 'Microsoft.Web/sites@2023-01-01' = {
  name: 'semantic-kernel-app'
  location: resourceGroup().location
  kind: 'app'
  properties: {
    siteConfig: {
      appSettings: [
        { name: 'OPENAI_API_KEY', value: openAiKey }
      ]
    }
  }
}
```

**MELHORIA:** Implemente blue-green deployment para atualizações sem downtime.

---

### 18. Multilinguismo e Globalização

**Skills:**
1. Suporte a múltiplos idiomas
2. Localização de prompts
3. Cultural context handling
4. Unicode e encoding

**Código Exemplo:**
```csharp
// Prompts localizados
public class LocalizedPromptProvider
{
    private readonly IStringLocalizer _localizer;
    
    public string GetPrompt(string key, string language)
    {
        using var scope = new CultureScope(language);
        return _localizer[key];
    }
}

// Uso com kernel
var prompt = promptProvider.GetPrompt("analysis_request", "pt-BR");
var result = await kernel.InvokePromptAsync(prompt);
```

**MELHORIA:** Crie um cache de traduções de prompts para evitar recálculos em requisições repetidas.

---

### 19. Avançado: Custom Kernel Services

**Skills:**
1. Custom AI service
2. Custom text generation
3. Custom embedding service
4. Service aggregation

**Código Exemplo:**
```csharp
// Custom AI Service
public class CustomAIService : IAIService
{
    public async Task<IReadOnlyList<string>> CompleteAsync(
        string prompt,
        PromptExecutionSettings? settings = null,
        CancellationToken cancellationToken = default)
    {
        // Lógica customizada de completions
        return new List<string> { "Resultado customizado" };
    }
}

// Registrar serviço customizado
builder.Services.AddSingleton<IAIService, CustomAIService>();
kernel.Services.GetRequiredService<IAIServiceRegistry>()
    .AddCompletionService<CustomAIService>("custom");
```

**MELHORIA:** Implemente adapter pattern para integração com LLMs não-convencionais ou modelos locais.

---

### 20. Padrões Avançados de Uso

**Skills:**
1. Agentic patterns
2. Multi-agent orchestration
3. Tool composition
4. Error recovery patterns

**Código Exemplo:**
```csharp
// Multi-agent orchestration
public class MultiAgentOrchestrator
{
    private readonly Kernel _kernel;
    
    public async Task<string> OrchestrateAsync(string task)
    {
        // Delegar para agentes especializados
        var researchAgent = await _kernel.InvokePromptAsync(
            $"Pesquise sobre: {task}");
        
        var analysisAgent = await _kernel.InvokePromptAsync(
            $"Analise os seguintes dados: {researchAgent}");
        
        var summaryAgent = await _kernel.InvokePromptAsync(
            $"Resuma a análise: {analysisAgent}");
        
        return summaryAgent.GetValue<string>();
    }
}

// Error recovery
public class ResilientKernelService
{
    public async Task<string> InvokeWithRetryAsync(string prompt,
        int maxRetries = 3)
    {
        for (int i = 0; i < maxRetries; i++)
        {
            try
            {
                var result = await _kernel.InvokePromptAsync(prompt);
                return result.GetValue<string>();
            }
            catch (Exception ex) when (i < maxRetries - 1)
            {
                await Task.Delay(TimeSpan.FromSeconds(Math.Pow(2, i)));
            }
        }
        throw new MaxRetriesExceededException();
    }
}
```

**MELHORIA:** Implemente circuit breaker com fallback para resiliência em produção.

---

## 🔧 Boas Práticas

1. **Use dependency injection** para gerenciar o ciclo de vida do kernel
2. **Implemente logging** em todas as chamadas de função
3. **Valide inputs** antes de enviar ao modelo
4. **Cacheie embeddings** para mejorar performance
5. **Use Managed Identity** em produção Azure

---

## 📚 Recursos Adicionais

- **Documentação Oficial**: https://learn.microsoft.com/semantic-kernel/
- **GitHub**: https://github.com/microsoft/semantic-kernel
- **Samples**: https://github.com/microsoft/semantic-kernel/tree/main/samples
- **Blog da Equipe**: https://devblogs.microsoft.com/semantic-kernel/
- **Discord**: https://aka.ms/semantic-kernel-discord

---

## 🔄 Comparação de Linguagens

| Feature | C# | Python | Java |
|---------|-----|--------|------|
| Maturity | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Performance | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Ecosistema | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Azure Integration | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Community | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
