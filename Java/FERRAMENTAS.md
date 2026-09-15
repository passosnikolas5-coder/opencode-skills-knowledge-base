# 🔧 Guia Completo de Ferramentas Java

> **Última atualização:** Setembro 2026  
> **Versão:** 1.0  
> **Autor:** SkillsKnowledge

---

## 📑 Índice

1. [IDEs e Editores](#1-ides-e-editores)
2. [Build Tools](#2-build-tools)
3. [Testing](#3-testing)
4. [Code Quality](#4-code-quality)
5. [Documentation](#5-documentation)
6. [Deployment](#6-deployment)
7. [Monitoring](#7-monitoring)
8. [Logging](#8-logging)

---

## 1. IDEs e Editores

---

### 1.1 IntelliJ IDEA

#### 🔹 O que é
IntelliJ IDEA é a IDE mais popular para desenvolvimento Java, desenvolvida pela JetBrains. Disponível em versões Community (gratuita) e Ultimate (paga).

#### 🔹 Por que usar
- ✅ Autocomplete inteligente com IA (AI Assistant)
- ✅ Refactoring robusto e seguro
- ✅ Debugging avançado com expression evaluation
- ✅ Integração nativa com Maven, Gradle, Docker, Kubernetes
- ✅ Suporte a 50+ linguagens e frameworks

#### 🔹 Instalação
```
Windows: https://www.jetbrains.com/idea/download/
Linux:   sudo snap install intellij-idea-community --classic
macOS:   brew install --cask intellij-idea
```

#### 🔹 Configuração
```
File → Settings (Ctrl+Alt+S)
```

| Configuração | Caminho | Recomendação |
|---|---|---|
| JDK | Project → Project SDK | Java 21+ |
| Code Style | Editor → Code Style | Google Java Format |
| Memory | Help → Edit VM Options | `-Xmx4g` |
| Auto Save | Appearance → Auto Save | Habilitado |
| Plugins | Plugins → Marketplace | Veja tabela abaixo |

#### 🔹 Plugins Essenciais

| Plugin | Função |
|---|---|
| **Lombok** | Reduz boilerplate (getters, setters, etc.) |
| **SonarLint** | Análise de qualidade em tempo real |
| **CheckStyle-IDEA** | Verificação de padrões de código |
| **GitToolBox** | Git blame inline, auto-fetch |
| **Maven Helper** | Resolver conflitos de dependência |
| **Rainbow Brackets** | Colchetes coloridos |
| **Key Promoter X** | Ensina atalhos do teclado |
| **AI Assistant** | Autocomplete com IA |

#### 🔹 Atalhos Úteis

| Atalho | Ação |
|---|---|
| `Ctrl + D` | Duplicar linha/seleção |
| `Ctrl + Y` | Deletar linha |
| `Ctrl + Shift + ↑/↓` | Mover linha |
| `Ctrl + Alt + L` | Formatar código |
| `Ctrl + Alt + O` | Organizar imports |
| `Ctrl + N` | Buscar classe |
| `Ctrl + Shift + N` | Buscar arquivo |
| `Ctrl + E` | Arquivos recentes |
| `Ctrl + F12` | Estrutura do arquivo |
| `Alt + Enter` | Quick fixes |
| `Ctrl + Shift + A` | Buscar ação |
| `F7` | Step Into (debug) |
| `F8` | Step Over (debug) |
| `F9` | Resume (debug) |
| `Ctrl + F8` | Toggle breakpoint |
| `Ctrl + Shift + F8` | View breakpoints |
| `Shift + F9` | Debug (com aplicação) |
| `Ctrl + Shift + T` | Criar teste para classe |
| `Ctrl + Alt + T` | Surround with (try/catch, if, etc.) |
| `Ctrl + O` | Override methods |
| `Ctrl + I` | Implement methods |

#### 🔹 Debugging Avançado
```
Breakpoints condicionais:
  Clique direito no breakpoint → Condition
  Exemplo: userId > 100

Evaluate Expression (Alt + F8):
  - Executar código durante pausa
  - Modificar variáveis em runtime
  - Testar expressões

Watchpoints:
  - Monitorar mudanças em campos específicos
  - Clique direito no campo → Add Field Watchpoint

Hot Swap:
  - Modificar código durante debug
  - Ctrl + Shift + F9 para hot reload
```

#### 🔹 Refactoring
```
F6  → Mover classe/método
F5  → Copiar classe
F7  → Mover para outro pacote
Shift + F6 → Renomear
Ctrl + F6 → Alterar assinatura do método
Ctrl + Alt + M → Extrair método
Ctrl + Alt + V → Extrair variável
Ctrl + Alt + C → Extrair constante
Ctrl + Alt + F → Extrair campo
Ctrl + Alt + P → Extrair parâmetro
```

#### 🔹 Melhores Práticas
1. 🎯 Use "Optimize Imports on the Fly" para manter imports limpos
2. 🎯 Configure `.editorconfig` no projeto para padronização
3. 🎯 Use Live Templates (Settings → Editor → Live Templates) para snippets
4. 🎯 Ative "Column Selection Mode" (Alt + Shift + Insert) para edição em bloco
5. 🎯 Use bookmarks (F11) para navegar rapidamente

---

### 1.2 Eclipse

#### 🔹 O que é
Eclipse é uma IDE open-source para Java, amplamente utilizada em ambientes corporativos e acadêmicos.

#### 🔹 Por que usar
- ✅ 100% gratuito e open-source
- ✅ Grande ecossistema de plugins
- ✅ Suporte nativo a Java EE
- ✅ Leve comparado a IDEs pesadas

#### 🔹 Instalação
```
Windows: https://www.eclipse.org/downloads/
Linux:   sudo snap install eclipse --classic
macOS:   brew install --cask eclipse-jee
```

#### 🔹 Configuração
```
Window → Preferences
```

| Configuração | Caminho | Recomendação |
|---|---|---|
| JDK | Installed JREs | Java 21+ |
| Compiler | Java → Compiler | Compliance 21 |
| Encoding | General → Workspace | UTF-8 |
| Maven | Maven → User Settings | settings.xml customizado |

#### 🔹 Atalhos Essenciais

| Atalho | Ação |
|---|---|
| `Ctrl + Space` | Content assist |
| `Ctrl + Shift + O` | Organizar imports |
| `Ctrl + Shift + F` | Formatar código |
| `Ctrl + D` | Deletar linha |
| `Ctrl + /` | Comentário de linha |
| `Ctrl + Shift + /` | Comentário de bloco |
| `F3` | Go to declaration |
| `Ctrl + T` | Type hierarchy |
| `Ctrl + O` | Quick outline |
| `F5` | Step into (debug) |
| `F6` | Step over (debug) |
| `F7` | Step return (debug) |
| `F8` | Resume (debug) |
| `Ctrl + F11` | Run last launched |

#### 🔹 Plugins Essenciais

| Plugin | Função |
|---|---|
| **EclEmma** | Cobertura de código (JaCoCo) |
| **Checkstyle** | Verificação de padrões |
| **FindBugs/SpotBugs** | Detecção de bugs |
| **M2Eclipse** | Suporte a Maven |
| **Buildship** | Suporte a Gradle |
| **Spring Tools 4** | Suporte a Spring Boot |
| **Lombok** | Redução de boilerplate |

---

### 1.3 VS Code

#### 🔹 O que é
Visual Studio Code é um editor leve e extensível da Microsoft, com suporte Java através de extensões.

#### 🔹 Por que usar
- ✅ Extremamente leve e rápido
- ✅ Gratuito
- ✅ Grande variedade de extensões
- ✅ Suporte a múltiplas linguagens
- ✅ Terminal integrado

#### 🔹 Extensões Essenciais para Java

| Extensão | ID | Função |
|---|---|---|
| **Extension Pack for Java** | `vscjava.vscode-java-pack` | Pacote completo Java |
| **Language Support for Java** | `redhat.java` | LSP Java |
| **Debugger for Java** | `vscjava.vscode-java-debug` | Debugging |
| **Test Runner for Java** | `vscjava.vscode-java-test` | Execução de testes |
| **Maven for Java** | `vscjava.vscode-maven` | Suporte Maven |
| **Gradle for Java** | `vscjava.vscode-gradle` | Suporte Gradle |
| **Spring Boot Tools** | `vmware.vscode-spring-boot` | Spring Boot |
| **SonarLint** | `SonarSource.sonarlint-vscode` | Qualidade de código |
| **GitLens** | `eamodio.gitlens` | Git avançado |
| **Error Lens** | `usernamehw.errorlens` | Erros inline |

#### 🔹 Configuração
```json
// settings.json
{
  "java.configuration.updateBuildConfiguration": "automatic",
  "java.compile.nullAnalysis.mode": "automatic",
  "java.format.enabled": true,
  "java.format.profile": "GoogleStyle",
  "java.import.maven.enabled": true,
  "java.import.gradle.enabled": true,
  "java.debug.settings.showHex": false,
  "java.debug.settings.showQualifiedNames": false,
  "java.debug.settings.enableRunDebugCodeLens": true,
  "java.references.includeDecompiledSources": true,
  "editor.suggestSelection": "first",
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "redhat.java",
  "files.encoding": "utf8",
  "terminal.integrated.defaultProfile.windows": "PowerShell"
}
```

#### 🔹 Atalhos Essenciais

| Atalho | Ação |
|---|---|
| `Ctrl + Space` | Content assist |
| `Ctrl + Shift + O` | Organizar imports |
| `Shift + Alt + F` | Formatar código |
| `Ctrl + Shift + P` | Command palette |
| `F5` | Iniciar debug |
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `Ctrl + F5` | Run without debug |
| `Ctrl + Shift + T` | Criar teste |

#### 🔹 Debugging
```
1. Configure launch.json:
   Run → Add Configuration → Java

2. Exemplo launch.json:
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Debug App",
      "request": "launch",
      "mainClass": "com.example.MainClass",
      "projectName": "my-project"
    }
  ]
}

3. Breakpoints:
   - Clique na margem esquerda
   - Breakpoints condicionais: clique direito → Edit Breakpoint

4. Watch Expressions:
   - Adicione expressões no painel "Watch"
   - Variáveis são avaliadas a cada step
```

---

## 2. Build Tools

---

### 2.1 Maven

#### 🔹 O que é
Apache Maven é uma ferramenta de gerenciamento de projeto baseada em um modelo de projeto convencional (pom.xml).

#### 🔹 Por que usar
- ✅ Gerenciamento centralizado de dependências
- ✅ Lifecycle padronizado
- ✅ Extenso ecossistema de plugins
- ✅ Suporte a multi-module
- ✅ Repositórios中央izados (Maven Central)

#### 🔹 Instalação
```bash
# Windows (com Scoop)
scoop install maven

# Windows (manual)
# 1. Baixar de https://maven.apache.org/download.cgi
# 2. Adicionar bin/ ao PATH
# 3. Configurar M2_HOME

# Linux
sudo apt install maven
sudo snap install maven --classic

# macOS
brew install maven

# Verificar instalação
mvn -version
```

#### 🔹 Estrutura do Projeto
```
meu-projeto/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/exemplo/
│   │   │       └── App.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       ├── java/
│       │   └── com/exemplo/
│       │       └── AppTest.java
│       └── resources/
└── target/
```

#### 🔹 Configuração do pom.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <!-- Dados do Projeto -->
    <groupId>com.exemplo</groupId>
    <artifactId>meu-projeto</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <!-- Propriedades -->
    <properties>
        <maven.compiler.source>21</maven.compiler.source>
        <maven.compiler.target>21</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <spring-boot.version>3.2.0</spring-boot.version>
        <junit.version>5.10.1</junit.version>
        <mockito.version>5.8.0</mockito.version>
    </properties>

    <!-- Dependências -->
    <dependencies>
        <!-- Spring Boot Starter Web -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>${spring-boot.version}</version>
        </dependency>

        <!-- Spring Data JPA -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
            <version>${spring-boot.version}</version>
        </dependency>

        <!-- Lombok -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.30</version>
            <scope>provided</scope>
        </dependency>

        <!-- JUnit 5 -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>${junit.version}</version>
            <scope>test</scope>
        </dependency>

        <!-- Mockito -->
        <dependency>
            <groupId>org.mockito</groupId>
            <artifactId>mockito-core</artifactId>
            <version>${mockito.version}</version>
            <scope>test</scope>
        </dependency>

        <!-- MySQL Driver -->
        <dependency>
            <groupId>com.mysql</groupId>
            <artifactId>mysql-connector-j</artifactId>
            <version>8.2.0</version>
        </dependency>
    </dependencies>

    <!-- Build Plugins -->
    <build>
        <plugins>
            <!-- Maven Compiler Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.12.0</version>
                <configuration>
                    <source>21</source>
                    <target>21</target>
                    <annotationProcessorPaths>
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                            <version>1.18.30</version>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>

            <!-- Spring Boot Maven Plugin -->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>${spring-boot.version}</version>
            </plugin>

            <!-- Maven Surefire Plugin (testes) -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.2.3</version>
            </plugin>

            <!-- JaCoCo (cobertura) -->
            <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
                <version>0.8.11</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>prepare-agent</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>report</id>
                        <phase>test</phase>
                        <goals>
                            <goal>report</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>

    <!-- Profiles -->
    <profiles>
        <profile>
            <id>dev</id>
            <properties>
                <activatedProfile>dev</activatedProfile>
            </properties>
            <dependencies>
                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-devtools</artifactId>
                    <version>${spring-boot.version}</version>
                </dependency>
            </dependencies>
        </profile>

        <profile>
            <id>prod</id>
            <properties>
                <activatedProfile>prod</activatedProfile>
            </properties>
        </profile>
    </profiles>
</project>
```

#### 🔹 Lifecycle do Maven

| Fase | Descrição |
|---|---|
| `validate` | Valida estrutura do projeto |
| `compile` | Compila código-fonte |
| `test` | Executa testes |
| `package` | Empacota em JAR/WAR |
| `verify` | Verifica integração |
| `install` | Instala no repositório local |
| `deploy` | Instala no repositório remoto |

#### 🔹 Comandos Essenciais
```bash
# Compilar
mvn compile

# Executar testes
mvn test

# Empacotar (pular testes)
mvn package -DskipTests

# Instalar no repositório local
mvn install

# Deploy
mvn deploy

# Limpar projeto
mvn clean

# Lifecycle completo
mvn clean install

# Gerar site de documentação
mvn site

# Dependência tree
mvn dependency:tree

# Buscar dependência atualizada
mvn versions:display-dependency-updates

# Executar aplicação Spring Boot
mvn spring-boot:run
```

#### 🔹 Comandos com Profiles
```bash
# Ativar profile de desenvolvimento
mvn clean install -Pdev

# Ativar profile de produção
mvn clean install -Pprod

# Profiles de sistema
mvn clean install -Dspring.profiles.active=dev
```

---

### 2.2 Gradle

#### 🔹 O que é
Gradle é uma ferramenta de build moderna e flexível, utilizada por grandes projetos como Android, Spring Boot e Kafka.

#### 🔹 Por que usar
- ✅ Mais rápido que Maven (build incremental, cache)
- ✅ DSL expressivo (Groovy ou Kotlin)
- ✅ Build caches e demon
- ✅ Flexível e customizável
- ✅ Gradle Wrapper garante versão consistente

#### 🔹 Instalação
```bash
# Windows (com Scoop)
scoop install gradle

# Linux
sudo apt install gradle

# macOS
brew install gradle

# Gradle Wrapper (recomendado)
gradle wrapper --gradle-version 8.5

# Verificar
gradle --version
./gradlew --version  # Usando wrapper
```

#### 🔹 Configuração do build.gradle
```groovy
// build.gradle (Groovy DSL)
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}

group = 'com.exemplo'
version = '1.0.0-SNAPSHOT'

java {
    sourceCompatibility = '21'
    targetCompatibility = '21'
}

configurations {
    compileOnly {
        extendsFrom annotationProcessor
    }
}

repositories {
    mavenCentral()
}

dependencies {
    // Spring Boot
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-validation'

    // Lombok
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'

    // MySQL
    runtimeOnly 'com.mysql:mysql-connector-j'

    // Testes
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testImplementation 'org.mockito:mockito-core'
    testImplementation 'org.testcontainers:testcontainers:1.19.3'
    testImplementation 'org.testcontainers:junit-jupiter:1.19.3'
    testImplementation 'org.testcontainers:mysql:1.19.3'
}

// Tarefas customizadas
tasks.named('test') {
    useJUnitPlatform()
}

tasks.named('bootRun') {
    // Ativar hot reload
    systemProperty 'springdevtools.restart.enabled', 'true'
}

// Build scan
buildScan {
    termsOfServiceUrl = 'https://gradle.com/terms-of-service'
    termsOfServiceAgree = 'yes'
}
```

#### 🔹 build.gradle.kts (Kotlin DSL)
```kotlin
// build.gradle.kts
plugins {
    java
    id("org.springframework.boot") version "3.2.0"
    id("io.spring.dependency-management") version "1.1.4"
}

group = "com.exemplo"
version = "1.0.0-SNAPSHOT"

java {
    sourceCompatibility = JavaVersion.VERSION_21
    targetCompatibility = JavaVersion.VERSION_21
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")

    compileOnly("org.projectlombok:lombok")
    annotationProcessor("org.projectlombok:lombok")

    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testImplementation("org.mockito:mockito-core")
}

tasks.withType<Test> {
    useJUnitPlatform()
}
```

#### 🔹 Tarefas Essenciais
```bash
# Compilar
./gradlew compileJava

# Executar testes
./gradlew test

# Build completo
./gradlew build

# Limpar
./gradlew clean

# Build limpo
./gradlew clean build

# Executar aplicação
./gradlew bootRun

# Gerar relatório de dependências
./gradlew dependencies

# Gerar relatório de dependências em árvore
./gradlew dependencyInsight --dependency spring-boot-starter-web

# Build scan (online)
./gradlew build --scan

# Listar tarefas disponíveis
./gradlew tasks

# Verificar atualizações
./gradlew dependencyUpdates

# Fat JAR (bootJar)
./gradlew bootJar
```

#### 🔹 Multi-Module Project
```
root-project/
├── build.gradle
├── settings.gradle
├── module-api/
│   ├── build.gradle
│   └── src/
├── module-service/
│   ├── build.gradle
│   └── src/
└── module-repository/
    ├── build.gradle
    └── src/
```

```groovy
// settings.gradle
rootProject.name = 'my-project'
include 'module-api', 'module-service', 'module-repository'

// root build.gradle
subprojects {
    apply plugin: 'java'

    group = 'com.exemplo'
    version = '1.0.0-SNAPSHOT'

    java {
        sourceCompatibility = '21'
    }

    repositories {
        mavenCentral()
    }
}

// module-service/build.gradle
dependencies {
    implementation project(':module-api')
    implementation project(':module-repository')
}
```

#### 🔹 Gradle Wrapper
```bash
# Gerar wrapper (executar apenas uma vez)
gradle wrapper

# Usar wrapper (recomendado)
./gradlew build          # Linux/macOS
gradlew.bat build        # Windows

# Atualizar versão do wrapper
./gradlew wrapper --gradle-version 8.5
```

---

## 3. Testing

---

### 3.1 JUnit 5

#### 🔹 O que é
JUnit 5 é o framework de teste padrão para Java, composto por JUnit Platform, JUnit Jupiter e JUnit Vintage.

#### 🔹 Por que usar
- ✅ Padrão da indústria para testes Java
- ✅ Annotations expressivas
- ✅ Suporte a parametrização
- ✅ Nested tests para melhor organização
- ✅ Extensions para customização
- ✅ Integração com IDEs e build tools

#### 🔹 Instalação
```xml
<!-- Maven -->
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.10.1</version>
    <scope>test</scope>
</dependency>
```

```groovy
// Gradle
testImplementation 'org.junit.jupiter:junit-jupiter:5.10.1'
testRuntimeOnly 'org.junit.platform:junit-platform-launcher'
```

#### 🔹 Annotations Essenciais

| Annotation | Descrição |
|---|---|
| `@Test` | Marca método como teste |
| `@DisplayName` | Nome legível para o teste |
| `@BeforeEach` | Executa antes de cada teste |
| `@AfterEach` | Executa após cada teste |
| `@BeforeAll` | Executa antes de todos os testes (static) |
| `@AfterAll` | Executa após todos os testes (static) |
| `@Disabled` | Desabilita teste |
| `@Nested` | Grupo de testes aninhados |
| `@Tag` | Categoriza testes |
| `@ExtendWith` | Registra extensões |
| `@ParameterizedTest` | Teste parametrizado |
| `@ValueSource` | Fonte de valores simples |
| `@CsvSource` | Fonte CSV |
| `@MethodSource` | Fonte de método |
| `@TempDir` | Diretório temporário |

#### 🔹 Assertions

```java
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import static org.junit.jupiter.api.Assertions.*;

class CalculadoraTest {

    @Test
    @DisplayName("Deve somar dois números corretamente")
    void deveSomarDoisNumeros() {
        Calculadora calc = new Calculadora();
        assertEquals(5, calc.somar(2, 3));
    }

    @Test
    @DisplayName("Deve lançar exceção ao dividir por zero")
    void deveLancarExcecaoAoDividirPorZero() {
        Calculadora calc = new Calculadora();
        assertThrows(ArithmeticException.class,
            () -> calc.dividir(10, 0));
    }

    @Test
    @DisplayName("Deve verificar que arrays são iguais")
    void deveVerificarArrays() {
        int[] esperado = {1, 2, 3};
        int[] resultado = {1, 2, 3};
        assertArrayEquals(esperado, resultado);
    }

    @Test
    @DisplayName("Deve verificar que objetos são iguais")
    void deveVerificarObjetos() {
        Pessoa p1 = new Pessoa("João", 25);
        Pessoa p2 = new Pessoa("João", 25);
        assertEquals(p1, p2);
    }

    @Test
    @DisplayName("Deve verificar que condição é verdadeira")
    void deveVerificarCondicao() {
        int idade = 18;
        assertTrue(idade >= 18, "Idade deve ser maior ou igual a 18");
    }

    @Test
    @DisplayName("Deve verificar que collections são iguais")
    void deveVerificarCollections() {
        List<String> esperado = List.of("a", "b", "c");
        List<String> resultado = List.of("a", "b", "c");
        assertEquals(esperado, resultado);
    }

    @Test
    @DisplayName("Deve executar asserts multicast")
    void deveExecutarAssertsMulticast() {
        assertAll("Verificações da pessoa",
            () -> assertEquals("João", pessoa.getNome()),
            () -> assertEquals(25, pessoa.getIdade()),
            () -> assertNotNull(pessoa.getEmail())
        );
    }
}
```

#### 🔹 Assumptions
```java
import org.junit.jupiter.api.Assumptions;

class AssumptionsTest {

    @Test
    @DisplayName("Executa apenas em CI")
    void executaApenasEmCI() {
        Assumptions.assumeTrue(
            "CI".equals(System.getenv("ENVIRONMENT")),
            "Executando apenas no CI"
        );
        // Teste só executa se a condição for verdadeira
    }

    @Test
    @DisplayName("Executa apenas com banco disponível")
    void executaComBanco() {
        Assumptions.assumeTrue(
            isDatabaseAvailable(),
            "Banco de dados não disponível"
        );
    }
}
```

#### 🔹 Parameterized Tests
```java
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.*;

class ParameterizedTestExample {

    @ParameterizedTest
    @ValueSource(strings = {"Java", "Python", "JavaScript"})
    void deveReconhecerLinguagens(String linguagem) {
        assertNotNull(linguagem);
        assertFalse(linguagem.isEmpty());
    }

    @ParameterizedTest
    @CsvSource({
        "1, 1, 2",
        "2, 3, 5",
        "10, 20, 30",
        "-1, 1, 0"
    })
    void deveSomarCorretamente(int a, int b, int esperado) {
        assertEquals(esperado, new Calculadora().somar(a, b));
    }

    @ParameterizedTest
    @CsvFileSource(resources = "/dados-teste.csv", numLinesToSkip = 1)
    void deveLerCSV(int a, int b, int esperado) {
        assertEquals(esperado, new Calculadora().somar(a, b));
    }

    @ParameterizedTest
    @MethodSource("fonteDeDados")
    void deveUsarMethodSource(String entrada, String esperado) {
        assertEquals(esperado, ProcessadorTexto.processar(entrada));
    }

    static Stream<Arguments> fonteDeDados() {
        return Stream.of(
            Arguments.of("  hello  ", "hello"),
            Arguments.of("HELLO", "hello"),
            Arguments.of("  HELLO  ", "hello")
        );
    }
}
```

#### 🔹 Nested Tests
```java
class ContaBancariaTest {

    private ContaBancaria conta;

    @BeforeEach
    void setUp() {
        conta = new ContaBancaria("João", 1000.0);
    }

    @Nested
    @DisplayName("Depósitos")
    class Depositos {

        @Test
        @DisplayName("Deve depositar valor positivo")
        void deveDepositarValorPositivo() {
            conta.depositar(500);
            assertEquals(1500, conta.getSaldo());
        }

        @Test
        @DisplayName("Não deve depositar valor negativo")
        void naoDeveDepositarValorNegativo() {
            assertThrows(IllegalArgumentException.class,
                () -> conta.depositar(-100));
        }
    }

    @Nested
    @DisplayName("Saques")
    class Saques {

        @Test
        @DisplayName("Deve sacar valor válido")
        void deveSacarValorValido() {
            conta.sacar(500);
            assertEquals(500, conta.getSaldo());
        }

        @Test
        @DisplayName("Não deve sacar mais que o saldo")
        void naoDeveSacarMaisQueSaldo() {
            assertThrows(SaldoInsuficienteException.class,
                () -> conta.sacar(2000));
        }
    }

    @Nested
    @DisplayName("Transferências")
    class Transferencias {

        @Test
        @DisplayName("Deve transferir para outra conta")
        void deveTransferir() {
            ContaBancaria outraConta = new ContaBancaria("Maria", 500);
            conta.transferir(outraConta, 300);
            assertEquals(700, conta.getSaldo());
            assertEquals(800, outraConta.getSaldo());
        }
    }
}
```

#### 🔹 Extensions
```java
// Custom Extension
public class TempoExecucaoExtension implements BeforeEachCallback, AfterEachCallback {

    private long inicio;

    @Override
    public void beforeEach(ExtensionContext context) {
        inicio = System.currentTimeMillis();
    }

    @Override
    public void afterEach(ExtensionContext context) {
        long duracao = System.currentTimeMillis() - inicio;
        System.out.println("Teste " + context.getDisplayName()
            + " executou em " + duracao + "ms");
    }
}

// Usando a extension
@ExtendWith(TempoExecucaoExtension.class)
class MinhaClasseTest {

    @Test
    void testeComTempo() {
        // ...
    }
}
```

---

### 3.2 Mockito

#### 🔹 O que é
Mockito é a biblioteca mais popular para criação de mocks em Java, permitindo testar unidades de forma isolada.

#### 🔹 Por que usar
- ✅ Simula comportamento de dependências
- ✅ Verifica interações entre objetos
- ✅ Fácil de usar e configurar
- ✅ Integração nativa com JUnit 5

#### 🔹 Instalação
```xml
<!-- Maven -->
<dependency>
    <groupId>org.mockito</groupId>
    <artifactId>mockito-core</artifactId>
    <version>5.8.0</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.mockito</groupId>
    <artifactId>mockito-junit-jupiter</artifactId>
    <version>5.8.0</version>
    <scope>test</scope>
</dependency>
```

```groovy
// Gradle
testImplementation 'org.mockito:mockito-core:5.8.0'
testImplementation 'org.mockito:mockito-junit-jupiter:5.8.0'
```

#### 🔹 Mocking e Stubbing
```java
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
class PedidoServiceTest {

    @Mock
    private PedidoRepository pedidoRepository;

    @Mock
    private EmailService emailService;

    @InjectMocks
    private PedidoService pedidoService;

    @Test
    @DisplayName("Deve criar pedido e enviar email")
    void deveCriarPedidoEEnviarEmail() {
        // Arrange
        Pedido pedido = new Pedido("Produto A", 2);
        when(pedidoRepository.save(any(Pedido.class)))
            .thenReturn(pedido.withId(1L));
        doNothing().when(emailService).enviarEmail(anyString());

        // Act
        Pedido resultado = pedidoService.criarPedido(pedido);

        // Assert
        assertNotNull(resultado);
        assertEquals(1L, resultado.getId());
        verify(pedidoRepository, times(1)).save(any(Pedido.class));
        verify(emailService, times(1)).enviarEmail(anyString());
    }

    @Test
    @DisplayName("Deve lançar exceção quando estoque insuficiente")
    void deveLancarExcecaoEstoqueInsuficiente() {
        // Arrange
        Pedido pedido = new Pedido("Produto B", 100);
        when(pedidoRepository.save(any()))
            .thenThrow(new EstoqueInsuficienteException());

        // Act & Assert
        assertThrows(EstoqueInsuficienteException.class,
            () -> pedidoService.criarPedido(pedido));
    }
}
```

#### 🔹 Verification
```java
@Test
void deveVerificarInteracoes() {
    // Verificar que foi chamado uma vez
    verify(pedidoRepository, times(1)).save(any());

    // Verificar que nunca foi chamado
    verify(emailService, never()).enviarEmail(any());

    // Verificar no mínimo uma vez
    verify(pedidoRepository, atLeastOnce()).save(any());

    // Verificar no máximo 3 vezes
    verify(pedidoRepository, atMost(3)).save(any());

    // Verificar ordem de chamadas
    InOrder inOrder = inOrder(pedidoRepository, emailService);
    inOrder.verify(pedidoRepository).save(any());
    inOrder.verify(emailService).enviarEmail(any());

    // Verificar que não houve mais interações
    verifyNoMoreInteractions(pedidoRepository);
    verifyNoInteractions(emailService);
}
```

#### 🔹 Argument Matchers
```java
@Test
void deveUsarArgumentMatchers() {
    // any() - qualquer valor
    when(pedidoRepository.save(any(Pedido.class))).thenReturn(pedido);

    // anyString() - qualquer string
    when(emailService.enviarEmail(anyString())).thenReturn(true);

    // eq() - valor exato
    when(pedidoRepository.findById(eq(1L))).thenReturn(Optional.of(pedido));

    // contains() - string contém
    when(emailService.enviarEmail(contains("@exemplo.com"))).thenReturn(true);

    // startsWith() - string começa com
    when(emailService.enviarEmail(startsWith("Subject:"))).thenReturn(true);

    // argThat() - predicado customizado
    when(pedidoRepository.save(argThat(p -> p.getQuantidade() > 0)))
        .thenReturn(pedido);
}
```

#### 🔹 Spy
```java
@Test
void deveUsarSpy() {
    // Spy mantém comportamento real, permite stubbing parcial
    PedidoService realService = new PedidoService();
    PedidoService spyService = spy(realService);

    // Stubbing parcial
    doReturn(true).when(spyService).enviarNotificacao(any());

    // Comportamento real mantém para outros métodos
    Pedido resultado = spyService.criarPedido(pedido);
    assertNotNull(resultado);
}
```

---

### 3.3 TestContainers

#### 🔹 O que é
TestContainers é uma biblioteca para testes de integração que fornece instâncias Docker de bancos de dados, message brokers e outros serviços.

#### 🔹 Por que usar
- ✅ Testes de integração reais
- ✅ Isolamento entre testes
- ✅ Suporte a MySQL, PostgreSQL, MongoDB, Redis, Kafka, etc.
- ✅ Lifecycle automático (iniciar/parar containers)

#### 🔹 Instalação
```xml
<!-- Maven -->
<dependency>
    <groupId>org.testcontainers</groupId>
    <artifactId>testcontainers</artifactId>
    <version>1.19.3</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.testcontainers</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>1.19.3</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.testcontainers</groupId>
    <artifactId>mysql</artifactId>
    <version>1.19.3</version>
    <scope>test</scope>
</dependency>
```

#### 🔹 Database Testing
```java
import org.junit.jupiter.api.Test;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

import static org.junit.jupiter.api.Assertions.*;

@Testcontainers
class UsuarioRepositoryIntegrationTest {

    @Container
    static MySQLContainer<?> mysql = new MySQLContainer<>("mysql:8.0")
        .withDatabaseName("testdb")
        .withUsername("test")
        .withPassword("test")
        .withInitScript("schema.sql");

    @Test
    void deveInserirEBuscarUsuario() {
        try (Connection conn = DriverManager.getConnection(
                mysql.getJdbcUrl(),
                mysql.getUsername(),
                mysql.getPassword())) {

            // Inserir dados
            conn.createStatement().executeUpdate(
                "INSERT INTO usuarios (nome, email) VALUES ('João', 'joao@test.com')"
            );

            // Buscar dados
            ResultSet rs = conn.createStatement()
                .executeQuery("SELECT * FROM usuarios WHERE nome = 'João'");

            assertTrue(rs.next());
            assertEquals("joao@test.com", rs.getString("email"));
        }
    }
}
```

#### 🔹 Integration Tests com Spring
```java
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Testcontainers
class UsuarioServiceIntegrationTest {

    @Container
    static MySQLContainer<?> mysql = new MySQLContainer<>("mysql:8.0")
        .withDatabaseName("testdb")
        .withUsername("test")
        .withPassword("test");

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", mysql::getJdbcUrl);
        registry.add("spring.datasource.username", mysql::getUsername);
        registry.add("spring.datasource.password", mysql::getPassword);
    }

    @Autowired
    private UsuarioService usuarioService;

    @Test
    void deveCriarEBuscarUsuario() {
        Usuario usuario = new Usuario("Maria", "maria@test.com");
        Usuario salvo = usuarioService.salvar(usuario);

        assertNotNull(salvo.getId());
        assertEquals("Maria", salvo.getNome());
    }
}
```

---

### 3.4 Cucumber

#### 🔹 O que é
Cucumber é uma ferramenta de testes BDD (Behavior-Driven Development) que permite escrever testes em linguagem natural.

#### 🔹 Por que usar
- ✅ Testes legíveis para stakeholders não técnicos
- ✅ Documentação viva do comportamento
- ✅ Separação entre spec e implementação
- ✅ Integração com JUnit 5

#### 🔹 Instalação
```xml
<!-- Maven -->
<dependency>
    <groupId>io.cucumber</groupId>
    <artifactId>cucumber-java</artifactId>
    <version>7.15.0</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>io.cucumber</groupId>
    <artifactId>cucumber-junit-platform-engine</artifactId>
    <version>7.15.0</version>
    <scope>test</scope>
</dependency>
```

#### 🔹 Feature Files
```gherkin
# src/test/resources/features/usuario.feature
Funcionalidade: Gerenciamento de Usuários

  Como usuário do sistema
  Quero cadastrar e gerenciar meus dados
  Para manter minhas informações atualizadas

  Cenário: Cadastrar novo usuário
    Dado que estou na página de cadastro
    Quando preencho o nome "João Silva"
    E preencho o email "joao@email.com"
    E clico em salvar
    Então devo ver a mensagem "Usuário cadastrado com sucesso"

  Cenário: Tentar cadastrar com email inválido
    Dado que estou na página de cadastro
    Quando preencho o nome "Maria"
    E preencho o email "email-invalido"
    E clico em salvar
    Então devo ver a mensagem de erro "Email inválido"

  Esquema do Cenário: Validar idade mínima
    Dado que estou na página de cadastro
    Quando informo a idade <idade>
    Então o resultado deve ser "<resultado>"

    Exemplos:
      | idade | resultado    |
      | 18    | permitido    |
      | 17    | não permitido |
      | 25    | permitido    |
```

#### 🔹 Step Definitions
```java
import io.cucumber.java.pt.Dado;
import io.cucumber.java.pt.Quando;
import io.cucumber.java.pt.Então;
import io.cucumber.java.Before;
import io.cucumber.java.After;

public class UsuarioSteps {

    private WebDriver driver;
    private UsuarioPage usuarioPage;

    @Before
    public void setUp() {
        driver = new ChromeDriver();
        usuarioPage = new UsuarioPage(driver);
    }

    @After
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }

    @Dado("que estou na página de cadastro")
    public void queEstouNaPaginaDeCadastro() {
        usuarioPage.navegarParaCadastro();
    }

    @Quando("preencho o nome {string}")
    public void preenchoONome(String nome) {
        usuarioPage.preencherNome(nome);
    }

    @Quando("preencho o email {string}")
    public void preenchoOEmail(String email) {
        usuarioPage.preencherEmail(email);
    }

    @Quando("clico em salvar")
    public void clicoEmSalvar() {
        usuarioPage.clicarSalvar();
    }

    @Então("devo ver a mensagem {string}")
    public void devoVerAMensagem(String mensagem) {
        assertEquals(mensagem, usuarioPage.getMensagemSucesso());
    }

    @Então("devo ver a mensagem de erro {string}")
    public void devoVerAMensagemDeErro(String mensagem) {
        assertEquals(mensagem, usuarioPage.getMensagemErro());
    }

    @Quando("informo a idade {int}")
    public void informoAIdade(int idade) {
        usuarioPage.preencherIdade(idade);
    }

    @Então("o resultado deve ser {string}")
    public void oResultadoDeveSer(String resultado) {
        assertEquals(resultado, usuarioPage.getResultadoIdade());
    }
}
```

---

## 4. Code Quality

---

### 4.1 SonarQube

#### 🔹 O que é
SonarQube é uma plataforma de análise de qualidade de código que detecta bugs, vulnerabilidades e code smells.

#### 🔹 Por que usar
- ✅ Análise contínua de qualidade
- ✅ Quality Gates para garantir padrões
- ✅ Suporte a 25+ linguagens
- ✅ Histórico de qualidade ao longo do tempo
- ✅ Integração com CI/CD

#### 🔹 Instalação
```bash
# Docker (recomendado)
docker run -d --name sonarqube -p 9000:9000 sonarqube:latest

# Acessar: http://localhost:9000
# Login: admin / admin (alterar senha no primeiro acesso)
```

#### 🔹 Configuração com Maven
```xml
<!-- pom.xml -->
<plugin>
    <groupId>org.sonarsource.scanner.maven</groupId>
    <artifactId>sonar-maven-plugin</artifactId>
    <version>3.10.0.2594</version>
</plugin>
```

```bash
# Executar análise
mvn sonar:sonar \
  -Dsonar.projectKey=my-project \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=sqp_xxxxxxxxxxxx
```

#### 🔹 Configuração com Gradle
```groovy
// build.gradle
plugins {
    id 'org.sonarqube' version '4.4.1.3373'
}

sonar {
    properties {
        property "sonar.projectKey", "my-project"
        property "sonar.host.url", "http://localhost:9000"
        property "sonar.login", "sqp_xxxxxxxxxxxx"
    }
}
```

```bash
# Executar análise
./gradlew sonarqube
```

#### 🔹 Quality Gates
```
Configuração padrão (Sonar Way):
├── Novo código deve ter:
│   ├── 0 Bugs novos
│   ├── 0 Vulnerabilidades novas
│   ├── 0 Code Smells novos
│   ├── Cobertura > 80%
│   └── Duplicações < 3%
└── Código existente deve manter:
    ├── Mantido conforme padrão
    └── Cobertura não degradada
```

---

### 4.2 Checkstyle

#### 🔹 O que é
Checkstyle é uma ferramenta que verifica se o código segue padrões de codificação definidos.

#### 🔹 Por que usar
- ✅ Padronização de código
- ✅ Deteção automática de violações
- ✅ Configuração customizável
- ✅ Integração com Maven e Gradle

#### 🔹 Configuração
```xml
<!-- pom.xml -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-checkstyle-plugin</artifactId>
    <version>3.3.1</version>
    <dependencies>
        <dependency>
            <groupId>com.puppycrawl.tools</groupId>
            <artifactId>checkstyle</artifactId>
            <version>10.12.5</version>
        </dependency>
    </dependencies>
    <configuration>
        <configLocation>checkstyle.xml</configLocation>
        <consoleOutput>true</consoleOutput>
        <failsOnError>true</failsOnError>
        <linkXRef>false</linkXRef>
    </configuration>
</plugin>
```

```xml
<!-- checkstyle.xml -->
<?xml version="1.0"?>
<!DOCTYPE module PUBLIC
    "-//Checkstyle//DTD Checkstyle Configuration 1.3//EN"
    "https://checkstyle.org/dtds/configuration_1_3.dtd">

<module name="Checker">
    <property name="charset" value="UTF-8"/>
    <property name="severity" value="error"/>

    <!-- Regras de Kod -->
    <module name="TreeWalker">
        <!-- Nomes de classes -->
        <module name="TypeName">
            <property name="format" value="^[A-Z][a-zA-Z0-9]*$"/>
        </module>

        <!-- Nomes de métodos -->
        <module name="MethodName">
            <property name="format" value="^[a-z][a-zA-Z0-9]*$"/>
        </module>

        <!-- Tamanho da linha -->
        <module name="LineLength">
            <property name="max" value="120"/>
        </module>

        <!-- Imports -->
        <module name="AvoidStarImport"/>
        <module name="UnusedImports"/>

        <!-- Espaços -->
        <module name="GenericWhitespace"/>
        <module name="NoWhitespaceAfter"/>
        <module name="NoWhitespaceBefore"/>

        <!-- Chaves -->
        <module name="LeftCurly"/>
        <module name="RightCurly"/>
        <module name="NeedBraces"/>

        <!-- Indentação -->
        <module name="Indentation">
            <property name="basicOffset" value="4"/>
            <property name="caseIndent" value="4"/>
        </module>
    </module>
</module>
```

#### 🔹 Executar
```bash
# Maven
mvn checkstyle:check

# Gradle
./gradlew checkstyleMain
```

---

### 4.3 SpotBugs

#### 🔹 O que é
SpotBugs é um fork do FindBugs que detecta bugs potenciais em código Java através de análise estática.

#### 🔹 Por que usar
- ✅ Detecta bugs silenciosos
- ✅ Análise profunda de bytecode
- ✅ Baixa taxa de falsos positivos
- ✅ Integração com IDEs e CI/CD

#### 🔹 Configuração
```xml
<!-- pom.xml -->
<plugin>
    <groupId>com.github.spotbugs</groupId>
    <artifactId>spotbugs-maven-plugin</artifactId>
    <version>4.8.3.0</version>
    <configuration>
        <effort>Max</effort>
        <threshold>Medium</threshold>
        <xmlOutput>true</xmlOutput>
    </configuration>
</plugin>
```

```groovy
// build.gradle
plugins {
    id 'com.github.spotbugs' version '6.0.4'
}

spotbugs {
    effort = 'max'
    reportLevel = 'medium'
    ignoreFailures = false
}

tasks.withType(com.github.spotbugs.snom.SpotBugsTask) {
    reports {
        xml.required = true
        html.required = true
    }
}
```

#### 🔹 Bug Patterns Comuns

| Pattern | Severidade | Descrição |
|---|---|---|
| `NP_NULL_ON_SOME_PATH` | High | Possível NullPointerException |
| `RCN_REDUNDANT_NULLCHECK` | Medium | Null check redundante |
| `URF_UNREAD_FIELD` | Low | Campo nunca lido |
| `EI_EXPOSE_REP` | Medium | Exposição de representação interna |
| `DM_DEFAULT_ENCODING` | Medium | Encoding não especificado |
| `SQL_NONCONSTANT_STRING` | High | SQL com string não constante |
| `RV_RETURN_VALUE_IGNORED` | Medium | Retorno de método ignorado |

#### 🔹 Executar
```bash
# Maven
mvn spotbugs:check
mvn spotbugs:gui  # Interface gráfica

# Gradle
./gradlew spotbugsMain
./gradlew spotbugsTest
```

---

### 4.4 JaCoCo

#### 🔹 O que é
JaCoCo é uma ferramenta de cobertura de código que gera relatórios detalhados de execução.

#### 🔹 Por que usar
- ✅ Mede cobertura de código
- ✅ Identifica código não testado
- ✅ Gera relatórios em HTML, XML e CSV
- ✅ Integra com SonarQube e CI/CD

#### 🔹 Configuração
```xml
<!-- pom.xml -->
<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.11</version>
    <executions>
        <execution>
            <id>prepare-agent</id>
            <goals>
                <goal>prepare-agent</goal>
            </goals>
        </execution>
        <execution>
            <id>report</id>
            <phase>test</phase>
            <goals>
                <goal>report</goal>
            </goals>
        </execution>
        <execution>
            <id>check</id>
            <goals>
                <goal>check</goal>
            </goals>
            <configuration>
                <rules>
                    <rule>
                        <element>BUNDLE</element>
                        <limits>
                            <limit>
                                <counter>LINE</counter>
                                <value>COVEREDRATIO</value>
                                <minimum>0.80</minimum>
                            </limit>
                            <limit>
                                <counter>BRANCH</counter>
                                <value>COVEREDRATIO</value>
                                <minimum>0.70</minimum>
                            </limit>
                        </limits>
                    </rule>
                </rules>
            </configuration>
        </execution>
    </executions>
</plugin>
```

```groovy
// build.gradle
plugins {
    id 'jacoco'
}

jacoco {
    toolVersion = "0.8.11"
}

test {
    finalizedBy jacocoTestReport
}

jacocoTestReport {
    reports {
        xml.required = true
        html.required = true
    }
}

jacocoTestCoverageVerification {
    violationRules {
        rule {
            limit {
                minimum = 0.80  // 80% line coverage
            }
        }
    }
}

// Executar verificação
check.dependsOn jacocoTestCoverageVerification
```

#### 🔹 Métricas de Cobertura

| Métrica | Descrição | Meta Recomendada |
|---|---|---|
| **Line Coverage** | % de linhas executadas | ≥ 80% |
| **Branch Coverage** | % de branches executados | ≥ 70% |
| **Method Coverage** | % de métodos executados | ≥ 90% |
| **Class Coverage** | % de classes testadas | ≥ 100% |
| **Complexity Coverage** | % de complexidade coberta | ≥ 75% |

#### 🔹 Relatório
```bash
# Maven
mvn test
# Relatório em: target/site/jacoco/index.html

# Gradle
./gradlew test jacocoTestReport
# Relatório em: build/reports/jacoco/test/html/index.html
```

---

## 5. Documentation

---

### 5.1 Javadoc

#### 🔹 O que é
Javadoc é a ferramenta padrão do Java para geração de documentação a partir de comentários no código-fonte.

#### 🔹 Por que usar
- ✅ Documentação automática a partir do código
- ✅ Padrão da indústria Java
- ✅ Integração com IDEs
- ✅ Gera HTML navegável

#### 🔹 Sintaxe Básica
```java
/**
 * Representa um usuário do sistema.
 *
 * <p>Esta classe gerencia as informações básicas de um usuário,
 * incluindo nome, email e data de criação.</p>
 *
 * @author João Silva
 * @version 2.0
 * @since 1.0
 * @see Pedido
 * @see ServicoEmail
 */
public class Usuario {

    /** Nome completo do usuário. */
    private String nome;

    /**
     * Email do usuário.
     *
     * <p>O email deve ser único no sistema e válido.</p>
     *
     * @see #validarEmail(String)
     */
    private String email;

    /**
     * Cria um novo usuário.
     *
     * @param nome  o nome completo do usuário (não pode ser nulo)
     * @param email o email do usuário (deve ser válido)
     * @throws IllegalArgumentException se o email for inválido
     * @throws NullPointerException     se o nome for nulo
     */
    public Usuario(String nome, String email) {
        if (nome == null) {
            throw new NullPointerException("Nome não pode ser nulo");
        }
        if (!validarEmail(email)) {
            throw new IllegalArgumentException("Email inválido: " + email);
        }
        this.nome = nome;
        this.email = email;
    }

    /**
     * Valida o formato do email.
     *
     * @param email o email a ser validado
     * @return {@code true} se o email for válido, {@code false} caso contrário
     */
    public static boolean validarEmail(String email) {
        return email != null && email.contains("@");
    }

    /**
     * Obtém o nome do usuário.
     *
     * @return o nome completo do usuário
     */
    public String getNome() {
        return nome;
    }

    /**
     * Atualiza o nome do usuário.
     *
     * @param novoNome o novo nome (não pode ser nulo ou vazio)
     * @throws IllegalArgumentException se o nome for nulo ou vazio
     */
    public void setNome(String novoNome) {
        if (novoNome == null || novoNome.isBlank()) {
            throw new IllegalArgumentException("Nome inválido");
        }
        this.nome = novoNome;
    }

    /**
     * Retorna uma representação textual do usuário.
     *
     * @return string no formato "Usuario{nome='...', email='...'}"
     */
    @Override
    public String toString() {
        return String.format("Usuario{nome='%s', email='%s'}", nome, email);
    }
}
```

#### 🔹 Tags Disponíveis

| Tag | Descrição |
|---|---|
| `@param` | Descreve um parâmetro |
| `@return` | Descreve o valor retornado |
| `@throws` / `@exception` | Descreve exceções lançadas |
| `@see` | Referência cruzada |
| `@since` | Versão em que foi adicionado |
| `@version` | Versão da classe |
| `@author` | Autor |
| `@deprecated` | Marca como obsoleto |
| `@link` | Link para outra classe/método |
| `@code` | Formata como código |
| `@literal` | Texto literal (não interpretado) |
| `@inheritDoc` | Herda documentação da superclasse |

#### 🔹 Gerando Javadoc
```bash
# Maven
mvn javadoc:javadoc

# Gradle
./gradlew javadoc

# Com opções
javadoc -d doc -author -version -windowtitle "API" src/**/*.java
```

---

### 5.2 Swagger/OpenAPI

#### 🔹 O que é
Swagger (OpenAPI) é um framework para documentação e consumo de APIs REST, com UI interativa e especificação padronizada.

#### 🔹 Por que usar
- ✅ Documentação interativa da API
- ✅ Teste direto na documentação
- ✅ Geração automática de clientes
- ✅ Padronização de contratos de API

#### 🔹 Configuração (Spring Boot 3)
```xml
<!-- pom.xml -->
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.3.0</version>
</dependency>
```

```yaml
# application.yml
springdoc:
  api-docs:
    path: /api-docs
  swagger-ui:
    path: /swagger-ui.html
    operationsSorter: method
    tagsSorter: alpha
    tryItOutEnabled: true
```

#### 🔹 Anotações
```java
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@RequestMapping("/api/usuarios")
@Tag(name = "Usuários", description = "Operações de gerenciamento de usuários")
public class UsuarioController {

    private final UsuarioService usuarioService;

    public UsuarioController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @GetMapping("/{id}")
    @Operation(
        summary = "Buscar usuário por ID",
        description = "Retorna um usuário pelo seu identificador único"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "Usuário encontrado",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = UsuarioResponse.class)
            )
        ),
        @ApiResponse(
            responseCode = "404",
            description = "Usuário não encontrado",
            content = @Content
        )
    })
    public ResponseEntity<UsuarioResponse> buscarPorId(
            @Parameter(description = "ID do usuário") @PathVariable Long id) {
        return usuarioService.buscarPorId(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    @Operation(
        summary = "Criar novo usuário",
        description = "Cria um novo usuário no sistema"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "201",
            description = "Usuário criado com sucesso"
        ),
        @ApiResponse(
            responseCode = "400",
            description = "Dados inválidos"
        )
    })
    public ResponseEntity<UsuarioResponse> criar(
            @RequestBody @Valid UsuarioRequest request) {
        UsuarioResponse response = usuarioService.criar(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping
    @Operation(summary = "Listar todos os usuários")
    public ResponseEntity<List<UsuarioResponse>> listar(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(usuarioService.listar(page, size));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Atualizar usuário")
    public ResponseEntity<UsuarioResponse> atualizar(
            @PathVariable Long id,
            @RequestBody @Valid UsuarioRequest request) {
        return ResponseEntity.ok(usuarioService.atualizar(id, request));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Remover usuário")
    public ResponseEntity<Void> remover(@PathVariable Long id) {
        usuarioService.remover(id);
        return ResponseEntity.noContent().build();
    }
}
```

#### 🔹 Acessar UI
```
Swagger UI:  http://localhost:8080/swagger-ui.html
API Docs:    http://localhost:8080/api-docs
OpenAPI JSON: http://localhost:8080/api-docs
```

---

## 6. Deployment

---

### 6.1 Docker

#### 🔹 O que é
Docker é uma plataforma de containerização que permite empacotar aplicações com suas dependências.

#### 🔹 Por que usar
- ✅ Consistência entre ambientes
- ✅ Isolamento de dependências
- ✅ Deploy rápido e reproduzível
- ✅ Escalabilidade horizontal

#### 🔹 Dockerfile para Java
```dockerfile
# Dockerfile - Multi-stage build
# Stage 1: Build
FROM eclipse-temurin:21-jdk-jammy AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN apt-get update && apt-get install -y maven
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:21-jre-jammy AS runtime
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENV JAVA_OPTS="-Xms512m -Xmx1024m"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
```

#### 🔹 Multi-stage Build (Gradle)
```dockerfile
# Stage 1: Build
FROM eclipse-temurin:21-jdk-jammy AS builder
WORKDIR /app
COPY gradle ./gradle
COPY gradlew .
COPY build.gradle settings.gradle .
COPY src ./src
RUN chmod +x gradlew && ./gradlew bootJar --no-daemon

# Stage 2: Runtime
FROM eclipse-temurin:21-jre-jammy AS runtime
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENV JAVA_OPTS="-Xms512m -Xmx1024m"
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/actuator/health || exit 1
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
```

#### 🔹 Docker Compose
```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "8080:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=docker
      - SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/mydb
      - SPRING_DATASOURCE_USERNAME=root
      - SPRING_DATASOURCE_PASSWORD=secret
      - REDIS_HOST=redis
      - REDIS_PORT=6379
    depends_on:
      mysql:
        condition: service_healthy
      redis:
        condition: service_started
    networks:
      - app-network
    restart: unless-stopped

  mysql:
    image: mysql:8.0
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: mydb
    volumes:
      - mysql-data:/var/lib/mysql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - app-network

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis-data:/data
    networks:
      - app-network

  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    networks:
      - app-network

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    volumes:
      - grafana-data:/var/lib/grafana
    networks:
      - app-network

volumes:
  mysql-data:
  redis-data:
  grafana-data:

networks:
  app-network:
    driver: bridge
```

#### 🔹 Comandos Docker
```bash
# Build
docker build -t minha-app .

# Executar
docker run -p 8080:8080 minha-app

# Com variáveis de ambiente
docker run -e SPRING_PROFILES_ACTIVE=prod -p 8080:8080 minha-app

# Docker Compose
docker-compose up -d          # Iniciar
docker-compose down            # Parar
docker-compose logs -f app     # Logs
docker-compose ps              # Status
docker-compose restart app     # Reiniciar

# Utilitários
docker images                  # Listar imagens
docker ps                      # Containers rodando
docker exec -it <container> bash  # Acessar container
docker system prune            # Limpar recursos
```

---

### 6.2 Kubernetes

#### 🔹 O que é
Kubernetes (K8s) é uma plataforma de orquestração de containers para automação de deploy, escalabilidade e gerenciamento.

#### 🔹 Deployment
```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minha-app
  labels:
    app: minha-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: minha-app
  template:
    metadata:
      labels:
        app: minha-app
    spec:
      containers:
        - name: minha-app
          image: registry.example.com/minha-app:1.0.0
          ports:
            - containerPort: 8080
          env:
            - name: SPRING_PROFILES_ACTIVE
              value: "production"
            - name: SPRING_DATASOURCE_URL
              valueFrom:
                configMapKeyRef:
                  name: app-config
                  key: datasource-url
            - name: SPRING_DATASOURCE_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: datasource-password
          resources:
            requests:
              memory: "512Mi"
              cpu: "250m"
            limits:
              memory: "1024Mi"
              cpu: "500m"
          livenessProbe:
            httpGet:
              path: /actuator/health/liveness
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /actuator/health/readiness
              port: 8080
            initialDelaySeconds: 20
            periodSeconds: 5
```

#### 🔹 Service
```yaml
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: minha-app-service
spec:
  selector:
    app: minha-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: LoadBalancer
```

#### 🔹 ConfigMap e Secrets
```yaml
# configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  datasource-url: "jdbc:mysql://mysql-service:3306/mydb"
  redis-host: "redis-service"
  log-level: "INFO"

---
# secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  datasource-password: c2VjcmV0  # base64 de "secret"
```

#### 🔹 Comandos Kubectl
```bash
# Aplicar configurações
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Verificar status
kubectl get pods
kubectl get services
kubectl get deployments

# Logs
kubectl logs -f <pod-name>

# Executar no pod
kubectl exec -it <pod-name> -- /bin/bash

# Escalar
kubectl scale deployment minha-app --replicas=5

# Rollout
kubectl rollout status deployment/minha-app
kubectl rollout undo deployment/minha-app

# Port forward
kubectl port-forward svc/minha-app-service 8080:80
```

---

### 6.3 CI/CD

#### 🔹 GitHub Actions
```yaml
# .github/workflows/ci.yml
name: Java CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    services:
      mysql:
        image: mysql:8.0
        env:
          MYSQL_ROOT_PASSWORD: root
          MYSQL_DATABASE: testdb
        ports:
          - 3306:3306
        options: >-
          --health-cmd="mysqladmin ping"
          --health-interval=10s
          --health-timeout=5s
          --health-retries=5

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up JDK 21
        uses: actions/setup-java@v4
        with:
          java-version: '21'
          distribution: 'temurin'
          cache: 'maven'

      - name: Build with Maven
        run: mvn clean compile

      - name: Run tests
        run: mvn test
        env:
          SPRING_DATASOURCE_URL: jdbc:mysql://localhost:3306/testdb
          SPRING_DATASOURCE_USERNAME: root
          SPRING_DATASOURCE_PASSWORD: root

      - name: Run SonarQube analysis
        run: mvn sonar:sonar
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

      - name: Build JAR
        run: mvn package -DskipTests

      - name: Build Docker image
        run: docker build -t minha-app:${{ github.sha }} .

      - name: Login to Docker Registry
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Push Docker image
        run: |
          docker tag minha-app:${{ github.sha }} ghcr.io/${{ github.repository }}/minha-app:${{ github.sha }}
          docker push ghcr.io/${{ github.repository }}/minha-app:${{ github.sha }}
```

#### 🔹 GitLab CI
```yaml
# .gitlab-ci.yml
image: maven:3.9-eclipse-temurin-21

stages:
  - build
  - test
  - quality
  - package
  - deploy

variables:
  MAVEN_OPTS: "-Dmaven.repo.local=$CI_PROJECT_DIR/.m2/repository"

cache:
  paths:
    - .m2/repository

build:
  stage: build
  script:
    - mvn clean compile

test:
  stage: test
  services:
    - mysql:8.0
  variables:
    MYSQL_ROOT_PASSWORD: root
    MYSQL_DATABASE: testdb
    SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/testdb
    SPRING_DATASOURCE_USERNAME: root
    SPRING_DATASOURCE_PASSWORD: root
  script:
    - mvn test
  artifacts:
    reports:
      junit:
        - target/surefire-reports/TEST-*.xml

sonarqube:
  stage: quality
  script:
    - mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN
  only:
    - main
    - develop

package:
  stage: package
  script:
    - mvn package -DskipTests
  artifacts:
    paths:
      - target/*.jar
  only:
    - main

docker-build:
  stage: deploy
  image: docker:24
  services:
    - docker:24-dind
  script:
    - docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA .
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  only:
    - main
```

#### 🔹 Jenkinsfile
```groovy
// Jenkinsfile
pipeline {
    agent any

    tools {
        jdk 'JDK-21'
        maven 'Maven-3.9'
    }

    environment {
        DOCKER_REGISTRY = 'registry.example.com'
        APP_NAME = 'minha-app'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                    jacoco execPattern: '**/target/jacoco.exec'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER} ."
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-registry',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh "echo $PASS | docker login ${DOCKER_REGISTRY} -u $USER --password-stdin"
                    sh "docker push ${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER}"
                }
            }
        }

        stage('Deploy to Staging') {
            when {
                branch 'develop'
            }
            steps {
                sh "kubectl set image deployment/${APP_NAME} ${APP_NAME}=${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER}"
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy para produção?'
                sh "kubectl set image deployment/${APP_NAME} ${APP_NAME}=${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER}"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            slackSend(
                color: 'good',
                message: "✅ Build #${BUILD_NUMBER} do ${APP_NAME} foi bem-sucedido!"
            )
        }
        failure {
            slackSend(
                color: 'danger',
                message: "❌ Build #${BUILD_NUMBER} do ${APP_NAME} falhou!"
            )
        }
    }
}
```

---

## 7. Monitoring

---

### 7.1 Micrometer

#### 🔹 O que é
Micrometer é uma biblioteca de métricas para JVM que fornece uma facade para sistemas de monitoramento como Prometheus, Datadog e New Relic.

#### 🔹 Por que usar
- ✅ Abstração de métricas para múltiplos backends
- ✅ Métricas de aplicação customizadas
- ✅ Integração nativa com Spring Boot
- ✅ Baixo overhead de performance

#### 🔹 Instalação
```xml
<!-- Maven -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-registry-prometheus</artifactId>
</dependency>
```

#### 🔹 Configuração
```yaml
# application.yml
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  metrics:
    tags:
      application: minha-app
    distribution:
      percentiles-histogram:
        http.server.requests: true
      percentiles:
        http.server.requests: 0.5, 0.75, 0.95, 0.99
    export:
      prometheus:
        enabled: true
```

#### 🔹 Métricas Customizadas
```java
import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.Gauge;
import io.micrometer.core.instrument.MeterRegistry;
import io.micrometer.core.instrument.Timer;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

@Component
public class MetricasNegocio {

    private final Counter pedidosCriados;
    private final Counter pedidosCancelados;
    private final Timer tempoProcessamento;
    private final AtomicInteger usuariosAtivos;
    private final Gauge gaugeUsuariosAtivos;

    public MetricasNegocio(MeterRegistry registry) {
        // Counter - contagem de eventos
        this.pedidosCriados = Counter.builder("pedidos.criados")
            .description("Número total de pedidos criados")
            .tag("tipo", "online")
            .register(registry);

        this.pedidosCancelados = Counter.builder("pedidos.cancelados")
            .description("Número total de pedidos cancelados")
            .register(registry);

        // Timer - medição de tempo
        this.tempoProcessamento = Timer.builder("pedidos.tempo.processamento")
            .description("Tempo de processamento de pedidos")
            .publishPercentiles(0.5, 0.75, 0.95, 0.99)
            .register(registry);

        // Gauge - valor atual
        this.usuariosAtivos = new AtomicInteger(0);
        this.gaugeUsuariosAtivos = Gauge.builder("usuarios.ativos", usuariosAtivos::get)
            .description("Número de usuários ativos")
            .register(registry);
    }

    public void registrarPedidoCriado() {
        pedidosCriados.increment();
    }

    public void registrarPedidoCancelado() {
        pedidosCancelados.increment();
    }

    public void registrarTempoProcessamento(long tempoMs) {
        tempoProcessamento.record(tempoMs, TimeUnit.MILLISECONDS);
    }

    public void incrementarUsuariosAtivos() {
        usuariosAtivos.incrementAndGet();
    }

    public void decrementarUsuariosAtivos() {
        usuariosAtivos.decrementAndGet();
    }
}
```

#### 🔹 Usando em Serviços
```java
@Service
public class PedidoService {

    private final MetricasNegocio metricas;
    private final PedidoRepository repository;

    public PedidoService(MetricasNegocio metricas, PedidoRepository repository) {
        this.metricas = metricas;
        this.repository = repository;
    }

    public Pedido criarPedido(PedidoRequest request) {
        long inicio = System.currentTimeMillis();
        try {
            Pedido pedido = new Pedido(request);
            Pedido salvo = repository.save(pedido);
            metricas.registrarPedidoCriado();
            return salvo;
        } finally {
            long duracao = System.currentTimeMillis() - inicio;
            metricas.registrarTempoProcessamento(duracao);
        }
    }
}
```

---

### 7.2 Prometheus

#### 🔹 O que é
Prometheus é um sistema de monitoramento e alerta open-source, projetado para coletar métricas em tempo real.

#### 🔹 Por que usar
- ✅ Model pull-based (Prometheus puxa métricas)
- ✅ Linguagem de consulta poderosa (PromQL)
- ✅ Integração nativa com Micrometer
- ✅ Suporte a service discovery

#### 🔹 Configuração
```yaml
# prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'minha-app'
    metrics_path: '/actuator/prometheus'
    static_configs:
      - targets: ['app:8080']
        labels:
          environment: 'production'

  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  # Service discovery com Docker
  - job_name: 'docker'
    docker_sd_configs:
      - host: unix:///var/run/docker.sock
        filters:
          - name: label
            values: ['prometheus.scrape=true']
```

#### 🔹 Queries PromQL Úteis
```promql
# Taxa de requisições por segundo (5 min)
rate(http_server_requests_seconds_count[5m])

# Taxa de erros (5 min)
rate(http_server_requests_seconds_count{status=~"5.."}[5m])

# Latência P95
histogram_quantile(0.95, rate(http_server_requests_seconds_bucket[5m]))

# Latência P99
histogram_quantile(0.99, rate(http_server_requests_seconds_bucket[5m]))

# Média de latência
rate(http_server_requests_seconds_sum[5m]) / rate(http_server_requests_seconds_count[5m])

# CPUs em uso (JVM)
jvm_threads_live_threads

# Memória usada (JVM)
jvm_memory_used_bytes{area="heap"}

# Pedidos criados (5 min)
rate(pedidos_criados_total[5m])

# Usuários ativos
usuarios_ativos

# Disk usage
node_filesystem_avail_bytes / node_filesystem_size_bytes
```

#### 🔹 Alert Rules
```yaml
# alert.rules.yml
groups:
  - name: java-app-alerts
    rules:
      - alert: HighErrorRate
        expr: rate(http_server_requests_seconds_count{status=~"5.."}[5m]) > 0.05
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "Taxa de erros alta"
          description: "Taxa de erro > 5% nos últimos 5 minutos"

      - alert: HighLatency
        expr: histogram_quantile(0.95, rate(http_server_requests_seconds_bucket[5m])) > 1
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "Latência P95 alta"
          description: "P95 > 1 segundo nos últimos 5 minutos"

      - alert: HighMemoryUsage
        expr: jvm_memory_used_bytes{area="heap"} / jvm_memory_max_bytes{area="heap"} > 0.8
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: "Uso de memória heap alto"
          description: "Heap usage > 80%"
```

---

### 7.3 Grafana

#### 🔹 O que é
Grafana é uma plataforma de visualização de dados que permite criar dashboards personalizados a partir de múltiplas fontes de dados.

#### 🔹 Por que usar
- ✅ Dashboards visualmente ricos
- ✅ Múltiplas fontes de dados (Prometheus, MySQL, etc.)
- ✅ Alertas integrados
- ✅ Templates de dashboards compartilháveis

#### 🔹 Instalação
```bash
# Docker
docker run -d --name=grafana -p 3000:3000 grafana/grafana

# Acessar: http://localhost:3000
# Login: admin / admin
```

#### 🔹 Dashboard JSON (Spring Boot)
```json
{
  "dashboard": {
    "title": "Spring Boot Dashboard",
    "panels": [
      {
        "title": "Requisições por Segundo",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(http_server_requests_seconds_count{application=\"minha-app\"}[5m])",
            "legendFormat": "{{method}} {{uri}}"
          }
        ]
      },
      {
        "title": "Latência P95",
        "type": "graph",
        "targets": [
          {
            "expr": "histogram_quantile(0.95, rate(http_server_requests_seconds_bucket{application=\"minha-app\"}[5m]))",
            "legendFormat": "P95 Latency"
          }
        ]
      },
      {
        "title": "Uso de Memória Heap",
        "type": "gauge",
        "targets": [
          {
            "expr": "jvm_memory_used_bytes{area=\"heap\",application=\"minha-app\"} / jvm_memory_max_bytes{area=\"heap\",application=\"minha-app\"} * 100",
            "legendFormat": "Heap Usage %"
          }
        ],
        "options": {
          "thresholds": {
            "steps": [
              { "value": 0, "color": "green" },
              { "value": 70, "color": "yellow" },
              { "value": 85, "color": "red" }
            ]
          }
        }
      },
      {
        "title": "Threads Ativas",
        "type": "singlestat",
        "targets": [
          {
            "expr": "jvm_threads_live_threads{application=\"minha-app\"}"
          }
        ]
      }
    ]
  }
}
```

---

## 8. Logging

---

### 8.1 SLF4J

#### 🔹 O que é
SLF4J (Simple Logging Facade for Java) é uma fachada para frameworks de logging, permitindo trocar implementações sem mudar o código.

#### 🔹 Por que usar
- ✅ Desacoplamento entre código e implementação de logging
- ✅ Padronização de API
- ✅ Facilita troca de framework
- ✅ Amplamente utilizado em ecossistema Java

#### 🔹 Configuração
```xml
<!-- pom.xml -->
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-api</artifactId>
    <version>2.0.9</version>
</dependency>
<!-- Usar com Logback -->
<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>1.4.14</version>
</dependency>
```

#### 🔹 Uso no Código
```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PedidoService {

    private static final Logger logger = LoggerFactory.getLogger(PedidoService.class);

    public Pedido criarPedido(PedidoRequest request) {
        logger.info("Criando pedido para usuário: {}", request.getUsuarioId());
        logger.debug("Detalhes do pedido: {}", request);

        try {
            Pedido pedido = repository.save(new Pedido(request));
            logger.info("Pedido criado com sucesso. ID: {}", pedido.getId());
            return pedido;
        } catch (Exception e) {
            logger.error("Erro ao criar pedido para usuário: {}",
                request.getUsuarioId(), e);
            throw e;
        }
    }

    public void processarPedido(Long pedidoId) {
        if (logger.isDebugEnabled()) {
            logger.debug("Processando pedido ID: {}", pedidoId);
        }
        // ...
    }
}
```

#### 🔹 Pattern Layout
```
# Padrão comum
%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n

# Exemplo de saída
2024-01-15 14:30:25.123 [main] INFO  c.e.p.PedidoService - Pedido criado com sucesso. ID: 123
2024-01-15 14:30:25.125 [main] ERROR c.e.p.PedidoService - Erro ao processar pedido ID: 456
```

---

### 8.2 Logback

#### 🔹 O que é
Logback é a implementação padrão do SLF4J, oferecendo alta performance e recursos avançados de logging.

#### 🔹 Por que usar
- ✅ Implementação nativa do SLF4J
- ✅ Performance superior ao Log4j 1.x
- ✅ Suporte a rotação automática de logs
- ✅ Filtros avançados
- ✅ Configuração via XML ou Groovy

#### 🔹 Configuração
```xml
<!-- logback-spring.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <!-- Variáveis -->
    <property name="LOG_DIR" value="logs"/>
    <property name="APP_NAME" value="minha-app"/>

    <!-- Console Appender -->
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- File Appender -->
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>${LOG_DIR}/${APP_NAME}.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${LOG_DIR}/${APP_NAME}.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
            <totalSizeCap>10GB</totalSizeCap>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- JSON Appender (para ELK) -->
    <appender name="JSON" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>${LOG_DIR}/${APP_NAME}-json.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${LOG_DIR}/${APP_NAME}-json.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
        </rollingPolicy>
        <encoder class="net.logstash.logback.encoder.LogstashEncoder"/>
    </appender>

    <!-- Async Appender -->
    <appender name="ASYNC_FILE" class="ch.qos.logback.classic.AsyncAppender">
        <appender-ref ref="FILE"/>
        <queueSize>10000</queueSize>
        <discardingThreshold>0</discardingThreshold>
    </appender>

    <!-- Filters -->
    <appender name="FILTERED_CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
            <level>INFO</level>
        </filter>
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- Profiles -->
    <springProfile name="dev">
        <root level="DEBUG">
            <appender-ref ref="CONSOLE"/>
        </root>
    </springProfile>

    <springProfile name="prod">
        <root level="INFO">
            <appender-ref ref="ASYNC_FILE"/>
            <appender-ref ref="JSON"/>
        </root>
    </springProfile>

    <!-- Loggers específicos -->
    <logger name="com.exemplo" level="DEBUG"/>
    <logger name="org.springframework" level="WARN"/>
    <logger name="org.hibernate" level="WARN"/>

</configuration>
```

#### 🔹 Appenders

| Appender | Descrição |
|---|---|
| `ConsoleAppender` | Saída para console |
| `FileAppender` | Saída para arquivo |
| `RollingFileAppender` | Arquivo com rotação |
| `AsyncAppender` | Appender assíncrono |
| `SocketAppender` | Envio via socket |
| `SMTPAppender` | Envio por email |
| `DBAppender` | Envio para banco de dados |

#### 🔹 Encoders

| Encoder | Formato |
|---|---|
| `PatternLayoutEncoder` | Formato customizado |
| `LogstashEncoder` | JSON para ELK |
| `JsonLayoutEncoder` | JSON simples |
| `AccessEventCompositeEncoder` | Para access logs |

---

### 8.3 Log4j2

#### 🔹 O que é
Apache Log4j 2 é um framework de logging de alta performance, com suporte a async logging e muchos recursos avançados.

#### 🔹 Por que usar
- ✅ Performance superior (async logging)
- ✅ Suporte a logs estruturados (JSON)
- ✅ Garbage-free logging
- ✅ Plugins extensíveis
- ✅ Configuração via XML, JSON ou YAML

#### 🔹 Instalação
```xml
<!-- pom.xml -->
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-core</artifactId>
    <version>2.21.1</version>
</dependency>
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-slf4j2-impl</artifactId>
    <version>2.21.1</version>
</dependency>
```

#### 🔹 Configuração
```xml
<!-- log4j2.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN">

    <Properties>
        <Property name="LOG_DIR">logs</Property>
        <Property name="APP_NAME">minha-app</Property>
        <Property name="LOG_PATTERN">
            %d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n
        </Property>
    </Properties>

    <Appenders>
        <!-- Console -->
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="${LOG_PATTERN}"/>
        </Console>

        <!-- File -->
        <RollingFile name="File"
                     fileName="${LOG_DIR}/${APP_NAME}.log"
                     filePattern="${LOG_DIR}/${APP_NAME}-%d{yyyy-MM-dd}-%i.log.gz">
            <PatternLayout pattern="${LOG_PATTERN}"/>
            <Policies>
                <TimeBasedTriggeringPolicy/>
                <SizeBasedTriggeringPolicy size="10MB"/>
            </Policies>
            <DefaultRolloverStrategy max="30"/>
        </RollingFile>

        <!-- JSON -->
        <RollingFile name="JsonFile"
                     fileName="${LOG_DIR}/${APP_NAME}-json.log"
                     filePattern="${LOG_DIR}/${APP_NAME}-json-%d{yyyy-MM-dd}-%i.log.gz">
            <JsonLayout compact="true" eventEol="true"/>
            <Policies>
                <TimeBasedTriggeringPolicy/>
            </Policies>
        </RollingFile>

        <!-- Async -->
        <Async name="AsyncFile" bufferSize="1024">
            <AppenderRef ref="File"/>
        </Async>
    </Appenders>

    <Loggers>
        <!-- Logger raiz -->
        <Root level="INFO">
            <AppenderRef ref="Console"/>
            <AppenderRef ref="AsyncFile"/>
        </Root>

        <!-- Loggers específicos -->
        <Logger name="com.exemplo" level="DEBUG" additivity="false">
            <AppenderRef ref="Console"/>
            <AppenderRef ref="AsyncFile"/>
        </Logger>

        <Logger name="org.springframework" level="WARN"/>
        <Logger name="org.hibernate" level="WARN"/>
    </Loggers>

</Configuration>
```

#### 🔹 Uso no Código
```java
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class PedidoService {

    private static final Logger logger = LogManager.getLogger(PedidoService.class);

    public Pedido criarPedido(PedidoRequest request) {
        logger.info("Criando pedido para usuário: {}", request.getUsuarioId());
        logger.debug("Detalhes do pedido: {}", request);

        try {
            Pedido pedido = repository.save(new Pedido(request));
            logger.info("Pedido criado com sucesso. ID: {}", pedido.getId());
            return pedido;
        } catch (Exception e) {
            logger.error("Erro ao criar pedido para usuário: {}",
                request.getUsuarioId(), e);
            throw e;
        }
    }
}
```

#### 🔹 Performance Tips
```
1. Usar AsyncLogger para alta performance:
   <AsyncLogger name="com.exemplo" level="INFO"/>

2. Garbage-free logging (evita alocação):
   <Configuration status="WARN" monitorInterval="30">
       <Appenders>
           <Console name="Console">
               <PatternLayout pattern="%msg%n"/>
           </Console>
       </Appenders>
   </Configuration>

3. Usar Level HACK para evitar formatação desnecessária:
   if (logger.isDebugEnabled()) {
       logger.debug("Detalhes: {}", expensiveOperation());
   }

4. Evitar string concatenation:
   // ❌ Ruim
   logger.info("Pedido: " + pedidoId);

   // ✅ Bom
   logger.info("Pedido: {}", pedidoId);
```

---

## 📊 Resumo das Ferramentas

| Categoria | Ferramenta | Uso Principal |
|---|---|---|
| **IDE** | IntelliJ IDEA | Desenvolvimento Java completo |
| **IDE** | Eclipse | IDE open-source |
| **IDE** | VS Code | Editor leve e extensível |
| **Build** | Maven | Gerenciamento de projetos |
| **Build** | Gradle | Build moderno e flexível |
| **Test** | JUnit 5 | Framework de testes padrão |
| **Test** | Mockito | Mocking e stubbing |
| **Test** | TestContainers | Testes com containers Docker |
| **Test** | Cucumber | Testes BDD |
| **Quality** | SonarQube | Análise de qualidade |
| **Quality** | Checkstyle | Padrões de código |
| **Quality** | SpotBugs | Detecção de bugs |
| **Quality** | JaCoCo | Cobertura de código |
| **Docs** | Javadoc | Documentação Java |
| **Docs** | Swagger/OpenAPI | Documentação de APIs |
| **Deploy** | Docker | Containerização |
| **Deploy** | Kubernetes | Orquestração |
| **CI/CD** | GitHub Actions | CI/CD no GitHub |
| **CI/CD** | GitLab CI | CI/CD no GitLab |
| **CI/CD** | Jenkins | Automação de build |
| **Monitor** | Micrometer | Métricas de aplicação |
| **Monitor** | Prometheus | Coleta de métricas |
| **Monitor** | Grafana | Visualização de dados |
| **Log** | SLF4J | Fachada de logging |
| **Log** | Logback | Implementação de logging |
| **Log** | Log4j2 | Logging de alta performance |

---

## 🔗 Referências

| Ferramenta | URL Oficial |
|---|---|
| IntelliJ IDEA | https://www.jetbrains.com/idea/ |
| Eclipse | https://www.eclipse.org/ |
| VS Code | https://code.visualstudio.com/ |
| Maven | https://maven.apache.org/ |
| Gradle | https://gradle.org/ |
| JUnit 5 | https://junit.org/junit5/ |
| Mockito | https://site.mockito.org/ |
| TestContainers | https://www.testcontainers.org/ |
| Cucumber | https://cucumber.io/ |
| SonarQube | https://www.sonarqube.org/ |
| Checkstyle | https://checkstyle.org/ |
| SpotBugs | https://spotbugs.github.io/ |
| JaCoCo | https://www.jacoco.org/ |
| Swagger | https://swagger.io/ |
| Docker | https://www.docker.com/ |
| Kubernetes | https://kubernetes.io/ |
| GitHub Actions | https://docs.github.com/en/actions |
| GitLab CI | https://docs.gitlab.com/ee/ci/ |
| Jenkins | https://www.jenkins.io/ |
| Micrometer | https://micrometer.io/ |
| Prometheus | https://prometheus.io/ |
| Grafana | https://grafana.com/ |
| SLF4J | https://www.slf4j.org/ |
| Logback | https://logback.qos.ch/ |
| Log4j2 | https://logging.apache.org/log4j/2.x/ |

---

> **Nota:** Este guia é uma referência completa para ferramentas Java. Mantenha-o atualizado conforme novas versões e ferramentas surgirem.
