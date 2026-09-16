# 🔥 FIREBASE AVANÇADO — Skills Completas

**Fonte:** https://github.com/firebase/firebase-js-sdk (26k+ stars)
**Descrição:** Firebase é a plataforma de desenvolvimento de aplicativos do Google, oferecendo backend completo como serviço (BaaS) com banco de dados em tempo real, autenticação, functions serverless, storage e muito mais.

---

## 📋 Índice de Skills

1. [Firestore — Estrutura e Modelagem](#1-firestore--estrutura-e-modelagem)
2. [Firestore — Consultas Avançadas](#2-firestore--consultas-avancadas)
3. [Firestore — Transações e Lotes](#3-firestore--transacoes-e-lotes)
4. [Authentication — Configuração Multi-Provedor](#4-authentication--configuracao-multi-provedor)
5. [Authentication — Custom Claims e Tokens](#5-authentication--custom-claims-e-tokens)
6. [Cloud Functions — Triggers e Eventos](#6-cloud-functions--triggers-e-eventos)
7. [Cloud Functions — HTTP Functions e Middleware](#7-cloud-functions--http-functions-e-middleware)
8. [Cloud Storage — Upload e Downloads](#8-cloud-storage--uploads-e-downloads)
9. [Security Rules — Regras Avançadas](#9-security-rules--regras-avancadas)
10. [Remote Config — Feature Flags](#10-remote-config--feature-flags)
11. [Cloud Messaging — Notificações Push](#11-cloud-messaging--notificacoes-push)
12. [Emulator Suite — Desenvolvimento Local](#12-emulator-suite--desenvolvimento-local)
13. [Firebase AI — Vertex AI e Gemini](#13-firebase-ai--vertex-ai-e-gemini)
14. [Performance Monitoring e Crashlytics](#14-performance-monitoring-e-crashlytics)
15. [App Check — Segurança](#15-app-check--seguranca)
16. [ML Kit — Machine Learning](#16-ml-kit--machine-learning)
17. [Firebase Extensions](#17-firebase-extensions)
18. [Analytics e Eventos Customizados](#18-analytics-e-eventos-customizados)
19. [Migração e Sync Offline](#19-migracao-e-sync-offline)
20. [Deploy e CI/CD](#20-deploy-e-cicd)

---

## 1. Firestore — Estrutura e Modelagem

O Firestore é um banco de dados NoSQL document-based com suporte a consultas em tempo real.

### Estrutura de Coleções e Documentos

```typescript
import { collection, addDoc, doc, setDoc } from "firebase/firestore";
import { db } from "./firebase-config";

// Criar documento com ID automático
const addUser = async (userData: { name: string; email: string }) => {
  const docRef = await addDoc(collection(db, "users"), {
    ...userData,
    createdAt: new Date(),
    updatedAt: new Date(),
  });
  return docRef.id;
};

// Criar documento com ID específico
const setUserProfile = async (userId: string, profile: object) => {
  await setDoc(doc(db, "users", userId), profile);
};
```

### Subcoleções e Hierarquia

```typescript
// Estrutura: users/{userId}/posts/{postId}
const createPost = async (userId: string, post: { title: string; content: string }) => {
  const docRef = await addDoc(collection(db, "users", userId, "posts"), {
    ...post,
    likes: 0,
    published: false,
    createdAt: new Date(),
  });
  return docRef.id;
};

// Estrutura: posts/{postId}/comments/{commentId}
const addComment = async (postId: string, comment: { text: string; authorId: string }) => {
  await addDoc(collection(db, "posts", postId, "comments"), {
    ...comment,
    createdAt: new Date(),
  });
};
```

### MELHORIA — Modelagem de Dados

❌ **ERRADO:** Aninhar dados demais em subcoleções
```typescript
// ❌ Evitar: muitos níveis de subcoleções
// users/{userId}/projects/{projectId}/tasks/{taskId}/subtasks/{subtaskId}
// Isso dificulta consultas e manutenção
```

✅ **CORRETO:** Usar referências e coleções de nível superior
```typescript
// ✅ Usar referências entre coleções
const taskRef = doc(db, "tasks", taskId);
await setDoc(doc(db, "subtasks", subtaskDocRef.id), {
  ...subtask,
  parentTaskId: taskId, // Referência direta
});
```

---

## 2. Firestore — Consultas Avançadas

### Filtros Compostos e Índices

```typescript
import { collection, query, where, orderBy, limit, getDocs } from "firebase/firestore";

// Consulta com múltiplos filtros
const searchActiveUsers = async () => {
  const q = query(
    collection(db, "users"),
    where("active", "==", true),
    where("age", ">=", 18),
    orderBy("age", "desc"),
    limit(20)
  );

  const snapshot = await getDocs(q);
  return snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
};
```

### Consultas com Cursors (Paginação)

```typescript
import { startAfter, getDocs, query, orderBy, limit } from "firebase/firestore";

// Paginação com cursor
const getPaginatedUsers = async (lastVisible?: any) => {
  let q;
  if (lastVisible) {
    q = query(
      collection(db, "users"),
      orderBy("createdAt", "desc"),
      startAfter(lastVisible),
      limit(25)
    );
  } else {
    q = query(collection(db, "users"), orderBy("createdAt", "desc"), limit(25));
  }

  const snapshot = await getDocs(q);
  return {
    users: snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() })),
    lastVisible: snapshot.docs[snapshot.docs.length - 1],
    hasMore: snapshot.docs.length === 25,
  };
};
```

### Consultas em Tempo Real

```typescript
import { onSnapshot } from "firebase/firestore";

// Listener em tempo real
const listenToChat = (chatId: string, callback: (messages: any[]) => void) => {
  const q = query(
    collection(db, "chats", chatId, "messages"),
    orderBy("createdAt", "asc")
  );

  return onSnapshot(q, (snapshot) => {
    const messages = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
    callback(messages);
  });
};
```

### MELHORIA — Consultas

❌ **ERRADO:** Buscar todos os documentos para filtrar no cliente
```typescript
// ❌ Ineficiente: busca tudo e filtra no código
const snapshot = await getDocs(collection(db, "users"));
const activeUsers = snapshot.docs
  .map(doc => doc.data())
  .filter(user => user.active === true); // Filtragem no cliente
```

✅ **CORRETO:** Usar filtros do Firestore
```typescript
// ✅ Eficiente: filtro no servidor
const q = query(collection(db, "users"), where("active", "==", true));
const snapshot = await getDocs(q); // Só retorna ativos
```

---

## 3. Firestore — Transações e Lotes

### Transações

```typescript
import { runTransaction, doc, getDoc, updateDoc, increment } from "firebase/firestore";

// Transferência segura entre contas
const transferBalance = async (fromId: string, toId: string, amount: number) => {
  return runTransaction(db, async (transaction) => {
    const fromDoc = await getDoc(doc(db, "wallets", fromId));
    const toDoc = await getDoc(doc(db, "wallets", toId));

    if (!fromDoc.exists() || !toDoc.exists()) {
      throw new Error("Carteira não encontrada");
    }

    const fromBalance = fromDoc.data().balance;
    if (fromBalance < amount) {
      throw new Error("Saldo insuficiente");
    }

    transaction.update(doc(db, "wallets", fromId), { balance: fromBalance - amount });
    transaction.update(doc(db, "wallets", toId), {
      balance: toDoc.data().balance + amount,
    });

    // Log da transação
    transaction.set(doc(db, "transactions", Date.now().toString()), {
      from: fromId,
      to: toId,
      amount,
      timestamp: new Date(),
    });
  });
};
```

### Lotes (Batch Operations)

```typescript
import { writeBatch, doc } from "firebase/firestore";

// Atualização em massa
const batchUpdateUsers = async (userIds: string[], updates: object) => {
  const batch = writeBatch(db);

  userIds.forEach((userId) => {
    const userRef = doc(db, "users", userId);
    batch.update(userRef, updates);
  });

  await batch.commit();
};
```

### MELHORIA — Transações

❌ **ERRADO:** Não usar transações para operações que dependem de dados
```typescript
// ❌ Condição de corrida (race condition)
const wallet = await getDoc(doc(db, "wallets", fromId));
const newBalance = wallet.data().balance - amount;
await updateDoc(doc(db, "wallets", fromId), { balance: newBalance });
// Outro usuário pode alterar o saldo entre leitura e escrita
```

✅ **CORRETO:** Usar transação para operações atômicas
```typescript
// ✅ Transação garante atomicidade
await runTransaction(db, async (transaction) => {
  const wallet = await transaction.get(doc(db, "wallets", fromId));
  const newBalance = wallet.data()!.balance - amount;
  transaction.update(doc(db, "wallets", fromId), { balance: newBalance });
});
```

---

## 4. Authentication — Configuração Multi-Provedor

```typescript
import {
  getAuth,
  signInWithEmailAndPassword,
  GoogleAuthProvider,
  FacebookAuthProvider,
  signInWithPopup,
  OAuthProvider,
} from "firebase/auth";

const auth = getAuth();

// Login com email/senha
const loginEmail = async (email: string, password: string) => {
  const credential = await signInWithEmailAndPassword(auth, email, password);
  return credential.user;
};

// Login com Google
const loginGoogle = async () => {
  const provider = new GoogleAuthProvider();
  provider.addScope("email");
  provider.addScope("profile");
  const result = await signInWithPopup(auth, provider);
  return result.user;
};

// Login com Facebook
const loginFacebook = async () => {
  const provider = new FacebookAuthProvider();
  provider.addScope("email");
  const result = await signInWithPopup(auth, provider);
  return result.user;
};

// Login com Apple
const loginApple = async () => {
  const provider = new OAuthProvider("apple.com");
  provider.addScope("email");
  provider.addScope("name");
  const result = await signInWithPopup(auth, provider);
  return result.user;
};

// Login anônimo
const loginAnonymous = async () => {
  const { signInWithAnonymous } = await import("firebase/auth");
  const result = await signInWithAnonymous(auth);
  return result.user;
};
```

### MELHORIA — Autenticação

❌ **ERRADO:** Não tratar erros de autenticação
```typescript
// ❌ Não tratamento de erros
const user = await signInWithEmailAndPassword(auth, email, password);
```

✅ **CORRETO:** Tratar erros específicos
```typescript
// ✅ Tratamento robusto
try {
  const user = await signInWithEmailAndPassword(auth, email, password);
} catch (error: any) {
  switch (error.code) {
    case "auth/user-not-found":
      throw new Error("Usuário não encontrado");
    case "auth/wrong-password":
      throw new Error("Senha incorreta");
    case "auth/too-many-requests":
      throw new Error("Muitas tentativas. Tente novamente mais tarde");
    case "auth/invalid-email":
      throw new Error("Email inválido");
    default:
      throw new Error("Erro ao fazer login");
  }
}
```

---

## 5. Authentication — Custom Claims e Tokens

```typescript
import { getAuth } from "firebase-admin/auth";

// Definir claims customizadas via Admin SDK
const setCustomClaims = async (uid: string, claims: object) => {
  await getAuth().setCustomUserClaims(uid, claims);
  // Exemplo: { admin: true, role: "editor", premium: true }
};

// Verificar claims no servidor
const verifyToken = async (idToken: string) => {
  try {
    const decodedToken = await getAuth().verifyIdToken(idToken);
    return {
      uid: decodedToken.uid,
      email: decodedToken.email,
      admin: decodedToken.admin ?? false,
      role: decodedToken.role ?? "user",
    };
  } catch (error) {
    throw new Error("Token inválido");
  }
};

// Middleware para verificar permissões
const requireAdmin = async (req: any, res: any, next: any) => {
  const token = req.headers.authorization?.split("Bearer ")[1];
  if (!token) {
    return res.status(401).json({ error: "Token não fornecido" });
  }

  const decoded = await verifyToken(token);
  if (!decoded.admin) {
    return res.status(403).json({ error: "Acesso negado" });
  }

  req.user = decoded;
  next();
};
```

---

## 6. Cloud Functions — Triggers e Eventos

```typescript
import { onDocumentCreated, onDocumentUpdated, onSchedule } from "firebase-functions/v2/firestore";
import { onCall } from "firebase-functions/v2/https";

// Trigger quando documento é criado
const onUserCreated = onDocumentCreated("users/{userId}", async (event) => {
  const userData = event.data?.data();
  const userId = event.params.userId;

  // Criar perfil padrão
  const profileRef = event.data?.ref.collection("profile").doc("default");
  await profileRef?.set({
    avatar: "default.png",
    bio: "",
    preferences: { theme: "light", language: "pt-BR" },
  });

  // Enviar email de boas-vindas via SendGrid
  // await sendWelcomeEmail(userData.email);
});

// Trigger quando documento é atualizado
const onOrderStatusChanged = onDocumentUpdated("orders/{orderId}", async (event) => {
  const before = event.data?.before.data();
  const after = event.data?.after.data();

  if (before?.status !== after?.status) {
    // Atualizar notificação
    console.log(`Pedido ${event.params.orderId}: ${before?.status} → ${after?.status}`);
  }
});

// Agendamento com cron
const cleanupOldSessions = onSchedule("every 24 hours", async (event) => {
  const cutoff = new Date();
  cutoff.setDate(cutoff.getDate() - 30);

  const snapshot = await getDocs(
    query(collection(db, "sessions"), where("createdAt", "<", cutoff))
  );

  const batch = writeBatch(db);
  snapshot.docs.forEach((doc) => batch.delete(doc.ref));
  await batch.commit();
});

// Cloud Function chamável
const calculateShipping = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Usuário deve estar autenticado");
  }

  const { cep, weight } = request.data;
  // Lógica de cálculo de frete
  return { shippingCost: weight * 0.1 + 10 };
});
```

### MELHORIA — Cloud Functions

❌ **ERRADO:** Não validar dados de entrada
```typescript
// ❌ Sem validação
const createUser = onCall(async (request) => {
  await addDoc(collection(db, "users"), request.data);
});
```

✅ **CORRETO:** Validar e sanitizar dados
```typescript
// ✅ Com validação completa
const createUser = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Login necessário");
  }

  const { name, email } = request.data;

  if (typeof name !== "string" || name.length < 2) {
    throw new HttpsError("invalid-argument", "Nome inválido");
  }

  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    throw new HttpsError("invalid-argument", "Email inválido");
  }

  return await addDoc(collection(db, "users"), { name, email });
});
```

---

## 7. Cloud Functions — HTTP Functions e Middleware

```typescript
import { onRequest } from "firebase-functions/v2/https";
import cors from "cors";
import express from "express";

const app = express();
app.use(cors({ origin: true }));

// Middleware de autenticação
const authenticate = async (req: any, res: any, next: any) => {
  const idToken = req.headers.authorization?.split("Bearer ")[1];
  if (!idToken) {
    return res.status(401).json({ error: "Não autenticado" });
  }

  try {
    const decoded = await getAuth().verifyIdToken(idToken);
    req.user = decoded;
    next();
  } catch {
    res.status(401).json({ error: "Token inválido" });
  }
};

// Rotas
app.get("/users", authenticate, async (req: any, res) => {
  const snapshot = await getDocs(collection(db, "users"));
  const users = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
  res.json(users);
});

app.post("/users", authenticate, async (req: any, res) => {
  const docRef = await addDoc(collection(db, "users"), req.body);
  res.status(201).json({ id: docRef.id });
});

export const api = onRequest(app);
```

---

## 8. Cloud Storage — Upload e Downloads

```typescript
import {
  getStorage,
  ref,
  uploadBytes,
  getDownloadURL,
  deleteObject,
} from "firebase/storage";

const storage = getStorage();

// Upload de arquivo
const uploadFile = async (file: File, path: string) => {
  const storageRef = ref(storage, path);
  const snapshot = await uploadBytes(storageRef, file);
  const downloadURL = await getDownloadURL(snapshot.ref);
  return downloadURL;
};

// Upload com progresso
const uploadWithProgress = async (file: File, path: string) => {
  const storageRef = ref(storage, path);
  const uploadTask = uploadBytesResumable(storageRef, file);

  return new Promise<string>((resolve, reject) => {
    uploadTask.on(
      "state_changed",
      (snapshot) => {
        const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        console.log(`Upload: ${progress}%`);
      },
      (error) => reject(error),
      async () => {
        const url = await getDownloadURL(uploadTask.snapshot.ref);
        resolve(url);
      }
    );
  });
};

// Deletar arquivo
const deleteFile = async (path: string) => {
  const storageRef = ref(storage, path);
  await deleteObject(storageRef);
};
```

---

## 9. Security Rules — Regras Avançadas

```javascript
// firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Regra para coleção de usuários
    match /users/{userId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if request.auth != null && request.auth.uid == userId;

      // Permissões para subcoleções
      match /posts/{postId} {
        allow read: if true;
        allow create: if request.auth != null && request.auth.uid == userId;
        allow update, delete: if request.auth != null && 
          (request.auth.uid == userId || get(/databases/$(database)/documents/users/$(request.auth.uid)).data.admin == true);
      }
    }

    // Regras para pedidos
    match /orders/{orderId} {
      allow read: if request.auth != null && 
        (resource.data.userId == request.auth.uid || 
         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin');
      
      allow create: if request.auth != null && 
        request.resource.data.keys().hasAll(['items', 'total', 'status']) &&
        request.resource.data.status == 'pending';
      
      allow update: if request.auth != null && 
        get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin' &&
        request.resource.data.status in ['processing', 'shipped', 'delivered'];
    }

    // Validação de dados
    match /products/{productId} {
      allow read: if true;
      allow write: if request.auth != null && 
        request.resource.data.name is string &&
        request.resource.data.name.size() > 0 &&
        request.resource.data.price is number &&
        request.resource.data.price > 0;
    }
  }
}
```

### MELHORIA — Security Rules

❌ **ERRADO:** Regras muito permissivas
```javascript
// ❌ Nunca fazer isso em produção
match /{document=**} {
  allow read, write: if true;
}
```

✅ **CORRETO:** Regras granulares e específicas
```javascript
// ✅ Regras restritivas
match /users/{userId} {
  allow read: if request.auth != null;
  allow write: if request.auth != null && request.auth.uid == userId;
}
```

---

## 10. Remote Config — Feature Flags

```typescript
import { getRemoteConfig, getValue, getAll } from "firebase/remote-config";

const remoteConfig = getRemoteConfig();

// Configurar fetch e ativação
remoteConfig.settings.minimumFetchIntervalMillis = 3600000; // 1 hora em produção
remoteConfig.settings.fetchTimeoutMillis = 60000;

// Ativar experimentos
remoteConfig.defaultConfig = {
  new_checkout_flow: false,
  max_items_per_page: 20,
  maintenance_mode: false,
  hero_banner_variant: "control",
};

// Buscar valores
const getFeatureFlags = async () => {
  await remoteConfig.fetchAndActivate();

  const config = await getAll(remoteConfig);
  return {
    newCheckout: getValue(config, "new_checkout_flow").asBoolean(),
    maxItems: getValue(config, "max_items_per_page").asNumber(),
    maintenance: getValue(config, "maintenance_mode").asBoolean(),
    bannerVariant: getValue(config, "hero_banner_variant").asString(),
  };
};

// Usar no componente
const HomePage = () => {
  const [features, setFeatures] = useState<any>(null);

  useEffect(() => {
    getFeatureFlags().then(setFeatures);
  }, []);

  if (features?.maintenance) return <MaintenancePage />;

  return (
    <div>
      {features?.newCheckout ? <NewCheckout /> : <OldCheckout />}
    </div>
  );
};
```

---

## 11. Cloud Messaging — Notificações Push

```typescript
import { getMessaging, getToken, onMessage } from "firebase/messaging";
import { getAnalytics } from "firebase/analytics";

// Solicitar permissão e obter token
const requestNotificationPermission = async () => {
  const messaging = getMessaging();

  const permission = await Notification.requestPermission();
  if (permission !== "granted") {
    throw new Error("Permissão negada");
  }

  const token = await getToken(messaging, {
    vapidKey: "YOUR_VAPID_KEY",
  });

  // Salvar token no Firestore
  await addDoc(collection(db, "fcmTokens"), {
    token,
    userId: getCurrentUserId(),
    createdAt: new Date(),
  });

  return token;
};

// Receber notificações em primeiro plano
const setupForegroundListener = () => {
  const messaging = getMessaging();

  onMessage(messaging, (payload) => {
    // Exibir notificação personalizada
    showCustomNotification(payload.notification?.title, payload.notification?.body);
  });
};
```

---

## 12. Emulator Suite — Desenvolvimento Local

```json
// firebase.json
{
  "emulators": {
    "auth": {
      "port": 9099
    },
    "firestore": {
      "port": 8080
    },
    "functions": {
      "port": 5001
    },
    "storage": {
      "port": 9199
    },
    "pubsub": {
      "port": 8085
    },
    "ui": {
      "enabled": true,
      "port": 4000
    }
  }
}
```

### Configurar Conexão com Emuladores

```typescript
import { connectFunctionsEmulator } from "firebase/functions";
import { connectFirestoreEmulator } from "firebase/firestore";
import { connectStorageEmulator } from "firebase/storage";

const connectToEmulators = () => {
  if (location.hostname === "localhost") {
    connectFunctionsEmulator(getFunctions(), "localhost", 5001);
    connectFirestoreEmulator(getFirestore(), "localhost", 8080);
    connectStorageEmulator(getStorage(), "localhost", 9199);
  }
};
```

---

## 13. Firebase AI — Vertex AI e Gemini

```typescript
import { getVertexAI, getGenerativeModel } from "firebase/vertexai";

// Inicializar Vertex AI
const vertexAI = getVertexAI();
const model = getGenerativeModel(vertexAI, {
  model: "gemini-2.0-flash",
  systemInstruction: "Você é um assistente útil em português brasileiro.",
});

// Gerar conteúdo
const generateResponse = async (prompt: string) => {
  const result = await model.generateContent(prompt);
  return result.response.text();
};

// Chat com histórico
const startChat = () => {
  const chat = model.startChat({
    history: [],
  });
  return chat;
};

// Geração com imagens
const analyzeImage = async (imageData: string, prompt: string) => {
  const result = await model.generateContent([
    prompt,
    {
      inlineData: {
        mimeType: "image/jpeg",
        data: imageData,
      },
    },
  ]);
  return result.response.text();
};

// Streaming de resposta
const streamResponse = async (prompt: string) => {
  const result = await model.generateContentStream(prompt);
  let fullText = "";

  for await (const chunk of result.stream) {
    fullText += chunk.text();
    updateUI(fullText);
  }

  return fullText;
};
```

---

## 14. Performance Monitoring e Crashlytics

```typescript
import { getPerformance } from "firebase/performance";
import { getCrashlytics, recordException } from "firebase/crashlytics";

// Performance Monitoring - custom traces
const tracePerformance = async () => {
  const perf = getPerformance();
  const trace = perf.trace("load_products");

  trace.start();
  try {
    await loadProducts();
  } finally {
    trace.stop();
  }
};

// Custom metrics
const trackCustomMetric = (value: number) => {
  const perf = getPerformance();
  const metric = perf.metric("checkout_duration");
  metric.put(value);
};

// Crashlytics - registrar erros
const reportError = (error: Error, context?: object) => {
  const crashlytics = getCrashlytics();
  recordException(crashlytics, error);

  if (context) {
    Object.entries(context).forEach(([key, value]) => {
      crashlytics.setCustomKey(key, String(value));
    });
  }
};
```

---

## 15. App Check — Segurança

```typescript
import { initializeAppCheck, ReCaptchaV3Provider, getToken } from "firebase/app-check";

// Inicializar App Check
const initAppCheck = () => {
  const appCheck = initializeAppCheck(app, {
    provider: new ReCaptchaV3Provider("YOUR_RECAPTCHA_SITE_KEY"),
    isTokenAutoRefreshEnabled: true,
  });
  return appCheck;
};

// Verificar token em Cloud Functions
const verifyAppCheckToken = async () => {
  const appCheck = getAppCheck();
  const tokenResult = await getToken(appCheck);
  return tokenResult.token;
};

// Cloud Function com App Check
const protectedFunction = onCall({ enforceAppCheck: true }, async (request) => {
  // App Check verificado automaticamente
  return { data: "Dados protegidos" };
});
```

---

## 16. ML Kit — Machine Learning

```typescript
import { getMLkit } from "firebase/ml";

// Reconhecimento de texto
const recognizeText = async (imageUri: string) => {
  const mlkit = getMLkit();
  const result = await mlkit.recognizeText(imageUri);
  return result.text;
};

// Detecção de rostos
const detectFaces = async (imageUri: string) => {
  const mlkit = getMLkit();
  const result = await mlkit.faceDetection(imageUri);
  return result.faces;
};

// Tradução de texto
const translateText = async (text: string, targetLanguage: string) => {
  const mlkit = getMLkit();
  const result = await mlkit.translateText(text, targetLanguage);
  return result.translatedText;
};
```

---

## 17. Firebase Extensions

```json
// firebase.json - Extensions
{
  "extensions": {
    "firestore-send-email": "firebase/firestore-send-email@0.1.4",
    "firestore-stripe-payments": "stripe/firestore-stripe-payments@0.1.16",
    "firebase-delete-user-data": "firebase/delete-user-data@0.1.3"
  }
}
```

### Exemplo: Stripe Payments

```typescript
// Criar sessão de checkout
const createCheckoutSession = async (priceId: string) => {
  const userId = getCurrentUserId();

  const docRef = await addDoc(
    collection(db, "customers", userId, "checkout_sessions"),
    {
      price: priceId,
      success_url: `${window.location.origin}/success`,
      cancel_url: `${window.location.origin}/cancel`,
    }
  );

  // Listener para redirecionamento
  onSnapshot(docRef, (snap) => {
    const { error, url } = snap.data() as any;
    if (error) {
      console.error(`Erro: ${error.message}`);
    }
    if (url) {
      window.location.assign(url);
    }
  });
};
```

---

## 18. Analytics e Eventos Customizados

```typescript
import { getAnalytics, logEvent, setUserProperties } from "firebase/analytics";

const analytics = getAnalytics();

// Logar evento customizado
const trackPurchase = (items: any[], total: number) => {
  logEvent(analytics, "purchase", {
    currency: "BRL",
    value: total,
    items: items.map((item) => ({
      item_id: item.id,
      item_name: item.name,
      price: item.price,
      quantity: item.quantity,
    })),
  });
};

// Logar evento de navegação
const trackPageView = (pageName: string) => {
  logEvent(analytics, "page_view", { page_title: pageName });
};

// Configurar propriedades do usuário
const setUserAnalytics = (userId: string, properties: object) => {
  setUserProperties(analytics, properties);
};

// Logar evento de busca
const trackSearch = (searchTerm: string, resultsCount: number) => {
  logEvent(analytics, "search", {
    search_term: searchTerm,
    results_count: resultsCount,
  });
};
```

---

## 19. Migração e Sync Offline

### Habilitar Persistência Offline

```typescript
import { initializeFirestore, persistentLocalCache } from "firebase/firestore";

// Habilitar cache local
const firestore = initializeFirestore(app, {
  localCache: persistentLocalCache({
    cacheSizeBytes: 104857600, // 100 MB
  }),
});
```

### Estratégias de Migração de Dados

```typescript
// Script de migração para Firestore
const migrateUsersToNewSchema = async () => {
  const snapshot = await getDocs(collection(db, "users_v1"));
  const batch = writeBatch(db);

  for (const doc of snapshot.docs) {
    const oldData = doc.data();
    const newData = {
      firstName: oldData.name.split(" ")[0],
      lastName: oldData.name.split(" ").slice(1).join(" "),
      email: oldData.email.toLowerCase().trim(),
      createdAt: Timestamp.fromDate(new Date(oldData.created_at)),
      status: oldData.active ? "active" : "inactive",
    };

    batch.set(doc.ref, newData, { merge: true });
  }

  await batch.commit();
  console.log(`Migrados ${snapshot.size} documentos`);
};
```

---

## 20. Deploy e CI/CD

### GitHub Actions para Firebase

```yaml
# .github/workflows/deploy.yml
name: Deploy Firebase

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: 18
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run tests
        run: npm test
        
      - name: Deploy to Firebase
        uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: "${{ secrets.GITHUB_TOKEN }}"
          firebaseServiceAccount: "${{ secrets.FIREBASE_SERVICE_ACCOUNT }}"
          channelId: live
          projectId: my-project
```

### Deploy via CLI

```bash
# Deploy de todos os serviços
firebase deploy

# Deploy apenas de functions
firebase deploy --only functions

# Deploy apenas de hosting
firebase deploy --only hosting

# Deploy com escopo específico
firebase deploy --only functions:api,functions:onUserCreated
```

---

## 📚 Referências e Recursos

- [Documentação oficial Firebase](https://firebase.google.com/docs)
- [Firebase JS SDK (GitHub)](https://github.com/firebase/firebase-js-sdk)
- [Cloud Functions](https://firebase.google.com/docs/functions)
- [Security Rules](https://firebase.google.com/docs/rules)
- [Firebase Emulator Suite](https://firebase.google.com/docs/emulator-suite)
- [Firebase AI (Vertex AI)](https://firebase.google.com/docs/vertex-ai)
- [App Check](https://firebase.google.com/docs/app-check)

---

**Última atualização:** Setembro 2026
**Versão do Firebase SDK:** 11.x+
**Compatibilidade:** Node.js 18+, TypeScript 5.x+
