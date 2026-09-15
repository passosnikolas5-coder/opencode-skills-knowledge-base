# ☕ Java Avançado — Guia Completo

> **Versão:** Java 21+ | **Nível:** Avançado | **Atualizado:** Setembro 2026

---

## 📑 Índice

| # | Tópico | Link |
|---|--------|------|
| 1 | Collections Framework Avançado | [Ir →](#1--collections-framework-avançado) |
| 2 | Generics | [Ir →](#2--generics) |
| 3 | Lambda Expressions e Functional Interfaces | [Ir →](#3--lambda-expressions-e-functional-interfaces) |
| 4 | Streams API | [Ir →](#4--streams-api) |
| 5 | Concorrência e Multithreading | [Ir →](#5--concorrência-e-multithreading) |
| 6 | Reflection | [Ir →](#6--reflection) |
| 7 | Annotations | [Ir →](#7--annotations) |
| 8 | Java I/O e NIO | [Ir →](#8--java-io-e-nio) |
| 9 | JDBC | [Ir →](#9--jdbc) |
| 10 | Optional | [Ir →](#10--optional) |

---

# 1 — Collections Framework Avançado

## 1.1 Visão Geral da Hierarquia

```
Iterable<E>
 └── Collection<E>
      ├── List<E>
      │    ├── ArrayList<E>
      │    ├── LinkedList<E>
      │    ├── Vector<E>
      │    │    └── Stack<E>
      │    └── CopyOnWriteArrayList<E>
      ├── Set<E>
      │    ├── HashSet<E>
      │    │    └── LinkedHashSet<E>
      │    └── TreeSet<E>
      ├── Queue<E>
      │    ├── PriorityQueue<E>
      │    └── Deque<E>
      │         ├── ArrayDeque<E>
      │         └── LinkedList<E>
      └── Map<E,V>
           ├── HashMap<E,V>
           │    └── LinkedHashMap<E,V>
           ├── TreeMap<E,V>
           ├── Hashtable<E,V>
           │    └── Properties
           ├── ConcurrentHashMap<E,V>
           └── EnumMap<E,V>
```

---

## 1.2 List

| Implementação | Estrutura | Acesso | Inserção/Remoção | Thread-Safe | Uso Recomendado |
|---------------|-----------|--------|-------------------|-------------|-----------------|
| **ArrayList** | Array dinâmico | O(1) | O(n) | ❌ | Leituras frequentes |
| **LinkedList** | Lista duplamente ligada | O(n) | O(1) | ❌ | Inserções/remoções em ambos os extremos |
| **Vector** | Array dinâmico | O(1) | O(n) | ✅ | Código legado |
| **Stack** | Pilha (herda Vector) | O(1) | O(1) | ✅ | Código legado (use Deque) |

### ArrayList

```java
// Criação
List<String> nomes = new ArrayList<>();
List<String> nomes = new ArrayList<>(List.of("Ana", "Bruno", "Carlos"));
List<String> nomes = new ArrayList<>(10); // capacity inicial

// Operações comuns
nomes.add("Diana");                // adiciona ao final
nomes.add(0, "Antônio");          // adiciona no índice 0
nomes.set(1, "Beatriz");          // substitui no índice 1
nomes.remove("Ana");               // remove pelo objeto
nomes.remove(0);                   // remove pelo índice

// Iteração
for (String nome : nomes) {        // enhanced for
    System.out.println(nome);
}

nomes.forEach(System.out::println); // method reference

// SubList (view — alterações afetam a lista original)
List<String> sub = nomes.subList(1, 3);

// Ordenação
nomes.sort(Comparator.naturalOrder());
nomes.sort(Comparator.comparingInt(String::length));

// Cópia defensiva
List<String> copia = new ArrayList<>(nomes);
```

### LinkedList

```java
// Implementa List E Deque
Deque<String> deque = new LinkedList<>();
deque.addFirst("Início");
deque.addLast("Fim");
String primeiro = deque.removeFirst();
String ultimo = deque.removeLast();

// Como lista
List<String> lista = new LinkedList<>();
lista.add("A");
lista.addFirst("Z"); // O(1) — vantagem sobre ArrayList
```

> **⚠️ Dica:** Prefira `ArrayDeque` a `LinkedList` para uso como fila/pilha. É mais rápido em cache.

### Stack (legado)

```java
// ⚠️ Evite Stack do Java — use ArrayDeque
Stack<String> pilha = new Stack<>();
pilha.push("A");
pilha.push("B");
String topo = pilha.pop();      // "B"
String peek  = pilha.peek();    // "A"

// ✅ Alternativa moderna
Deque<String> pilhaModerna = new ArrayDeque<>();
pilhaModerna.push("A");
pilhaModerna.push("B");
```

---

## 1.3 Set

| Implementação | Ordenação | Nulls | Thread-Safe | Performance |
|---------------|-----------|-------|-------------|-------------|
| **HashSet** | Nenhuma | 1 null | ❌ | O(1) |
| **LinkedHashSet** | Inserção | 1 null | ❌ | O(1) |
| **TreeSet** | Natural/Comparator | ❌ | ❌ | O(log n) |

### HashSet

```java
Set<String> linguagens = new HashSet<>();
linguagens.add("Java");
linguagens.add("Python");
linguagens.add("Java"); // duplicata — ignorada

System.out.println(linguagens.size()); // 2

// Operações de conjunto
Set<String> a = new HashSet<>(Set.of("Java", "Python", "C++"));
Set<String> b = new HashSet<>(Set.of("Python", "Go", "Rust"));

Set<String> intersecao = new HashSet<>(a);
intersecao.retainAll(b);                       // {Python}

Set<String> uniao = new HashSet<>(a);
uniao.addAll(b);                               // {Java, Python, C++, Go, Rust}

Set<String> diferenca = new HashSet<>(a);
diferenca.removeAll(b);                        // {Java, C++}
```

### TreeSet (ordenado)

```java
// Ordenação natural (Comparable)
TreeSet<Integer> numeros = new TreeSet<>(Set.of(5, 1, 3, 2, 4));
System.out.println(numeros); // [1, 2, 3, 4, 5]

// Com Comparator customizado
TreeSet<String> porTamanho = new TreeSet<>(
    Comparator.comparingInt(String::length)
              .thenComparing(Comparator.naturalOrder())
);
porTamanho.addAll(Set.of("Java", "Go", "Python", "Rust"));

// Navegação
Integer menor = numeros.first();       // 1
Integer maior = numeros.last();        // 5
Integer menorQue3 = numeros.lower(3);  // 2
Integer maiorQue3 = numeros.higher(3); // 4

// Subconjuntos
SortedSet<Integer> sub = numeros.subSet(2, true, 4, true); // [2, 3, 4]
```

---

## 1.4 Map

| Implementação | Ordenação | Null Keys | Thread-Safe | Uso Recomendado |
|---------------|-----------|-----------|-------------|-----------------|
| **HashMap** | Nenhuma | 1 null key | ❌ | Uso geral |
| **LinkedHashMap** | Inserção/LRU | 1 null key | ❌ | Ordem de inserção |
| **TreeSet→TreeMap** | Chave | ❌ | ❌ | Chaves ordenadas |
| **Hashtable** | Nenhuma | ❌ | ✅ | Código legado |
| **ConcurrentHashMap** | Nenhuma | ❌ | ✅ | Alto concorrência |

### HashMap

```java
Map<String, Integer> idades = new HashMap<>();

// Inserção
idades.put("Ana", 25);
idades.put("Bruno", 30);
idades.putIfAbsent("Carlos", 28); // só insere se ausente

// Consulta
int idadeAna = idades.get("Ana");
int idadeDefault = idades.getOrDefault("Zeca", 0);

// Verificação
boolean temAna = idades.containsKey("Ana");
boolean tem25 = idades.containsValue(25);

// Iteração
idades.forEach((nome, idade) ->
    System.out.println(nome + " tem " + idade + " anos")
);

// compute, merge, putIfAbsent
idades.compute("Ana", (key, val) -> val == null ? 0 : val + 1);
idades.merge("Diana", 1, Integer::sum); // se ausente, insere 1; se existe, soma

// Remoção condicional
idades.remove("Bruno", 30); // remove só se valor == 30
```

### LinkedHashMap (ordem de inserção)

```java
Map<String, String> capitalidades = new LinkedHashMap<>();
capitalidades.put("BR", "Brasília");
capitalidades.put("AR", "Buenos Aires");
capitalidades.put("CL", "Santiago");

// Mantém a ordem de inserção ao iterar
capitalidades.forEach((k, v) -> System.out.println(k + " → " + v));
// BR → Brasília
// AR → Buenos Aires
// CL → Santiago
```

### LinkedHashMap como LRU Cache

```java
Map<String, String> lruCache = new LinkedHashMap<>(16, 0.75f, true) {
    @Override
    protected boolean removeEldestEntry(Map.Entry<String, String> eldest) {
        return size() > 100; // mantém apenas 100 entradas
    }
};
```

### TreeMap (chaves ordenadas)

```java
TreeMap<String, Integer> mapaOrdenado = new TreeMap<>();
mapaOrdenado.put("Banana", 3);
mapaOrdenado.put("Maçã", 5);
mapaOrdenado.put("Abacate", 2);

System.out.println(mapaOrdenado.firstKey()); // "Abacate"
System.out.println(mapaOrdenado.lastKey());  // "Maçã"

// Navegação por rangos
NavigableMap<String, Integer> navegavel = mapaOrdenado;
Map.Entry<String, Integer> entry = navegavel.lowerEntry("Maçã"); // Banana→3
```

### ConcurrentHashMap

```java
// Thread-safe sem sincronização pesada (locks segmentados → CAS)
ConcurrentHashMap<String, Integer> mapaConcorrente = new ConcurrentHashMap<>();

mapaConcorrente.put("A", 1);
mapaConcorrente.computeIfAbsent("B", k -> 2);
mapaConcorrente.merge("A", 10, Integer::sum); // A → 11

// Operações atômicas em massa
mapaConcorrente.forEach(4, (k, v) -> {  // paralelismo mínimo 4
    System.out.println(k + "=" + v);
});
```

---

## 1.5 Queue e Deque

```java
// Queue — FIFO
Queue<String> fila = new PriorityQueue<>();       // min-heap
Queue<String> fila2 = new ArrayDeque<>();         // mais rápido

fila.offer("C");  // enqueue
fila.offer("A");
fila.offer("B");
String proximo = fila.poll();   // dequeue — "A" (menor)
String peek     = fila.peek();  // olha sem remover

// Deque — Double-Ended Queue
Deque<String> deque = new ArrayDeque<>();

// Como Pilha (Stack)
deque.push("Topo1");
deque.push("Topo2");
String topo = deque.pop(); // "Topo2"

// Como Fila (Queue)
deque.offer("Fim1");
deque.offer("Fim2");
String primeiro = deque.poll(); // "Topo1"
```

### PriorityQueue

```java
// Min-heap padrão
PriorityQueue<Integer> minHeap = new PriorityQueue<>();
minHeap.addAll(List.of(5, 1, 3, 2, 4));
while (!minHeap.isEmpty()) {
    System.out.print(minHeap.poll() + " "); // 1 2 3 4 5
}

// Max-heap
PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Comparator.reverseOrder());
maxHeap.addAll(List.of(5, 1, 3, 2, 4));
while (!maxHeap.isEmpty()) {
    System.out.print(maxHeap.poll() + " "); // 5 4 3 2 1
}

// Com objeto complexo
PriorityQueue<int[]> tarefas = new PriorityQueue<>(
    Comparator.comparingInt((int[] a) -> a[1]) // prioridade
);
tarefas.offer(new int[]{1, 30}); // tarefa 1, prioridade 30
tarefas.offer(new int[]{2, 10}); // tarefa 2, prioridade 10
System.out.println(tarefas.poll()[0]); // 2
```

---

## 1.6 Collections Utility Methods

```java
// Ordenação
List<Integer> nums = new ArrayList<>(List.of(3, 1, 4, 1, 5, 9));
Collections.sort(nums);
Collections.sort(nums, Comparator.reverseOrder());

// Busca (requer lista ordenada)
int idx = Collections.binarySearch(nums, 4);

// Embaralhar
Collections.shuffle(nums);

// Inverter
Collections.reverse(nums);

// Rotacionar
Collections.rotate(nums, 2); // rotaciona 2 posições à direita

// Mínimo e Máximo
int min = Collections.min(nums);
int max = Collections.max(nums);

// Frequência
int freq = Collections.frequency(nums, 1);

// Sincronizar (wrapper)
List<String> sincronizada = Collections.synchronizedList(new ArrayList<>());

// Inmodifiable
List<String> imutavel = Collections.unmodifiableList(List.of("A", "B"));
// imutavel.add("C"); // UnsupportedOperationException
```

---

## 1.7 Performance e Escolha da Coleção

| Operação | ArrayList | LinkedList | HashSet | TreeMap | HashMap |
|----------|-----------|------------|---------|---------|---------|
| Acesso por índice | ⚡ O(1) | 🐢 O(n) | ❌ | ❌ | ❌ |
| Busca | 🐢 O(n) | 🐢 O(n) | ⚡ O(1) | O(log n) | ⚡ O(1) |
| Inserção início | 🐢 O(n) | ⚡ O(1) | ⚡ O(1) | O(log n) | ⚡ O(1) |
| Inserção fim | ⚡ O(1)* | ⚡ O(1) | ⚡ O(1) | O(log n) | ⚡ O(1) |
| Inserção meio | 🐢 O(n) | 🐢 O(n) | ❌ | O(log n) | ❌ |
| Remoção | 🐢 O(n) | ⚡ O(1)* | ⚡ O(1) | O(log n) | ⚡ O(1) |
| Memória | Baixa | Alta | Média | Alta | Média |

*\*Com referência direta ao nó*

### Regra de Ouro

```
📋 Precisa de índice/ordem?           → ArrayList
🔗 Inserções/remoções frequentes no meio? → LinkedList (ou ArrayList com cópia)
🔑 Busca rápida por chave?            → HashMap
📈 Chaves ordenadas?                  → TreeMap
🔒 Thread-safe?                       → ConcurrentHashMap / CopyOnWriteArrayList
📊 Prioridade dinâmica?               → PriorityQueue
```

---

## 1.8 Dicas e Erros Comuns

### ✅ Dicas

```java
// 1. Inicialize com capacity quando possível
List<String> lista = new ArrayList<>(10_000);

// 2. Use List.of() / Map.of() para coleções imutáveis
List<String> imutavel = List.of("A", "B", "C");
Map<String, Integer> mapa = Map.of("A", 1, "B", 2);

// 3. Use Set para remoção de duplicatas (mais rápido que.contains em List)
Set<String> vistos = new HashSet<>(lista);

// 4. Collections.unmodifiable* para defensas defensivas
public List<String> getItens() {
    return Collections.unmodifiableList(itens);
}

// 5. Use compute/merge em vez de get+put
mapa.merge(chave, 1, Integer::sum);
```

### ❌ Erros Comuns

```java
// 1. Modificar coleção durante iteração (ConcurrentModificationException)
for (String s : lista) {
    if (s.equals("remover")) lista.remove(s); // ❌ ERRO
}
// ✅ Correto:
Iterator<String> it = lista.iterator();
while (it.hasNext()) {
    if (it.next().equals("remover")) it.remove();
}
// ✅ Ou:
lista.removeIf(s -> s.equals("remover"));

// 2. Usar HashSet com objeto sem hashCode/equals consistentes
// ❌ Dois objetos iguais podem aparecer como distintos

// 3. Usar Stack do Java — semântica confusa, use ArrayDeque

// 4. Esquecer que ArrayList.remove(int) remove pelo ÍNDICE, não pelo objeto
lista.remove(0);   // remove índice 0
lista.remove("A"); // remove objeto "A"
```

---

## 1.9 Exercícios

1. **Top K Frequentes:** Dada uma lista de palavras, retorne as 3 mais frequentes.
2. **Group Anagrams:** Agrupar uma lista de strings em anagramas usando Map.
3. **LRU Cache:** Implementar uma LRU Cache usando LinkedHashMap.
4. **Two Sum:** Dado um array e um alvo, encontrar dois números que somam o alvo (HashMap).

---

# 2 — Generics

## 2.1 Conceito

Generics permitem criar classes, interfaces e métodos **tipados** com parâmetros, garantindo type safety em tempo de compilação e eliminando casts manuais.

## 2.2 Classes Genéricas

```java
public class Caixa<T> {
    private T conteudo;

    public Caixa(T conteudo) {
        this.conteudo = conteudo;
    }

    public T getConteudo() {
        return conteudo;
    }

    public void setConteudo(T conteudo) {
        this.conteudo = conteudo;
    }
}

// Uso
Caixa<String> caixaTexto = new Caixa<>("Olá");
Caixa<Integer> caixaNumero = new Caixa<>(42);
// Caixa<int> errado = new Caixa<>(1); // ❌ Tipo primitivo não aceito
```

### Múltiplos Parâmetros de Tipo

```java
public class Par<A, B> {
    private final A primeiro;
    private final B segundo;

    public Par(A primeiro, B segundo) {
        this.primeiro = primeiro;
        this.segundo = segundo;
    }

    public A getPrimeiro() { return primeiro; }
    public B getSegundo()  { return segundo; }
}

Par<String, Integer> par = new Par<>("idade", 25);
```

## 2.3 Métodos Genéricos

```java
// Métodos genéricos — o tipo é inferido
public static <T> List<T> arrayToList(T[] array) {
    return Arrays.asList(array);
}

public static <T extends Comparable<T>> T max(List<T> lista) {
    return lista.stream().max(Comparator.naturalOrder()).orElseThrow();
}

// Uso
String[] nomes = {"Ana", "Bruno", "Carlos"};
List<String> lista = arrayToList(nomes);

List<Integer> numeros = List.of(5, 2, 8, 1);
Integer maior = max(numeros); // 8
```

## 2.4 Wildcards

```java
// ? extends T — Upper Bounded Wildcard (LEITURA)
// Aceita T e qualquer subtipo de T
public static double soma(List<? extends Number> lista) {
    return lista.stream().mapToDouble(Number::doubleValue).sum();
}
soma(List.of(1, 2, 3));       // Integer
soma(List.of(1.5, 2.5));     // Double

// ? super T — Lower Bounded Wildcard (ESCRITA)
// Aceita T e qualquer supertipo de T
public static void addIntegers(List<? super Integer> lista) {
    lista.add(1);
    lista.add(2);
}
List<Number> nums = new ArrayList<>();
addIntegers(nums); // OK — Number é supertipo de Integer

// ? — Unbounded Wildcard
public static void printAll(List<?> lista) {
    for (Object item : lista) {
        System.out.println(item);
    }
}
```

### PECS: Producer Extends, Consumer Super

```
Producer (lê de coleção) → <? extends T>
Consumer (escreve na coleção) → <? super T>
```

```java
// Copiar de src (produz) para dest (consome)
public static <T> void copy(List<? super T> dest, List<? extends T> src) {
    for (T item : src) {
        dest.add(item);
    }
}
```

## 2.5 Bounded Types

```java
// Single bound
public <T extends Comparable<T>> T min(List<T> lista) { ... }

// Multiple bounds (interface limitada com &)
public <T extends Comparable<T> & Serializable> T metodo(T a, T b) {
    return a.compareTo(b) <= 0 ? a : b;
}

// Classe + interfaces: classe vem PRIMEIRO
public <T extends Number & Comparable<T>> void processo(T valor) { ... }
```

## 2.6 Type Erasure

```java
// Em runtime, T vira Object (ou o bound)
Caixa<String> cs = new Caixa<>("Oi");
Caixa<Integer> ci = new Caixa<>(42);
System.out.println(cs.getClass() == ci.getClass()); // true!

// Não pode fazer:
// T obj = new T();          // ❌
// if (obj instanceof T)     // ❌
// T[] arr = new T[10];      // ❌

// Workaround para obter tipo em runtime
public abstract class TypeReference<T> {
    private final Type type;

    protected TypeReference() {
        Type superclass = getClass().getGenericSuperclass();
        ParameterizedType pt = (ParameterizedType) superclass;
        this.type = pt.getActualTypeArguments()[0];
    }

    public Type getType() { return type; }
}

// Uso
TypeReference<List<String>> ref = new TypeReference<>() {};
System.out.println(ref.getType()); // java.util.List<java.lang.String>
```

## 2.7 Records Genéricos (Java 16+)

```java
public record Resultado<T>(boolean sucesso, T dados, String erro) {
    public static <T> Resultado<T> ok(T dados) {
        return new Resultado<>(true, dados, null);
    }

    public static <T> Resultado<T> falha(String erro) {
        return new Resultado<>(false, null, erro);
    }
}

Resultado<String> r = Resultado.ok("Sucesso");
Resultado<String> e = Resultado.falha("Erro interno");
```

## 2.8 Dicas e Erros Comuns

| ✅ Dica | ❌ Erro Comum |
|---------|---------------|
| Use tipos não anotados com diamond `<>` | `new ArrayList<String>()` redundante |
| Prefira bounded types quando possível | `List<?>` quando poderia ser `List<? extends Number>` |
| Use `instanceof` com check de reified types | `instanceof T` não compila |
| Evite raw types (`List` sem `<>`) | Perde type safety |
| Use records genéricos para DTOs | Sobreutilizar `Pair<A,B>` genérico demais |

---

## 2.9 Exercícios

1. **Generic Stack:** Implementar uma pilha genérica com `push`, `pop`, `peek`, `isEmpty`.
2. **Generic Repository:** Criar um repositório genérico com `save`, `findById`, `findAll`.
3. **Bounded Max:** Criar método que encontra o maior elemento usando `extends Comparable`.

---

# 3 — Lambda Expressions e Functional Interfaces

## 3.1 Sintaxe Lambda

```java
// Sintaxe completa
(x, y) -> { return x + y; }

// Com um parâmetro (parênteses opcionais)
x -> x * x

// Sem parâmetros
() -> System.out.println("Olá")

// Com tipo explícito
(int x, int y) -> x + y

// multiline
(assinatura) -> {
    // múltiplas linhas
    return resultado;
}
```

## 3.2 Functional Interfaces

Interfaces com **exatamente um método abstrato** (`@FunctionalInterface`).

```java
@FunctionalInterface
public interface MeuPredicate<T> {
    boolean test(T t);

    // Métodos default e static são permitidos
    default MeuPredicate<T> and(MeuPredicate<T> other) {
        return t -> test(t) && other.test(t);
    }
}
```

### Interfaces Padrão do `java.util.function`

| Interface | Método | Uso |
|-----------|--------|-----|
| `Predicate<T>` | `boolean test(T t)` | Filtragem |
| `Function<T,R>` | `R apply(T t)` | Transformação |
| `Consumer<T>` | `void accept(T t)` | Ação sem retorno |
| `Supplier<T>` | `T get()` | Fornecer valor |
| `UnaryOperator<T>` | `T apply(T t)` | Transforma T em T |
| `BinaryOperator<T>` | `T apply(T a, T b)` | Combina dois T |
| `BiFunction<T,U,R>` | `R apply(T t, U u)` | Dois inputs, um output |
| `BiPredicate<T,U>` | `boolean test(T t, U u)` | Dois inputs, boolean |
| `BiConsumer<T,U>` | `void accept(T t, U u)` | Dois inputs, sem retorno |
| `ToIntFunction<T>` | `int applyAsInt(T t)` | Evita autoboxing |

### Predicate

```java
Predicate<String> ehLongo = s -> s.length() > 5;
Predicate<String> comecaComJ = s -> s.startsWith("J");

// Composição
Predicate<String> filtro = ehLongo.and(comecaComJ);       // AND
Predicate<String> ou     = ehLongo.or(comecaComJ);        // OR
Predicate<String> negado = ehLongo.negate();               // NOT

List<String> linguagens = List.of("Java", "Python", "JavaScript", "Go", "Rust");
List<String> resultado = linguagens.stream()
    .filter(ehLongo.and(comecaComJ))
    .toList(); // ["JavaScript"]
```

### Function

```java
Function<String, Integer> tamanho = String::length;
Function<Integer, String> vezesX = n -> "x".repeat(n);

// Composição: andThen e compose
Function<String, String> processar = tamanho.andThen(vezesX);
System.out.println(processar.apply("Java")); // "xxxx"

// compose aplica a função de trás pra frente
Function<String, String> composta = vezesX.compose(tamanho);
System.out.println(composta.apply("Java")); // "xxxx" (mesmo resultado)
```

### Consumer

```java
Consumer<String> imprimir = System.out::println;
Consumer<String> maiuscula = s -> System.out.println(s.toUpperCase());

// Encadeamento
List.of("a", "b", "c").forEach(imprimir.andThen(maiuscula));
```

### Supplier

```java
Supplier<List<String>> listFactory = ArrayList::new;
List<String> novaLista = listFactory.get();

Supplier<Double> randomSupplier = Math::random;
double valor = randomSupplier.get();
```

### UnaryOperator e BinaryOperator

```java
UnaryOperator<String> paraMaiuscula = String::toUpperCase;
UnaryOperator<Integer> dobro = n -> n * 2;

BinaryOperator<Integer> soma = Integer::sum;
BinaryOperator<Integer> max = BinaryOperator.maxBy(Comparator.naturalOrder());

System.out.println(soma.apply(3, 4));  // 7
System.out.println(max.apply(3, 4));  // 4
```

## 3.3 Method References

```java
// Tipo 1: Referência a método estático
Function<String, Integer> parseInt = Integer::parseInt;
// Equivalente: s -> Integer.parseInt(s)

// Tipo 2: Referência a método de instância (objeto particular)
String str = "hello";
Supplier<Integer> len = str::length;
// Equivalente: () -> str.length()

// Tipo 3: Referência a método de instância (arbitrária)
Function<String, String> upper = String::toUpperCase;
// Equivalente: s -> s.toUpperCase()

// Tipo 4: Referência a construtor
Supplier<ArrayList<String>> listFactory = ArrayList::new;
// Equivalente: () -> new ArrayList<>()

Function<String, List<String>> toList = ArrayList::new;
// Equivalente: s -> new ArrayList<>(List.of(s.split(",")))

// Tipo 5: Referência a construtor genérico
BiFunction<String, Integer, String> pad = String::new;
// Precisa de contexto de tipo para ser útil
```

## 3.4 Composição de Funções

```java
// Pipeline de processamento
Function<String, String> trim      = String::trim;
Function<String, String> lower     = String::toLowerCase;
Function<String, String> removeAcc = s -> s.replaceAll("[àáâãäåèéêëìíîïòóôõöùúûü]", "");

Function<String, String> normalizar = trim
    .andThen(lower)
    .andThen(removeAcc);

System.out.println(normalizar.apply("  Olá Mundo  ")); // "ola mundo"

// Predicate composition
Predicate<String> notEmpty = s -> !s.isEmpty();
Predicate<String> isAlpha  = s -> s.matches("[a-zA-Z]+");

List<String> filtrados = List.of("Java", "", "123", "Python", " ")
    .stream()
    .filter(notEmpty.and(isAlpha))
    .toList(); // ["Java", "Python"]
```

## 3.5 CompletableFuture

```java
// Criar e encadear
CompletableFuture<String> futuro = CompletableFuture
    .supplyAsync(() -> {
        sleep(100);
        return "Resultado";
    })
    .thenApply(resultado -> resultado.toUpperCase())
    .thenApply(r -> r + " PROCESSADO");

System.out.println(futuro.join()); // "RESULTADO PROCESSADO"

// Combinar dois futuros
CompletableFuture<String> f1 = CompletableFuture.supplyAsync(() -> "Java");
CompletableFuture<Integer> f2 = CompletableFuture.supplyAsync(() -> 21);

CompletableFuture<String> combinado = f1.thenCombine(f2,
    (ling, ver) -> ling + " " + ver
);
System.out.println(combinado.join()); // "Java 21"

// allOf — aguardar múltiplos
CompletableFuture<Void> todos = CompletableFuture.allOf(
    CompletableFuture.runAsync(() -> sleep(100)),
    CompletableFuture.runAsync(() -> sleep(200))
);
todos.join(); // aguarda ambos

// exceptional handling
CompletableFuture<String> comErro = CompletableFuture
    .supplyAsync(() -> {
        if (true) throw new RuntimeException("Falha!");
        return "OK";
    })
    .exceptionally(ex -> "Recuperado: " + ex.getMessage())
    .thenApply(r -> r + " ✅");

System.out.println(comErro.join()); // "Recuperado: Falha! ✅"

// handle — combina success e error
CompletableFuture<String> handled = CompletableFuture
    .supplyAsync(() -> "sucesso")
    .handle((resultado, ex) -> {
        if (ex != null) return "Erro: " + ex.getMessage();
        return "Sucesso: " + resultado;
    });
```

## 3.6 Dicas e Erros Comuns

| ✅ Dica | ❌ Erro Comum |
|---------|---------------|
| Use `@FunctionalInterface` para documentar intenção | Lambda com efeitos colaterais |
| Prefira method references quando legível | Nested lambdas difíceis de ler |
| Use `Supplier` para lazy evaluation | Criar objetos desnecessariamente |
| `CompletableFuture.exceptionally` para handling | Ignorar erros assíncronos |
| Use `supplyAsync` com Executor customizado | Usar ForkJoinPool.commonPool() em IO |

---

## 3.7 Exercícios

1. **Filter Map:** Dado um Map<String, Integer>, filtrar apenas valores > 10 usando Predicate e lambda.
2. **Function Composition:** Criar pipeline: trim → lowercase → remover acentos →首字大写.
3. **Custom Functional Interface:** Criar `Transformer<T>` com `transform(T) -> T` e compor 3 transformações.

---

# 4 — Streams API

## 4.1 Criação de Streams

```java
// De collection
List<String> lista = List.of("A", "B", "C");
Stream<String> s1 = lista.stream();
Stream<String> s2 = lista.parallelStream(); // paralelo

// De array
String[] arr = {"X", "Y", "Z"};
Stream<String> s3 = Arrays.stream(arr);
Stream<String> s4 = Arrays.stream(arr, 1, 3); // subarray

// De valores individuais
Stream<String> s5 = Stream.of("A", "B", "C");

// De arquivo
Stream<String> s6 = Files.lines(Path.of("texto.txt"));

// Gerador infinito
Stream<Double> s7 = Stream.generate(Math::random).limit(5);
Stream<Integer> s8 = Stream.iterate(0, n -> n + 2).limit(10); // 0, 2, 4...

// Inteiro range
IntStream s9 = IntStream.range(1, 10);      // 1..9
IntStream s10 = IntStream.rangeClosed(1, 10); // 1..10

// De Optional
Stream<String> s11 = Optional.of("valor").stream();

// Concatenando streams
Stream<String> s12 = Stream.concat(
    Stream.of("A", "B"),
    Stream.of("C", "D")
);
```

## 4.2 Operações Intermediárias (Lazy)

```java
List<Produto> produtos = List.of(
    new Produto("Notebook", 4500, "Eletrônicos"),
    new Produto("Mouse", 80, "Eletrônicos"),
    new Produto("Cadeira", 1200, "Móveis"),
    new Produto("Monitor", 2000, "Eletrônicos"),
    new Produto("Mesa", 800, "Móveis")
);

// filter
List<Produto> eletronicos = produtos.stream()
    .filter(p -> p.getCategoria().equals("Eletrônicos"))
    .toList();

// map
List<String> nomes = produtos.stream()
    .map(Produto::getNome)
    .toList();

// flatMap
List<List<Integer>> listas = List.of(
    List.of(1, 2, 3),
    List.of(4, 5),
    List.of(6, 7, 8, 9)
);
List<Integer> achatado = listas.stream()
    .flatMap(Collection::stream)
    .toList(); // [1, 2, 3, 4, 5, 6, 7, 8, 9]

// sorted
List<Produto> porPreco = produtos.stream()
    .sorted(Comparator.comparingDouble(Produto::getPreco))
    .toList();

// distinct
Stream.of(1, 2, 2, 3, 3, 3).distinct().toList(); // [1, 2, 3]

// peek (debug/side-effect — use com cuidado)
List<Produto> processados = produtos.stream()
    .filter(p -> p.getPreco() > 100)
    .peek(p -> System.out.println("Filtrado: " + p.getNome()))
    .map(p -> new Produto(p.getNome(), p.getPreco() * 1.1, p.getCategoria()))
    .toList();

// limit e skip (paginação)
List<Produto> pagina = produtos.stream()
    .skip(0)   // pula 0
    .limit(2)  // pega 2
    .toList();

// takeWhile e dropWhile (Java 9+)
List<Integer> numeros = List.of(1, 2, 3, 7, 8, 9);
List<Integer> ate3 = numeros.stream()
    .takeWhile(n -> n < 4)
    .toList(); // [1, 2, 3]

List<Integer> de7 = numeros.stream()
    .dropWhile(n -> n < 7)
    .toList(); // [7, 8, 9]
```

## 4.3 Operações Terminais

```java
// collect
List<String> resultado = produtos.stream()
    .map(Produto::getNome)
    .collect(Collectors.toList()); // ou .toList()

// reduce
Optional<Integer> soma = IntStream.rangeClosed(1, 100)
    .reduce(Integer::sum);
System.out.println(soma.orElse(0)); // 5050

String concatenado = Stream.of("A", "B", "C")
    .reduce("", (a, b) -> a + b); // "ABC"

// forEach
produtos.stream()
    .filter(p -> p.getPreco() > 1000)
    .forEach(System.out::println);

// toArray
Produto[] arrProdutos = produtos.stream()
    .filter(p -> p.getPreco() > 1000)
    .toArray(Produto[]::new);

// count
long total = produtos.stream()
    .filter(p -> p.getCategoria().equals("Eletrônicos"))
    .count();

// min / max
Optional<Produto> maisCaro = produtos.stream()
    .max(Comparator.comparingDouble(Produto::getPreco));

// anyMatch / allMatch / noneMatch
boolean temCaro   = produtos.stream().anyMatch(p -> p.getPreco() > 3000);
boolean todosBaratos = produtos.stream().allMatch(p -> p.getPreco() < 5000);
boolean nenhumGratis = produtos.stream().noneMatch(p -> p.getPreco() == 0);

// findFirst / findAny
Optional<Produto> primeiro = produtos.stream()
    .filter(p -> p.getCategoria().equals("Móveis"))
    .findFirst();
```

## 4.4 Collectors

```java
// toList
List<String> nomes = produtos.stream()
    .map(Produto::getNome)
    .collect(Collectors.toList());

// toSet
Set<String> categorias = produtos.stream()
    .map(Produto::getCategoria)
    .collect(Collectors.toSet());

// joining
String nomesFormatados = produtos.stream()
    .map(Produto::getNome)
    .collect(Collectors.joining(", ", "[", "]"));
// [Notebook, Mouse, Cadeira, Monitor, Mesa]

// groupingBy
Map<String, List<Produto>> porCategoria = produtos.stream()
    .collect(Collectors.groupingBy(Produto::getCategoria));

// groupingBy + counting
Map<String, Long> contagem = produtos.stream()
    .collect(Collectors.groupingBy(
        Produto::getCategoria,
        Collectors.counting()
    ));

// groupingBy + summingDouble
Map<String, Double> totalPorCategoria = produtos.stream()
    .collect(Collectors.groupingBy(
        Produto::getCategoria,
        Collectors.summingDouble(Produto::getPreco)
    ));

// groupingBy custom
Map<String, Set<String>> nomesPorCategoria = produtos.stream()
    .collect(Collectors.groupingBy(
        Produto::getCategoria,
        Collectors.mapping(Produto::getNome, Collectors.toSet())
    ));

// partitioningBy
Map<Boolean, List<Produto>> particionados = produtos.stream()
    .collect(Collectors.partitioningBy(p -> p.getPreco() > 1000));

// toMap
Map<String, Double> precoMap = produtos.stream()
    .collect(Collectors.toMap(
        Produto::getNome,
        Produto::getPreco
    ));

// toMap com merge function
Map<String, Double> precoMaxPorCategoria = produtos.stream()
    .collect(Collectors.toMap(
        Produto::getCategoria,
        Produto::getPreco,
        Double::max
    ));

// summarizingDouble
DoubleSummaryStatistics stats = produtos.stream()
    .collect(Collectors.summarizingDouble(Produto::getPreco));
// count=5, sum=8380.0, min=80.0, average=1676.0, max=4500.0

// collectingAndThen
List<Produto> imutavel = produtos.stream()
    .collect(Collectors.collectingAndThen(
        Collectors.toList(),
        Collections::unmodifiableList
    ));

// flatMap + collect
Map<String, Set<String>> tags = List.of(
    new Post("A", Set.of("java", "stream")),
    new Post("B", Set.of("java", "generics"))
).stream()
    .flatMap(p -> p.getTags().stream().map(tag -> Map.entry(tag, p.getTitulo())))
    .collect(Collectors.groupingBy(
        Map.Entry::getKey,
        Collectors.mapping(Map.Entry::getValue, Collectors.toSet())
    ));
```

## 4.5 Parallel Streams

```java
// Criar
List<Integer> lista = IntStream.rangeClosed(1, 1_000_000).boxed().toList();
long soma = lista.parallelStream()
    .mapToLong(Long::valueOf)
    .sum();

// Usar com ForkJoinPool customizado
ForkJoinPool customPool = new ForkJoinPool(8);
long resultado = customPool.submit(() ->
    lista.parallelStream()
        .filter(n -> n % 2 == 0)
        .count()
).get();

// ⚠️ Cuidados
// 1. Não use parallelStream com operações de side-effect
// 2. Não é útil para coleções pequenas
// 3. Operações de ordenação são custosas em paralelo
// 4. Evite I/O em parallel streams (blocks threads)
```

## 4.6 Custom Collectors

```java
public static <T> Collector<T, ?, List<T>> toUnmodifiableList() {
    return Collector.of(
        ArrayList::new,
        List::add,
        (left, right) -> { left.addAll(right); return left; },
        Collections::unmodifiableList,
        Collector.Characteristics.UNORDERED
    );
}

// Collector para agrupar em um TreeMap
public static <T, K extends Comparable<K>, V> Collector<T, ?, Map<K, List<V>>>
    toSortedMap(Function<? super T, ? extends K> keyMapper,
                Function<? super T, ? extends V> valueMapper) {
    return Collectors.groupingBy(
        keyMapper,
        TreeMap::new,
        Collectors.mapping(valueMapper, Collectors.toList())
    );
}

// Uso
Map<String, List<String>> mapOrdenado = produtos.stream()
    .collect(toSortedMap(
        Produto::getCategoria,
        Produto::getNome
    ));
```

## 4.7 Dicas e Erros Comuns

| ✅ Dica | ❌ Erro Comum |
|---------|---------------|
| Use `.toList()` (Java 16+) em vez de `collect(toList())` | Misturar `parallel` com side-effects |
| Prefira `flatMap` a `map` + `flatten` | Criar streams infinitos sem `limit` |
| Use `Collectors.joining` para concatenar strings | Concatenar em loop com `+` |
| Cache streams reutilizáveis com `Supplier<Stream>` | Reusar um stream (one-shot) |
| Prefira `mapToInt/Long/Double` para evitar autoboxing | `map(Integer::intValue)` |

---

## 4.8 Exercícios

1. **Word Count:** Contar a frequência de cada palavra em um texto usando `Collectors.groupingBy`.
2. **Top N:** Encontrar os 5 produtos mais caros.
3. **FlatMap Aninhado:** Dado um `List<List<Set<String>>>`, obter todas as strings únicas ordenadas.
4. **Custom Collector:** Implementar um `Collector` que junta strings com delimitador customizado.

---

# 5 — Concorrência e Multithreading

## 5.1 Thread e Runnable

```java
// Criando thread com Runnable (preferido)
Runnable tarefa = () -> {
    System.out.println("Executando em: " + Thread.currentThread().getName());
};
Thread thread = new Thread(tarefa, "Minha-Thread");
thread.start();
thread.join(); // espera terminar

// Criando thread com Callable (retorna resultado)
Callable<Integer> calculo = () -> {
    Thread.sleep(100);
    return 42;
};
ExecutorService executor = Executors.newSingleThreadExecutor();
Future<Integer> futuro = executor.submit(calculo);
System.out.println(futuro.get()); // 42
executor.shutdown();
```

## 5.2 Synchronized

```java
public class Contador {
    private int valor = 0;

    // Synchronized method
    public synchronized void incrementar() {
        valor++;
    }

    // Synchronized block
    public void decrementar() {
        synchronized (this) {
            valor--;
        }
    }

    // Synchronized em objeto específico
    private final Object lock = new Object();
    public void metodo() {
        synchronized (lock) {
            // seção crítica
        }
    }

    public int getValor() { return valor; }
}

// ⚠️ Thread-safety com coleções
List<String> lista = Collections.synchronizedList(new ArrayList<>());
// ou melhor:
List<String> listaSegura = new CopyOnWriteArrayList<>();
```

## 5.3 Locks

### ReentrantLock

```java
public class FilaLock {
    private final ReentrantLock lock = new ReentrantLock();
    private final Queue<String> fila = new LinkedList<>();

    public void enqueue(String item) {
        lock.lock();
        try {
            fila.offer(item);
        } finally {
            lock.unlock(); // SEMPRE no finally
        }
    }

    public String dequeue() {
        lock.lock();
        try {
            return fila.poll();
        } finally {
            lock.unlock();
        }
    }

    // Try-lock (não bloqueia)
    public boolean tryEnqueue(String item) {
        if (lock.tryLock()) {
            try {
                fila.offer(item);
                return true;
            } finally {
                lock.unlock();
            }
        }
        return false;
    }

    // Try-lock com timeout
    public boolean tryEnqueueTimeout(String item) throws InterruptedException {
        if (lock.tryLock(1, TimeUnit.SECONDS)) {
            try {
                fila.offer(item);
                return true;
            } finally {
                lock.unlock();
            }
        }
        return false;
    }
}
```

### ReadWriteLock

```java
public class Cache<K, V> {
    private final Map<K, V> mapa = new HashMap<>();
    private final ReadWriteLock rwLock = new ReentrantReadWriteLock();

    // Leitores podem ler simultaneamente
    public V get(K chave) {
        rwLock.readLock().lock();
        try {
            return mapa.get(chave);
        } finally {
            rwLock.readLock().unlock();
        }
    }

    // Escritor bloqueia todos
    public void put(K chave, V valor) {
        rwLock.writeLock().lock();
        try {
            mapa.put(chave, valor);
        } finally {
            rwLock.writeLock().unlock();
        }
    }
}
```

### StampedLock (Java 8+)

```java
public class Point {
    private double x, y;
    private final StampedLock sl = new StampedLock();

    // Leitura otimista (sem lock)
    public double distanceFromOrigin() {
        long stamp = sl.tryOptimisticRead();
        double currentX = x, currentY = y;
        if (!sl.validate(stamp)) {
            stamp = sl.readLock();
            try {
                currentX = x;
                currentY = y;
            } finally {
                sl.unlockRead(stamp);
            }
        }
        return Math.sqrt(currentX * currentX + currentY * currentY);
    }

    // Escrita
    public void move(double newX, double newY) {
        long stamp = sl.writeLock();
        try {
            x = newX;
            y = newY;
        } finally {
            sl.unlockWrite(stamp);
        }
    }
}
```

## 5.4 Executors e Thread Pools

```java
// Fixed Thread Pool
ExecutorService fixed = Executors.newFixedThreadPool(4);

// Cached Thread Pool (cria threads sob demanda)
ExecutorService cached = Executors.newCachedThreadPool();

// Single Thread
ExecutorService single = Executors.newSingleThreadExecutor();

// Scheduled Executor
ScheduledExecutorService scheduled = Executors.newScheduledThreadPool(2);
scheduled.schedule(() -> System.out.println("Executa após 5s"), 5, TimeUnit.SECONDS);
scheduled.scheduleAtFixedRate(
    () -> System.out.println("A cada 2s"),
    0, 2, TimeUnit.SECONDS
);

// Custom ThreadPoolExecutor
ThreadPoolExecutor custom = new ThreadPoolExecutor(
    2,                        // core pool size
    8,                        // max pool size
    60L, TimeUnit.SECONDS,    // keep alive
    new LinkedBlockingQueue<>(100), // work queue
    new ThreadPoolExecutor.CallerRunsPolicy() // rejection policy
);

// Submit tasks
for (int i = 0; i < 20; i++) {
    final int taskId = i;
    custom.execute(() -> {
        System.out.println("Task " + taskId + " - " +
            Thread.currentThread().getName());
        sleep(100);
    });
}

custom.shutdown();
custom.awaitTermination(10, TimeUnit.SECONDS);

// Rejection Policies
// AbortPolicy          — lança RejectedExecutionException
// CallerRunsPolicy     — caller thread executa a task
// DiscardPolicy        — descarta silenciosamente
// DiscardOldestPolicy  — descarta a mais antiga da fila
```

## 5.5 CompletableFuture (avançado)

```java
// Pipeline completo com timeout
CompletableFuture<String> resultado = CompletableFuture
    .supplyAsync(() -> {
        sleep(200);
        return "dados";
    })
    .thenApplyAsync(dados -> dados.toUpperCase(), Executors.newFixedThreadPool(2))
    .orTimeout(1, TimeUnit.SECONDS)    // Java 9+
    .exceptionally(ex -> "timeout");

// thenCompose (flatmap para futures)
CompletableFuture<String> usuario = CompletableFuture
    .supplyAsync(() -> "user123")
    .thenCompose(id -> buscarNome(id)); // retorna CompletableFuture<String>

// thenAccept — consumir resultado sem retornar
CompletableFuture.runAsync(() -> {
    String resultado = processar();
    System.out.println(resultado);
});

// allOf com timeout
CompletableFuture<?> todos = CompletableFuture.allOf(
    CompletableFuture.supplyAsync(() -> "A"),
    CompletableFuture.supplyAsync(() -> "B"),
    CompletableFuture.supplyAsync(() -> "C")
);
todos.orTimeout(5, TimeUnit.SECONDS).join();

// anyOf — primeiro a completar
CompletableFuture<Object> primeiro = CompletableFuture.anyOf(
    CompletableFuture.supplyAsync(() -> { sleep(300); return "lento"; }),
    CompletableFuture.supplyAsync(() -> { sleep(100); return "rapido"; })
);
System.out.println(primeiro.join()); // "rapido"
```

## 5.6 Virtual Threads (Java 21+)

```java
// Criar virtual thread simples
Thread vt = Thread.ofVirtual().name("vt-1").start(() -> {
    System.out.println("Executando em virtual thread");
});
vt.join();

// Executor com virtual threads
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    IntStream.range(0, 10_000).forEach(i -> {
        executor.submit(() -> {
            Thread.sleep(Duration.ofSeconds(1));
            return i;
        });
    });
}

// Estrutura de concurrency com StructuredTaskScope (Java 21+ preview)
// Em production, use CompletableFuture ou Thread.ofVirtual().scope()

// Virtual threads com pooled executor (Java 23+)
ExecutorService vtPool = Executors.newVirtualThreadPerTaskExecutor();

// ⚡ Diferenças entre Platform e Virtual Threads
// Platform: pesadas, limitadas pelo número de CPUs
// Virtual: leves, milhares simultâneas, I/O bound
```

### Simulando Structured Concurrency (Java 21)

```java
// Abordagem funcional com CompletableFuture
public record ResultadoConsulta(String usuario, List<String> pedidos) {}

public CompletableFuture<ResultadoConsulta> buscarDados(String userId) {
    CompletableFuture<String> usuario = CompletableFuture
        .supplyAsync(() -> service.getUsuario(userId));

    CompletableFuture<List<String>> pedidos = CompletableFuture
        .supplyAsync(() -> service.getPedidos(userId));

    return usuario.thenCombine(pedidos, ResultadoConsulta::new);
}

// Uso
ResultadoConsulta dados = buscarDados("user123").join();
System.out.println(dados);
```

## 5.7 Atomic Classes

```java
// AtomicInteger, AtomicLong, AtomicBoolean, AtomicReference
AtomicInteger counter = new AtomicInteger(0);

// Operações atômicas
counter.incrementAndGet();       // ++counter → 1
counter.getAndIncrement();       // counter++ → 1 (retorna valor antigo)
counter.addAndGet(5);            // counter += 5
counter.compareAndSet(1, 10);    // se == 1, set 10 (retorna boolean)

// AtomicReference
AtomicReference<String> ref = new AtomicReference<>("inicial");
ref.compareAndSet("inicial", "atualizado");

// LongAdder (melhor que AtomicLong para contadores concorrentes)
LongAdder adder = new LongAdder();
adder.increment();
adder.add(5);
long total = adder.sum();

// LongAccumulator (operação customizada)
LongAccumulator max = new LongAccumulator(Long::max, Long.MIN_VALUE);
max.accumulate(42);
max.accumulate(100);
System.out.println(max.get()); // 100
```

## 5.8 Dicas e Erros Comuns

| ✅ Dica | ❌ Erro Comum |
|---------|---------------|
| Prefira `ExecutorService` a criar `Thread` diretamente | `Thread.sleep()` em main thread |
| Use `try-finally` com Locks | Esquecer `unlock()` |
| Use `ConcurrentHashMap` em vez de `Collections.synchronizedMap` | Race conditions em `HashMap` |
| Use `Virtual Threads` para I/O bound | Criar 1000 platform threads |
| Use `LongAdder` para contadores concorrentes | `AtomicLong` com alta contenção |

---

## 5.9 Exercícios

1. **Producer-Consumer:** Implementar com `BlockingQueue`.
2. **Reader-Writer Lock:** Criar cache com `ReadWriteLock`.
3. **Parallel Sort:** Ordenar array grande com `parallelSort`.
4. **Virtual Threads Benchmark:** Comparar tempo de 10.000 operações I/O com platform vs virtual threads.

---

# 6 — Reflection

## 6.1 Obtendo Classes

```java
// Forma 1: .class
Class<?> clazz1 = String.class;

// Forma 2: getClass()
String s = "hello";
Class<?> clazz2 = s.getClass();

// Forma 3: forName (com nome completo)
Class<?> clazz3 = Class.forName("java.lang.String");

// Informações da classe
System.out.println(clazz1.getName());      // java.lang.String
System.out.println(clazz1.getSimpleName()); // String
System.out.println(clazz1.getSuperclass()); // class java.lang.Object
System.out.println(clazz1.getModifiers());  // 17 (public final)
```

## 6.2 Obtendo Campos

```java
public class Pessoa {
    public String nome;
    protected int idade;
    private String email;

    public Pessoa(String nome, int idade, String email) {
        this.nome = nome;
        this.idade = idade;
        this.email = email;
    }
}

Class<Pessoa> clazz = Pessoa.class;

// Todos os campos (incluindo privados)
Field[] campos = clazz.getDeclaredFields();
for (Field campo : campos) {
    System.out.println(Modifier.toString(campo.getModifiers()) + " " + campo.getName());
}

// Campo específico
Field campoEmail = clazz.getDeclaredField("email");
campoEmail.setAccessible(true); // acesso a campo privado

Pessoa p = new Pessoa("Ana", 25, "ana@email.com");
String email = (String) campoEmail.get(p);
System.out.println(email); // ana@email.com

// Modificar campo
campoEmail.set(p, "novo@email.com");
System.out.println(p.getEmail()); // novo@email.com

// Campos públicos (sem setAccessible)
Field campoNome = clazz.getField("nome");
String nome = (String) campoNome.get(p);
```

## 6.3 Obtendo Métodos

```java
Class<Pessoa> clazz = Pessoa.class;

// Todos os métodos
Method[] metodos = clazz.getDeclaredMethods();
for (Method metodo : metodos) {
    System.out.println(Modifier.toString(metodo.getModifiers()) +
        " " + metodo.getReturnType().getSimpleName() +
        " " + metodo.getName() +
        " " + Arrays.toString(metodo.getParameterTypes()));
}

// Método específico
Method metodoGetIdade = clazz.getDeclaredMethod("getIdade");
metodoGetIdade.setAccessible(true);

int idade = (int) metodoGetIdade.invoke(p);
System.out.println(idade); // 25

// Método com parâmetros
Method metodoSet = clazz.getDeclaredMethod("setEmail", String.class);
metodoSet.invoke(p, "teste@email.com");

// Métodos da interface
Method[] metodosInterface = clazz.getMethods(); // inclui métodos públicos herdados
```

## 6.4 Invocando Métodos Dinamicamente

```java
// Invocar por nome
public static Object invocarMetodo(Object obj, String nomeMetodo, Object... args) throws Exception {
    Class<?> clazz = obj.getClass();
    Method metodo = Arrays.stream(clazz.getDeclaredMethods())
        .filter(m -> m.getName().equals(nomeMetodo))
        .findFirst()
        .orElseThrow(() -> new NoSuchMethodException(nomeMetodo));

    metodo.setAccessible(true);
    return metodo.invoke(obj, args);
}

// Uso
Pessoa p = new Pessoa("Ana", 25, "ana@email.com");
String nome = (String) invocarMetodo(p, "getNome");
System.out.println(nome); // Ana
```

## 6.5 Criando Objetos Dinamicamente

```java
// Criar instância por反射
Class<?> clazz = Class.forName("com.example.MinhaClasse");
Object instancia = clazz.getDeclaredConstructor().newInstance();

// Criar com construtor parametrizado
Constructor<Pessoa> construtor = Pessoa.class
    .getDeclaredConstructor(String.class, int.class, String.class);
Pessoa novaPessoa = construtor.newInstance("Bruno", 30, "bruno@email.com");

// Listar construtores
Constructor<?>[] construtores = Pessoa.class.getDeclaredConstructors();
for (Constructor<?> c : construtores) {
    System.out.println(Arrays.toString(c.getParameterTypes()));
}
```

## 6.6 Anotações com Reflection

```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface JsonField {
    String name() default "";
}

public class Usuario {
    @JsonField(name = "user_name")
    private String nome;

    @JsonField(name = "user_age")
    private int idade;
}

// Serializar usando reflection + anotações
public static Map<String, Object> toJson(Object obj) throws Exception {
    Map<String, Object> map = new LinkedHashMap<>();
    Class<?> clazz = obj.getClass();

    for (Field campo : clazz.getDeclaredFields()) {
        JsonField anotacao = campo.getAnnotation(JsonField.class);
        if (anotacao != null) {
            campo.setAccessible(true);
            String chave = anotacao.name().isEmpty() ? campo.getName() : anotacao.name();
            map.put(chave, campo.get(obj));
        }
    }
    return map;
}

// Uso
Usuario u = new Usuario("Ana", 25);
Map<String, Object> json = toJson(u);
// {user_name=Ana, user_age=25}
```

## 6.7 Dicas e Erros Comuns

| ✅ Dica | ❌ Erro Comum |
|---------|---------------|
| Cache `Class`, `Field`, `Method` | Chamar reflection repetidamente |
| Use `setAccessible(true)` para privados | Esquecer e ter IllegalAccessException |
| Use records para DTOs modernos | Reflection para tudo (preferir type-safe) |
| Verifique `null` em `invoke` | `InvocationTargetException` sem tratar |

---

## 6.8 Exercícios

1. **Object Mapper:** Criar um serializador JSON genérico usando reflection.
2. **Dependency Injector:** Implementar um mini-container DI com `@Inject`.
3. **Bean Validator:** Validar campos de um objeto usando reflection e anotações.

---

# 7 — Annotations

## 7.1 Annotations Built-in

```java
@Override       // sobrescrita de método
@SuppressWarnings("unchecked") // suprime warning
@Deprecated     // marca como obsoleto
@FunctionalInterface // interface com 1 método abstrato
@SafeVarargs    // suprime warning de varargs genéricos

// Spring
@Autowired
@Component
@Service
@Repository
@EventListener

// Lombok
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
```

## 7.2 Criando Annotations Customizadas

```java
import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)   // quando disponível
@Target(ElementType.TYPE)              // onde pode ser usada
@Documented                            // incluído no Javadoc
@Inherited                             // herdada por subclasses
public @interface MeuAnnotation {
    // Elementos (atributos)
    String value() default "";
    int prioridade() default 0;
    String[] tags() default {};
    boolean obrigatorio() default true;
}
```

### Retention Policies

| Policy | Disponível em | Uso |
|--------|---------------|-----|
| `SOURCE` | Compilador apenas | `@Override`, `@SuppressWarnings` |
| `CLASS` | Classloader (não runtime) | Frameworks de bytecode |
| `RUNTIME` | Runtime (reflection) | Spring, Hibernate, validação |

### Target Types

| Target | Aplicável em |
|--------|--------------|
| `TYPE` | Classe, interface, enum |
| `METHOD` | Métodos |
| `FIELD` | Campos |
| `CONSTRUCTOR` | Construtores |
| `PARAMETER` | Parâmetros |
| `LOCAL_VARIABLE` | Variáveis locais |
| `PACKAGE` | Pacotes |
| `MODULE` | Módulos (Java 9+) |

### Exemplo Prático

```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface Validar {
    int minimo() default 0;
    int maximo() default Integer.MAX_VALUE;
    String mensagem() default "Valor inválido";
}

public class Produto {
    @Validar(minimo = 1, maximo = 100, mensagem = "Preço deve ser entre 1 e 100")
    private double preco;

    @Validar(minimo = 1, maximo = 500, mensagem = "Estoque inválido")
    private int estoque;
}

// Validador usando reflection
public static List<String> validar(Object obj) throws Exception {
    List<String> erros = new ArrayList<>();
    Class<?> clazz = obj.getClass();

    for (Field campo : clazz.getDeclaredFields()) {
        Validar anotacao = campo.getAnnotation(Validar.class);
        if (anotacao != null) {
            campo.setAccessible(true);
            double valor = campo.getDouble(obj);

            if (valor < anotacao.minimo() || valor > anotacao.maximo()) {
                erros.add(campo.getName() + ": " + anotacao.mensagem());
            }
        }
    }
    return erros;
}
```

## 7.3 Meta-Annotations

```java
// Combinando anotações
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Documented
public @interface Servico {
    String nome() default "";
}

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Servico                          // meta-anotação!
@Lazy                             // combina com outra
public @interface MeuServico {
    String descricao() default "";
}

// Usando
@MeuServico(descricao = "Serviço de email")
public class EmailService { }

// Lendo meta-anotação via reflection
Servico s = EmailService.class.getAnnotation(Servico.class);
if (s != null) {
    System.out.println(s.nome()); // ""
}

MeuServico ms = EmailService.class.getAnnotation(MeuServico.class);
System.out.println(ms.descricao()); // "Serviço de email"
```

## 7.4 Processadores de Annotations

```java
// 1. Definir annotation
@Retention(RetentionPolicy.SOURCE)
@Target(ElementType.TYPE)
public @interface GerarToString {
}

// 2. Processador (compilação)
@SupportedAnnotationTypes("com.example.GerarToString")
@SupportedSourceVersion(SourceVersion.RELEASE_17)
public class GerarToStringProcessor extends AbstractProcessor {

    @Override
    public boolean process(Set<? extends TypeElement> annotations,
                          RoundEnvironment roundEnv) {

        for (Element element : roundEnv.getElementsAnnotatedWith(GerarToString.class)) {
            TypeElement typeElement = (TypeElement) element;
            String className = typeElement.getQualifiedName().toString();

            // Gerar código
            String javaFile = """
                package %s;

                public class %s {
                    @Override
                    public String toString() {
                        return "%s{}";
                    }
                }
                """.formatted(
                    processingEnv.getElementUtils().getPackageOf(typeElement).getSimpleName(),
                    typeElement.getSimpleName() + "ToString",
                    typeElement.getSimpleName()
                );

            // Escrever arquivo
            try {
                JavaFileObject sourceFile = processingEnv.getFiler()
                    .createSourceFile(className + "ToString");
                try (Writer writer = sourceFile.openWriter()) {
                    writer.write(javaFile);
                }
            } catch (IOException e) {
                processingEnv.getMessager().printMessage(
                    Diagnostic.Kind.ERROR,
                    e.getMessage()
                );
            }
        }
        return true;
    }
}
```

## 7.5 Dicas e Erros Comuns

| ✅ Dica | ❌ Erro Comum |
|---------|---------------|
| Use `@Retention(SOURCE)` para validação em compile-time | Usar `RUNTIME` sem necessidade |
| Use `@Inherited` quando subclasses devem herdar | Esquecer e ter que redeclarar em subclasses |
| Documente com `@Documented` | Annotation sem javadoc |
| Valide valores default | Annotation sem default em todos os elementos |

---

## 7.6 Exercícios

1. **@Cacheable:** Criar annotation que, em runtime, cacheia o resultado de um método.
2. **@Log:** Criar annotation que, antes de executar um método, loga o nome e parâmetros.
3. **@OverrideValidator:** Criar processador que verifica se `@Override` é válido em compile-time.

---

# 8 — Java I/O e NIO

## 8.1 Streams (byte-based)

```java
// FileInputStream / FileOutputStream
try (FileInputStream fis = new FileInputStream("entrada.txt");
     FileOutputStream fos = new FileOutputStream("saida.txt")) {

    byte[] buffer = new byte[1024];
    int bytesLidos;
    while ((bytesLidos = fis.read(buffer)) != -1) {
        fos.write(buffer, 0, bytesLidos);
    }
}

// BufferedInputStream / BufferedOutputStream
try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream("grande.dat"));
     BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream("copia.dat"))) {

    byte[] buffer = new byte[8192];
    int bytesLidos;
    while ((bytesLidos = bis.read(buffer)) != -1) {
        bos.write(buffer, 0, bytesLidos);
    }
}

// DataInputStream / DataOutputStream (tipos primitivos)
try (DataOutputStream dos = new DataOutputStream(new FileOutputStream("dados.bin"))) {
    dos.writeInt(42);
    dos.writeDouble(3.14);
    dos.writeUTF("Olá");
}

try (DataInputStream dis = new DataInputStream(new FileInputStream("dados.bin"))) {
    int i = dis.readInt();
    double d = dis.readDouble();
    String s = dis.readUTF();
}
```

## 8.2 Readers e Writers (character-based)

```java
// FileReader / FileWriter
try (FileReader fr = new FileReader("texto.txt", StandardCharsets.UTF_8);
     FileWriter fw = new FileWriter("copia.txt", StandardCharsets.UTF_8)) {

    int c;
    while ((c = fr.read()) != -1) {
        fw.write(c);
    }
}

// BufferedReader / BufferedWriter
try (BufferedReader br = new BufferedReader(new FileReader("texto.txt", StandardCharsets.UTF_8));
     BufferedWriter bw = new BufferedWriter(new FileWriter("saida.txt"))) {

    String linha;
    while ((linha = br.readLine()) != null) {
        bw.write(linha);
        bw.newLine();
    }
}

// PrintWriter (formatação fácil)
try (PrintWriter pw = new PrintWriter(new FileWriter("log.txt"))) {
    pw.println("Timestamp: " + LocalDateTime.now());
    pw.printf("Valor: %.2f%n", 3.14159);
}

// StringReader / StringWriter
StringReader sr = new StringReader("Hello World");
StringWriter sw = new StringWriter();
sr.transferTo(sw);
System.out.println(sw.toString()); // "Hello World"
```

## 8.3 NIO — Channels e Buffers

```java
// FileChannel + ByteBuffer
try (FileChannel channel = FileChannel.open(Path.of("dados.txt"),
        StandardOpenOption.READ)) {

    ByteBuffer buffer = ByteBuffer.allocate(1024);
    int bytesRead = channel.read(buffer);

    buffer.flip(); // prepare para leitura
    while (buffer.hasRemaining()) {
        System.out.print((char) buffer.get());
    }
}

// Escrita com FileChannel
try (FileChannel channel = FileChannel.open(Path.of("saida.txt"),
        StandardOpenOption.CREATE, StandardOpenOption.WRITE)) {

    ByteBuffer buffer = ByteBuffer.wrap("Olá NIO!".getBytes(StandardCharsets.UTF_8));
    channel.write(buffer);
}

// Cópia eficiente de arquivo
try (FileChannel src = FileChannel.open(Path.of("original.dat"));
     FileChannel dest = FileChannel.open(Path.of("copia.dat"),
        StandardOpenOption.CREATE, StandardOpenOption.WRITE)) {

    src.transferTo(0, src.size(), dest);
}

// MappedByteBuffer (memory-mapped files)
try (FileChannel channel = FileChannel.open(Path.of("grande.dat"), StandardOpenOption.READ)) {

    MappedByteBuffer mapped = channel.map(
        FileChannel.MapMode.READ_ONLY, 0, channel.size()
    );
    // Acesso direto ao arquivo como se fosse memória
    byte b = mapped.get(0);
}
```

## 8.4 NIO — Path e Files

```java
// Criar Path
Path path = Path.of("diretorio", "subdiretorio", "arquivo.txt");
Path pathAbs = Path.of("/home/usuario/arquivo.txt");
Path pathRel = Path.of("./saida.txt");

// Informações
System.out.println(path.getFileName());       // arquivo.txt
System.out.println(path.getParent());         // diretorio/subdiretorio
System.out.println(path.getRoot());           // null (relativo)
System.out.println(path.toAbsolutePath());    // caminho absoluto completo
System.out.println(path.normalize());         // normaliza ../

// Operações com Files
Files.createDirectories(Path.of("src/main/java/com/exemplo"));
Files.createFile(Path.of("temp.txt"));
Files.copy(Path.of("origem.txt"), Path.of("destino.txt"),
    StandardCopyOption.REPLACE_EXISTING);
Files.move(Path.of("antigo.txt"), Path.of("novo.txt"));
Files.delete(Path.of("temp.txt"));
Files.deleteIfExists(Path.of("temp.txt"));

// Leitura/escrita rápida
String conteudo = Files.readString(Path.of("texto.txt"), StandardCharsets.UTF_8);
List<String> linhas = Files.readAllLines(Path.of("texto.txt"), StandardCharsets.UTF_8);
byte[] bytes = Files.readAllBytes(Path.of("binario.dat"));

Files.writeString(Path.of("saida.txt"), "Olá!", StandardCharsets.UTF_8);
Files.write(Path.of("dados.bin"), new byte[]{1, 2, 3});

// Listar diretórios
try (Stream<Path> caminhos = Files.list(Path.of("."))) {
    caminhos.filter(Files::isDirectory)
        .forEach(System.out::println);
}

// Walk — percorrer árvore
try (Stream<Path> caminhos = Files.walk(Path.of("src"), 3)) {
    caminhos.filter(Files::isRegularFile)
        .filter(p -> p.toString().endsWith(".java"))
        .forEach(System.out::println);
}

// Find — buscar por critério
try (Stream<Path> caminhos = Files.find(Path.of("src"), 5,
        (p, attrs) -> attrs.isRegularFile() && p.toString().endsWith(".java"))) {
    caminhos.forEach(System.out::println);
}

// Attributes
BasicFileAttributes attrs = Files.readAttributes(
    Path.of("arquivo.txt"), BasicFileAttributes.class
);
System.out.println(attrs.size());
System.out.println(attrs.lastModifiedTime());
System.out.println(attrs.isDirectory());

// WatchService (monitorar diretório)
WatchService watcher = FileSystems.getDefault().newWatchService();
Path dir = Path.of("watched");
dir.register(watcher, StandardWatchEventKinds.ENTRY_CREATE,
    StandardWatchEventKinds.ENTRY_DELETE,
    StandardWatchEventKinds.ENTRY_MODIFY);

// Em thread separada
new Thread(() -> {
    while (true) {
        WatchKey key = watcher.poll();
        if (key != null) {
            for (WatchEvent<?> event : key.pollEvents()) {
                System.out.println(event.kind() + ": " + event.context());
            }
            key.reset();
        }
    }
}).start();
```

## 8.5 Dicas e Erros Comuns

| ✅ Dica | ❌ Erro Comum |
|---------|---------------|
| Sempre use try-with-resources | Esquecer de fechar streams/channels |
| Use NIO para arquivos grandes | Ler arquivo inteiro na memória |
| Use `Files.readString()` para texto simples | Usar FileReader+BufferedReader para leitura simples |
| Prefira `Path.of()` a `new File()` | Usar String para caminhos |
| Use `StandardCharsets.UTF_8` sempre | Depender de charset default |

---

## 8.6 Exercícios

1. **File Merger:** Juntar múltiplos arquivos em um único arquivo.
2. **Directory Watcher:** Monitorar um diretório e logar criações/modificações.
3. **Binary Search:** Buscar um inteiro em arquivo binário ordenado usando FileChannel.
4. **CSV Parser:** Ler CSV gigante usando BufferedReader com streaming.

---

# 9 — JDBC

## 9.1 Conexão com Banco

```java
// Conexão básica com JDBC
String url = "jdbc:postgresql://localhost:5432/meubanco";
String usuario = "admin";
String senha = "senha123";

// Usando DriverManager
Connection conn = DriverManager.getConnection(url, usuario, senha);

// Usando DataSource (preferido)
HikariConfig config = new HikariConfig();
config.setJdbcUrl(url);
config.setUsername(usuario);
config.setPassword(senha);
config.setMaximumPoolSize(10);
config.setMinimumIdle(2);
config.setConnectionTimeout(30000);
config.setIdleTimeout(600000);
config.setMaxLifetime(1800000);

HikariDataSource dataSource = new HikariDataSource(config);
Connection conn = dataSource.getConnection();
```

## 9.2 Statement e PreparedStatement

```java
// Statement (evitar — vulnerável a SQL Injection)
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM usuarios WHERE nome = '" + nome + "'");

// ✅ PreparedStatement (SEMPRE usar)
String sql = "SELECT id, nome, email FROM usuarios WHERE idade > ? AND ativo = ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setInt(1, 18);       // primeiro ?
ps.setBoolean(2, true); // segundo ?

ResultSet rs = ps.executeQuery();
while (rs.next()) {
    int id = rs.getInt("id");
    String nomeRs = rs.getString("nome");
    String email = rs.getString("email");
    System.out.printf("ID: %d, Nome: %s, Email: %s%n", id, nomeRs, email);
}

// INSERT
String insertSql = "INSERT INTO usuarios (nome, email, idade) VALUES (?, ?, ?)";
PreparedStatement psInsert = conn.prepareStatement(insertSql,
    Statement.RETURN_GENERATED_KEYS);
psInsert.setString(1, "Ana");
psInsert.setString(2, "ana@email.com");
psInsert.setInt(3, 25);
psInsert.executeUpdate();

// Obter ID gerado
ResultSet generatedKeys = psInsert.getGeneratedKeys();
if (generatedKeys.next()) {
    long id = generatedKeys.getLong(1);
}

// UPDATE / DELETE
String updateSql = "UPDATE usuarios SET email = ? WHERE id = ?";
PreparedStatement psUpdate = conn.prepareStatement(updateSql);
psUpdate.setString(1, "novo@email.com");
psUpdate.setLong(2, 1L);
int linhasAfetadas = psUpdate.executeUpdate();

// Batch
String batchSql = "INSERT INTO usuarios (nome, email) VALUES (?, ?)";
PreparedStatement psBatch = conn.prepareStatement(batchSql);

conn.setAutoCommit(false);
for (Usuario u : usuarios) {
    psBatch.setString(1, u.getNome());
    psBatch.setString(2, u.getEmail());
    psBatch.addBatch();
}
psBatch.executeBatch();
conn.commit();
conn.setAutoCommit(true);
```

## 9.3 ResultSet

```java
ResultSet rs = stmt.executeQuery("SELECT * FROM usuarios");

// Navegação
rs.next();              // próximo
rs.previous();          // anterior
rs.first();             // primeiro
rs.last();              // último
rs.absolute(5);         // quinto registro

// Leitura por tipo
int id = rs.getInt("id");
String nome = rs.getString("nome");
double salario = rs.getDouble("salario");
Date dataNasc = rs.getDate("data_nascimento");
Timestamp ts = rs.getTimestamp("criado_em");

// Verificar null
if (rs.wasNull()) {
    System.out.println("Valor era NULL");
}

// Metadados
ResultSetMetaData meta = rs.getMetaData();
int colunas = meta.getColumnCount();
for (int i = 1; i <= colunas; i++) {
    System.out.println(meta.getColumnName(i) + " → " + meta.getColumnTypeName(i));
}
```

## 9.4 Transações

```java
Connection conn = dataSource.getConnection();
try {
    conn.setAutoCommit(false);

    // Operação 1
    PreparedStatement ps1 = conn.prepareStatement(
        "UPDATE contas SET saldo = saldo - ? WHERE id = ?");
    ps1.setDouble(1, 1000);
    ps1.setLong(2, 1L);
    ps1.executeUpdate();

    // Operação 2
    PreparedStatement ps2 = conn.prepareStatement(
        "UPDATE contas SET saldo = saldo + ? WHERE id = ?");
    ps2.setDouble(1, 1000);
    ps2.setLong(2, 2L);
    ps2.executeUpdate();

    conn.commit(); // sucesso
} catch (SQLException e) {
    conn.rollback(); // desfaz tudo
    throw e;
} finally {
    conn.setAutoCommit(true);
    conn.close();
}

// Savepoints
conn.setAutoCommit(false);
conn.prepareStatement("INSERT INTO audit ...").executeUpdate();
Savepoint sp = conn.setSavepoint("antes_do_update");
conn.prepareStatement("UPDATE ...").executeUpdate();

if (problemaDetectado) {
    conn.rollback(sp); // desfaz só a partir do savepoint
}
conn.commit();
```

## 9.5 Connection Pooling (HikariCP)

```java
// Configuração completa
HikariConfig config = new HikariConfig();

// Básico
config.setJdbcUrl("jdbc:postgresql://localhost:5432/meubanco");
config.setUsername("admin");
config.setPassword("senha123");

// Pool
config.setPoolName("MeuPool");
config.setMaximumPoolSize(10);        // máx de conexões
config.setMinimumIdle(2);             // mín de idle
config.setIdleTimeout(600000);        // 10 min
config.setMaxLifetime(1800000);       // 30 min
config.setConnectionTimeout(30000);   // 30s para obter conexão

// Performance
config.addDataSourceProperty("cachePrepStmts", "true");
config.addDataSourceProperty("prepStmtCacheSize", "250");
config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

// Monitoramento
config.setRegisterMbeans(true);

HikariDataSource ds = new HikariDataSource(config);

// Usar com try-with-resources
try (Connection conn = ds.getConnection();
     PreparedStatement ps = conn.prepareStatement("SELECT ...")) {
    ResultSet rs = ps.executeQuery();
    // processar
} // conexão volta pro pool automaticamente
```

## 9.6 Dicas e Erros Comuns

| ✅ Dica | ❌ Erro Comum |
|---------|---------------|
| SEMPRE use PreparedStatement | Statement com concatenação (SQL Injection) |
| Use try-with-resources | Fechar conexão manualmente |
| Use connection pooling | Criar conexão a cada query |
| Use batch para inserts em massa | Insert em loop sem batch |
| Trate `SQLException` adequadamente | Ignorar erros de banco |
| Use transações para operações múltiplas | Commit parcial |

---

## 9.7 Exercícios

1. **CRUD Completo:** Implementar DAO completo para uma entidade.
2. **Batch Import:** Importar 100.000 registros usando batch + transação.
3. **Connection Pool Monitor:** Criar endpoint que reporta status do pool.
4. **Stored Procedure:** Chamar procedure e processar ResultSet de saída.

---

# 10 — Optional

## 10.1 Criando Optional

```java
// Criar Optional
Optional<String> vazio = Optional.empty();
Optional<String> presente = Optional.of("valor");
Optional<String> nullable = Optional.ofNullable(null); // não lança NPE

// A partir de método que retorna null
public Optional<Usuario> buscarUsuario(long id) {
    Usuario u = repository.findById(id);
    return Optional.ofNullable(u);
}
```

## 10.2 Métodos Principais

```java
Optional<String> opt = Optional.of("Hello");

// isPresent / isEmpty (Java 11+)
if (opt.isPresent()) {
    System.out.println(opt.get());
}
if (opt.isEmpty()) {
    System.out.println("Vazio");
}

// orElse — valor padrão
String valor = opt.orElse("Default");

// orElseGet — supplier (lazy)
String valor2 = opt.orElseGet(() -> {
    // executa apenas se vazio
    return computarDefault();
});

// orElseThrow — exceção
String valor3 = opt.orElseThrow(() -> new IllegalStateException("Não encontrado"));

// ifPresent — executar se presente
opt.ifPresent(v -> System.out.println("Valor: " + v));

// ifPresentOrElse (Java 9+)
opt.ifPresentOrElse(
    v -> System.out.println("Encontrado: " + v),
    () -> System.out.println("Não encontrado")
);

// or (Java 9+) — outro Optional como fallback
Optional<String> resultado = Optional.empty()
    .or(() -> Optional.of("fallback"));

// stream (Java 9+) — converter para Stream
List<String> lista = Optional.of("hello").stream().toList(); // ["hello"]
List<String> vazia = Optional.<String>empty().stream().toList(); // []
```

## 10.3 Filtrando e Mapeando

```java
Optional<Integer> num = Optional.of(42);

// map — transforma o valor
Optional<String> mapped = num.map(n -> "Valor: " + n);
System.out.println(mapped.orElse("")); // "Valor: 42"

// flatMap — quando o mapper retorna Optional
Optional<Optional<Integer>> wrong = num.map(n -> Optional.of(n * 2)); // ❌ Optional<Optional<>>
Optional<Integer> right = num.flatMap(n -> Optional.of(n * 2));        // ✅ Optional<Integer>

// filter — condicional
Optional<Integer> par = Optional.of(4).filter(n -> n % 2 == 0);  // 4
Optional<Integer> impar = Optional.of(3).filter(n -> n % 2 == 0); // empty

// Encadeamento completo
String resultado = Optional.of("  Ana  ")
    .map(String::trim)
    .filter(s -> !s.isEmpty())
    .map(String::toUpperCase)
    .orElse("ANÔNIMO");
// "ANA"
```

## 10.4 Exemplo Prático: Pipeline de Usuário

```java
public record Usuario(String nome, String email, Endereco endereco) {}
public record Endereco(String rua, String cidade, String cep) {}

public Optional<String> buscarCepUsuario(Usuario usuario) {
    return Optional.ofNullable(usuario)
        .flatMap(u -> Optional.ofNullable(u.endereco()))
        .map(Endereco::cep)
        .filter(cep -> cep.matches("\\d{5}-\\d{3}"));
}

// Uso
Usuario completo = new Usuario("Ana", "ana@email.com",
    new Endereco("Rua A", "SP", "01001-000"));
Usuario semEndereco = new Usuario("Bruno", "bruno@email.com", null);

System.out.println(buscarCepUsuario(completo));  // Optional[01001-000]
System.out.println(buscarCepUsuario(semEndereco)); // Optional.empty
```

## 10.5 Exceptions com Optional

```java
// Converter checked exception em Optional
public static <T> Optional<T> safe(Supplier<T> supplier) {
    try {
        return Optional.ofNullable(supplier.get());
    } catch (Exception e) {
        return Optional.empty();
    }
}

// Uso
Optional<Integer> resultado = safe(() -> Integer.parseInt("abc"));
System.out.println(resultado.isPresent()); // false

Optional<Usuario> user = safe(() -> service.buscarUsuario(1L));
```

## 10.6 Best Practices

```java
// ✅ USE Optional para:
// 1. Retorno de métodos que podem não ter valor
public Optional<Usuario> findById(long id) { ... }

// 2. Encadear operações com null-safety
String cidade = Optional.ofNullable(usuario)
    .map(Usuario::endereco)
    .map(Endereco::cidade)
    .orElse("Desconhecida");

// ❌ NÃO USE Optional para:
// 1. Atributos de classe (use null ou Default)
public class Usuario {
    Optional<String> email; // ❌
    String email;           // ✅
}

// 2. Parâmetros de método
public void processar(Optional<String> param) { } // ❌

// 3. Em coleções — use Collections.emptyList()
List<Optional<String>> lista; // ❌
List<String> lista;           // ✅

// 4. Serialização — Optional não é serializável

// ✅ Preferências
// 1. Prefira orElseGet a orElse quando o default é custoso
String v = opt.orElse(computarCusto());   // computa sempre
String v = opt.orElseGet(() -> computar()); // só se vazio

// 2. Prefira orElseThrow a get()
Usuario u = opt.orElseThrow(); // Java 10+ — exceção genérica
Usuario u = opt.orElseThrow(() -> new NotFoundException("User not found"));

// 3. Use map/flatMap/filter ao invés de isPresent + get
// ❌
if (opt.isPresent()) {
    String valor = opt.get().toUpperCase();
}
// ✅
opt.map(String::toUpperCase).ifPresent(System.out::println);
```

## 10.7 Dicas e Erros Comuns

| ✅ Dica | ❌ Erro Comum |
|---------|---------------|
| `map` quando transforma, `flatMap` quando retorna Optional | `map` com função que retorna Optional → `Optional<Optional<>>` |
| `orElseGet` para valores custosos | `orElse` com computação pesada |
| `filter` para validações | Usar `if (opt.isPresent()) opt.get().equals(...)` |
| Retorne Optional de métodos que podem falhar | Use Optional como parâmetro |
| Prefira `orElseThrow()` a `get()` | `opt.get()` sem `isPresent()` |

---

## 10.8 Exercícios

1. **Safe Navigation:** Criar `Optional` chain para acessar `usuario.empresa.diretor.nome`.
2. **Optional Builder:** Criar builder que constrói `Optional` a partir de múltiplas fontes.
3. **Optional Collector:** Criar `Collector` que junta `Stream<Optional<T>>` em `List<T>` (filtra os vazios).

---

# 📌 Resumo Rápido

| Tópico | Conceito-Chave | Quando Usar |
|--------|---------------|-------------|
| **Collections** | Estruturas de dados padronizadas | Sempre que armazenar/grupar dados |
| **Generics** | Type safety em compile-time | APIs, coleções, métodos reutilizáveis |
| **Lambdas** | Funções anônimas + functional interfaces | Callbacks, streams, event handlers |
| **Streams** | Pipeline funcional de dados | Transformação/filtro/agregação de coleções |
| **Concurrency** | Execução paralela e assíncrona | I/O, CPU-bound, APIs reativas |
| **Reflection** | Inspeção/introspecção em runtime | Frameworks, DI, serialização |
| **Annotations** | Metadata declarativa | Configuração, validação, geração de código |
| **I/O & NIO** | Leitura/escrita de dados | Arquivos, rede, buffers |
| **JDBC** | Acesso a bancos relacionais | CRUD, transações, SQL |
| **Optional** | Tratamento de nulos | Retornos de métodos que podem não ter valor |

---

> **📚 Próximos Passos:** Design Patterns, Spring Boot, Arquitetura de Microsserviços, Testes Avançados (JUnit 5 + Mockito)

---

*Guia Java Avançado — Criado em Setembro 2026*
