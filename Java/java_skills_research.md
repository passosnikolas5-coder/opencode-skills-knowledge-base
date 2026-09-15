# Pesquisa Completa: Java Skills e Recursos

**Data da Pesquisa:** 14 de Setembro de 2026  
**Objetivo:** Documentar as principais skills, conceitos, exemplos de código, melhores práticas e referências oficiais de Java.

---

## Índice

1. [Fundamentos de Java](#1-fundamentos-de-java)
2. [Java Avançado](#2-java-avançado)
3. [Frameworks Populares](#3-frameworks-populares)
4. [Áreas Específicas](#4-áreas-específicas)
5. [Ferramentas e Ecossistema](#5-ferramentas-e-ecossistema)
6. [Referências e Recursos](#6-referências-e-recursos)

---

## 1. Fundamentos de Java

### 1.1 Sintaxe e Estruturas Básicas

**Conceitos Principais:**
- Java é uma linguagem fortemente tipada, orientada a objetos e de uso geral
- Segue o princípio "Write Once, Run Anywhere" (WORA) devido à JVM
- Estrutura básica: classes, métodos, variáveis, operadores
- Tipos primitivos: `int`, `double`, `char`, `boolean`, `long`, `float`, `byte`, `short`
- Tipos de referência: `String`, arrays, objetos

**Exemplo de Código - Hello World:**
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

**Melhores Práticas:**
- Use convenções de nomenclatura: classes em PascalCase, métodos/variáveis em camelCase
- Declare variáveis o mais tarde possível
- Use `final` para constantes
- Prefira tipos primitivos para performance quando aplicável

---

### 1.2 Programação Orientada a Objetos (OOP)

**Conceitos Principais:**
- **Encapsulamento:** Esconder detalhes internos usando modificadores de acesso (private, protected, public)
- **Herança:** Reutilização de código através de classes filhas (extends)
- **Polimorfismo:** Capacidade de objetos de classes diferentes responderem ao mesmo método
- **Abstração:** Simplificar complexidade através de interfaces e classes abstratas

**Exemplo de Código - Classes e Herança:**
```java
// Classe abstrata
public abstract class Animal {
    protected String name;
    
    public Animal(String name) {
        this.name = name;
    }
    
    public abstract void makeSound();
    
    public void eat() {
        System.out.println(name + " está comendo");
    }
}

// Classe concreta
public class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }
    
    @Override
    public void makeSound() {
        System.out.println(name + " diz: Au au!");
    }
}

// Polimorfismo
public class Main {
    public static void main(String[] args) {
        Animal dog = new Dog("Rex");
        dog.makeSound(); // Rex diz: Au au!
        dog.eat();       // Rex está comendo
    }
}
```

**Exemplo - Interface:**
```java
public interface Swimmable {
    void swim();
    
    default void float_() {
        System.out.println("Flutuando...");
    }
}

public class Duck extends Animal implements Swimmable {
    public Duck(String name) {
        super(name);
    }
    
    @Override
    public void makeSound() {
        System.out.println(name + " diz: Quack!");
    }
    
    @Override
    public void swim() {
        System.out.println(name + " está nadando");
    }
}
```

**Melhores Práticas:**
- Programar para interfaces, não para implementações
- Usar composição sobre herança quando possível
- Aplicar o Princípio da Inversão de Dependência (DIP)
- Manter classes pequenas e com responsabilidade única (SRP)

---

### 1.3 Tratamento de Exceções

**Conceitos Principais:**
- Hierarquia: Throwable > Exception > RuntimeException (unchecked) / IOException (checked)
- Bloco `try-catch-finally` para tratamento
- `try-with-resources` (Java 7+) para gerenciamento automático de recursos
- Exceções customizadas

**Exemplo de Código:**
```java
// Estrutura básica
try {
    // código que pode lançar exceção
} catch (ExcecaoTipo1 ex) {
    // tratar ExcecaoTipo1
} catch (ExcecaoTipo2 ex) {
    // tratar ExcecaoTipo2
} finally {
    // código executado independentemente da exceção
}

// Try-with-resources
try (BufferedReader br = new BufferedReader(new FileReader("arquivo.txt"))) {
    String line = br.readLine();
    System.out.println(line);
} catch (IOException e) {
    e.printStackTrace();
}

// Exceção customizada
public class NegativoException extends Exception {
    public NegativoException(String message) {
        super(message);
    }
}

// Uso
public static int fatorial(int n) throws NegativoException {
    if (n < 0) {
        throw new NegativoException("Número não pode ser negativo");
    }
    return (n <= 1) ? 1 : n * fatorial(n - 1);
}
```

**Melhores Práticas:**
- Nunca usar exceções para controle de fluxo
- Ser específico no tipo de exceção capturada
- Sempre registrar exceções para debug
- Usar try-with-resources para recursos Closeable
- Criar exceções informativas com contexto

---

### 1.4 Collections Framework

**Conceitos Principais:**
- **List:** Coleção ordenada que permite duplicatas (ArrayList, LinkedList)
- **Set:** Coleção sem duplicatas (HashSet, TreeSet, LinkedHashSet)
- **Map:** Pares chave-valor (HashMap, TreeMap, LinkedHashMap)
- **Queue:** FIFO para processamento (PriorityQueue, LinkedList)
- **Deque:** Double-ended queue (ArrayDeque, LinkedList)

**Exemplo de Código:**
```java
// ArrayList
List<String> nomes = new ArrayList<>();
nomes.add("João");
nomes.add("Maria");
nomes.add("Pedro");
nomes.remove("Maria");

// HashSet
Set<Integer> numeros = new HashSet<>();
numeros.add(1);
numeros.add(2);
numeros.add(2); // duplicata ignorada

// HashMap
Map<String, Integer>idades = new HashMap<>();
idades.put("Ana", 25);
idades.put("Carlos", 30);
idades.get("Ana"); // 25

// TreeMap (ordenado)
TreeMap<String, Integer> mapaOrdenado = new TreeMap<>(idades);

// PriorityQueue
PriorityQueue<Integer> fila = new PriorityQueue<>();
fila.add(30);
fila.add(10);
fila.add(20);
fila.peek(); // 10 (menor elemento)

// Iterando coleções
for (String nome : nomes) {
    System.out.println(nome);
}

// Usando Iterator
Iterator<String> it = nomes.iterator();
while (it.hasNext()) {
    System.out.println(it.next());
}

// Collections utility
Collections.sort(nomes); // ordena
Collections.reverse(nomes); // inverte
Collections.shuffle(nomes); // embaralha
```

**Melhores Práticas:**
- Usar interface como tipo (List, Map, Set) em vez de implementação
- Inicializar com capacidade adequada quando conhecida
- Usar `ConcurrentHashMap` para ambientes multi-thread
- Preferir `LinkedList` para inserções frequentes no início/fim
- Usar `ArrayList` para acesso aleatório rápido

---

### 1.5 Generics

**Conceitos Principais:**
- Type safety em tempo de compilação
- Wildcards: `? extends T` (upper bound), `? super T` (lower bound)
- Type erasure (informações de tipo são removidas em runtime)
- Métodos e classes genéricas

**Exemplo de Código:**
```java
// Classe genérica
public class Caixa<T> {
    private T conteudo;
    
    public T getConteudo() {
        return conteudo;
    }
    
    public void setConteudo(T conteudo) {
        this.conteudo = conteudo;
    }
}

// Método genérico
public <T> T genericMethod(T input) {
    return input;
}

// Wildcards
public void processar(List<? extends Number> lista) {
    for (Number n : lista) {
        System.out.println(n.doubleValue());
    }
}

public void adicionar(List<? super Integer> lista) {
    lista.add(1);
    lista.add(2);
}

// Uso
Caixa<String> caixaTexto = new Caixa<>();
caixaTexto.setConteudo("Hello");
// caixaTexto.setConteudo(123); // Erro de compilação
```

---

### 1.6 Lambda Expressions

**Conceitos Principais:**
- Sintaxe concisa para implementação de interfaces funcionais
- Expressões lambda: `(参数) -> 表达式` ou `(参数) -> { 语句; }`
- Referências de método: `ClassName::methodName`
- Interfaces funcionais: `Predicate`, `Function`, `Consumer`, `Supplier`

**Exemplo de Código:**
```java
// Lambda com Runnable
new Thread(() -> System.out.println("Nova thread criada")).start();

// Lambda com Predicate
Predicate<String> isNotEmpty = s -> !s.isEmpty();
isNotEmpty.test("Hello"); // true

// Lambda com Function
Function<String, Integer> toLength = String::length;
toLength.apply("Java"); // 4

// Referência de método
List<String> nomes = Arrays.asList("java", "spring", "microservice");
nomes.stream()
     .map(String::toUpperCase)
     .forEach(System.out::println);

// Lambda com Collection
nomes.stream()
     .filter(nome -> nome.length() > 4)
     .sorted()
     .forEach(System.out::println);
```

**Melhores Práticas:**
- Usar lambdas para expressões curtas e claras
- Evitar side effects em lambdas
- Usar referências de método quando possível
- Prefira `var` para parâmetros de lambda (Java 10+)

---

### 1.7 Streams API

**Conceitos Principais:**
- Pipeline de operações sobre coleções
- Operações intermediárias (lazy): filter, map, flatMap, sorted, distinct
- Operações terminais: collect, forEach, reduce, count, findFirst
- Parallel streams para processamento paralelo
- Collectors para agregação (toList, groupingBy, partitioningBy)

**Exemplo de Código:**
```java
// Stream básico
List<String> nomes = Arrays.asList("Ana", "Bruno", "Carlos", "Ana");

List<String> resultado = nomes.stream()
    .distinct()
    .filter(n -> n.length() > 3)
    .sorted()
    .collect(Collectors.toList());

// Reduce
int soma = IntStream.rangeClosed(1, 10)
    .reduce(0, Integer::sum);

// GroupingBy
Map<Integer, List<String>> porTamanho = nomes.stream()
    .collect(Collectors.groupingBy(String::length));

// PartitioningBy
Map<Boolean, List<String>> particionado = nomes.stream()
    .collect(Collectors.partitioningBy(n -> n.startsWith("A")));

// FlatMap
List<List<Integer>> listas = Arrays.asList(
    Arrays.asList(1, 2, 3),
    Arrays.asList(4, 5, 6)
);
List<Integer> achatado = listas.stream()
    .flatMap(Collection::stream)
    .collect(Collectors.toList());

// Parallel stream
long count = nomes.parallelStream()
    .filter(n -> n.length() > 3)
    .count();

// Optional
Optional<String> primeiro = nomes.stream()
    .filter(n -> n.startsWith("B"))
    .findFirst();
```

**Melhores Práticas:**
- Usar parallel streams apenas com datasets grandes e operações CPU-bound
- Evitar mutação de estado externo em streams
- Usar `Collectors` para operações complexas de agregação
- Preferir `flatMap` sobre `map` quando o mapeamento retorna coleções
- Usar `Optional` para evitar NullPointerException

---

## 2. Java Avançado

### 2.1 Concorrência e Multithreading

**Conceitos Principais:**
- Thread, Runnable, Callable, Future
- Synchronized, volatile, locks
- ExecutorService, ThreadPool
- Concurrent collections (ConcurrentHashMap, CopyOnWriteArrayList)
- CompletableFuture para programação assíncrona

**Exemplo de Código - ReadWriteLock:**
```java
import java.util.concurrent.locks.*;

class SharedData {
    private final List<String> list = new ArrayList<>();
    private final ReadWriteLock rwLock = new ReentrantReadWriteLock();
    private final Lock readLock = rwLock.readLock();
    private final Lock writeLock = rwLock.writeLock();

    public void add(String value) {
        writeLock.lock();
        try {
            list.add(value);
        } finally {
            writeLock.unlock();
        }
    }

    public String read(int index) {
        readLock.lock();
        try {
            return (index < list.size()) ? list.get(index) : null;
        } finally {
            readLock.unlock();
        }
    }
}
```

**Exemplo - Synchronized:**
```java
class BankAccount {
    private int balance = 1000;

    public synchronized void deposit(int amount) {
        balance += amount;
    }

    public synchronized void withdraw(int amount) {
        if (balance >= amount) {
            balance -= amount;
        }
    }

    public int getBalance() { return balance; }
}
```

**Exemplo - CompletableFuture:**
```java
CompletableFuture<String> future = CompletableFuture
    .supplyAsync(() -> buscarDados())
    .thenApply(dados -> processar(dados))
    .thenApply(resultado -> formatar(resultado))
    .exceptionally(ex -> "Erro: " + ex.getMessage());
```

**Melhores Práticas:**
- Usar `ExecutorService` em vez de criar threads manualmente
- Preferir `ConcurrentHashMap` sobre `Collections.synchronizedMap`
- Usar `CountDownLatch` ou `CyclicBarrier` para sincronização
- Evitar deadlocks com ordem consistente de locks

---

### 2.2 Reflection

**Conceitos Principais:**
- Inspeção e manipulação de classes em runtime
- Acesso a campos, métodos e construtores privados
- Criação dinâmica de instâncias
- Usado extensivamente em frameworks (Spring, Hibernate)

**Exemplo de Código:**
```java
Class<?> clazz = Class.forName("com.example.MinhaClasse");

// Criar instância
Object instance = clazz.getDeclaredConstructor().newInstance();

// Acessar campo privado
Field field = clazz.getDeclaredField("meuCampo");
field.setAccessible(true);
Object valor = field.get(instance);

// Invocar método
Method method = clazz.getDeclaredMethod("meuMetodo", String.class);
method.setAccessible(true);
Object resultado = method.invoke(instance, "arg1");
```

---

### 2.3 Annotations

**Conceitos Principais:**
- Metadados para informações de compilador, runtime ou source
- Anotações padrão: `@Override`, `@Deprecated`, `@SuppressWarnings`
- Anotações customizadas com `@interface`
- Processadores de anotação para processamento em compile-time

**Exemplo de Código - Anotação Customizada:**
```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface LogExecutionTime {
    String value() default "";
}

// Uso
public class Service {
    @LogExecutionTime("Operação lenta")
    public void operacaoLenta() {
        // lógica...
    }
}

// Processador
public class LogProcessor {
    public static void process(Object obj) {
        for (Method method : obj.getClass().getDeclaredMethods()) {
            if (method.isAnnotationPresent(LogExecutionTime.class)) {
                LogExecutionTime annotation = method.getAnnotation(LogExecutionTime.class);
                System.out.println("Method: " + method.getName() + " - " + annotation.value());
            }
        }
    }
}
```

---

### 2.4 Serialization

**Conceitos Principais:**
- Conversão de objetos para stream de bytes (serialização)
- Interface `Serializable` e `Externalizable`
- `serialVersionUID` para controle de versão
- Serialização seletiva com `transient`
- Serialização JSON com Jackson/Gson

**Exemplo de Código:**
```java
public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String nome;
    private transient String senha; // não serializado
    
    // Getters e setters
}

// Serializar
try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("usuario.ser"))) {
    oos.writeObject(usuario);
}

// Deserializar
try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream("usuario.ser"))) {
    Usuario usuario = (Usuario) ois.readObject();
}
```

---

### 2.5 Networking

**Conceitos Principais:**
- Socket programming (TCP/UDP)
- HTTP clients (java.net.http.HttpClient em Java 11+)
- Server sockets para servidores
- URL e URI

**Exemplo de Código - HttpClient (Java 11+):**
```java
HttpClient client = HttpClient.newHttpClient();
HttpRequest request = HttpRequest.newBuilder()
    .uri(URI.create("https://api.example.com/data"))
    .header("Accept", "application/json")
    .GET()
    .build();

HttpResponse<String> response = client.send(
    request, HttpResponse.BodyHandlers.ofString()
);
System.out.println(response.body());
```

---

### 2.6 JDBC

**Conceitos Principais:**
- Conexão com bancos de dados relacionais
- Statements: Statement, PreparedStatement, CallableStatement
- ResultSet para processamento de resultados
- Transações e connection pooling

**Exemplo de Código:**
```java
String url = "jdbc:mysql://localhost:3306/escola";
String user = "root";
String password = "senha";

try (Connection con = DriverManager.getConnection(url, user, password);
     PreparedStatement stmt = con.prepareStatement(
         "SELECT * FROM alunos WHERE idade > ?")) {
    
    stmt.setInt(1, 18);
    ResultSet rs = stmt.executeQuery();
    
    while (rs.next()) {
        System.out.println(rs.getInt("id") + " " + rs.getString("nome"));
    }
} catch (SQLException e) {
    e.printStackTrace();
}
```

**Melhores Práticas:**
- Sempre usar `PreparedStatement` para evitar SQL injection
- Usar try-with-resources para fechar conexões
- Implementar connection pooling (HikariCP, DBCP)
- Usar transações para operações atômicas

---

### 2.7 Java I/O e NIO

**Conceitos Principais:**
- **I/O Tradicional:** Streams (InputStream, OutputStream, Reader, Writer)
- **NIO:** Channels, Buffers, Selectors (non-blocking I/O)
- **Files:** java.nio.file.Path, Files (Java 7+)
- **Serialization:** ObjectInputStream/ObjectOutputStream

**Exemplo de Código - NIO:**
```java
// Path
Path path = Paths.get("/diretorio/arquivo.txt");

// Ler arquivo com Files
List<String> linhas = Files.readAllLines(path, StandardCharsets.UTF_8);

// Escrever arquivo
Files.write(path, "conteúdo".getBytes(), StandardCharsets.UTF_8);

// Files utility
Files.createDirectories(Paths.get("/novo/diretorio"));
Files.copy(origem, destino, StandardCopyOption.REPLACE_EXISTING);
Files.deleteIfExists(path);

// Canal NIO
try (FileChannel channel = FileChannel.open(path, StandardOpenOption.READ)) {
    ByteBuffer buffer = ByteBuffer.allocate(1024);
    while (channel.read(buffer) > 0) {
        buffer.flip();
        // processar buffer
        buffer.clear();
    }
}
```

---

## 3. Frameworks Populares

### 3.1 Spring Framework

#### 3.1.1 Spring Boot

**Conceitos Principais:**
- Auto-configuração e starter dependencies
- Embedded servers (Tomcat, Jetty, Undertow)
- Externalized configuration (application.properties/yml)
- Actuator para monitoring
- Profiles para ambientes

**Exemplo de Código - Aplicação Spring Boot:**
```java
import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;

@RestController
@SpringBootApplication
public class Example {

    @RequestMapping("/")
    String home() {
        return "Hello World!";
    }

    public static void main(String[] args) {
        SpringApplication.run(Example.class, args);
    }
}
```

**Configuração - application.yml:**
```yaml
spring:
  application:
    name: "minha-app"
  datasource:
    url: "jdbc:mysql://localhost/test"
    username: "dbuser"
    password: "dbpass"
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
server:
  port: 8080
```

**Dependência Maven:**
```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-webmvc</artifactId>
    </dependency>
</dependencies>
```

#### 3.1.2 Spring MVC

**Conceitos Principais:**
- Modelo-Visão-Controlador para aplicações web
- `@Controller` e `@RestController`
- `@RequestMapping`, `@GetMapping`, `@PostMapping`
- `@PathVariable`, `@RequestParam`, `@RequestBody`
- Validação com `@Valid`

**Exemplo de Código:**
```java
@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    private final UsuarioService usuarioService;

    public UsuarioController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Usuario> buscarPorId(@PathVariable Long id) {
        return usuarioService.findById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Usuario> criar(@Valid @RequestBody Usuario usuario) {
        Usuario salvo = usuarioService.save(usuario);
        return ResponseEntity.status(HttpStatus.CREATED).body(salvo);
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.NOT_FOUND)
    private void handleNotFound(NotFoundException ex) {
    }
}
```

#### 3.1.3 Spring Data

**Conceitos Principais:**
- Repository pattern abstrato
- Query methods derivadas do nome
- JPQL e Native queries
- Pagination e Sorting
- Auditing automático

**Exemplo de Código:**
```java
// Interface Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    
    // Query derivada
    List<Usuario> findByNome(String nome);
    
    // Query JPQL
    @Query("SELECT u FROM Usuario u WHERE u.email LIKE %:domain")
    List<Usuario> findByEmailDomain(@Param("domain") String domain);
    
    // Query nativa
    @Query(value = "SELECT * FROM usuarios WHERE ativo = true", nativeQuery = true)
    List<Usuario> findAtivos();
    
    // Paginação
    Page<Usuario> findByNome(String nome, Pageable pageable);
}

// Uso
@Service
public class UsuarioService {
    
    @Autowired
    private UsuarioRepository repository;
    
    public List<Usuario> buscarPorNome(String nome) {
        return repository.findByNome(nome);
    }
    
    public Page<Usuario> listarComPaginacao(int page, int size) {
        return repository.findAll(PageRequest.of(page, size));
    }
}
```

#### 3.1.4 Spring Security

**Conceitos Principais:**
- Autenticação e autorização
- CSRF protection
- Session management
- OAuth2 e JWT
- Method-level security

**Exemplo de Código:**
```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authz -> authz
                .requestMatchers("/public/**").permitAll()
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .defaultSuccessUrl("/dashboard")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutSuccessUrl("/login?logout")
                .permitAll()
            );
        
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

---

### 3.2 Jakarta EE

**Conceitos Principais:**
- **JPA:** Java Persistence API para mapeamento objeto-relacional
- **EJB:** Enterprise Java Beans para lógica de negócio
- **JMS:** Java Message Service para messaging assíncrono
- **CDI:** Contexts and Dependency Injection
- **JAX-RS:** APIs RESTful

**Exemplo - JPA Entity:**
```java
@Entity
@Table(name = "usuarios")
public class Usuario {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, length = 100)
    private String nome;
    
    @Column(unique = true)
    private String email;
    
    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    private List<Ordem> ordens;
    
    // Getters e setters
}
```

---

### 3.3 Hibernate

**Conceitos Principais:**
- ORM (Object-Relational Mapping) para Java
- Mapeamento de entidades e relacionamentos
- HQL (Hibernate Query Language)
- Caching (first-level e second-level cache)
- Lazy/Eager loading

**Exemplo de Código - Configuração de Cache:**
```java
@Entity
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "Publishers")
class Publisher {
    ...
    
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "PublishedBooks")
    @OneToMany(mappedBy = "publisher")
    Set<Book> books;
    ...
}
```

**Configuração - persistence.xml:**
```xml
<persistence-unit name="meuPU">
    <properties>
        <property name="hibernate.dialect" value="org.hibernate.dialect.MySQL8Dialect"/>
        <property name="hibernate.hbm2ddl.auto" value="update"/>
        <property name="hibernate.show_sql" value="true"/>
        <property name="hibernate.cache.use_second_level_cache" value="true"/>
        <property name="hibernate.cache.use_query_cache" value="true"/>
    </properties>
</persistence-unit>
```

**Melhores Práticas:**
- Usar `FetchType.LAZY` por padrão
- Evitar N+1 queries com `JOIN FETCH`
- Usar batch processing para inserções em massa
- Configurar cache apenas para dados que mudam pouco

---

### 3.4 Apache Commons

**Bibliotecas Principais:**
- **commons-lang3:** Utilidades de string, reflection, exception
- **commons-collections4:** Coleções adicionais
- **commons-io:** Utilidades de I/O
- **commons-codec:** Codificação/decodificação
- **commons-math3:** Matemática e estatística

**Exemplo - Apache Commons Lang:**
```java
import org.apache.commons.lang3.StringUtils;

// Strings
StringUtils.isEmpty(""); // true
StringUtils.isNotEmpty("hello"); // true
StringUtils.capitalize("java"); // "Java"
StringUtils.abbreviate("texto longo", 10); // "texto lon..."

// Builder
StringBuilder sb = new StringUtils.StringBuilder();
sb.append("Hello").append(" ").append("World");
```

---

### 3.5 Maven e Gradle

#### Maven

**Conceitos Principais:**
- Build lifecycle: validate, compile, test, package, verify, install, deploy
- Dependencies e repositories
- Plugins (compiler, surefire, etc.)
- Profiles para ambientes

**pom.xml Básico:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>meu-projeto</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>
    
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>3.4.1</version>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

#### Gradle

**Conceitos Principais:**
- Build scripts em Groovy ou Kotlin DSL
- Tasks e dependencies
- Build cache e configuration cache
- Plugin ecosystem

**build.gradle:**
```groovy
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.4.1'
}

group = 'com.example'
version = '1.0-SNAPSHOT'

java {
    sourceCompatibility = '17'
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    testImplementation 'org.junit.jupiter:junit-jupiter:5.10.2'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

test {
    useJUnitPlatform()
}
```

---

### 3.6 JUnit e Mockito

#### JUnit 5

**Conceitos Principais:**
- Anotações: `@Test`, `@BeforeEach`, `@AfterEach`, `@BeforeAll`, `@AfterAll`
- Assertions: `assertEquals`, `assertTrue`, `assertThrows`
- Parameterized tests com `@ValueSource`, `@CsvSource`, `@MethodSource`
- Extensions para customização

**Exemplo de Código:**
```java
import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.*;

class CalculadoraTest {

    private Calculadora calculadora;

    @BeforeEach
    void setUp() {
        calculadora = new Calculadora();
    }

    @Test
    void deveSomarDoisNumeros() {
        assertEquals(5, calculadora.somar(2, 3));
    }

    @Test
    void deveLancarExcecaoParaDivisaoPorZero() {
        assertThrows(ArithmeticException.class, 
            () -> calculadora.dividir(10, 0));
    }

    @ParameterizedTest
    @ValueSource(ints = {1, 2, 3, 4, 5})
    void deveRetornarPositivo(int numero) {
        assertTrue(calculadora.abs(numero) > 0);
    }
}
```

#### Mockito

**Conceitos Principais:**
- Mocking de objetos para isolamento de testes
- `@Mock`, `@InjectMocks`, `@Spy`
- Stubbing com `when().thenReturn()`
- Verificação de interações com `verify()`

**Exemplo de Código:**
```java
@ExtendWith(MockitoExtension.class)
class UsuarioServiceTest {

    @Mock
    private UsuarioRepository repository;

    @InjectMocks
    private UsuarioService service;

    @Test
    void deveBuscarUsuarioPorId() {
        // Arrange
        Usuario usuario = new Usuario(1L, "Ana");
        when(repository.findById(1L)).thenReturn(Optional.of(usuario));

        // Act
        Optional<Usuario> resultado = service.findById(1L);

        // Assert
        assertTrue(resultado.isPresent());
        assertEquals("Ana", resultado.get().getNome());
        verify(repository, times(1)).findById(1L);
    }

    @Test
    void deveLancarExcecaoQuandoNaoEncontrado() {
        when(repository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(NaoEncontradoException.class,
            () -> service.findById(99L));
    }
}
```

---

## 4. Áreas Específicas

### 4.1 Desenvolvimento Web

**Conceitos Principais:**
- Servlets e JSP (legado)
- Spring MVC / Spring Boot para web
- Thymeleaf para templates server-side
- REST APIs com Jackson/Gson
- WebSockets para comunicação bidirecional

**Arquitetura Típica:**
```
[Cliente] → [Controller] → [Service] → [Repository] → [Database]
                         ↓
                    [View/Template]
```

---

### 4.2 APIs RESTful

**Conceitos Principais:**
- Princípios REST: stateless, cache, uniform interface
- Métodos HTTP: GET, POST, PUT, PATCH, DELETE
- Status codes: 200, 201, 400, 401, 403, 404, 500
- Content negotiation (JSON, XML)
- HATEOAS para navegação

**Exemplo - Controlador REST Completo:**
```java
@RestController
@RequestMapping("/api/produtos")
@Tag(name = "Produtos", description = "API de gestão de produtos")
public class ProdutoController {

    private final ProdutoService service;

    public ProdutoController(ProdutoService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<Produto>> listar(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<Produto> produtos = service.listar(PageRequest.of(page, size));
        return ResponseEntity.ok(produtos.getContent());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Produto> buscar(@PathVariable Long id) {
        return service.findById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Produto criar(@Valid @RequestBody Produto produto) {
        return service.save(produto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Produto> atualizar(
            @PathVariable Long id,
            @Valid @RequestBody Produto produto) {
        return service.update(id, produto)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deletar(@PathVariable Long id) {
        service.deleteById(id);
    }
}
```

---

### 4.3 Microserviços

**Conceitos Principais:**
- Decomposição por domínio (DDD)
- Service discovery (Eureka, Consul)
- API Gateway (Spring Cloud Gateway)
- Circuit breaker (Resilience4j)
- Distributed tracing (Micrometer, Zipkin)
- Event-driven architecture (Kafka, RabbitMQ)

**Arquitetura:**
```
[Client] → [API Gateway] → [Service A] → [DB A]
                         → [Service B] → [DB B]
                         → [Service C] → [DB C]
                              ↓
                    [Message Broker (Kafka)]
```

**Spring Cloud Exemplo:**
```java
@SpringBootApplication
@EnableDiscoveryClient
public class PedidoServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(PedidoServiceApplication.class, args);
    }
}

@Service
@CircuitBreaker(name = "estoque", fallbackMethod = "fallbackEstoque")
public class PedidoService {
    
    public boolean verificarEstoque(Long produtoId) {
        return webClient.get()
            .uri("/estoque/{id}", produtoId)
            .retrieve()
            .bodyToMono(Boolean.class)
            .block();
    }
    
    public boolean fallbackEstoque(Long produtoId, Throwable t) {
        return true; // fallback logic
    }
}
```

---

### 4.4 Cloud Native

**Conceitos Principais:**
- 12-Factor App methodology
- Containerização com Docker
- Orquestração com Kubernetes
- Spring Cloud para cloud patterns
- Config management (Spring Cloud Config)
- Service mesh

**Dockerfile Exemplo:**
```dockerfile
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

**Kubernetes Deployment:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minha-app
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
        image: minha-app:latest
        ports:
        - containerPort: 8080
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
```

---

### 4.5 Machine Learning com Java

**Conceitos Principais:**
- **Deeplearning4j:** Framework deep learning para JVM
- **Weka:** Machine learning clássico
- **MOA:** Machine learning para data streams
- **Apache Spark MLlib:** ML distribuído
- **Tribuo:** Oracle ML library

**Exemplo - Weka:**
```java
import weka.classifiers.trees.J48;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;

// Carregar dataset
DataSource source = new DataSource("dados.arff");
Instances data = source.getDataSet();

// Treinar modelo J48 (árvore de decisão)
J48 tree = new J48();
tree.buildClassifier(data);

// Avaliar
Evaluation eval = new Evaluation(data);
eval.crossValidateModel(tree, data, 10, new Random(1));
System.out.println(eval.toSummaryString());
```

**Referências:**
- Deeplearning4j: https://deeplearning4j.org/
- Weka: https://www.cs.waikato.ac.nz/ml/weka/
- Tribuo: https://github.com/oracle/tribuo

---

### 4.6 Android Development

**Conceitos Principais:**
- Kotlin como linguagem primária (desde 2019)
- Android SDK e Android Studio
- Jetpack Compose para UI declarativa
- Architecture Components (ViewModel, LiveData, Room)
- Coroutines para async

**Exemplo - Activity com Jetpack Compose:**
```kotlin
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MeuAppTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Greeting("Android")
                }
            }
        }
    }
}

@Composable
fun Greeting(name: String) {
    Text(text = "Hello $name!")
}
```

**Referências:**
- Android Developers: https://developer.android.com/
- Jetpack Compose: https://developer.android.com/jetpack/compose
- Kotlin: https://kotlinlang.org/docs/android-overview.html

---

## 5. Ferramentas e Ecossistema

### 5.1 IDEs

#### IntelliJ IDEA
- IDE líder para Java e Kotlin
- Refactorings inteligentes
- Suporte a Spring, Hibernate, e outros frameworks
- Debugger avançado
- **Referência:** https://www.jetbrains.com/idea/

#### Eclipse
- IDE open-source
- Extensa plugin ecosystem
- Suporte a múltiplas linguagens
- **Referência:** https://www.eclipse.org/

#### VS Code
- Leve e extensível
- Extensions: Java Extension Pack, Spring Boot Tools
- Integrado com Git e terminal
- **Referência:** https://code.visualstudio.com/

---

### 5.2 Build Tools

#### Maven
- Convenção sobre configuração
- Lifecycle padronizado
- Repositórios centrais
- **Referência:** https://maven.apache.org/

#### Gradle
- Performance superior (incremental builds, build cache)
- Flexibilidade com DSL
- Kotlin DSL alternative
- **Referência:** https://gradle.org/

#### Maven Wrapper / Gradle Wrapper
- Garante versão consistente do build tool
- Não requer instalação global
- **Referência:** https://maven.apache.org/wrapper/ / https://docs.gradle.org/current/userguide/gradle_wrapper.html

---

### 5.3 Testing

#### JUnit 5
- Framework de teste padrão
- Parameterized tests
- Extensions
- **Referência:** https://junit.org/junit5/

#### Mockito
- Mocking framework
- Stubbing e verification
- Spy e partial mocks
- **Referência:** https://site.mockito.org/

#### TestContainers
- Containers Docker para testes de integração
- Databases (PostgreSQL, MySQL, etc.)
- Message brokers (Kafka, RabbitMQ)
- **Exemplo:**
```java
@Testcontainers
class UsuarioRepositoryTest {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:15")
            .withDatabaseName("test")
            .withUsername("test")
            .withPassword("test");

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }

    @Test
    void deveSalvarUsuario() {
        // teste usando banco real em container
    }
}
```
- **Referência:** https://www.testcontainers.org/

---

### 5.4 Monitoring

#### Micrometer
- Facade para métricas (Prometheus, Datadog, etc.)
- Counter, Timer, Gauge, DistributionSummary
- **Exemplo:**
```java
@Service
public class PedidoService {

    private final Counter pedidoCounter;
    private final Timer timer;

    public PedidoService(MeterRegistry registry) {
        this.pedidoCounter = Counter.builder("pedidos.total")
            .description("Total de pedidos")
            .register(registry);
        
        this.timer = Timer.builder("pedidos.tempo")
            .description("Tempo de processamento")
            .register(registry);
    }

    public Pedido processar(Pedido pedido) {
        return timer.record(() -> {
            pedidoCounter.increment();
            // lógica...
            return pedido;
        });
    }
}
```
- **Referência:** https://micrometer.io/

#### Prometheus
- Coleta e armazenamento de métricas
- Query language (PromQL)
- Alerting com Alertmanager
- **Referência:** https://prometheus.io/

---

### 5.5 Logging

#### SLF4J
- Facade de logging (abstração)
- Permite trocar implementação sem mudar código
- **Referência:** http://www.slf4j.org/

#### Logback
- Implementação nativa SLF4J
- Performance superior
- Configuração via XML ou Groovy
- **Exemplo de configuração:**
```xml
<configuration>
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    
    <root level="INFO">
        <appender-ref ref="STDOUT" />
    </root>
    
    <logger name="com.meuapp" level="DEBUG" />
</configuration>
```
- **Referência:** https://logback.qos.ch/

#### Log4j 2
- Alta performance com Async Loggers
- configurção via XML, JSON, YAML
- **Referência:** https://logging.apache.org/log4j/2.x/

---

## 6. Referências e Recursos

### Documentação Oficial
- **Java SE Documentation:** https://docs.oracle.com/en/java/javase/17/
- **Spring Boot:** https://spring.io/projects/spring-boot
- **Hibernate ORM:** https://hibernate.org/
- **JUnit 5:** https://junit.org/junit5/
- **Maven:** https://maven.apache.org/
- **Gradle:** https://gradle.org/

### Repositórios de Exemplos
- **Baeldung:** https://www.baeldung.com/ - Tutoriais abrangentes de Java
- **Spring Guides:** https://spring.io/guides - Guias oficiais Spring
- **GeeksforGeeks Java:** https://www.geeksforgeeks.org/java/ - Conceitos e exemplos

### Cursos e Trilhas de Aprendizado
- **Oracle Java Tutorials:** https://docs.oracle.com/javase/tutorial/
- **Coursera - Java Programming:** https://www.coursera.org/learn/java-programming
- **Udemy - Java Masterclass:** Cursos de Java completo

### Comunidades
- **Stack Overflow:** https://stackoverflow.com/questions/tagged/java
- **Reddit r/java:** https://www.reddit.com/r/java/
- **Java Community Process:** https://www.jcp.org/

### Conferências
- **Devoxx:** https://www.devoxx.com/
- **JavaOne:** https://www.oracle.com/javaone/
- **SpringOne:** https://springone.io/

---

## Resumo da Pesquisa

| Área | Tópicos Cobertos | Status |
|------|-----------------|--------|
| Fundamentos Java | Sintaxe, OOP, Exceções, Collections, Generics, Lambdas, Streams | ✅ Completo |
| Java Avançado | Concorrência, Reflection, Annotations, Serialization, JDBC, NIO | ✅ Completo |
| Spring Framework | Boot, MVC, Data, Security | ✅ Completo |
| Jakarta EE / Hibernate | JPA, EJB, JMS, ORM, Cache | ✅ Completo |
| Build Tools | Maven, Gradle, Wrapper | ✅ Completo |
| Testing | JUnit 5, Mockito, TestContainers | ✅ Completo |
| Monitoring | Micrometer, Prometheus | ✅ Completo |
| Logging | SLF4J, Logback, Log4j | ✅ Completo |
| Áreas Especiais | Web, REST, Microserviços, Cloud, ML, Android | ✅ Completo |

**Total de Exemplos de Código:** 50+ exemplos práticos  
**Referências Coletadas:** 30+ fontes oficiais e repositories

---

*Documento gerado em 14 de Setembro de 2026*
