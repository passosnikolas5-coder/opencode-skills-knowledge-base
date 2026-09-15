# 📱 Mobile Development Skills - 6.000 Skills

> **Todas as habilidades de desenvolvimento mobile documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| iOS Development | 1.200 | Básico → Expert |
| Android Development | 1.200 | Básico → Expert |
| React Native | 1.000 | Básico → Expert |
| Flutter | 1.000 | Básico → Expert |
| Cross-Platform | 600 | Intermediário → Expert |
| Mobile UI/UX | 500 | Intermediário → Expert |
| Mobile Testing | 300 | Intermediário → Expert |
| Mobile Security | 200 | Avançado → Expert |

---

## 🍎 iOS Development Skills (1.200)

### Swift Fundamentals (300)

#### iOS001: Swift Language Mastery
```lua
-- SKILL: Swift Language Mastery
-- Nível: Básico → Expert
-- Contexto: Linguagem para iOS/macOS

-- CONCEITOS:
-- 1. Types
--    - Basic types (Int, String, Bool, Double)
--    - Collections (Array, Dictionary, Set)
--    - Optionals
--    - Tuples
--
-- 2. Control Flow
--    - if/else, switch
--    - for-in, while
--    - guard, defer
--
-- 3. Functions
--    - Parameters (external/internal)
--    - Return values
--    - Closures
--    - Higher-order functions
--
-- 4. OOP
--    - Classes vs Structs
--    - Inheritance
--    - Protocols
--    - Extensions

-- MELHORIA:
-- ERRADO: Usar force unwrap (!) excessivamente
-- CERTO: Optional binding (if let, guard let)
```

#### iOS002: Swift Advanced Patterns
```lua
-- SKILL: Swift Advanced Patterns
-- Nível: Avançado → Expert
-- Contexto: Padrões avançados

-- PADRÕES:
-- 1. Protocol-Oriented Programming
--    - Protocol composition
--    - Protocol extensions
--    - Associated types
--
-- 2. Generics
--    - Type parameters
--    - Constraints
--    - Associated types
--
-- 3. Error Handling
--    - do-try-catch
--    - Result type
--    - Custom errors
--
-- 4. Concurrency
--    - async/await
--    - Actors
--    - Structured concurrency
--    - Sendable

-- MELHORIA:
-- ERRADO: Herança profunda
-- CERTO: Protocol composition + extensions
```

### SwiftUI (300)

#### iOS003: SwiftUI Fundamentals
```lua
-- SKILL: SwiftUI Fundamentals
-- Nível: Básico → Expert
-- Contexto: UI declarativa para iOS

-- CONCEITOS:
-- 1. Views
--    - Text, Image, Button
--    - List, Form
--    - NavigationStack
--
-- 2. State Management
--    - @State
--    - @Binding
--    - @ObservedObject
--    - @StateObject
--    - @EnvironmentObject
--
-- 3. Layout
--    - HStack, VStack, ZStack
--    - Spacer, Divider
--    - GeometryReader
--
-- 4. Modifiers
--    - Padding, Margin
--    - Background, Overlay
--    - Corner radius, Shadow

-- MELHORIA:
-- ERRADO: UIKit em novos projetos
-- CERTO: SwiftUI + UIKit quando necessário
```

#### iOS004: SwiftUI Advanced
```lua
-- SKILL: SwiftUI Advanced Patterns
-- Nível: Intermediário → Expert
-- Contexto: UI complexa em SwiftUI

-- PADRÕES:
-- 1. Custom Components
--    - ViewBuilder
--    - ContentUnavailable
--    - Custom modifiers
--
-- 2. Animations
--    - withAnimation
--    - matchedGeometryEffect
--    - PhaseAnimator
--    - KeyframeAnimator
--
-- 3. Data Flow
--    - @Observable (iOS 17)
--    - @Environment
--    - @ScaledMetric
--
-- 4. Navigation
--    - NavigationStack
--    - NavigationPath
--    - .navigationDestination
--    - Sheet, fullScreenCover

-- MELHORIA:
-- ERRADO: Estado fragmentado
-- CERTO: @Observable + @Environment
```

### UIKit (200)

#### iOS005: UIKit Fundamentals
```lua
-- SKILL: UIKit Fundamentals
-- Nível: Básico → Expert
-- Contexto: UI tradicional para iOS

-- CONCEITOS:
-- 1. Views
--    - UILabel, UIButton, UIImageView
--    - UITableView, UICollectionView
--    - UIScrollView
--
-- 2. View Controllers
--    - UIViewController
--    - UICollectionViewController
--    - UINavigationController
--    - UITabBarController
--
-- 3. Auto Layout
--    - Constraints
--    - Stack Views
--    - Size Classes
--
-- 4. Storyboards vs Code
--    - Interface Builder
--    - Programmatic UI
--    - XIBs

-- MELHORIA:
-- ERRADO: Storyboards complexos
-- CERTO: Programmatic UI ou SwiftUI
```

### Core Data & Persistence (200)

#### iOS006: Core Data Mastery
```lua
-- SKILL: Core Data Mastery
-- Nível: Intermediário → Expert
-- Contexto: Persistência no iOS

-- CONCEITOS:
-- 1. Stack
--    - NSPersistentContainer
--    - Managed Object Context
--    - Persistent Store Coordinator
--
-- 2. Model
--    - Entities
--    - Attributes
--    - Relationships
--    - Fetch Requests
--
-- 3. Patterns
--    - NSFetchRequest
--    - NSBatchDeleteRequest
--    - NSAsynchronousFetchRequest
--
-- 4. Integration
--    - @FetchRequest (SwiftUI)
--    - NSFetchedResultsController
--    - CloudKit sync

-- ALTERNATIVAS:
-- - SwiftData (iOS 17+)
-- - Realm
-- - SQLite directly
-- - UserDefaults (simples)
```

### Networking (200)

#### iOS007: Networking in iOS
```lua
-- SKILL: Networking in iOS
-- Nível: Intermediário → Expert
-- Contexto: Chamadas de rede no iOS

-- FRAMEWORKS:
-- 1. URLSession
--    - Data tasks
--    - Download tasks
--    - Upload tasks
--    - WebSocket tasks
--
-- 2. Alamofire
--    - Convenience
--    - Chainable
--    - Rich features
--
-- 3. Moya
--    - Abstracted layer
--    - Type-safe
--    - Testable
--
-- 4. Composable (TCA)
--    - Effect-based
--    - Testable
--    - Predictable

-- PATTERNS:
-- - Codable for JSON
-- - Async/await
-- - Combine publishers
-- - Error handling
```

---

## 🤖 Android Development Skills (1.200)

### Kotlin Fundamentals (300)

#### Android001: Kotlin Language Mastery
```lua
-- SKILL: Kotlin Language Mastery
-- Nível: Básico → Expert
-- Contexto: Linguagem para Android

-- CONCEITOS:
-- 1. Types
--    - val vs var
--    - Nullable types (?)
--    - Collections
--    - Data classes
--
-- 2. Functions
--    - Default parameters
--    - Named parameters
--    - Lambda expressions
--    - Extension functions
--
-- 3. Coroutines
--    - launch vs async
--    - suspend functions
--    - CoroutineScope
--    - Flow
--
-- 4. Scope Functions
--    - let, run, with
--    - apply, also

-- MELHORIA:
-- ERRADO: Java-style code
-- CERTO: Idiomatic Kotlin
```

### Jetpack Compose (300)

#### Android002: Jetpack Compose Fundamentals
```lua
-- SKILL: Jetpack Compose Fundamentals
-- Nível: Básico → Expert
-- Contexto: UI declarativa para Android

-- CONCEITOS:
-- 1. Composables
--    - Text, Image, Button
--    - LazyColumn, LazyRow
--    - Scaffold
--
-- 2. State
--    - remember
--    - mutableStateOf
--    - rememberSaveable
--    - State hoisting
--
-- 3. Layout
--    - Row, Column, Box
--    - Spacer
--    - Modifier system
--
-- 4. Theming
--    - Material 3
--    - Custom themes
--    - Dynamic color

-- MELHORIA:
-- ERRADO: XML layouts em novos projetos
-- CERTO: Jetpack Compose + Kotlin
```

#### Android003: Jetpack Compose Advanced
```lua
-- SKILL: Jetpack Compose Advanced
-- Nível: Intermediário → Expert
-- Contexto: UI complexa em Compose

-- PADRÕES:
-- 1. Custom Composables
--    - Layout
--    - Modifier
--    - CompositionLocal
--
-- 2. Animation
--    - animate*AsState
--    - AnimatedVisibility
--    - AnimatedContent
--    - updateTransition
--
-- 3. Navigation
--    - Navigation Compose
--    - NavHost
--    - Deep links
--
-- 4. Performance
--    - Recomposition
--    - DerivedStateOf
--    - LazyColumn optimization

-- MELHORIA:
-- ERRADO: Recomposição excessiva
-- CERTO: State hoisting + derivedStateOf
```

### Architecture (300)

#### Android004: Android Architecture
```lua
-- SKILL: Android Architecture
-- Nível: Intermediário → Expert
-- Contexto: Arquitetura de apps Android

-- PADRÕES:
-- 1. MVVM
--    - ViewModel
--    - LiveData/StateFlow
--    - Repository
--
-- 2. MVI
--    - State
--    - Intent
--    - Side effects
--
-- 3. Clean Architecture
--    - Domain layer
--    - Data layer
--    - Presentation layer
--
-- 4. UDF (Unidirectional Data Flow)
--    - State down
--    - Events up
--    - Single source of truth

-- COMPONENTES:
-- - ViewModel
-- - Hilt (DI)
-- - Room (database)
-- - WorkManager (background)
-- - DataStore (preferences)
```

### Android Jetpack (300)

#### Android005: Jetpack Libraries
```lua
-- SKILL: Jetpack Libraries Mastery
-- Nível: Intermediário → Expert
-- Contexto: Bibliotecas Jetpack

-- BIBLIOTECAS:
-- 1. Room
--    - Database
--    - DAO
--    - Entities
--    - Migrations
--
-- 2. Hilt
--    - @HiltAndroidApp
--    - @Inject
--    - @Module
--    - @Provides
--
-- 3. WorkManager
--    - Periodic work
--    - One-time work
--    - Constraints
--    - Chain
--
-- 4. Navigation
--    - NavHost
--    - Routes
--    - Arguments
--    - Deep links
--
-- 5. Paging
--    - PagingSource
--    - Pager
--    - LazyPagingItems
--
-- 6. DataStore
--    - Preferences DataStore
--    - Proto DataStore

-- MELHORIA:
-- ERRADO: AsyncTask, Loaders (legado)
-- CERTO: Coroutines + Flow + Jetpack
```

### Kotlin Multiplatform (100)

#### KMP001: Kotlin Multiplatform
```lua
-- SKILL: Kotlin Multiplatform
-- Nível: Intermediário → Expert
-- Contexto: Código compartilhado

-- CONCEITOS:
-- 1. Shared Code
--    - expect/actual
--    - Common module
--    - Platform modules
--
-- 2. Compose Multiplatform
--    - Shared UI
--    - Platform-specific
--    - Navigation
--
-- 3. Networking
--    - Ktor
--    - Kotlinx.serialization
--
-- 4. Persistence
--    - SQLDelight
--    - DataStore

-- PLATAFORMAS:
-- - Android
-- - iOS
-- - Desktop
-- - Web (Wasm)

-- MELHORIA:
-- ERRADO: Duplicar código entre plataformas
-- CERTO: Shared logic + platform UI
```

---

## ⚛️ React Native Skills (1.000)

### Core Concepts (300)

#### RN001: React Native Fundamentals
```lua
-- SKILL: React Native Fundamentals
-- Nível: Básico → Expert
-- Contexto: Apps mobile com React

-- CONCEITOS:
-- 1. Components
--    - View, Text, Image
--    - ScrollView, FlatList
--    - TextInput, Button
--
-- 2. Styling
--    - StyleSheet
--    - Flexbox
--    - Responsive design
--
-- 3. Navigation
--    - React Navigation
--    - Stack, Tab, Drawer
--
-- 4. State
--    - useState, useReducer
--    - Context API
--    - Zustand, Jotai

-- MELHORIA:
-- ERRADO: class components
-- CERTO: functional components + hooks
```

### Advanced (300)

#### RN002: React Native Advanced
```lua
-- SKILL: React Native Advanced
-- Nível: Intermediário → Expert
-- Contexto: Apps complexos

-- PADRÕES:
-- 1. Performance
--    - FlatList optimization
--    - useMemo, useCallback
--    - Image caching
--    - Hermes engine
--
-- 2. Native Modules
--    - Turbo Modules
--    - JSI
--    - Fabric
--
-- 3. Animations
--    - Reanimated
--    - Gesture Handler
--    - Layout Animations
--
-- 4. Offline
--    - MMKV
--    - SQLite
--    - WatermelonDB

-- MELHORIA:
-- ERRADO: JavaScript bridge excessivo
-- CERTO: JSI + Turbo Modules
```

### Expo (200)

#### RN003: Expo Ecosystem
```lua
-- SKILL: Expo Ecosystem
-- Nível: Intermediário → Expert
-- Contexto: Desenvolvimento rápido

-- CONCEITOS:
-- 1. Managed Workflow
--    - Config plugins
--    - EAS Build
--    - Expo Go
--
-- 2. Modules
--    - Camera
--    - Location
--    - Notifications
--    - File System
--
-- 3. EAS
--    - Build
--    - Submit
--    - Update
--
-- 4. Router
--    - File-based routing
--    - Layouts
--    - Deep links

-- MELHORIA:
-- ERRADO: Bare workflow desnecessário
-- CERTO: Managed workflow + config plugins
```

### State Management (200)

#### RN004: React Native State
```lua
-- SKILL: React Native State Management
-- Nível: Intermediário → Expert
-- Contexto: Gerenciar estado

-- OPÇÕES:
-- 1. Zustand
--    - Simples
--    - Performático
--    - DevTools
--
-- 2. Jotai
--    - Atômico
--    - Granular
--    - Async atoms
--
-- 3. TanStack Query
--    - Server state
--    - Cache
--    - Optimistic updates
--
-- 4. Redux Toolkit
--    - Enterprise
--    - Predictable
--    - DevTools

-- DECISÃO:
-- App simples → Zustand
-- Server state → TanStack Query
-- Enterprise → Redux Toolkit
```

---

## 🐦 Flutter Skills (1.000)

### Dart Fundamentals (200)

#### Flutter001: Dart Language
```lua
-- SKILL: Dart Language Mastery
-- Nível: Básico → Expert
-- Contexto: Linguagem para Flutter

-- CONCEITOS:
-- 1. Types
--    - var, final, const
--    - Null safety
--    - Late variables
--
-- 2. Functions
--    - Optional parameters
--    - Named parameters
--    - Arrow functions
--
-- 3. Classes
--    - Constructors
--    - Mixins
--    - Extension methods
--
-- 4. Async
--    - Futures
--    - Streams
--    - async/await
--    - Isolates

-- MELHORIA:
-- ERRADO: dynamic everywhere
-- CERTO: Type-safe code
```

### Flutter Core (300)

#### Flutter002: Flutter Widgets
```lua
-- SKILL: Flutter Widgets Mastery
-- Nível: Básico → Expert
-- Contexto: Componentes Flutter

-- WIDGETS:
-- 1. Layout
--    - Row, Column, Stack
--    - Container, Padding
--    - Expanded, Flexible
--
-- 2. Material
--    - AppBar, Drawer
--    - Card, ListTile
--    - TextField, Button
--
-- 3. Cupertino
--    - CupertinoNavigationBar
--    - CupertinoButton
--    - CupertinoListSection
--
-- 4. Custom
--    - CustomPaint
--    - CustomScrollView
--    - Slivers

-- MELHORIA:
-- ERRADO: Container em excesso
-- CERTO: Widgets específicos para cada caso
```

#### Flutter003: Flutter State Management
```lua
-- SKILL: Flutter State Management
-- Nível: Intermediário → Expert
-- Contexto: Gerenciar estado em Flutter

-- OPÇÕES:
-- 1. Provider
--    - ChangeNotifier
--    - Consumer
--    - Selector
--
-- 2. Riverpod
--    - Provider-based
--    - Type-safe
--    - AsyncValue
--
-- 3. BLoC
--    - Events, States
--    - Cubit
--    - Multi BLoC
--
-- 4. GetX
--    - Simple state
--    - Reactive
--    - Dependency injection

-- DECISÃO:
-- Simples → Provider
-- Médio → Riverpod
-- Complexo → BLoC
```

### Flutter Advanced (300)

#### Flutter004: Flutter Advanced Patterns
```lua
-- SKILL: Flutter Advanced Patterns
-- Nível: Intermediário → Expert
-- Contexto: Padrões avançados

-- PADRÕES:
-- 1. Navigation
--    - go_router
--    - Auto route
--    - Deep links
--
-- 2. Networking
--    - Dio
--    - Retrofit
--    - GraphQL
--
-- 3. Database
--    - Hive
--    - Isar
--    - Drift (SQLite)
--
-- 4. Animations
--    - Implicit animations
--    - Explicit animations
--    - Hero animations
--    - Rive

-- MELHORIA:
-- ERRADO: setState excessivo
-- CERTO: State management pattern
```

### Flutter Web & Desktop (200)

#### Flutter005: Flutter Multi-Platform
```lua
-- SKILL: Flutter Multi-Platform
-- Nível: Intermediário → Expert
-- Contexto: Apps para múltiplas plataformas

-- PLATAFORMAS:
-- 1. Mobile
--    - Android, iOS
--    - Native feel
--
-- 2. Web
--    - Responsive design
--    - Web-specific widgets
--
-- 3. Desktop
--    - Windows, macOS, Linux
--    - Keyboard/mouse input
--    - Window management

-- CONSIDERAÇÕES:
-- - Platform-specific code
-- - Responsive layouts
-- - Input methods
-- - Performance

-- MELHORIA:
-- ERRADO: Um layout para todas plataformas
-- CERTO: Adaptive layouts por plataforma
```

---

## 🔄 Cross-Platform Skills (600)

### Comparison (200)

#### CP001: Cross-Platform Framework Comparison
```lua
-- SKILL: Cross-Platform Framework Comparison
-- Nível: Intermediário → Expert
-- Contexto: Escolher framework

-- FRAMEWORKS:
-- 1. React Native
--    - JavaScript/TypeScript
--    - Native components
--    - Large ecosystem
--
-- 2. Flutter
--    - Dart
--    - Custom rendering
--    - Consistent UI
--
-- 3. Kotlin Multiplatform
--    - Kotlin
--    - Shared logic
--    - Native UI
--
-- 4. .NET MAUI
--    - C#
--    - XAML
--    - Microsoft ecosystem

-- CRITÉRIOS:
-- - Performance
-- - Ecosystem
-- - Learning curve
-- - Native access
-- - Community
-- - Job market

-- DECISÃO:
-- Web devs → React Native
-- Design-heavy → Flutter
-- Enterprise → Kotlin Multiplatform/.NET MAUI
```

### Shared Logic (200)

#### CP002: Shared Business Logic
```lua
-- SKILL: Shared Business Logic
-- Nível: Intermediário → Expert
-- Contexto: Lógica compartilhada

-- ABORDAGENS:
-- 1. Code Generation
--    - Protocol buffers
--    - OpenAPI
--    - GraphQL schema
--
-- 2. Shared Libraries
--    - Kotlin Multiplatform
--    - Swift Package Manager
--    - C++ core
--
-- 3. API Layer
--    - REST
--    - GraphQL
--    - gRPC
--
-- 4. State Synchronization
--    - CRDTs
--    - Event sourcing
--    - Conflict resolution

-- MELHORIA:
-- ERRADO: Lógica duplicada
-- CERTO: Shared core + platform adapters
```

### Native Bridge (200)

#### CP003: Native Module Development
```lua
-- SKILL: Native Module Development
-- Nível: Avançado → Expert
-- Contexto: Integrar código nativo

-- PLATAFORMAS:
-- 1. React Native
--    - Turbo Modules (new arch)
--    - Native Modules (legacy)
--    - Expo Modules
--
-- 2. Flutter
--    - Platform Channels
--    - FFI
--    - Pigeon
--
-- 3. General
--    - C/C++ core
--    - Swift/Kotlin wrappers
--    - FFI

-- CASOS:
-- - Camera access
-- - Bluetooth
-- - Native UI components
-- - Performance-critical code
-- - Hardware access
```

---

## 🎨 Mobile UI/UX Skills (500)

### Mobile Design Patterns (200)

#### MUI001: Mobile Navigation Patterns
```lua
-- SKILL: Mobile Navigation Patterns
-- Nível: Básico → Expert
-- Contexto: Navegação em apps mobile

-- PADRÕES:
-- 1. Tab Bar
--    - 3-5 itens principais
--    - Sempre visível
--    - Bottom navigation
--
-- 2. Stack Navigation
--    - Push/pop
--    - Hierarquia
--    - Back button
--
-- 3. Drawer
--    - Menu lateral
--    - Muitas opções
--    - Swipe para abrir
--
-- 4. Modal
--    - Ações contextuais
--    - Formulários
--    - Confirmações

-- MELHORIA:
-- ERRADO: Navegação confusa
-- CERTO: Padrão consistente + gesture-based
```

### Mobile Forms (150)

#### MUI002: Mobile Form Design
```lua
-- SKILL: Mobile Form Design
-- Nível: Básico → Expert
-- Contexto: Formulários mobile

-- PRINCÍPIOS:
-- 1. Minimal Input
--    - Autocomplete
--    - Defaults
--    - Conditional fields
--
-- 2. Keyboard Management
--    - Correct keyboard type
--    - Avoid keyboard overlap
--    - Scroll to focus
--
-- 3. Validation
--    - Inline validation
--    - Clear errors
--    - Prevent submission
--
-- 4. Progress
--    - Multi-step forms
--    - Save progress
--    - Visual feedback

-- MELHORIA:
-- ERRADO: Muitos campos em uma tela
-- CERTO: Steps + progress indicator
```

### Mobile Performance (150)

#### MUI003: Mobile Performance
```lua
-- SKILL: Mobile Performance Optimization
-- Nível: Intermediário → Expert
-- Contexto: Otimizar apps mobile

-- MÉTRICAS:
-- - App launch time
-- - Frame rate (60fps)
-- - Memory usage
-- - Battery consumption
-- - Network usage

-- OTIMIZAÇÕES:
-- 1. Startup
--    - Lazy loading
--    - Splash screen
--    - Background fetch
--
-- 2. Rendering
--    - Avoid overdraw
--    - Optimize images
--    - Reduce shadows
--
-- 3. Memory
--    - Image caching
--    - Object pooling
--    - Memory leaks
--
-- 4. Network
--    - Caching
--    - Compression
--    - Batch requests

-- FERRAMENTAS:
-- - Instruments (iOS)
-- - Android Profiler
-- - Flipper
-- - React Native Debugger
```

---

## 🧪 Mobile Testing Skills (300)

### Unit Testing (100)

#### MT001: Mobile Unit Testing
```lua
-- SKILL: Mobile Unit Testing
-- Nível: Intermediário → Expert
-- Contexto: Testes unitários mobile

-- FRAMEWORKS:
-- 1. iOS
--    - XCTest
--    - Quick/Nimble
--
-- 2. Android
--    - JUnit
--    - Mockito
--    - MockK
--
-- 3. React Native
--    - Jest
--    - React Native Testing Library
--
-- 4. Flutter
--    - flutter_test
--    - mockito

-- PADRÕES:
-- - AAA (Arrange, Act, Assert)
-- - Dependency injection
-- - Mock external dependencies
-- - Test edge cases
```

### Integration Testing (100)

#### MT002: Mobile Integration Testing
```lua
-- SKILL: Mobile Integration Testing
-- Nível: Intermediário → Expert
-- Contexto: Testes de integração

-- FERRAMENTAS:
-- 1. iOS
--    - XCUITest
--    - EarlGrey
--
-- 2. Android
--    - Espresso
--    - UI Automator
--
-- 3. Cross-Platform
--    - Detox
--    - Appium
--    - Maestro

-- PADRÕES:
-- - Page Object Model
-- - Data-testid
-- - Custom matchers
-- - Screenshots
```

### E2E Testing (100)

#### MT003: Mobile E2E Testing
```lua
-- SKILL: Mobile E2E Testing
-- Nível: Intermediário → Expert
-- Contexto: Testes end-to-end

-- FERRAMENTAS:
-- 1. Detox
--    - React Native
--    - Synchronized
--    - CI integration
--
-- 2. Appium
--    - Cross-platform
--    - WebDriver protocol
--    - Multiple languages
--
-- 3. Maestro
--    - Modern
--    - YAML flows
--    - Easy setup

-- FLUXO:
-- 1. Setup environment
-- 2. Write test flows
-- 3. Run on devices
-- 4. Generate reports
-- 5. CI integration
```

---

## 🔒 Mobile Security Skills (200)

### iOS Security (100)

#### MIS001: iOS Security Best Practices
```lua
-- SKILL: iOS Security Best Practices
-- Nível: Intermediário → Expert
-- Contexto: Segurança em apps iOS

-- CONCEITOS:
-- 1. Data Protection
--    - Keychain
--    - File Protection
--    - Data Encryption
--
-- 2. Network Security
--    - ATS (App Transport Security)
--    - Certificate pinning
--    - TLS 1.3
--
-- 3. Code Security
--    - Code signing
--    - Jailbreak detection
--    - Anti-tampering
--
-- 4. Privacy
--    - Permission descriptions
--    - Privacy manifest
--    - Tracking transparency

-- MELHORIA:
-- ERRADO: Armazenar senhas em UserDefaults
-- CERTO: Keychain + Data Protection
```

### Android Security (100)

#### MAS001: Android Security Best Practices
```lua
-- SKILL: Android Security Best Practices
-- Nível: Intermediário → Expert
-- Contexto: Segurança em apps Android

-- CONCEITOS:
-- 1. Data Security
--    - EncryptedSharedPreferences
--    - Keystore
--    - Android Keystore System
--
-- 2. Network Security
--    - Network Security Config
--    - Certificate pinning
--    - TLS 1.3
--
-- 3. Code Security
--    - ProGuard/R8
--    - Root detection
--    - Integrity checks
--
-- 4. Privacy
--    - Permissions model
--    - Scoped storage
--    - Privacy Sandbox

-- MELHORIA:
-- ERRADO: Permissões excessivas
-- CERTO: Least privilege + runtime permissions
```

---

*Mobile Development Skills v1.0 - Setembro 2026*