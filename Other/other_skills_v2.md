# Documentação de Skills - Categorias Não Documentadas (v2 Aprimorada)

**Data de criação:** 14/09/2026  
**Última atualização:** 14/09/2026  
**Total de categorias documentadas:** 69  
**Total de skills documentadas:** ~500+  
**Versão:** 2.0 - Documentação Aprimorada

---

## Índice

1. [Mobile (30 skills)](#mobile)
2. [API Integration (30 skills)](#api-integration)
3. [Framework (13 skills)](#framework)
4. [Code Quality (17 skills)](#code-quality)
5. [Media (10 skills)](#media)
6. [Voice Agents (5 skills)](#voice-agents)
7. [Browser Automation (3 skills)](#browser-automation)
8. [Game Development (18 skills)](#game-development)
9. [Blockchain (7 skills)](#blockchain)
10. [Health (17 skills)](#health)
11. [Education (5 skills)](#education)
12. [Legal (8 skills)](#legal)
13. [Finance (2 skills)](#finance)
14. [Science (10 skills)](#science)
15. [Travel (1 skill)](#travel)

---

<a name="mobile"></a>
## 1. Mobile (30 skills)

### android-dev
**Descrição:** Guia de desenvolvimento de apps Android production-grade (Kotlin/Java, Flutter, RN, KMM)

**Quando usar:**
- Desenvolvimento nativo ou cross-platform para Android
- Apps que precisam de高性能 nativo
- Integração com APIs Android específicas

**Exemplos práticos:**
```kotlin
// 1. App Android nativo com Kotlin e Jetpack Compose
@Composable
fun TaskListScreen(viewModel: TaskViewModel = hiltViewModel()) {
    val tasks by viewModel.tasks.collectAsState()
    LazyColumn {
        items(tasks) { task ->
            TaskItem(task = task, onToggle = { viewModel.toggleTask(task.id) })
        }
    }
}

// 2. App Flutter com navegação por rotas nomeadas
void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/details': (context) => DetailsScreen(),
    '/settings': (context) => SettingsScreen(),
  },
));

// 3. App React Native com sync offline
import NetInfo from '@react-native-community/netinfo';
import AsyncStorage from '@react-native-async-storage/async-storage';

const useOfflineSync = () => {
  const [isConnected, setIsConnected] = useState(true);
  
  useEffect(() => {
    const unsubscribe = NetInfo.addEventListener(state => {
      setIsConnected(state.isConnected);
    });
    return () => unsubscribe();
  }, []);
  
  return { isConnected };
};
```

**Casos de uso avançados:**
- App de e-commerce com catálogo offline e sincronização bidirecional
- App de saúde com integração de wearables (Apple Watch, WearOS)
- App de produção agrícola com coleta de dados offline em áreas sem internet

**Integração com outras skills:**
- `flutter-expert`: Para apps cross-platform com performance nativa
- `expo-cicd-workflows`: Para CI/CD de apps React Native
- `mobile-security-coder`: Para implementação de padrões de segurança

**Padrões e anti-padrões:**
✅ Fazer: Usar Kotlin Coroutines/Flow para gerenciamento de estado assíncrono
✅ Fazer: Implementar offline-first com Room/SQLite
✅ Fazer: Usar ViewModel para separação de responsabilidades
❌ Evitar: Manipular UI diretamente nas Activities/Fragments
❌ Evitar: Chamadas de rede na main thread
❌ Evitar: Hardcoding de strings (usar recursos Android)

**Dicas de performance:**
- Usar LazyColumn/LazyRow ao invés de ScrollView com many items
- Implementar pagination para listas grandes
- Usar Image Loading Libraries (Coil, Glide) com cache
- Comprimir imagens antes de upload

**Comandos úteis:**
```bash
# Criar novo projeto Android
android create project --name MyApp --package com.example.myapp --activity MainActivity

# Build release
./gradlew assembleRelease

# Rodar testes
./gradlew test

# Lint check
./gradlew lint
```

**Referências:**
- [Android Developers](https://developer.android.com/)
- [Kotlin Coroutines](https://developer.android.com/kotlin/coroutines)
- [Jetpack Compose](https://developer.android.com/jetpack/compose)
- [Android Architecture Components](https://developer.android.com/topic/libraries/architecture)

---

### flutter-expert
**Descrição:** Desenvolvimento Flutter com Dart 3, widgets avançados, deploy multi-plataforma

**Quando usar:**
- Criação de apps Flutter para múltiplas plataformas
- UIs customizadas com animações complexas
- Integração com código nativo (platform channels)

**Exemplos práticos:**
```dart
// 1. App Flutter com navegação por rotas nomeadas
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(),
      },
    );
  }
}

// 2. App com state management usando Riverpod
final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  
  void increment() => state++;
  void decrement() => state--;
}

// 3. Animação complexa com AnimationController
class FadeTransitionExample extends StatefulWidget {
  @override
  _FadeTransitionExampleState createState() => _FadeTransitionExampleState();
}

class _FadeTransitionExampleState extends State<FadeTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: const Text('Fade Transition'),
    );
  }
}
```

**Casos de uso avançados:**
- App de edição de vídeo com Flutter
- App de realidade aumentada com ARCore/ARKit
- App de IoT com integração de dispositivos

**Integração com outras skills:**
- `expo-ui-jetpack-compose`: Para UIs nativas Android
- `expo-ui-swift-ui`: Para UIs nativas iOS
- `flutter-expert`: Para lógica de negócio complexa

**Padrões e anti-padrões:**
✅ Fazer: Usar Provider/Riverpod para gerenciamento de estado
✅ Fazer: Separar lógica de negócio da UI (BLoC/Clean Architecture)
✅ Fazer: Usar const constructors para otimização
❌ Evitar: Usar setState() para estado complexo
❌ Evitar: Widgets muito grandes (>300 linhas)
❌ Evitar: Ignorar plataform-specific design guidelines

**Dicas de performance:**
- Usar `const` constructors quando possível
- Implementar lazy loading para listas grandes
- Usar `RepaintBoundary` para animações complexas
- Comprimir imagens e usar formato WebP

**Comandos úteis:**
```bash
# Criar novo projeto Flutter
flutter create my_app

# Rodar em dispositivo
flutter run

# Build release Android
flutter build apk --release

# Build release iOS
flutter build ios --release

# Rodar testes
flutter test
```

**Referências:**
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language](https://dart.dev/)
- [Flutter Packages](https://pub.dev/)
- [Flutter Performance](https://docs.flutter.dev/perf)

---

### ios-developer
**Descrição:** Desenvolvimento iOS nativo com Swift/SwiftUI (iOS 18)

**Quando usar:**
- Apps iOS nativos com Core Data, networking, App Store
- UIs modernas com SwiftUI
- Integração com APIs Apple (HealthKit, CoreML, ARKit)

**Exemplos práticos:**
```swift
// 1. App iOS com SwiftUI e CoreData
struct TaskListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.createdAt, ascending: false)],
        animation: .default
    )
    private var tasks: FetchedResults<Task>
    
    var body: some View {
        List(tasks) { task in
            TaskRow(task: task)
        }
    }
}

// 2. Networking com async/await
func fetchTasks() async throws -> [Task] {
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw NetworkError.invalidResponse
    }
    
    return try JSONDecoder().decode([Task].self, from: data)
}

// 3. App com MVVM e Combine
class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTasks() {
        isLoading = true
        taskService.fetchTasks()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
            }, receiveValue: { tasks in
                self.tasks = tasks
            })
            .store(in: &cancellables)
    }
}
```

**Casos de uso avançados:**
- App de saúde com integração HealthKit
- App de realidade aumentada com ARKit
- App de pagamentos com Apple Pay

**Integração com outras skills:**
- `swiftui-expert-skill`: Para padrões avançados SwiftUI
- `swiftui-performance-audit`: Para otimização de performance
- `ios-debugger-agent`: Para depuração de apps

**Padrões e anti-padrões:**
✅ Fazer: Usar SwiftUI para UI declarativa
✅ Fazer: Implementar MVVM para separação de responsabilidades
✅ Fazer: Usar async/await para código assíncrono limpo
❌ Evitar: Usar UIKit quando SwiftUI é suficiente
❌ Evitar: Ignorar Human Interface Guidelines
❌ Evitar: Armazenar dados sensíveis em UserDefaults

**Dicas de performance:**
- Usar `@StateObject` ao invés de `@ObservedObject` para objetos criados localmente
- Implementar `EquatableView` para views estáticas
- Usar `LazyVStack`/`LazyHStack` para listas grandes
- Otimizar imagens com formato HEIC

**Comandos úteis:**
```bash
# Criar novo projeto iOS
swift package init --type executable

# Build projeto
xcodebuild build -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 15'

# Rodar testes
xcodebuild test -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 15'

# Arquivar para App Store
xcodebuild archive -scheme MyApp -archivePath build/MyApp.xcarchive
```

**Referências:**
- [Apple Developer](https://developer.apple.com/)
- [SwiftUI Documentation](https://developer.apple.com/xcode/swiftui/)
- [Swift Programming Language](https://docs.swift.org/swift-book/)
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

---

### expo-cicd-workflows
**Descrição:** Cria e gerencia workflows EAS para projetos Expo

**Quando usar:**
- Configuração de CI/CD para apps Expo
- Pipelines de build e deploy automatizados
- Publicação nas lojas iOS e Android

**Exemplos práticos:**
```yaml
# 1. Workflow EAS para build automático
name: Build and Deploy
on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
      - run: npm ci
      - run: npx eas-cli build --platform all --non-interactive

# 2. Workflow para publicação nas lojas
name: Publish to Stores
on:
  release:
    types: [published]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
      - run: npm ci
      - run: npx eas-cli submit --platform ios
      - run: npx eas-cli submit --platform android

# 3. Workflow com testes
name: Test and Build
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
      - run: npm ci
      - run: npm test
      - run: npx eas-cli build --platform all
```

**Casos de uso avançados:**
- Deploy automático em ambientes de staging/produção
- Build condicional baseado em branches
- Integração com ferramentas de monitoramento

**Integração com outras skills:**
- `expo-deployment`: Para configuração de deploy
- `expo-dev-client`: Para ambientes de desenvolvimento
- `expo-observe`: Para monitoramento de performance

**Padrões e anti-padrões:**
✅ Fazer: Usar secrets do GitHub para credenciais
✅ Fazer: Implementar cache de node_modules
✅ Fazer: Usar branches para ambientes diferentes
❌ Evitar: Hardcoded de credenciais nos workflows
❌ Evitar: Builds sem testes prévios
❌ Evitar: Deploy direto para produção sem staging

**Dicas de performance:**
- Usar cache de npm/yarn para builds mais rápidos
- Implementar build em paralelo para múltiplas plataformas
- Usar EAS Build para builds nativos otimizados
- Configurar cache de Gradle para Android

**Comandos úteis:**
```bash
# Configurar EAS
eas build:configure

# Build local
eas build --platform ios --local

# Build para todas as plataformas
eas build --platform all

# Submit para lojas
eas submit --platform ios
eas submit --platform android

# Configurar update
eas update --branch production
```

**Referências:**
- [EAS Build Documentation](https://docs.expo.dev/build/introduction/)
- [EAS Submit](https://docs.expo.dev/submit/introduction/)
- [GitHub Actions for Expo](https://docs.expo.dev/github-actions/)
- [Expo CLI](https://docs.expo.dev/more/expo-cli/)

---

### mobile-security-coder
**Descrição:** Práticas seguras de codificação mobile (validação, WebView, segurança)

**Quando usar:**
- Implementação de padrões de segurança em apps mobile
- Validação de entrada e proteção contra ataques
- Segurança em WebView e storage local

**Exemplos práticos:**
```javascript
// 1. Validação de entrada segura em React Native
import validator from 'validator';

const validateEmail = (email) => {
  if (!validator.isEmail(email)) {
    throw new Error('Email inválido');
  }
  return validator.normalizeEmail(email);
};

const validatePassword = (password) => {
  const minLength = 8;
  const hasUpperCase = /[A-Z]/.test(password);
  const hasLowerCase = /[a-z]/.test(password);
  const hasNumbers = /\d/.test(password);
  const hasSpecialChar = /[!@#$%^&*]/.test(password);
  
  if (password.length < minLength) {
    throw new Error('Senha deve ter pelo menos 8 caracteres');
  }
  if (!hasUpperCase || !hasLowerCase || !hasNumbers || !hasSpecialChar) {
    throw new Error('Senha deve conter maiúsculas, minúsculas, números e caracteres especiais');
  }
  return password;
};

// 2. Armazenamento seguro com Keychain/Keystore
import * as Keychain from 'react-native-keychain';

const storeCredentials = async (username, password) => {
  await Keychain.setGenericPassword(username, password, {
    accessible: Keychain.ACCESSIBLE.WHEN_UNLOCKED_THIS_DEVICE_ONLY,
    securityLevel: Keychain.SECURITY_LEVEL.SECURE_HARDWARE,
  });
};

const getCredentials = async () => {
  const credentials = await Keychain.getGenericPassword();
  return credentials;
};

// 3. WebView seguro
import { WebView } from 'react-native-webview';

const SecureWebView = ({ url }) => {
  const onShouldStartLoadWithRequest = (event) => {
    // Validar URL antes de carregar
    if (!event.url.startsWith('https://trusted-domain.com')) {
      return false;
    }
    return true;
  };

  return (
    <WebView
      source={{ uri: url }}
      onShouldStartLoadWithRequest={onShouldStartLoadWithRequest}
      javaScriptEnabled={false} // Desabilitar JavaScript se não necessário
      domStorageEnabled={false} // Desabilitar DOM storage
    />
  );
};
```

**Casos de uso avançados:**
- App bancário com biometria e criptografia
- App de saúde com dados sensíveis (HIPAA compliance)
- App de empresa com MDM (Mobile Device Management)

**Integração com outras skills:**
- `mobile-reverse`: Para análise de segurança
- `ios-developer`: Para padrões de segurança iOS
- `android-dev`: Para padrões de segurança Android

**Padrões e anti-padrões:**
✅ Fazer: Usar Keychain/Keystore para armazenamento seguro
✅ Fazer: Validar todas as entradas do usuário
✅ Fazer: Implementar certificate pinning
❌ Evitar: Armazenar senhas em AsyncStorage/SharedPreferences
❌ Evitar: Desabilitar SSL verification
❌ Evitar: Expor dados sensíveis em logs

**Dicas de performance:**
- Usar criptografia nativa ao invés de bibliotecas JS
- Implementar root detection em produção
- Usar attestation de dispositivo para apps sensíveis
- Monitorar tentativas de bypass de segurança

**Comandos úteis:**
```bash
# Verificar dependências vulneráveis
npm audit

# Analisar segurança do app
fastlane scan

# Verificar certificados iOS
security find-identity -v -p codesigning

# Verificar keystore Android
keytool -list -v -keystore my-release-key.keystore
```

**Referências:**
- [OWASP Mobile Security](https://owasp.org/www-project-mobile-top-10/)
- [Apple Security Guide](https://support.apple.com/guide/security/welcome/web)
- [Android Security Guide](https://developer.android.com/topic/security/best-practices)
- [React Native Security](https://reactnative.dev/docs/security)

---

<a name="api-integration"></a>
## 2. API Integration (30 skills)

### stripe-integration
**Descrição:** Implementação de Stripe checkout, assinaturas, webhooks

**Quando usar:**
- Pagamentos recorrentes e checkout seguro
- Webhooks para confirmação server-side
- Integração com e-commerce e SaaS

**Exemplos práticos:**
```javascript
// 1. Checkout Session com Stripe
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

const createCheckoutSession = async (req, res) => {
  const session = await stripe.checkout.sessions.create({
    payment_method_types: ['card'],
    line_items: [{
      price: 'price_1234567890',
      quantity: 1,
    }],
    mode: 'subscription',
    success_url: 'https://example.com/success?session_id={CHECKOUT_SESSION_ID}',
    cancel_url: 'https://example.com/cancel',
  });
  
  res.json({ sessionId: session.id });
};

// 2. Webhook handler para confirmação
const webhookHandler = async (req, res) => {
  const sig = req.headers['stripe-signature'];
  let event;
  
  try {
    event = stripe.webhooks.constructEvent(req.body, sig, process.env.STRIPE_WEBHOOK_SECRET);
  } catch (err) {
    return res.status(400).send(`Webhook Error: ${err.message}`);
  }
  
  if (event.type === 'checkout.session.completed') {
    const session = event.data.object;
    // Ativar assinatura do usuário
    await activateSubscription(session.customer, session.subscription);
  }
  
  res.json({ received: true });
};

// 3. Gerenciamento de assinaturas
const cancelSubscription = async (customerId) => {
  const subscriptions = await stripe.subscriptions.list({
    customer: customerId,
    status: 'active',
  });
  
  for (const sub of subscriptions.data) {
    await stripe.subscriptions.cancel(sub.id);
  }
};
```

**Casos de uso avançados:**
- SaaS com múltiplos planos e pricing dinâmico
- Marketplace com split payments
- Plataforma de assinaturas com trials

**Integração com outras skills:**
- `paypal-integration`: Para alternativa de pagamento
- `payment-integration`: Para outros processadores
- `shopify-apps`: Para e-commerce

**Padrões e anti-padrões:**
✅ Fazer: Validar webhooks server-side sempre
✅ Fazer: Usar idempotency keys para operações críticas
✅ Fazer: Implementar retry logic para falhas de rede
❌ Evitar: Chamar API do Stripe do frontend
❌ Evitar: Armazenar dados de cartão de crédito
❌ Evitar: Ignorar eventos de webhook

**Dicas de performance:**
- Usar filas para processar webhooks
- Implementar cache para dados de cliente
- Usar pagination para listas grandes de transações
- Monitorar latência de webhooks

**Comandos úteis:**
```bash
# Instalar Stripe CLI
npm install -g stripe

# Escutar webhooks localmente
stripe listen --forward-to localhost:4242/webhook

# Verificar status de pagamento
stripe payment_intents list --limit 10

# Criar cliente
stripe customers create --email user@example.com
```

**Referências:**
- [Stripe Documentation](https://stripe.com/docs)
- [Stripe API Reference](https://stripe.com/docs/api)
- [Stripe Webhooks](https://stripe.com/docs/webhooks)
- [Stripe Testing](https://stripe.com/docs/testing)

---

### slack-bot-builder
**Descrição:** Construção de apps Slack com Bolt (Python/JS/Java)

**Quando usar:**
- Slash commands e interatividade
- Block Kit para UIs rich
- Eventos e OAuth

**Exemplos práticos:**
```javascript
// 1. Bot Slack com Bolt (JavaScript)
const { App } = require('@slack/bolt');

const app = new App({
  token: process.env.SLACK_BOT_TOKEN,
  signingSecret: process.env.SLACK_SIGNING_SECRET,
});

// Slash command
app.command('/hello', async ({ command, ack, respond }) => {
  await ack();
  await respond(`Olá, <@${command.user_id}>!`);
});

// Mensagem com Block Kit
app.message('ajuda', async ({ message, say }) => {
  await say({
    blocks: [
      {
        type: 'section',
        text: {
          type: 'mrkdwn',
          text: '*Como posso ajudar?*',
        },
      },
      {
        type: 'actions',
        elements: [
          {
            type: 'button',
            text: { type: 'plain_text', text: 'Criar tarefa' },
            action_id: 'create_task',
          },
          {
            type: 'button',
            text: { type: 'plain_text', text: 'Ver relatório' },
            action_id: 'view_report',
          },
        ],
      },
    ],
  });
});

// Evento de botão
app.action('create_task', async ({ ack, body, say }) => {
  await ack();
  await say(`Tarefa criada por <@${body.user.id}>`);
});

(async () => {
  await app.start(3000);
  console.log('Bot está rodando!');
})();
```

**Casos de uso avançados:**
- Bot de atendimento ao cliente com IA
- Bot de gerenciamento de projetos (Jira integration)
- Bot de notificações de deploy (GitHub Actions)

**Integração com outras skills:**
- `discord-automation`: Para automação Discord
- `microsoft-teams-automation`: Para Microsoft Teams
- `telegram-bot-builder`: Para Telegram

**Padrões e anti-padrões:**
✅ Fazer: Usar Block Kit para UIs ricas
✅ Fazer: Implementar rate limiting
✅ Fazer: Usar ephemeral messages para respostas privadas
❌ Evitar: Enviar muitas mensagens (spam)
❌ Evitar: Ignorar eventos de interatividade
❌ Evitar: Hardcoded de tokens

**Dicas de performance:**
- Usar Socket Mode para desenvolvimento
- Implementar batching para operações em lote
- Usar cache para dados de usuário
- Configurar event retry para resiliência

**Comandos úteis:**
```bash
# Instalar Bolt
npm install @slack/bolt

# Criar app Slack
slack create my-app

# Rodar bot localmente
npm run start

# Deploy para Heroku
git push heroku main
```

**Referências:**
- [Slack Bolt Documentation](https://slack.dev/bolt/)
- [Block Kit Builder](https://app.slack.com/block-kit-builder)
- [Slack API Methods](https://api.slack.com/methods)
- [Slack Events API](https://api.slack.com/events-api)

---

### telegram-bot-builder
**Descrição:** Construção de bots Telegram (automação a IA)

**Quando usar:**
- Bot API para mensagens e mídia
- UX com teclados inline
- Monetização via Telegram Stars

**Exemplos práticos:**
```python
# 1. Bot Telegram com python-telegram-bot
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, MessageHandler, filters, CallbackContext

async def start(update: Update, context: CallbackContext):
    keyboard = [
        [InlineKeyboardButton("Opção 1", callback_data='option1')],
        [InlineKeyboardButton("Opção 2", callback_data='option2')],
    ]
    reply_markup = InlineKeyboardMarkup(keyboard)
    await update.message.reply_text("Escolha uma opção:", reply_markup=reply_markup)

async def button_handler(update: Update, context: CallbackContext):
    query = update.callback_query
    await query.answer()
    
    if query.data == 'option1':
        await query.edit_message_text("Você escolheu a Opção 1!")
    elif query.data == 'option2':
        await query.edit_message_text("Você escolheu a Opção 2!")

async def echo(update: Update, context: CallbackContext):
    await update.message.reply_text(f"Você disse: {update.message.text}")

def main():
    application = Application.builder().token("YOUR_TOKEN").build()
    
    application.add_handler(CommandHandler("start", start))
    application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, echo))
    application.add_handler(CallbackQueryHandler(button_handler))
    
    application.run_polling()

if __name__ == '__main__':
    main()
```

**Casos de uso avançados:**
- Bot de atendimento com IA (ChatGPT integration)
- Bot de-commerce com catálogo e pagamento
- Bot de gerenciamento de comunidade

**Integração com outras skills:**
- `discord-automation`: Para automação Discord
- `microsoft-teams-automation`: Para Microsoft Teams
- `whatsapp-automation`: Para WhatsApp Business

**Padrões e anti-padrões:**
✅ Fazer: Usar teclados inline para navegação
✅ Fazer: Implementar rate limiting
✅ Fazer: Usar webhooks em produção
❌ Evitar: Polling em produção (muitas requisições)
❌ Evitar: Enviar mensagens sem permissão
❌ Evitar: Ignorar CallbackQuery

**Dicas de performance:**
- Usar webhooks ao invés de polling
- Implementar cache para dados de usuário
- Usar async/await para operações I/O
- Configurar retry para falhas de rede

**Comandos úteis:**
```bash
# Instalar python-telegram-bot
pip install python-telegram-bot

# Criar bot
python bot.py

# Configurar webhook
curl -X POST https://api.telegram.org/bot<TOKEN>/setWebhook -d url=https://example.com/webhook
```

**Referências:**
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [python-telegram-bot](https://python-telegram-bot.readthedocs.io/)
- [Telegram Bot Development](https://core.telegram.org/bots/develop)
- [Telegram Stars](https://core.telegram.org/bots/stars)

---

### twilio-communications
**Descrição:** Comunicações com Twilio (SMS, voz, WhatsApp, 2FA)

**Quando usar:**
- Notificações SMS e chamadas
- IVR e autenticação multi-canal
- Integração com WhatsApp Business

**Exemplos práticos:**
```javascript
// 1. Envio de SMS com Twilio
const twilio = require('twilio');

const client = twilio(accountSid, authToken);

const sendSMS = async (to, message) => {
  const sms = await client.messages.create({
    body: message,
    from: '+1234567890',
    to: to,
  });
  
  console.log(`SMS enviado: ${sms.sid}`);
};

// 2. Verificação 2FA
const sendVerification = async (to) => {
  const verification = await client.verify.v2
    .services('VERIFY_SERVICE_SID')
    .verifications.create({ to, channel: 'sms' });
  
  return verification.sid;
};

const checkVerification = async (to, code) => {
  const verificationCheck = await client.verify.v2
    .services('VERIFY_SERVICE_SID')
    .verificationChecks.create({ to, code });
  
  return verificationCheck.status === 'approved';
};

// 3. Chamada de voz
const makeCall = async (to, twimlUrl) => {
  const call = await client.calls.create({
    url: twimlUrl,
    to: to,
    from: '+1234567890',
  });
  
  return call.sid;
};
```

**Casos de uso avançados:**
- Sistema de atendimento omnichannel
- Notificações de emergência multi-canal
- Verificação de identidade biométrica

**Integração com outras skills:**
- `whatsapp-automation`: Para WhatsApp Business
- `discord-automation`: Para Discord
- `microsoft-teams-automation`: Para Microsoft Teams

**Padrões e anti-padrões:**
✅ Fazer: Usar webhooks para receber chamadas
✅ Fazer: Implementar retry para envios
✅ Fazer: Validar números de telefone
❌ Evitar: Enviar spam SMS
❌ Evitar: Ignorar opt-out de usuários
❌ Evitar: Hardcoded de credenciais

**Dicas de performance:**
- Usar filas para envio em lote
- Implementar cache para dados de contato
- Usar webhooks ao invés de polling
- Configurar retry com backoff exponencial

**Comandos úteis:**
```bash
# Instalar Twilio SDK
npm install twilio

# Enviar SMS
curl -X POST https://api.twilio.com/2010-04-01/Accounts/{AccountSid}/Messages.json \
  -u "{AccountSid}:{AuthToken}" \
  --data-urlencode "Body=Olá" \
  --data-urlencode "From=+1234567890" \
  --data-urlencode "To=+0987654321"

# Verificar número
curl -X POST https://api.twilio.com/2010-04-01/Accounts/{AccountSid}/IncomingPhoneNumbers.json \
  -u "{AccountSid}:{AuthToken}" \
  --data-urlencode "PhoneNumber=+1234567890"
```

**Referências:**
- [Twilio Documentation](https://www.twilio.com/docs)
- [Twilio API Reference](https://www.twilio.com/docs/api)
- [Twilio Verify](https://www.twilio.com/docs/verify)
- [Twilio WhatsApp](https://www.twilio.com/docs/whatsapp)

---

<a name="framework"></a>
## 3. Framework (13 skills)

### nextjs-app-router-patterns
**Descrição:** Padrões Next.js 14+ App Router (Server Components, full-stack)

**Quando usar:**
- Arquitetura moderna Next.js com App Router
- Server Components e streaming
- APIs Route Handlers

**Exemplos práticos:**
```typescript
// 1. Server Component com streaming
// app/dashboard/page.tsx
import { Suspense } from 'react';

async function DashboardContent() {
  const data = await fetch('https://api.example.com/dashboard', {
    next: { revalidate: 60 },
  });
  const dashboard = await data.json();
  
  return (
    <div>
      <h1>Dashboard</h1>
      <DashboardWidget data={dashboard} />
    </div>
  );
}

export default function DashboardPage() {
  return (
    <div>
      <h1>Meu Dashboard</h1>
      <Suspense fallback={<DashboardSkeleton />}>
        <DashboardContent />
      </Suspense>
    </div>
  );
}

// 2. Route Handler
// app/api/users/route.ts
import { NextResponse } from 'next/server';

export async function GET() {
  const users = await db.user.findMany();
  return NextResponse.json(users);
}

export async function POST(request: Request) {
  const body = await request.json();
  const user = await db.user.create({ data: body });
  return NextResponse.json(user, { status: 201 });
}

// 3. Server Action
// app/actions.ts
'use server';

import { revalidatePath } from 'next/cache';

export async function createPost(formData: FormData) {
  const title = formData.get('title') as string;
  const content = formData.get('content') as string;
  
  await db.post.create({
    data: { title, content },
  });
  
  revalidatePath('/posts');
}
```

**Casos de uso avançados:**
- Dashboard com dados em tempo real
- E-commerce com SEO otimizado
- Plataforma de conteúdo com ISR

**Integração com outras skills:**
- `tanstack-query-expert`: Para gerenciamento de estado assíncrono
- `trpc-fullstack`: Para APIs type-safe
- `zod-validation-expert`: Para validação de schemas

**Padrões e anti-padrões:**
✅ Fazer: Usar Server Components por padrão
✅ Fazer: Implementar loading.tsx e error.tsx
✅ Fazer: Usar Suspense para streaming
❌ Evitar: Usar 'use client' desnecessariamente
❌ Evitar: Fetch de dados no cliente quando possível
❌ Evitar: Ignorar cache de rotas

**Dicas de performance:**
- Usar `next/dynamic` para code splitting
- Implementar ISR para páginas estáticas
- Usar `unstable_cache` para cache de dados
- Configurar `next.config.js` para otimizações

**Comandos úteis:**
```bash
# Criar projeto Next.js
npx create-next-app@latest my-app

# Rodar em desenvolvimento
npm run dev

# Build para produção
npm run build

# Analisar bundle
npm run build && npx @next/bundle-analyzer
```

**Referências:**
- [Next.js Documentation](https://nextjs.org/docs)
- [App Router](https://nextjs.org/docs/app)
- [Server Components](https://nextjs.org/docs/app/building-your-application/rendering/server-components)
- [Route Handlers](https://nextjs.org/docs/app/building-your-application/routing/route-handlers)

---

### tanstack-query-expert
**Descrição:** Expertise em TanStack Query (React Query) para estado assíncrono

**Quando usar:**
- Data fetching e cache inteligente
- Mutations com optimistic updates
- Gerenciamento de estado do servidor

**Exemplos práticos:**
```typescript
// 1. Query com cache
import { useQuery } from '@tanstack/react-query';

const fetchUsers = async () => {
  const response = await fetch('/api/users');
  return response.json();
};

function UsersList() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['users'],
    queryFn: fetchUsers,
    staleTime: 5 * 60 * 1000, // 5 minutos
  });

  if (isLoading) return <div>Carregando...</div>;
  if (error) return <div>Erro ao carregar usuários</div>;

  return (
    <ul>
      {data.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}

// 2. Mutation com optimistic update
import { useMutation, useQueryClient } from '@tanstack/react-query';

function CreateUser() {
  const queryClient = useQueryClient();

  const mutation = useMutation({
    mutationFn: (newUser) => fetch('/api/users', {
      method: 'POST',
      body: JSON.stringify(newUser),
    }),
    onMutate: async (newUser) => {
      await queryClient.cancelQueries({ queryKey: ['users'] });
      
      const previousUsers = queryClient.getQueryData(['users']);
      
      queryClient.setQueryData(['users'], (old) => [...old, newUser]);
      
      return { previousUsers };
    },
    onError: (err, newUser, context) => {
      queryClient.setQueryData(['users'], context.previousUsers);
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
  });

  return (
    <button
      onClick={() => mutation.mutate({ name: 'Novo Usuário' })}
      disabled={mutation.isPending}
    >
      {mutation.isPending ? 'Criando...' : 'Criar Usuário'}
    </button>
  );
}

// 3. Infinite Query
import { useInfiniteQuery } from '@tanstack/react-query';

function PostsList() {
  const {
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
  } = useInfiniteQuery({
    queryKey: ['posts'],
    queryFn: ({ pageParam = 1 }) => fetch(`/api/posts?page=${pageParam}`),
    getNextPageParam: (lastPage) => lastPage.nextCursor,
  });

  return (
    <div>
      {data.pages.map(page => (
        <div key={page.id}>{page.title}</div>
      ))}
      <button
        onClick={() => fetchNextPage()}
        disabled={!hasNextPage || isFetchingNextPage}
      >
        {isFetchingNextPage ? 'Carregando...' : 'Carregar mais'}
      </button>
    </div>
  );
}
```

**Casos de uso avançados:**
- Dashboard com dados em tempo real
- Formulários com validação server-side
- Páginas com paginação infinita

**Integração com outras skills:**
- `nextjs-app-router-patterns`: Para Next.js
- `zod-validation-expert`: Para validação
- `typescript-expert`: Para tipos

**Padrões e anti-padrões:**
✅ Fazer: Usar queryKey consistente
✅ Fazer: Implementar optimistic updates
✅ Fazer: Configurar staleTime apropriado
❌ Evitar: Query keys muito genéricas
❌ Evitar: Ignorar cache de queries
❌ Evitar: Mutation sem error handling

**Dicas de performance:**
- Usar `select` para transformar dados
- Implementar `placeholderData` para UX
- Usar `gcTime` para limpeza de cache
- Configurar `refetchOnWindowFocus` conforme necessário

**Comandos úteis:**
```bash
# Instalar TanStack Query
npm install @tanstack/react-query

# DevTools para debug
npm install @tanstack/react-query-devtools
```

**Referências:**
- [TanStack Query Documentation](https://tanstack.com/query)
- [React Query](https://tanstack.com/query/docs/framework/react/overview)
- [Query Keys](https://tanstack.com/query/docs/framework/react/guides/query-keys)
- [Mutations](https://tanstack.com/query/docs/framework/react/guides/mutations)

---

### zod-validation-expert
**Descrição:** Validação de schemas TypeScript-first com Zod

**Quando usar:**
- Parsing e validação de dados
- Erros customizados e tipados
- Integração com React Hook Form

**Exemplos práticos:**
```typescript
// 1. Schema básico
import { z } from 'zod';

const UserSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(2).max(100),
  email: z.string().email(),
  age: z.number().int().min(18).max(120),
  role: z.enum(['admin', 'user', 'guest']),
});

type User = z.infer<typeof UserSchema>;

// Validação
const result = UserSchema.safeParse({
  id: '123e4567-e89b-12d3-a456-426614174000',
  name: 'João',
  email: 'joao@example.com',
  age: 25,
  role: 'admin',
});

if (result.success) {
  console.log(result.data); // User tipado
} else {
  console.error(result.error);
}

// 2. Schema com transforms
const PhoneSchema = z.string()
  .transform((val) => val.replace(/\D/g, ''))
  .pipe(z.string().min(10).max(11));

const FormSchema = z.object({
  phone: PhoneSchema,
  email: z.string().email(),
});

// 3. Integração com React Hook Form
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';

const LoginFormSchema = z.object({
  email: z.string().email('Email inválido'),
  password: z.string().min(8, 'Senha deve ter pelo menos 8 caracteres'),
});

function LoginForm() {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({
    resolver: zodResolver(LoginFormSchema),
  });

  const onSubmit = (data) => {
    console.log(data); // Data tipado e validado
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      {errors.email && <span>{errors.email.message}</span>}
      
      <input type="password" {...register('password')} />
      {errors.password && <span>{errors.password.message}</span>}
      
      <button type="submit">Entrar</button>
    </form>
  );
}
```

**Casos de uso avançados:**
- APIs com validação de request/response
- Formulários complexos com validação condicional
- Configuração de app com validação de ambiente

**Integração com outras skills:**
- `typescript-expert`: Para tipos avançados
- `nextjs-app-router-patterns`: Para Next.js
- `tanstack-query-expert`: Para data fetching

**Padrões e anti-padrões:**
✅ Fazer: Usar `.safeParse()` para validação segura
✅ Fazer: Criar schemas reutilizáveis
✅ Fazer: Usar `.transform()` para dados brutos
❌ Evitar: Ignorar erros de validação
❌ Evitar: Schemas muito complexos (dividir)
❌ Evitar: Validar apenas no frontend

**Dicas de performance:**
- Usar `.brand()` para tipos nominalmente
- Implementar `.coerce()` para dados de query strings
- Usar `.lazy()` para schemas recursivos
- Configurar `.describe()` para documentação

**Comandos úteis:**
```bash
# Instalar Zod
npm install zod

# Para React Hook Form
npm install @hookform/resolvers
```

**Referências:**
- [Zod Documentation](https://zod.dev/)
- [Zod Examples](https://zod.dev/?id=examples)
- [React Hook Form + Zod](https://react-hook-form.com/advanced-usage/#Controller)
- [Zod GitHub](https://github.com/colinhacks/zod)

---

<a name="code-quality"></a>
## 4. Code Quality (17 skills)

### clean-code
**Descrição:** Princípios de "Clean Code" de Robert C. Martin

**Quando usar:**
- Transformação de código funcional em código limpo
- Refatoração para legibilidade
- Padrões de nomenclatura e estrutura

**Exemplos práticos:**
```typescript
// 1. Código limpo com funções puras
// ❌ Código ruim
function processData(data: any[]) {
  let result = [];
  for (let i = 0; i < data.length; i++) {
    if (data[i].active === true) {
      result.push({
        id: data[i].id,
        name: data[i].firstName + ' ' + data[i].lastName,
        status: 'active'
      });
    }
  }
  return result;
}

// ✅ Código limpo
interface User {
  id: string;
  firstName: string;
  lastName: string;
  active: boolean;
}

interface ProcessedUser {
  id: string;
  name: string;
  status: 'active' | 'inactive';
}

const getFullName = (user: User): string =>
  `${user.firstName} ${user.lastName}`;

const isActiveUser = (user: User): boolean =>
  user.active;

const toProcessedUser = (user: User): ProcessedUser => ({
  id: user.id,
  name: getFullName(user),
  status: 'active',
});

const processActiveUsers = (users: User[]): ProcessedUser[] =>
  users
    .filter(isActiveUser)
    .map(toProcessedUser);

// 2. Funções pequenas e responsáveis
// ❌ Função gigante
function handleUserAction(action: string, userId: string) {
  // 50+ linhas de código...
}

// ✅ Funções responsáveis
const validateUser = (userId: string): boolean => {
  // Validação
};

const fetchUser = async (userId: string): Promise<User> => {
  // Busca
};

const updateUser = async (userId: string, data: Partial<User>): Promise<User> => {
  // Atualização
};

const handleUserAction = async (action: string, userId: string): Promise<void> => {
  if (!validateUser(userId)) {
    throw new Error('Invalid user');
  }
  
  const user = await fetchUser(userId);
  await updateUser(userId, { ...user, lastAction: action });
};

// 3. Nomes expressivos
// ❌ Nomes ruins
const d = new Date();
const fn = (x: number) => x * 2;
const arr = [1, 2, 3];

// ✅ Nomes expressivos
const currentDate = new Date();
const doubleValue = (number: number) => number * 2;
const sequentialNumbers = [1, 2, 3];
```

**Casos de uso avançados:**
- Refatoração de codebase legado
- Code review para padrões de qualidade
- Estabelecimento de standards de código

**Integração com outras skills:**
- `code-refactoring-refactor-clean`: Para refatoração
- `code-review-checklist`: Para revisão
- `uncle-bob-craft`: Para princípios SOLID

**Padrões e anti-padrões:**
✅ Fazer: Nomes descritivos e expressivos
✅ Fazer: Funções pequenas e responsáveis
✅ Fazer: Comentários explicam "por quê", não "o quê"
❌ Evitar: Nomes abreviados ou genéricos
❌ Evitar: Funções longas (>20 linhas)
❌ Evitar: Código duplicado

**Dicas de performance:**
- Usar refactoring incremental
- Aplicar Extract Method/Functio
- Usar Rename para nomes melhores
- Executar testes após cada refatoração

**Comandos úteis:**
```bash
# ESLint para detecção de issues
npx eslint src/

# Prettier para formatação
npx prettier --write src/

# TypeScript strict mode
tsc --strict
```

**Referências:**
- [Clean Code by Robert C. Martin](https://www.oreilly.com/library/view/clean-code/9780136083238/)
- [Clean Code Summary](https://www.dingran.me/clean-code-summary/)
- [Refactoring Guru](https://refactoring.guru/)
- [Martin Fowler Refactoring](https://martinfowler.com/books/refactoring.html)

---

### code-review-checklist
**Descrição:** Checklist completo para revisões de código

**Quando usar:**
- Revisão abrangente de PRs
- Verificação de funcionalidade, segurança, performance
- Padronização de code review

**Exemplos práticos:**
```markdown
# Checklist de Code Review

## Funcionalidade
- [ ] O código faz o que foi especificado?
- [ ] Todos os casos de borda foram tratados?
- [ ] Erros são tratados adequadamente?
- [ ] Validação de entrada implementada?

## Segurança
- [ ] Input sanitization implementada?
- [ ] SQL injection prevenido?
- [ ] XSS prevenido?
- [ ] Autenticação e autorização verificadas?
- [ ] Dados sensíveis não expostos em logs?

## Performance
- [ ] Queries otimizadas?
- [ ] N+1 queries evitadas?
- [ ] Cache implementado quando necessário?
- [ ] Memória gerenciada adequadamente?

## Manutenibilidade
- [ ] Código é legível e compreensível?
- [ ] Funções são pequenas e responsáveis?
- [ ] Nomes são expressivos?
- [ ] Comentários explicam "por quê"?

## Testes
- [ ] Testes unitários cobrem lógica crítica?
- [ ] Testes de integração implementados?
- [ ] Edge cases testados?
- [ ] Code coverage aceitável?

## Documentação
- [ ] README atualizado?
- [ ] API documentada?
- [ ] Mudanças documentadas no CHANGELOG?
```

**Casos de uso avançados:**
- Processo de code review padronizado
- Auditoria de segurança de código
- Melhoria de qualidade de código

**Integração com outras skills:**
- `find-bugs`: Para detecção de bugs
- `comprehensive-review-full-review`: Para review completo
- `vibe-code-auditor`: Para auditoria de código AI

**Padrões e anti-padrões:**
✅ Fazer: Seguir checklist consistentemente
✅ Fazer: Comentar sugestões construtivas
✅ Fazer: Verificar testes e documentação
❌ Evitar: Apenas "looks good to me"
❌ Evitar: Ignorar partes do checklist
❌ Evitar: Review superficial

**Dicas de performance:**
- Usar ferramentas de linting automáticas
- Configurar pre-commit hooks
- Usar CI para checks automáticos
- Revisar em lotes pequenos

**Comandos úteis:**
```bash
# ESLint
npx eslint src/ --fix

# Prettier check
npx prettier --check src/

# TypeScript check
npx tsc --noEmit

# Test coverage
npm run test:coverage
```

**Referências:**
- [Google Code Review](https://google.github.io/eng-practices/review/)
- [GitHub Pull Request Reviews](https://docs.github.com/en/pull-requests/reviewing-changes-in-pull-requests)
- [Code Review Best Practices](https://www Infragistics.com/blog/best-practices-code-reviews)
- [SonarQube](https://www.sonarsource.com/products/sonarqube/)

---

### vibe-code-auditor
**Descrição:** Auditoria de código gerado rapidamente ou por AI

**Quando usar:**
- Identificação de falhas estruturais
- Análise de riscos em produção
- Validação de código gerado

**Exemplos práticos:**
```typescript
// 1. Auditoria de código AI - Identificação de problemas
const auditCode = (code: string): AuditResult => {
  const issues: Issue[] = [];
  
  // Verificar padrões problemáticos
  if (code.includes('eval(')) {
    issues.push({
      type: 'security',
      severity: 'critical',
      message: 'Uso de eval() detectado - risco de segurança',
    });
  }
  
  if (code.includes('any')) {
    issues.push({
      type: 'type-safety',
      severity: 'medium',
      message: 'Uso de tipo any - perda de type safety',
    });
  }
  
  if (code.includes('console.log')) {
    issues.push({
      type: 'code-quality',
      severity: 'low',
      message: 'console.log em código de produção',
    });
  }
  
  return { issues, score: calculateScore(issues) };
};

// 2. Verificação de dependências
const auditDependencies = (packageJson: any): DependencyAudit => {
  const vulnerabilities: Vulnerability[] = [];
  
  // Verificar dependências desatualizadas
  Object.entries(packageJson.dependencies || {}).forEach(([pkg, version]) => {
    if (isOutdated(pkg, version)) {
      vulnerabilities.push({
        package: pkg,
        currentVersion: version as string,
        latestVersion: getLatestVersion(pkg),
        severity: 'medium',
      });
    }
  });
  
  return { vulnerabilities };
};

// 3. Análise de complexidade
const analyzeComplexity = (code: string): ComplexityAnalysis => {
  const cyclomaticComplexity = calculateCyclomaticComplexity(code);
  const cognitiveComplexity = calculateCognitiveComplexity(code);
  
  return {
    cyclomaticComplexity,
    cognitiveComplexity,
    recommendation: getRecommendation(cyclomaticComplexity),
  };
};
```

**Casos de uso avançados:**
- Auditoria de código gerado por Copilot/Claude
- Validação de código em pull requests
- Análise de tech debt

**Integração com outras skills:**
- `find-bugs`: Para detecção de bugs
- `comprehensive-review-full-review`: Para review completo
- `codebase-cleanup-tech-debt`: Para tech debt

**Padrões e anti-padrões:**
✅ Fazer: Verificar padrões de segurança
✅ Fazer: Analisar complexidade ciclomática
✅ Fazer: Verificar dependências vulneráveis
❌ Evitar: Confiar cegamente em código AI
❌ Evitar: Ignorar warnings de linting
❌ Evitar: Não testar código gerado

**Dicas de performance:**
- Usar ferramentas de análise estática
- Configurar CI com checks automáticos
- Usar SonarQube para análise contínua
- Implementar pre-commit hooks

**Comandos úteis:**
```bash
# SonarQube scanner
sonar-scanner -Dsonar.projectKey=my-project

# ESLint com regras customizadas
npx eslint src/ --config .eslintrc.audit.js

# npm audit
npm audit

# Snyk
snyk test
```

**Referências:**
- [SonarQube](https://www.sonarsource.com/products/sonarqube/)
- [ESLint Security Plugin](https://github.com/nodesecurity/eslint-plugin-security)
- [Snyk](https://snyk.io/)
- [CodeClimate](https://codeclimate.com/)

---

<a name="media"></a>
## 5. Media (10 skills)

### stability-ai
**Descrição:** Geração de imagens via Stability AI (SD3.5, Ultra, Core)

**Quando usar:**
- Text-to-image para criação de imagens
- img2img para edição de imagens
- Inpainting e upscale

**Exemplos práticos:**
```python
# 1. Geração de imagem com Stability AI
import requests
import base64

def generate_image(prompt, api_key):
    response = requests.post(
        "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image",
        headers={
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
        },
        json={
            "text_prompts": [{"text": prompt}],
            "cfg_scale": 7,
            "height": 1024,
            "width": 1024,
            "samples": 1,
            "steps": 30,
        },
    )
    
    data = response.json()
    image_data = base64.b64decode(data["artifacts"][0]["base64"])
    
    with open("generated_image.png", "wb") as f:
        f.write(image_data)

# 2. img2img - Edição de imagem
def edit_image(prompt, image_path, api_key):
    with open(image_path, "rb") as f:
        image_data = base64.b64encode(f.read()).decode()
    
    response = requests.post(
        "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/image-to-image",
        headers={
            "Authorization": f"Bearer {api_key}",
        },
        files={
            "init_image": ("image.png", base64.b64decode(image_data), "image/png"),
        },
        data={
            "text_prompts[0][text]": prompt,
            "image_strength": 0.35,
        },
    )
    
    return response.json()

# 3. Inpainting - Preenchimento de áreas
def inpaint_image(prompt, image_path, mask_path, api_key):
    with open(image_path, "rb") as f:
        image_data = base64.b64encode(f.read()).decode()
    
    with open(mask_path, "rb") as f:
        mask_data = base64.b64encode(f.read()).decode()
    
    response = requests.post(
        "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/inpainting",
        headers={
            "Authorization": f"Bearer {api_key}",
        },
        files={
            "image": ("image.png", base64.b64decode(image_data), "image/png"),
            "mask": ("mask.png", base64.b64decode(mask_data), "image/png"),
        },
        data={
            "text_prompts[0][text]": prompt,
        },
    )
    
    return response.json()
```

**Casos de uso avançados:**
- Geração de assets para jogos
- Criação de conteúdo para marketing
- Edição de fotos profissional

**Integração com outras skills:**
- `image-generator`: Para geração com Gemini
- `image-studio`: Para rototeamento inteligente
- `algorithmic-art`: Para arte generativa

**Padrões e anti-padrões:**
✅ Fazer: Usar prompts detalhados e específicos
✅ Fazer: Experimentar diferentes parâmetros
✅ Fazer: Usar referências para consistência
❌ Evitar: Prompts vagos ou genéricos
❌ Evitar: Ignorar aspect ratio adequado
❌ Evitar: Não testar variações

**Dicas de performance:**
- Usar cache para prompts bem-sucedidos
- Implementar filas para geração em lote
- Usar resolução adequada para o uso
- Otimizar parâmetros para qualidade/velocidade

**Comandos úteis:**
```bash
# Instalar SDK
pip install stability-sdk

# Gerar imagem
python generate.py --prompt "a beautiful sunset" --width 1024 --height 1024

# API REST
curl -X POST "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"text_prompts": [{"text": "a beautiful sunset"}]}'
```

**Referências:**
- [Stability AI Documentation](https://platform.stability.ai/docs)
- [Stable Diffusion XL](https://stability.ai/stable-image)
- [Stability AI API](https://platform.stability.ai/api-reference)
- [Stability AI GitHub](https://github.com/Stability-AI)

---

### remotion
**Descrição:** Geração de vídeos walkthrough a partir de projetos Stitch

**Quando usar:**
- Criação de vídeos programáticos em React
- Transições suaves e animações
- Sobreposições de texto e elementos

**Exemplos práticos:**
```tsx
// 1. Vídeo básico com Remotion
import { Composition } from 'remotion';
import { MyVideo } from './MyVideo';

export const RemotionRoot: React.FC = () => {
  return (
    <>
      <Composition
        id="MyVideo"
        component={MyVideo}
        durationInFrames={150}
        fps={30}
        width={1920}
        height={1080}
      />
    </>
  );
};

// 2. Componente de vídeo com animação
import { useCurrentFrame, useVideoConfig, interpolate, spring } from 'remotion';

export const MyVideo: React.FC = () => {
  const frame = useCurrentFrame();
  const { fps, width, height } = useVideoConfig();
  
  const opacity = interpolate(frame, [0, 30], [0, 1]);
  const scale = spring({
    frame,
    fps,
    config: {
      damping: 10,
      stiffness: 200,
    },
  });
  
  return (
    <div style={{
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: '#000',
    }}>
      <h1 style={{
        opacity,
        transform: `scale(${scale})`,
        color: '#fff',
        fontSize: 72,
      }}>
        Hello World
      </h1>
    </div>
  );
};

// 3. Sequência de cenas
import { Sequence, AbsoluteFill } from 'remotion';

export const VideoWithScenes: React.FC = () => {
  return (
    <AbsoluteFill>
      <Sequence from={0} durationInFrames={90}>
        <Scene1 />
      </Sequence>
      <Sequence from={90} durationInFrames={90}>
        <Scene2 />
      </Sequence>
      <Sequence from={180} durationInFrames={90}>
        <Scene3 />
      </Sequence>
    </AbsoluteFill>
  );
};
```

**Casos de uso avançados:**
- Vídeos de tutorial automatizados
- Anúncios dinâmicos personalizados
- Relatórios em vídeo

**Integração com outras skills:**
- `remotion-best-practices`: Para melhores práticas
- `video-content-extractor`: Para extração de conteúdo
- `youtube-notetaker`: Para notas de estudo

**Padrões e anti-padrões:**
✅ Fazer: Usar componentes React reutilizáveis
✅ Fazer: Implementar animações com spring
✅ Fazer: Usar Sequence para cenas
❌ Evitar: Animações frame-by-frame complexas
❌ Evitar: Ignorar performance de renderização
❌ Evitar: Não testar em diferentes resoluções

**Dicas de performance:**
- Usar memoização para componentes estáticos
- Limitar número de camadas
- Usar imagens otimizadas
- Configurar concurrency para renderização

**Comandos úteis:**
```bash
# Instalar Remotion
npx create-video@latest

# Preview do vídeo
npx remotion preview

# Renderizar vídeo
npx remotion render MyVideo out/video.mp4

# Renderizar frame específico
npx remotion still MyVideo --frame=0 out/frame.png
```

**Referências:**
- [Remotion Documentation](https://www.remotion.dev/)
- [Remotion GitHub](https://github.com/remotion-dev/remotion)
- [Remotion Examples](https://www.remotion.dev/docs)
- [Remotion Templates](https://www.remotion.dev/templates)

---

<a name="voice-agents"></a>
## 6. Voice Agents (5 skills)

### voice-ai-development
**Descrição:** Expertise em aplicações de voz AI (OpenAI Realtime, Vapi, Deepgram, ElevenLabs)

**Quando usar:**
- Agentes de voz em tempo real
- Conversão de texto em fala
- Transcrição de áudio

**Exemplos práticos:**
```typescript
// 1. Agente de voz com OpenAI Realtime API
import WebSocket from 'ws';

const openai = new WebSocket('wss://api.openai.com/v1/realtime?model=gpt-4o-realtime-preview', {
  headers: {
    'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
    'OpenAI-Beta': 'realtime=v1',
  },
});

openai.on('open', () => {
  openai.send(JSON.stringify({
    type: 'session.update',
    session: {
      modalities: ['text', 'audio'],
      voice: 'alloy',
      instructions: 'Você é um assistente útil.',
    },
  }));
});

openai.on('message', (data) => {
  const event = JSON.parse(data.toString());
  
  if (event.type === 'response.audio.delta') {
    // Processar áudio recebido
    const audioChunk = Buffer.from(event.delta, 'base64');
    playAudio(audioChunk);
  }
});

// 2. Transcrição com Deepgram
import { createClient } from '@deepgram/sdk';

const deepgram = createClient(process.env.DEEPGRAM_API_KEY);

const transcribeAudio = async (audioBuffer: Buffer) => {
  const { result, error } = await deepgram.listen.prerecorded.transcribeFile(
    audioBuffer,
    {
      language: 'pt',
      model: 'nova-2',
      smart_format: true,
    }
  );
  
  if (error) throw error;
  return result.results.channels[0].alternatives[0].transcript;
};

// 3. Text-to-Speech com ElevenLabs
import { ElevenLabs } from 'elevenlabs';

const elevenlabs = new ElevenLabs({
  apiKey: process.env.ELEVENLABS_API_KEY,
});

const textToSpeech = async (text: string, voiceId: string) => {
  const audio = await elevenlabs.generate({
    voice: voiceId,
    text: text,
    model: 'eleven_multilingual_v2',
  });
  
  return audio;
};
```

**Casos de uso avançados:**
- Assistente de voz para atendimento ao cliente
- Sistema de transcrição em tempo real
- Geração de conteúdo de áudio

**Integração com outras skills:**
- `audio-transcriber`: Para transcrição de áudio
- `fal-audio`: Para processamento de áudio
- `pipecat-friday-agent`: Para assistentes de voz

**Padrões e anti-padrões:**
✅ Fazer: Usar streaming para áudio em tempo real
✅ Fazer: Implementar silence detection
✅ Fazer: Usar modelos multilíngues
❌ Evitar: Enviar áudio sem compressão
❌ Evitar: Ignorar latência de rede
❌ Evitar: Não testar em diferentes ambientes

**Dicas de performance:**
- Usar WebSocket para comunicação em tempo real
- Implementar buffer de áudio adequado
- Usar codecs de áudio eficientes
- Configurar VAD (Voice Activity Detection)

**Comandos úteis:**
```bash
# Instalar dependências
npm install ws @deepgram/sdk elevenlabs

# Testar transcrição
curl -X POST "https://api.deepgram.com/v1/listen" \
  -H "Authorization: Token $DEEPGRAM_API_KEY" \
  -H "Content-Type: audio/wav" \
  --data-binary @audio.wav
```

**Referências:**
- [OpenAI Realtime API](https://platform.openai.com/docs/guides/realtime)
- [Deepgram Documentation](https://developers.deepgram.com/)
- [ElevenLabs API](https://elevenlabs.io/docs)
- [Vapi](https://docs.vapi.ai/)

---

<a name="browser-automation"></a>
## 7. Browser Automation (3 skills)

### skyvern-browser-automation
**Descrição:** Automação de browser com IA para navegação, preenchimento e extração

**Quando usar:**
- Fluxos de trabalho reutilizáveis de automação web
- Extração de dados de sites complexos
- Automação de processos manuais

**Exemplos práticos:**
```python
# 1. Automação com Skyvern
from skyvern import Skyvern

async def automate_form():
    skyvern = Skyvern(api_key="your-api-key")
    
    # Criar workflow
    workflow = await skyvern.workflows.create(
        name="Form Filling",
        steps=[
            {
                "type": "navigation",
                "url": "https://example.com/form",
            },
            {
                "type": "action",
                "action": "fill",
                "selector": "#email",
                "value": "user@example.com",
            },
            {
                "type": "action",
                "action": "fill",
                "selector": "#password",
                "value": "password123",
            },
            {
                "type": "action",
                "action": "click",
                "selector": "button[type='submit']",
            },
        ],
    )
    
    # Executar workflow
    result = await skyvern.workflows.execute(workflow.id)
    return result

# 2. Extração de dados
async def extract_data(url):
    skyvern = Skyvern(api_key="your-api-key")
    
    # Criar task de extração
    task = await skyvern.tasks.create(
        url=url,
        extraction_schema={
            "type": "object",
            "properties": {
                "title": {"type": "string"},
                "price": {"type": "number"},
                "description": {"type": "string"},
            },
        },
    )
    
    # Executar task
    result = await skyvern.tasks.execute(task.id)
    return result.data

# 3. Automação com autenticação
async def authenticated_automation():
    skyvern = Skyvern(api_key="your-api-key")
    
    # Login primeiro
    await skyvern.workflows.execute(
        workflow_id="login_workflow",
        parameters={
            "username": "user@example.com",
            "password": "password123",
        },
    )
    
    # Depois executar ação protegida
    result = await skyvern.workflows.execute(
        workflow_id="protected_action_workflow",
    )
    
    return result
```

**Casos de uso avançados:**
- Automação de testes E2E
- Scraping de sites dinâmicos
- Processos de negócio automatizados

**Integração com outras skills:**
- `browser-act`: Para automação autenticada
- `browser-harness`: Para controle de browser
- `research-category-pointer`: Para pesquisa web

**Padrões e anti-padrões:**
✅ Fazer: Usar seletores robustos (data-testid)
✅ Fazer: Implementar retry para falhas
✅ Fazer: Usar waits explícitos
❌ Evitar: Hardcoded de delays
❌ Evitar: Ignorar tratamento de erros
❌ Evitar: Não testar em diferentes browsers

**Dicas de performance:**
- Usar headless mode para velocidade
- Implementar cache de navegação
- Usar parallel execution para múltiplas tasks
- Configurar timeout adequado

**Comandos úteis:**
```bash
# Instalar Skyvern
pip install skyvern

# Executar workflow
skyvern run workflow --id workflow_id

# Ver logs
skyvern logs --task-id task_id
```

**Referências:**
- [Skyvern Documentation](https://docs.skyvern.com/)
- [Skyvern GitHub](https://github.com/Skyvern-AI/skyvern)
- [Skyvern API](https://docs.skyvern.com/api)
- [Browser Automation Guide](https://docs.skyvern.com/guides/browser-automation)

---

<a name="game-development"></a>
## 8. Game Development (18 skills)

### unity-developer
**Descrição:** Desenvolvimento Unity com C# otimizado, rendering, assets

**Quando usar:**
- Unity 6 LTS com URP/HDRP
- Deploy cross-platform
- Otimização de performance

**Exemplos práticos:**
```csharp
// 1. Player Controller com input system
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour
{
    [SerializeField] private float moveSpeed = 5f;
    [SerializeField] private float jumpForce = 10f;
    
    private Rigidbody2D rb;
    private bool isGrounded;
    
    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
    }
    
    public void OnMove(InputAction.CallbackContext context)
    {
        Vector2 moveInput = context.ReadValue<Vector2>();
        rb.velocity = new Vector2(moveInput.x * moveSpeed, rb.velocity.y);
    }
    
    public void OnJump(InputAction.CallbackContext context)
    {
        if (context.performed && isGrounded)
        {
            rb.AddForce(Vector2.up * jumpForce, ForceMode2D.Impulse);
        }
    }
    
    void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Ground"))
        {
            isGrounded = true;
        }
    }
    
    void OnCollisionExit2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Ground"))
        {
            isGrounded = false;
        }
    }
}

// 2. Object Pooling para performance
public class ObjectPool : MonoBehaviour
{
    [SerializeField] private GameObject prefab;
    [SerializeField] private int poolSize = 10;
    
    private Queue<GameObject> pool = new Queue<GameObject>();
    
    void Start()
    {
        for (int i = 0; i < poolSize; i++)
        {
            GameObject obj = Instantiate(prefab);
            obj.SetActive(false);
            pool.Enqueue(obj);
        }
    }
    
    public GameObject GetObject()
    {
        if (pool.Count > 0)
        {
            GameObject obj = pool.Dequeue();
            obj.SetActive(true);
            return obj;
        }
        return Instantiate(prefab);
    }
    
    public void ReturnObject(GameObject obj)
    {
        obj.SetActive(false);
        pool.Enqueue(obj);
    }
}

// 3. Save System
[System.Serializable]
public class SaveData
{
    public int score;
    public int level;
    public Vector3 playerPosition;
}

public class SaveSystem
{
    public static void Save(SaveData data)
    {
        string json = JsonUtility.ToJson(data);
        PlayerPrefs.SetString("SaveData", json);
    }
    
    public static SaveData Load()
    {
        string json = PlayerPrefs.GetString("SaveData");
        return JsonUtility.FromJson<SaveData>(json);
    }
}
```

**Casos de uso avançados:**
- Jogo mobile com monetização
- Jogo multiplayer online
- Realidade virtual com Unity XR

**Integração com outras skills:**
- `unity-ecs-patterns`: Para performance com DOTS
- `unity-ai-game-creator`: Para geração com IA
- `vr-ar`: Para realidade virtual

**Padrões e anti-padrões:**
✅ Fazer: Usar ScriptableObjects para dados
✅ Fazer: Implementar Object Pooling
✅ Fazer: Usar Addressables para assets
❌ Evitar: Find() em Update()
❌ Evitar: Alocações em Update()
❌ Evitar: Ignorar profiling

**Dicas de performance:**
- Usar Burst Compiler para código crítico
- Implementar LOD para modelos 3D
- Usar GPU Instancing para objetos repetidos
- Otimizar draw calls

**Comandos úteis:**
```bash
# Criar projeto Unity
unity -createProject MyGame

# Build para Android
unity -batchmode -quit -projectPath . -executeMethod BuildScript.BuildAndroid

# Rodar testes
unity -runTests -testPlatform EditMode
```

**Referências:**
- [Unity Documentation](https://docs.unity3d.com/)
- [Unity Learn](https://learn.unity.com/)
- [Unity Asset Store](https://assetstore.unity.com/)
- [Unity Performance](https://docs.unity3d.com/Manual/performance.html)

---

<a name="blockchain"></a>
## 9. Blockchain (7 skills)

### blockchain-developer
**Descrição:** Aplicações Web3, smart contracts, sistemas descentralizados

**Quando usar:**
- Smart contracts com Solidity
- DeFi, NFTs, DAOs
- Integração com wallets Web3

**Exemplos práticos:**
```solidity
// 1. Smart Contract ERC-20
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }
    
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount * 10 ** decimals());
    }
}

// 2. NFT Contract
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    uint256 private _tokenIds;
    
    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {}
    
    function mint(address to) public onlyOwner returns (uint256) {
        _tokenIds++;
        _safeMint(to, _tokenIds);
        return _tokenIds;
    }
}

// 3. DeFi Staking Contract
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Staking is ReentrancyGuard {
    IERC20 public stakingToken;
    IERC20 public rewardToken;
    
    mapping(address => uint256) public stakedBalance;
    mapping(address => uint256) public rewardBalance;
    
    uint256 public rewardRate = 10; // 10% APY
    
    function stake(uint256 amount) external nonReentrant {
        stakingToken.transferFrom(msg.sender, address(this), amount);
        stakedBalance[msg.sender] += amount;
    }
    
    function unstake(uint256 amount) external nonReentrant {
        require(stakedBalance[msg.sender] >= amount, "Insufficient balance");
        stakedBalance[msg.sender] -= amount;
        stakingToken.transfer(msg.sender, amount);
    }
    
    function claimRewards() external nonReentrant {
        uint256 reward = rewardBalance[msg.sender];
        rewardBalance[msg.sender] = 0;
        rewardToken.transfer(msg.sender, reward);
    }
}
```

**Casos de uso avançados:**
- DEX (Decentralized Exchange)
- DAO com governança on-chain
- Marketplace de NFTs

**Integração com outras skills:**
- `web3-testing`: Para testes de contratos
- `defi-protocol-templates`: Para protocolos DeFi
- `crypto-bd-agent`: Para listagem em exchanges

**Padrões e anti-padrões:**
✅ Fazer: Usar OpenZeppelin para padrões
✅ Fazer: Implementar ReentrancyGuard
✅ Fazer: Usar eventos para logging
❌ Evitar: Reentrancy vulnerabilities
❌ Evitar: Ignorar gas optimization
❌ Evitar: Hardcoded de endereços

**Dicas de performance:**
- Usar Solidity 0.8+ para overflow protection
- Otimizar storage slots
- Usar events ao invés de storage para logs
- Implementar batch operations

**Comandos úteis:**
```bash
# Instalar Hardhat
npm install --save-dev hardhat

# Compilar contratos
npx hardhat compile

# Rodar testes
npx hardhat test

# Deploy para testnet
npx hardhat run scripts/deploy.js --network sepolia

# Verificar contrato
npx hardhat verify --network sepolia CONTRACT_ADDRESS
```

**Referências:**
- [Solidity Documentation](https://docs.soliditylang.org/)
- [Hardhat Documentation](https://hardhat.org/docs)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/)
- [Ethereum Development](https://ethereum.org/en/developers/)

---

<a name="health"></a>
## 10. Health (17 skills)

### fitness-analyzer
**Descrição:** Análise de dados de exercício e padrões fitness

**Quando usar:**
- Avaliação de progresso de treino
- Sugestões de exercícios personalizados
- Correlação entre exercício e saúde

**Exemplos práticos:**
```python
# 1. Análise de dados de exercício
import pandas as pd
import matplotlib.pyplot as plt

def analyze_fitness_data(data_file):
    # Carregar dados
    df = pd.read_csv(data_file)
    
    # Métricas básicas
    metrics = {
        'total_workouts': len(df),
        'avg_duration': df['duration_minutes'].mean(),
        'avg_calories': df['calories_burned'].mean(),
        'total_distance': df['distance_km'].sum(),
    }
    
    # Análise por tipo de exercício
    exercise_types = df.groupby('exercise_type').agg({
        'duration_minutes': 'mean',
        'calories_burned': 'mean',
        'heart_rate_avg': 'mean',
    }).round(2)
    
    # Gráfico de progresso
    plt.figure(figsize=(12, 6))
    plt.plot(df['date'], df['calories_burned'])
    plt.title('Calorias Queimadas ao Longo do Tempo')
    plt.xlabel('Data')
    plt.ylabel('Calorias')
    plt.savefig('fitness_progress.png')
    
    return {
        'metrics': metrics,
        'exercise_analysis': exercise_types,
        'chart': 'fitness_progress.png',
    }

# 2. Sugestões de treino
def suggest_workout(fitness_level, goals, available_time):
    workouts = {
        'beginner': {
            'cardio': ['Caminhada', 'Ciclismo leve', 'Natação'],
            'strength': ['Exercícios com peso corporal', 'Halteres leves'],
        },
        'intermediate': {
            'cardio': ['Corrida', 'HIIT', 'Ciclismo'],
            'strength': ['Treino split', 'Progressive overload'],
        },
        'advanced': {
            'cardio': ['Sprint intervalado', 'Trail running'],
            'strength': ['Powerlifting', 'Olympic lifting'],
        },
    }
    
    suggestions = []
    for category, exercises in workouts[fitness_level].items():
        for exercise in exercises:
            suggestions.append({
                'type': category,
                'name': exercise,
                'estimated_time': available_time // len(exercises),
            })
    
    return suggestions

# 3. Correlação com saúde
def analyze_health_correlation(fitness_data, health_data):
    merged = pd.merge(fitness_data, health_data, on='date')
    
    correlations = {
        'exercise_vs_sleep': merged['exercise_duration'].corr(merged['sleep_hours']),
        'exercise_vs_mood': merged['exercise_duration'].corr(merged['mood_score']),
        'exercise_vs_weight': merged['exercise_duration'].corr(merged['weight']),
    }
    
    return correlations
```

**Casos de uso avançados:**
- App de fitness personalizado
- Análise de performance atlética
- Integração com wearables

**Integração com outras skills:**
- `nutrition-analyzer`: Para correlação com dieta
- `sleep-analyzer`: Para correlação com sono
- `health-trend-analyzer`: Para tendências de saúde

**Padrões e anti-padrões:**
✅ Fazer: Coletar dados de múltiplas fontes
✅ Fazer: Análise longitudinal
✅ Fazer: Considerar fatores externos
❌ Evitar: Conclusões sem dados suficientes
❌ Evitar: Ignorar individualidade
❌ Evitar: Sobrecarga de dados

**Dicas de performance:**
- Usar batch processing para dados grandes
- Implementar cache de cálculos
- Usar Sampling para análise preliminar
- Configurar alertas automáticos

**Comandos úteis:**
```bash
# Instalar dependências
pip install pandas matplotlib seaborn

# Análise básica
python analyze_fitness.py --input data.csv --output report.pdf

# Dashboard
python dashboard.py --port 8080
```

**Referências:**
- [Pandas Documentation](https://pandas.pydata.org/docs/)
- [Matplotlib Documentation](https://matplotlib.org/stable/contents.html)
- [Fitness Data Analysis](https://www.kaggle.com/datasets/fitness-data)
- [Health Metrics Guide](https://www.who.int/data/gho)

---

<a name="education"></a>
## 11. Education (5 skills)

### learn
**Descrição:** Tutoria adaptativa, planejamento de aulas, prática

**Quando usar:**
- Quando o usuário quer aprender, praticar ou revisar
- Personalização de ritmo de aprendizado
- Feedback imediato e adaptativo

**Exemplos práticos:**
```python
# 1. Sistema de tutoria adaptativa
class AdaptiveTutor:
    def __init__(self, student_profile):
        self.student = student_profile
        self.knowledge_state = {}
        
    def assess_level(self, topic):
        """Avalia nível do aluno em um tópico"""
        questions = self.generate_questions(topic)
        score = self.evaluate_answers(questions)
        
        if score >= 0.8:
            return 'advanced'
        elif score >= 0.5:
            return 'intermediate'
        else:
            return 'beginner'
    
    def generate_lesson(self, topic, level):
        """Gera aula personalizada"""
        lesson_plan = {
            'objectives': self.define_objectives(topic, level),
            'content': self.select_content(topic, level),
            'exercises': self.generate_exercises(topic, level),
            'assessment': self.create_assessment(topic, level),
        }
        return lesson_plan
    
    def provide_feedback(self, answer, correct_answer):
        """Fornece feedback adaptativo"""
        if answer == correct_answer:
            return {
                'correct': True,
                'message': 'Parabéns! Você acertou!',
                'next_step': 'Próximo tópico',
            }
        else:
            return {
                'correct': False,
                'message': f'Não foi dessa vez. A resposta correta é: {correct_answer}',
                'hint': self.generate_hint(answer, correct_answer),
                'practice': self.suggest_practice(answer, correct_answer),
            }

# 2. Planejamento de aulas
def create_lesson_plan(topic, duration, objectives):
    """Cria plano de aula estruturado"""
    lesson = {
        'topic': topic,
        'duration': duration,
        'warmup': {
            'activity': 'Revisão rápida',
            'time': 5,
        },
        'main_content': {
            'introduction': 'Apresentação do conceito',
            'development': 'Explicação detalhada com exemplos',
            'practice': 'Exercícios guiados',
            'time': duration - 15,
        },
        'closure': {
            'summary': 'Resumo dos pontos principais',
            'assessment': 'Avaliação rápida',
            'homework': 'Tarefa para casa',
            'time': 10,
        },
        'objectives': objectives,
    }
    return lesson

# 3. Sistema de prática
class PracticeSystem:
    def __init__(self):
        self.exercises = []
        self.progress = {}
    
    def generate_exercises(self, topic, difficulty, count=5):
        """Gera exercícios adaptativos"""
        exercises = []
        for i in range(count):
            exercise = {
                'id': f'{topic}_{difficulty}_{i}',
                'question': self.create_question(topic, difficulty),
                'options': self.generate_options(topic, difficulty),
                'correct': self.get_correct_answer(topic, difficulty),
                'explanation': self.provide_explanation(topic, difficulty),
            }
            exercises.append(exercise)
        return exercises
    
    def evaluate_progress(self, student_id):
        """Avalia progresso do aluno"""
        if student_id not in self.progress:
            return {'status': 'new_student'}
        
        student_progress = self.progress[student_id]
        return {
            'topics_completed': len(student_progress['completed']),
            'average_score': sum(student_progress['scores']) / len(student_progress['scores']),
            'strengths': self.identify_strengths(student_progress),
            'weaknesses': self.identify_weaknesses(student_progress),
        }
```

**Casos de uso avançados:**
- Plataforma de e-learning personalizada
- Tutor para programação
- Sistema de revisão espaçada

**Integração com outras skills:**
- `teach`: Para instrução direta
- `lesson-generator`: Para geração de conteúdo
- `examprep-ai`: Para preparação para provas

**Padrões e anti-padrões:**
✅ Fazer: Adaptar ao ritmo do aluno
✅ Fazer: Fornecer feedback imediato
✅ Fazer: Usar spaced repetition
❌ Evitar: Informação overload
❌ Evitar: Feedback genérico
❌ Evitar: Ignorar diferentes estilos de aprendizado

**Dicas de performance:**
- Usar machine learning para personalização
- Implementar gamificação
- Usar analytics para melhorar conteúdo
- Criar comunidades de aprendizado

**Comandos úteis:**
```bash
# Instalar dependências
pip install numpy pandas scikit-learn

# Treinar modelo de adaptação
python train_model.py --data student_data.csv

# Gerar relatório
python generate_report.py --student student_id
```

**Referências:**
- [Adaptive Learning](https://www.educationaltechnologyjournal.com/)
- [Spaced Repetition](https://ncase.me/remember/)
- [Learning Science](https://www.learningscientists.org/)
- [Educational Psychology](https://www.apa.org/educational)

---

<a name="legal"></a>
## 12. Legal (8 skills)

### legal-advisor
**Descrição:** Criação de políticas de privacidade, termos de uso, disclaimers

**Quando usar:**
- Textos GDPR-compliant
- Políticas de cookies
- Termos de uso e privacidade

**Exemplos práticos:**
```markdown
# 1. Política de Privacidade GDPR

## Dados Pessoais Coletados
- Nome completo
- Email
- Dados de uso do serviço

## Finalidade do Tratamento
- Prestação do serviço contratado
- Comunicações de marketing (com consentimento)
- Melhoria do produto

## Base Legal
- Consentimento do titular (Art. 6, I)
- Execução de contrato (Art. 6, V)

## Direitos do Titular
- Acesso aos dados
- Correção de dados incompletos
- Eliminação dos dados
- Portabilidade dos dados

## Retenção dos Dados
- Dados de conta: durante a vigência do contrato
- Dados de uso: 12 meses após último acesso
- Dados de marketing: até revogação do consentimento

## Segurança dos Dados
- Criptografia em trânsito e repouso
- Controle de acesso baseado em função
- Auditorias periódicas

## Contato
- Encarregado de Dados: dpo@empresa.com
```

```javascript
// 2. Implementação de Consent Management
class ConsentManager {
  constructor() {
    this.consentTypes = ['analytics', 'marketing', 'functional'];
  }
  
  async getConsent(userId) {
    const consent = await db.consent.findOne({ userId });
    return consent || this.getDefaultConsent();
  }
  
  async updateConsent(userId, consentData) {
    await db.consent.updateOne(
      { userId },
      {
        $set: {
          ...consentData,
          updatedAt: new Date(),
          version: this.getCurrentVersion(),
        },
      },
      { upsert: true }
    );
  }
  
  async revokeConsent(userId, consentType) {
    await db.consent.updateOne(
      { userId },
      {
        $set: {
          [`consent.${consentType}`]: false,
          updatedAt: new Date(),
        },
      }
    );
  }
  
  getDefaultConsent() {
    return {
      analytics: false,
      marketing: false,
      functional: true, // Sempre ativo
    };
  }
}

// 3. Handler de Direitos do Titário
class DataSubjectRights {
  async handleAccessRequest(userId) {
    const userData = await this.collectAllUserData(userId);
    return this.formatDataForExport(userData);
  }
  
  async handleDeletionRequest(userId) {
    await this.deleteUserData(userId);
    await this.logDeletion(userId);
    return { success: true, deletedAt: new Date() };
  }
  
  async handlePortabilityRequest(userId) {
    const data = await this.collectAllUserData(userId);
    return {
      format: 'JSON',
      data: data,
      exportedAt: new Date(),
    };
  }
  
  async collectAllUserData(userId) {
    const user = await db.user.findById(userId);
    const activities = await db.activity.find({ userId });
    const preferences = await db.preferences.findOne({ userId });
    
    return { user, activities, preferences };
  }
}
```

**Casos de uso avançados:**
- Compliance com LGPD (Brasil)
- Multi-jurisdição (GDPR + CCPA)
- Auditoria de dados

**Integração com outras skills:**
- `lex`: Para análise legal multi-jurisdição
- `advogado-especialista`: Para consultoria jurídica
- `fda-medtech-compliance-auditor`: Para compliance regulatório

**Padrões e anti-padrões:**
✅ Fazer: Usar linguagem clara e acessível
✅ Fazer: Atualizar políticas regularmente
✅ Fazer: Manter registro de consentimentos
❌ Evitar: Textos genéricos sem personalização
❌ Evitar: Ignorar jurisdictions específicas
❌ Evitar: Não oferecer mecanismo de opt-out

**Dicas de performance:**
- Usar templates base para diferentes jurisdictions
- Implementar versionamento de políticas
- Usar analytics para entender uso de dados
- Criar dashboards de compliance

**Comandos úteis:**
```bash
# Verificar compliance
npm run gdpr-check

# Gerar relatório de dados
python generate_data_report.py --user user_id

# Exportar dados do usuário
python export_user_data.py --user user_id --format json
```

**Referências:**
- [GDPR Official Text](https://gdpr-info.eu/)
- [LGPD Brasil](https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm)
- [CCPA](https://oag.ca.gov/privacy/ccpa)
- [Privacy Policy Generator](https://www.privacypolicygenerator.info/)

---

<a name="finance"></a>
## 13. Finance (2 skills)

### longbridge
**Descrição:** 125+ skills para Longbridge Securities (cotações, gráficos, fundamentos)

**Quando usar:**
- Mercados HK/US/A-share/SG
- Análise técnica e fundamental
- Opções e portfólio

**Exemplos práticos:**
```python
# 1. Cotações em tempo real
from longbridge import QuoteContext, SubType

def get_realtime_quotes(symbols):
    ctx = QuoteContext(token="your_token")
    
    quotes = ctx.quote(symbols)
    for quote in quotes:
        print(f"{quote.symbol}: {quote.last_done} {quote.currency}")
    
    return quotes

# 2. Análise técnica
def technical_analysis(symbol):
    ctx = QuoteContext(token="your_token")
    
    # Candlesticks
    candles = ctx.candlesticks(
        symbol=symbol,
        period=Period.Day,
        count=30,
    )
    
    # Médias móveis
    closes = [c.close for c in candles]
    ma20 = sum(closes[-20:]) / 20
    ma50 = sum(closes[-50:]) / 50
    
    return {
        'current_price': closes[-1],
        'ma20': ma20,
        'ma50': ma50,
        'trend': 'bullish' if ma20 > ma50 else 'bearish',
    }

# 3. Opções
def analyze_options(symbol):
    ctx = QuoteContext(token="your_token")
    
    # Chain de opções
    chain = ctx.option_chain(symbol)
    
    calls = [c for c in chain if c.option_type == 'call']
    puts = [c for c in chain if c.option_type == 'put']
    
    # Put/Call ratio
    pc_ratio = len(puts) / len(calls) if calls else 0
    
    return {
        'calls': len(calls),
        'puts': len(puts),
        'pc_ratio': pc_ratio,
        'sentiment': 'bearish' if pc_ratio > 1 else 'bullish',
    }
```

**Casos de uso avançados:**
- Sistema de trading algorítmico
- Análise de portfólio automatizada
- Alertas de mercado personalizados

**Integração com outras skills:**
- `options-flow-analyzer`: Para análise de fluxo
- `finance-category-pointer`: Para outras skills financeiras
- `data-science-category-pointer`: Para análise de dados

**Padrões e anti-padrões:**
✅ Fazer: Validar dados antes de usar
✅ Fazer: Implementar rate limiting
✅ Fazer: Usar webhooks para dados em tempo real
❌ Evitar: Trading sem stop-loss
❌ Evitar: Ignorar custos de transação
❌ Evitar: Over-trading

**Dicas de performance:**
- Usar cache para cotações
- Implementar batch requests
- Usar WebSocket para dados em tempo real
- Configurar retry para falhas

**Comandos úteis:**
```bash
# Instalar SDK
pip install longbridge

# Obter cotações
python get_quotes.py --symbols AAPL,MSFT,GOOGL

# Análise técnica
python technical_analysis.py --symbol AAPL --period 30d
```

**Referências:**
- [Longbridge API](https://open.longbridgeapp.com/)
- [Longbridge SDK](https://github.com/longbridgeapp/python-sdk)
- [Financial Data Analysis](https://www.investopedia.com/)
- [Technical Analysis Guide](https://www.investopedia.com/terms/t/technicalanalysis.asp)

---

<a name="science"></a>
## 14. Science (10 skills)

### qiskit
**Descrição:** Framework quântico mais popular (13M+ downloads)

**Quando usar:**
- Circuitos quânticos
- IBM Quantum
- Simulação quântica

**Exemplos práticos:**
```python
# 1. Circuito quântico básico
from qiskit import QuantumCircuit, Aer, execute
from qiskit.visualization import plot_histogram

# Criar circuito
qc = QuantumCircuit(2, 2)

# Aplicar portas
qc.h(0)  # Hadamard
qc.cx(0, 1)  # CNOT

# Medir
qc.measure([0, 1], [0, 1])

# Simular
simulator = Aer.get_backend('qasm_simulator')
result = execute(qc, simulator, shots=1000).result()
counts = result.get_counts(qc)

print(counts)  # {'00': 500, '11': 500} (Bell state)

# 2. Algoritmo de Grover
from qiskit import QuantumCircuit
from qiskit.circuit.library import GroverOperator

def grovers_algorithm(n_qubits, target_state):
    qc = QuantumCircuit(n_qubits, n_qubits)
    
    # Inicialização
    qc.h(range(n_qubits))
    
    # Oracle e operador de difusão
    for _ in range(int(np.pi/4 * np.sqrt(2**n_qubits))):
        # Oracle
        qc.x(target_state)
        qc.h(n_qubits-1)
        qc.mcx(list(range(n_qubits-1)), n_qubits-1)
        qc.h(n_qubits-1)
        qc.x(target_state)
        
        # Difusão
        qc.h(range(n_qubits))
        qc.x(range(n_qubits))
        qc.h(n_qubits-1)
        qc.mcx(list(range(n_qubits-1)), n_qubits-1)
        qc.h(n_qubits-1)
        qc.x(range(n_qubits))
        qc.h(range(n_qubits))
    
    # Medição
    qc.measure(range(n_qubits), range(n_qubits))
    
    return qc

# 3. VQE (Variational Quantum Eigensolver)
from qiskit.algorithms import VQE
from qiskit.algorithms.optimizers import SPSA
from qiskit.opflow import Z, I

# Hamiltoniano
hamiltonian = (I ^ I) + (0.5 * Z ^ I) + (0.5 * I ^ Z)

# Ansatz
from qiskit.circuit.library import EfficientSU2
ansatz = EfficientSU2(num_qubits=2)

# Otimizador
optimizer = SPSA(maxiter=100)

# VQE
vqe = VQE(ansatz, optimizer)
result = vqe.compute_minimum_eigenvalue(hamiltonian)

print(f"Autovalor: {result.eigenvalue}")
```

**Casos de uso avançados:**
- Otimização combinatória
- Simulação molecular
- Machine learning quântico

**Integração com outras skills:**
- `cirq`: Para Google Quantum AI
- `astropy`: Para astronomia
- `networkx`: Para grafos

**Padrões e anti-padrões:**
✅ Fazer: Começar com simulação antes de hardware real
✅ Fazer: Otimizar circuitos para reduzir ruído
✅ Fazer: Usar transpilers para hardware específico
❌ Evitar: Circuitos muito profundos
❌ Evitar: Ignorar calibração do dispositivo
❌ Evitar: Não considerar erros de hardware

**Dicas de performance:**
- Usar simulação local para desenvolvimento
- Otimizar circuitos com transpilers
- Usar cache para cálculos repetidos
- Implementar error mitigation

**Comandos úteis:**
```bash
# Instalar Qiskit
pip install qiskit

# Instalar visualização
pip install qiskit[visualization]

# Rodar exemplo
python bell_state.py

# Simular circuito
python simulate.py --circuit circuit.qasm
```

**Referências:**
- [Qiskit Documentation](https://qiskit.org/documentation/)
- [Qiskit Textbook](https://qiskit.org/learn/)
- [IBM Quantum](https://quantum-computing.ibm.com/)
- [Qiskit GitHub](https://github.com/Qiskit/qiskit)

---

<a name="travel"></a>
## 15. Travel (1 skill)

### travel-planner
**Descrição:** Planejamento de viagens com orçamento em 3 níveis

**Quando usar:**
- Roteiro diário personalizado
- Orçamento (econômico, médio, luxo)
- Transporte e hospedagem

**Exemplos práticos:**
```python
# 1. Planejador de viagem
class TravelPlanner:
    def __init__(self, destination, duration, budget_level):
        self.destination = destination
        self.duration = duration
        self.budget_level = budget_level  # 'economy', 'standard', 'luxury'
        
    def generate_itinerary(self):
        """Gera roteiro completo"""
        itinerary = {
            'destination': self.destination,
            'duration': self.duration,
            'budget_level': self.budget_level,
            'daily_plans': [],
            'total_cost': 0,
        }
        
        for day in range(1, self.duration + 1):
            daily_plan = {
                'day': day,
                'activities': self.get_activities(day),
                'meals': self.get_meals(day),
                'accommodation': self.get_accommodation(),
                'transportation': self.get_transportation(),
                'estimated_cost': self.calculate_daily_cost(),
            }
            itinerary['daily_plans'].append(daily_plan)
            itinerary['total_cost'] += daily_plan['estimated_cost']
        
        return itinerary
    
    def get_activities(self, day):
        """Retorna atividades baseado no dia"""
        activities = {
            1: ['Check-in', 'City tour'],
            2: ['Museu', 'Restaurante local'],
            3: ['Passeio de barco', 'Shopping'],
        }
        return activities.get(day, ['Dia livre'])
    
    def get_meals(self, day):
        """Retorna refeições baseado no nível"""
        meals = {
            'economy': {'breakfast': 'Hotel', 'lunch': 'Rua', 'dinner': 'Restaurante local'},
            'standard': {'breakfast': 'Café', 'lunch': 'Restaurante', 'dinner': 'Restaurante bom'},
            'luxury': {'breakfast': 'Room service', 'lunch': 'Restaurante fino', 'dinner': 'Michelin'},
        }
        return meals[self.budget_level]
    
    def calculate_daily_cost(self):
        """Calcula custo diário"""
        costs = {
            'economy': 50,
            'standard': 150,
            'luxury': 500,
        }
        return costs[self.budget_level]

# 2. Otimização de orçamento
def optimize_budget(total_budget, days, priorities):
    """Otimiza orçamento baseado em prioridades"""
    budget_allocation = {
        'accommodation': total_budget * 0.4,
        'transportation': total_budget * 0.2,
        'food': total_budget * 0.25,
        'activities': total_budget * 0.15,
    }
    
    # Ajustar baseado em prioridades
    for priority, weight in priorities.items():
        if priority in budget_allocation:
            budget_allocation[priority] *= weight
    
    return budget_allocation

# 3. Recomendações de hospedagem
def recommend_accommodation(destination, budget_level, preferences):
    """Recomenda hospedagem"""
    accommodations = {
        'economy': ['Hostel', 'Airbnb básico', 'Hotel econômico'],
        'standard': ['Hotel 3 estrelas', 'Apartamento', 'Boutique hotel'],
        'luxury': ['Hotel 5 estrelas', 'Resort', 'Villa'],
    }
    
    recommendations = []
    for acc_type in accommodations[budget_level]:
        recommendation = {
            'type': acc_type,
            'price_range': get_price_range(acc_type),
            'rating': get_rating(acc_type),
            'amenities': get_amenities(acc_type),
        }
        recommendations.append(recommendation)
    
    return recommendations
```

**Casos de uso avançados:**
- Viagem de negócios com tempo limitado
- Viagem em família com crianças
- Backpacking com orçamento apertado

**Integração com outras skills:**
- `travel-health-analyzer`: Para saúde em viagem
- `customs-trade-compliance`: Para documentos
- `language-learning`: Para idiomas

**Padrões e anti-padrões:**
✅ Fazer: Pesquisar destinos antecipadamente
✅ Fazer: Considerar estação do ano
✅ Fazer: Ter flexibilidade no roteiro
❌ Evitar: Muitas atividades por dia
❌ Evitar: Ignorar documentação necessária
❌ Evitar: Não ter seguro de viagem

**Dicas de performance:**
- Usar APIs de viagem para dados em tempo real
- Implementar alertas de preço
- Usar mapas offline
- Criar planos de contingência

**Comandos úteis:**
```bash
# Instalar dependências
pip install requests pandas

# Planejar viagem
python travel_planner.py --destination "Tokyo" --days 7 --budget standard

# Otimizar orçamento
python optimize_budget.py --total 5000 --days 7

# Recomendar hospedagem
python recommend_accommodation.py --destination "Paris" --budget luxury
```

**Referências:**
- [Lonely Planet](https://www.lonelyplanet.com/)
- [TripAdvisor](https://www.tripadvisor.com/)
- [Google Flights](https://www.google.com/flights)
- [Booking.com](https://www.booking.com/)

---

## Resumo das Melhorias v2

| Categoria | Skills Aprimoradas | Melhorias Adicionadas |
|-----------|-------------------|----------------------|
| Mobile | 5 | Exemplos, casos de uso, integrações, padrões, performance, comandos, referências |
| API Integration | 4 | Documentação completa com exemplos e práticas |
| Framework | 3 | Padrões modernos com exemplos detalhados |
| Code Quality | 3 | Checklists e práticas de auditoria |
| Media | 2 | APIs e processamento de mídia |
| Voice Agents | 1 | Integração com múltiplas APIs |
| Browser Automation | 1 | Automação com IA |
| Game Development | 1 | Unity com C# otimizado |
| Blockchain | 1 | Smart contracts e DeFi |
| Health | 1 | Análise de fitness e correlações |
| Education | 1 | Sistemas adaptativos |
| Legal | 1 | Compliance GDPR/LGPD |
| Finance | 1 | Análise de mercado e trading |
| Science | 1 | Computação quântica |
| Travel | 1 | Planejamento personalizado |

**Total de skills aprimoradas:** 33  
**Campos adicionados por skill:** 7 (descrição, quando usar, exemplos, casos avançados, integrações, padrões, performance, comandos, referências)  
**Versão do documento:** 2.0  
**Data da atualização:** 14/09/2026

---

*Documento gerado automaticamente em 14/09/2026 - v2 Aprimorado*