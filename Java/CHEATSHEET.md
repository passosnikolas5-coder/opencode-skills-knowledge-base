# ☕ Java Cheat Sheet - Referência Rápida

> **Guia de consulta rápida para Java** - Tudo que você precisa em uma página!

---

## 📋 Índice

- [Sintaxe Básica](#sintaxe-básica)
- [Tipos de Dados](#tipos-de-dados)
- [Operadores](#operadores)
- [Estruturas de Controle](#estruturas-de-controle)
- [Arrays e Strings](#arrays-e-strings)
- [OOP](#oop)
- [Collections](#collections)
- [Streams](#streams)
- [Lambdas](#lambdas)
- [Exceções](#exceções)
- [Generics](#generics)
- [Annotations](#annotations)
- [Spring Boot](#spring-boot)
- [JUnit 5](#junit-5)

---

## Sintaxe Básica

```java
// Hello World
public class App {
    public static void main(String[] args) {
        System.out.println("Olá, Mundo!");
    }
}

// Variáveis
String nome = "Java";
int idade = 25;
double salario = 5000.00;
boolean ativo = true;

// Var (Java 10+)
var texto = "Inferência de tipo";
var numero = 10;

// Text Block (Java 15+)
String json = """
        {
            "name": "Java",
            "version": 17
        }
        """;
```

---

## Tipos de Dados

| Tipo | Tamanho | Faixa | Exemplo |
|------|---------|-------|---------|
| `byte` | 1 byte | -128 a 127 | `byte b = 100;` |
| `short` | 2 bytes | -32.768 a 32.767 | `short s = 1000;` |
| `int` | 4 bytes | -2^31 a 2^31-1 | `int i = 100000;` |
| `long` | 8 bytes | -2^63 a 2^63-1 | `long l = 100000L;` |
| `float` | 4 bytes | 3.4e-38 a 3.4e+38 | `float f = 3.14f;` |
| `double` | 8 bytes | 4.9e-324 a 1.7e+308 | `double d = 3.14;` |
| `char` | 2 bytes | 0 a 65.535 | `char c = 'A';` |
| `boolean` | 1 bit | true/false | `boolean b = true;` |

### Wrappers

```java
Integer i = Integer.valueOf(10);
Double d = Double.valueOf(3.14);
Boolean b = Boolean.valueOf(true);

// Autoboxing
int primitive = 10;
Integer wrapper = primitive; // Autoboxing
int back = wrapper; // Unboxing
```

---

## Operadores

```java
// Aritméticos
+  -  *  /  %  ++  --

// Lógicos
&&  ||  !  ^  &  |

// Relacionais
==  !=  >  <  >=  <=

// Bitwise
&  |  ^  ~  <<  >>  >>>

// Atribuição
=  +=  -=  *=  /=  %=

// Ternário
int resultado = (x > 10) ? 100 : 200;
```

---

## Estruturas de Controle

```java
// If-Else
if (condicao) {
    // código
} else if (outraCondicao) {
    // código
} else {
    // código
}

// Switch Expression (Java 14+)
String resultado = switch (dia) {
    case "SEG", "TER", "QUI", "SEX" -> "Útil";
    case "SAB", "DOM" -> "Fim de semana";
    default -> "Inválido";
};

// For
for (int i = 0; i < 10; i++) {
    System.out.println(i);
}

// For-Each
for (String nome : nomes) {
    System.out.println(nome);
}

// While
while (condicao) {
    // código
}

// Do-While
do {
    // código
} while (condicao);
```

---

## Arrays e Strings

```java
// Arrays
int[] numeros = {1, 2, 3, 4, 5};
int[][] matriz = {{1, 2}, {3, 4}};

// Métodos de Arrays
Arrays.sort(numeros);
Arrays.fill(numeros, 0);
int[] copia = Arrays.copyOf(numeros, 3);
boolean contem = Arrays.asList(numeros).contains(3);

// Strings
String nome = "Java";
String upper = nome.toUpperCase();
String lower = nome.toLowerCase();
int tamanho = nome.length();
char caractere = nome.charAt(0);
String sub = nome.substring(0, 2);
boolean contem = nome.contains("av");
boolean comeca = nome.startsWith("J");
boolean termina = nome.endsWith("a");

// StringBuilder (performance)
StringBuilder sb = new StringBuilder();
sb.append("Olá");
sb.append(" ");
sb.append("Mundo");
String resultado = sb.toString();

// String Formatting
String formatada = String.format("Nome: %s, Idade: %d", nome, idade);
```

---

## OOP

```java
// Classe
public class Pessoa {
    private String nome;
    private int idade;
    
    // Construtor
    public Pessoa(String nome, int idade) {
        this.nome = nome;
        this.idade = idade;
    }
    
    // Métodos
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    
    // Método toString
    @Override
    public String toString() {
        return "Pessoa{nome='" + nome + "', idade=" + idade + "}";
    }
}

// Herança
public class Funcionario extends Pessoa {
    private double salario;
    
    public Funcionario(String nome, int idade, double salario) {
        super(nome, idade);
        this.salario = salario;
    }
}

// Interface
public interface Animal {
    void emitirSom();
    default void dormir() {
        System.out.println("Dormindo...");
    }
}

// Classe Abstrata
public abstract class Forma {
    public abstract double calcularArea();
}
```

---

## Collections

```java
// List (ArrayList, LinkedList)
List<String> lista = new ArrayList<>();
lista.add("Java");
lista.add("Python");
lista.remove("Python");
String item = lista.get(0);
int tamanho = lista.size();

// Set (HashSet, TreeSet)
Set<String> conjunto = new HashSet<>();
conjunto.add("Java");
conjunto.add("Python");
boolean contem = conjunto.contains("Java");

// Map (HashMap, TreeMap)
Map<String, Integer> mapa = new HashMap<>();
mapa.put("Java", 1);
mapa.put("Python", 2);
int valor = mapa.get("Java");
boolean contem = mapa.containsKey("Java");

// Queue e Deque
Queue<String> fila = new LinkedList<>();
fila.add("Item 1");
fila.add("Item 2");
String proximo = fila.poll();

Deque<String> pilha = new ArrayDeque<>();
pilha.push("Item 1");
pilha.push("Item 2");
String topo = pilha.pop();
```

---

## Streams

```java
// Criação
List<String> lista = List.of("Java", "Python", "JavaScript");
Stream<String> stream = lista.stream();
Stream<Integer> streamNumeros = IntStream.range(1, 10);

// Operações Intermediárias
List<String> resultado = lista.stream()
    .filter(s -> s.length() > 4)
    .map(String::toUpperCase)
    .sorted()
    .collect(Collectors.toList());

// Operações Terminais
lista.stream().forEach(System.out::println);
long count = lista.stream().count();
Optional<String> primeiro = lista.stream().findFirst();

// Collectors
Map<Integer, List<String>> porTamanho = lista.stream()
    .collect(Collectors.groupingBy(String::length));

String concat = lista.stream()
    .collect(Collectors.joining(", "));

// Parallel Streams
List<String> resultadoParalelo = lista.parallelStream()
    .filter(s -> s.length() > 4)
    .collect(Collectors.toList());
```

---

## Lambdas

```java
// Sintaxe
(args) -> { body }

// Exemplos
(int a, int b) -> a + b
(String s) -> System.out.println(s)
() -> System.out.println("Olá")

// Method References
String::toUpperCase          // Referência estática
System.out::println         // Referência de instância
String::new                 // Construtor

// Functional Interfaces
Predicate<String> ehMaior = s -> s.length() > 5;
Function<String, Integer> paraInteiro = Integer::parseInt;
Consumer<String> imprime = System.out::println;
Supplier<String> fornecedor = () -> "Olá";

// Composição
Function<Integer, Integer> dobro = x -> x * 2;
Function<Integer, Integer> soma10 = x -> x + 10;
Function<Integer, Integer> dobroMais10 = dobro.andThen(soma10);
```

---

## Exceções

```java
// Try-Catch-Finally
try {
    int resultado = 10 / 0;
} catch (ArithmeticException e) {
    System.out.println("Erro: " + e.getMessage());
} finally {
    System.out.println("Sempre executa");
}

// Try-with-resources
try (BufferedReader br = new BufferedReader(new FileReader("arquivo.txt"))) {
    String linha = br.readLine();
} catch (IOException e) {
    e.printStackTrace();
}

// Exceções Customizadas
public class MinhaExcecao extends Exception {
    public MinhaExcecao(String mensagem) {
        super(mensagem);
    }
}
```

---

## Generics

```java
// Classe Genérica
public class Caixa<T> {
    private T conteudo;
    
    public T getConteudo() { return conteudo; }
    public void setConteudo(T conteudo) { this.conteudo = conteudo; }
}

// Método Genérico
public static <T> void imprimir(T item) {
    System.out.println(item);
}

// Wildcards
public static void processar(List<? extends Number> lista) { ... }
public static void adicionar(List<? super Integer> lista) { ... }
```

---

## Annotations

```java
// Built-in
@Override
@SuppressWarnings("unchecked")
@Deprecated

// Spring
@RestController
@GetMapping("/api/users")
@Autowired
@Service

// Lombok
@Data
@Builder
@Slf4j
@AllArgsConstructor

// Custom
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface MinhaAnnotation {
    String valor() default "padrão";
}
```

---

## Spring Boot

```java
// Controller
@RestController
@RequestMapping("/api/users")
public class UserController {
    
    @GetMapping("/{id}")
    public ResponseEntity<User> getById(@PathVariable Long id) {
        return ResponseEntity.ok(userService.findById(id));
    }
    
    @PostMapping
    public ResponseEntity<User> create(@Valid @RequestBody UserDTO dto) {
        return ResponseEntity.status(HttpStatus.CREATED)
            .body(userService.create(dto));
    }
}

// Service
@Service
@RequiredArgsConstructor
public class UserService {
    
    private final UserRepository userRepository;
    
    public User create(UserDTO dto) {
        User user = UserMapper.toEntity(dto);
        return userRepository.save(user);
    }
}

// Repository
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    Optional<User> findByEmail(String email);
    
    @Query("SELECT u FROM User u WHERE u.name LIKE %:name%")
    List<User> findByNameContaining(@Param("name") String name);
}

// Exception Handler
@RestControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(ResourceNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(new ErrorResponse(ex.getMessage()));
    }
}
```

---

## JUnit 5

```java
// Teste Básico
@Test
void deveCalcularSoma() {
    Calculadora calc = new Calculadora();
    assertEquals(4, calc.somar(2, 2));
}

// Assertions
assertEquals(expected, actual);
assertNotEquals(expected, actual);
assertTrue(condition);
assertFalse(condition);
assertNull(object);
assertNotNull(object);
assertThrows(Exception.class, () -> { ... });

// Lifecycle
@BeforeEach
void setUp() { ... }

@AfterEach
void tearDown() { ... }

@BeforeAll
static void beforeAll() { ... }

@AfterAll
static void afterAll() { ... }

// Parameterized Tests
@ParameterizedTest
@ValueSource(ints = {1, 2, 3, 4, 5})
void deveSerPositivo(int numero) {
    assertTrue(numero > 0);
}

// Mockito
@Mock
UserService userService;

@InjectMocks
UserController userController;

@Test
void deveRetornarUsuario() {
    when(userService.findById(1L)).thenReturn(new User("Java"));
    User result = userController.getById(1L);
    assertNotNull(result);
    assertEquals("Java", result.getName());
}
```

---

## 📚 Referências Rápidas

| Recurso | URL |
|---------|-----|
| Java Documentation | https://docs.oracle.com/en/java/ |
| Spring Boot | https://spring.io/projects/spring-boot |
| Maven | https://maven.apache.org/ |
| JUnit 5 | https://junit.org/junit5/ |
| Baeldung | https://www.baeldung.com/ |

---

**Salve este cheat sheet para consulta rápida!** 📌

*Última atualização: Setembro 2026*