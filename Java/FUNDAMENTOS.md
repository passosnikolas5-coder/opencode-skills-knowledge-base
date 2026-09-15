# ☕ Fundamentos de Java — Guia Completo e Profissional

> **Última atualização:** Setembro 2026  
> **Versão do Java foco:** 17 LTS / 21 LTS  
> **Nível:** Iniciante → Intermediário

---

## 📑 Índice

1. [Introdução ao Java](#1-introdução-ao-java)
2. [Sintaxe Básica](#2-sintaxe-básica)
3. [Estruturas de Controle](#3-estruturas-de-controle)
4. [Arrays e Strings](#4-arrays-e-strings)
5. [Programação Orientada a Objetos](#5-programação-orientada-a-objetos)
6. [Tratamento de Exceções](#6-tratamento-de-exceções)
7. [Enum e Records](#7-enum-e-records)

---

## 1. Introdução ao Java

### 1.1 História e Evolução

| Ano | Evento |
|-----|--------|
| 1991 | Projeto **Oak** iniciado por James Gosling na Sun Microsystems |
| 1995 | Lançamento oficial do Java 1.0 |
| 1998 | Java 2 — adição de Swing, Collections Framework |
| 2004 | Java 5 — Generics, Autoboxing, Enums, For-each |
| 2011 | Java 7 — Try-with-resources, Diamond Operator |
| 2014 | Java 8 — **Lambda Expressions**, Streams API, Optional |
| 2017 | Java 9 — Módulos (Jigsaw), JShell |
| 2018 | Java 10 — Local Variables (var) |
| 2018 | Java 11 **LTS** — HTTP Client, String melhorias |
| 2021 | Java 17 **LTS** — Records, Sealed Classes, Pattern Matching |
| 2023 | Java 21 **LTS** — Virtual Threads, Pattern Matching for switch |

### 1.2 Por que aprender Java?

- 🔒 **Portabilidade:** "Write Once, Run Anywhere" — bytecode roda em qualquer JVM
- 🏢 **Enterprise:** Usado por grandes corporações (banco, seguradoras, governo)
- 📱 **Android:** Linguagem nativa (com Kotlin) para desenvolvimento mobile
- 🌐 **Web:** Spring Boot, Jakarta EE, Micronaut
- 📊 **Big Data:** Hadoop, Spark, Kafka escritos em Java/Scala
- 👥 **Comunidade:** Uma das maiores comunidades de desenvolvedores do mundo
- 💼 **Mercado:** Alta demanda e bons salários globalmente

### 1.3 Versões do Java (LTS e latest)

| Versão | Status | Destaques |
|--------|--------|-----------|
| **Java 8** | ✅ Amplamente usado | Lambda, Streams, Optional, Date/Time API |
| **Java 11** | ✅ LTS | HTTP Client, var, String.isBlank() |
| **Java 17** | ✅ LTS (recomendado) | Records, Sealed Classes, Text Blocks |
| **Java 21** | ✅ LTS (mais recente) | Virtual Threads, Pattern Matching switch |

> 💡 **Dica:** Para projetos novos, comece com **Java 17+**. Empresas legadas ainda mantêm Java 8/11.

### 1.4 Configuração do Ambiente

#### Opção 1 — JDK da Oracle / OpenJDK

```bash
# 1. Baixe o JDK em https://adoptium.net/ ou https://www.oracle.com/java/technologies/
# 2. Instale e configure JAVA_HOME

# Windows (PowerShell):
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk-21", "User")
[System.Environment]::SetEnvironmentVariable("Path", "$env:Path;$env:JAVA_HOME\bin", "User")

# Linux / macOS (~/.bashrc ou ~/.zshrc):
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
```

#### Opção 2 — SDKMAN! (Linux/macOS)

```bash
curl -s "https://get.sdkman.io" | bash
sdk install java 21.0.3-tem
sdk use java 21.0.3-tem
```

#### Verificação

```bash
java -version
javac -version
```

Saída esperada:
```
openjdk version "21.0.3" 2024-04-16 LTS
```

#### IDEs Recomendadas

| IDE | Tipo | Indicado para |
|-----|------|---------------|
| **IntelliJ IDEA** | Gratuito/Pago | Profissional, Android |
| **VS Code** | Gratuito | Leve, multi-linguagem |
| **Eclipse** | Gratuito | Clássico, plugins Java |
| **NetBeans** | Gratuito | Acadêmico, simples |

---

## 2. Sintaxe Básica

### 2.1 Estrutura de um Programa

```java
// Arquivo: OlaMundo.java — O nome do arquivo DEVE ser igual ao da classe pública

/**
 * Classe principal que imprime uma mensagem.
 * Comentário de documentação (Javadoc).
 */
public class OlaMundo {

    // Método principal — ponto de entrada de todo programa Java
    public static void main(String[] args) {
        System.out.println("Olá, Mundo!");
        System.out.println("Bem-vindo ao Java!");
    }
}
```

**Compilação e execução:**

```bash
javac OlaMundo.java    # Compila → gera OlaMundo.class
java OlaMundo          # Executa via JVM
```

#### Regras para nomes em Java

| Elemento | Convenção | Exemplo |
|----------|-----------|---------|
| Classe | PascalCase | `MinhaClasse` |
| Método | camelCase | `calcularTotal()` |
| Variável | camelCase | `nomeUsuario` |
| Constante | UPPER_SNAKE | `MAX_TENTATIVAS` |
| Pacote | lowercase | `com.exemplo.projeto` |

### 2.2 Variáveis e Tipos de Dados

#### Tipos Primitivos

| Tipo | Tamanho | Faixa | Exemplo |
|------|---------|-------|---------|
| `byte` | 8 bits | -128 a 127 | `byte idade = 25;` |
| `short` | 16 bits | -32.768 a 32.767 | `short ano = 2026;` |
| `int` | 32 bits | -2 bi a 2 bi | `int populacao = 1000000;` |
| `long` | 64 bits | -9e18 a 9e18 | `long distancia = 150_000_000L;` |
| `float` | 32 bits | 7 casas decimais | `float pi = 3.14f;` |
| `double` | 64 bits | 15 casas decimais | `double pi = 3.14159265;` |
| `char` | 16 bits | 0 a 65.535 (Unicode) | `char letra = 'A';` |
| `boolean` | 1 bit | true/false | `boolean ativo = true;` |

#### Variáveis Locais (var — Java 10+)

```java
var nome = "Ana";           // Inferido como String
var idade = 25;             // Inferido como int
var notas = new ArrayList<Double>(); // Inferido como ArrayList<Double>
```

> ⚠️ `var` só funciona para variáveis **locais** (dentro de métodos). Nunca em atributos de classe.

#### Exemplo Prático — Calculadora de IMC

```java
public class CalculadoraIMC {
    public static void main(String[] args) {
        String nome = "Maria";
        double peso = 68.5;   // kg
        double altura = 1.65; // m

        double imc = peso / (altura * altura);

        System.out.println("Nome: " + nome);
        System.out.printf("IMC: %.2f%n", imc);

        if (imc < 18.5) {
            System.out.println("Classificação: Abaixo do peso");
        } else if (imc < 25.0) {
            System.out.println("Classificação: Peso normal");
        } else if (imc < 30.0) {
            System.out.println("Classificação: Sobrepeso");
        } else {
            System.out.println("Classificação: Obesidade");
        }
    }
}
```

### 2.3 Operadores

#### Aritméticos

```java
int a = 10, b = 3;
System.out.println(a + b);  // 13  (soma)
System.out.println(a - b);  // 7   (subtração)
System.out.println(a * b);  // 30  (multiplicação)
System.out.println(a / b);  // 3   (divisão inteira!)
System.out.println(a % b);  // 1   (módulo/resto)
```

> ⚠️ **Erro comum:** `10 / 3` retorna `3` (divisão inteira). Use `10.0 / 3` ou `(double) a / b` para resultado `3.333...`.

#### Atribuição

```java
int x = 10;
x += 5;   // x = x + 5  → 15
x -= 3;   // x = x - 3  → 12
x *= 2;   // x = x * 2  → 24
x /= 4;   // x = x / 4  → 6
x %= 4;   // x = x % 4  → 2
```

#### Comparação (retornam boolean)

| Operador | Significado | Exemplo |
|----------|-------------|---------|
| `==` | Igual a | `5 == 5` → `true` |
| `!=` | Diferente de | `5 != 3` → `true` |
| `>` | Maior que | `5 > 3` → `true` |
| `<` | Menor que | `5 < 3` → `false` |
| `>=` | Maior ou igual | `5 >= 5` → `true` |
| `<=` | Menor ou igual | `3 <= 5` → `true` |

#### Lógicos

| Operador | Significado | Exemplo |
|----------|-------------|---------|
| `&&` | AND (curto-circuito) | `true && false` → `false` |
| `\|\|` | OR (curto-circuito) | `true \|\| false` → `true` |
| `!` | NOT | `!true` → `false` |

#### Bitwise

```java
int a = 0b1010;  // 10
int b = 0b1100;  // 12

System.out.println(Integer.toBinaryString(a & b));  // 1000 (AND)
System.out.println(Integer.toBinaryString(a | b));  // 1110 (OR)
System.out.println(Integer.toBinaryString(a ^ b));  // 0110 (XOR)
System.out.println(Integer.toBinaryString(~a));      // Complemento
```

#### Operador Ternário

```java
int idade = 20;
String status = (idade >= 18) ? "Maior de idade" : "Menor de idade";
// status = "Maior de idade"
```

### 2.4 Entrada e Saída de Dados

#### Saída

```java
System.out.println("Linha com quebra");    // Imprime e pula linha
System.out.print("Sem quebra de linha");   // Imprime sem pular
System.out.printf("Nome: %s | Idade: %d | Altura: %.2f%n",
                   "João", 30, 1.75);      // Formatação C-style
```

**Formatted Output — Tabulação de Especificadores:**

| Especificador | Tipo | Exemplo |
|---------------|------|---------|
| `%d` | int/long | `printf("%d", 42)` |
| `%f` | float/double | `printf("%.2f", 3.14)` |
| `%s` | String | `printf("%s", "olá")` |
| `%c` | char | `printf("%c", 'A')` |
| `%b` | boolean | `printf("%b", true)` |
| `%n` | Nova linha (plataforma) | — |

#### Entrada (Scanner)

```java
import java.util.Scanner;

public class LeituraDados {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Digite seu nome: ");
        String nome = scanner.nextLine();

        System.out.print("Digite sua idade: ");
        int idade = scanner.nextInt();

        System.out.printf("Olá, %s! Você tem %d anos.%n", nome, idade);

        scanner.close(); // Sempre fechar o Scanner
    }
}
```

#### Entrada Alternativa (Console — Java 6+)

```java
String nome = System.console().readLine("Nome: ");
int idade = Integer.parseInt(System.console().readLine("Idade: "));
```

> ⚠️ `System.console()` retorna `null` em IDEs. Use `Scanner` para desenvolvimento.

---

## 3. Estruturas de Controle

### 3.1 Condicionais

#### if / else if / else

```java
int nota = 75;

if (nota >= 90) {
    System.out.println("A — Excelente!");
} else if (nota >= 70) {
    System.out.println("B — Bom");
} else if (nota >= 50) {
    System.out.println("C — Regular");
} else {
    System.out.println("D — Reprovado");
}
```

#### switch

```java
// Java 14+ — Switch Expression (recomendado)
String diaSemana = "SEG";

String resultado = switch (diaSemana) {
    case "SEG", "TER", "QUA", "QUI", "SEX" -> "Dia útil";
    case "SAB" -> "Sábado";
    case "DOM" -> "Domingo";
    default -> "Inválido";
};

System.out.println(resultado); // Dia útil

// Com yield (bloco de código complexo)
int numero = 3;
String tipo = switch (numero) {
    case 1 -> "Um";
    case 2 -> "Dois";
    default -> {
        System.out.println("Número não mapeado");
        yield "Outro"; // yield retorna o valor no switch expression
    }
};
```

> ⚌ **Antes do Java 14:**
> ```java
> switch (diaSemana) {
>     case "SEG":
>     case "TER":
>     case "QUA":
>     case "QUI":
>     case "SEX":
>         resultado = "Dia útil";
>         break;
>     case "SAB":
>         resultado = "Sábado";
>         break;
>     default:
>         resultado = "Inválido";
>         break;
> }
> ```

#### Pattern Matching for switch (Java 21+)

```java
static String descrever(Object obj) {
    return switch (obj) {
        case Integer i when i > 0 -> "Inteiro positivo: " + i;
        case Integer i -> "Inteiro não positivo: " + i;
        case String s when s.isEmpty() -> "String vazia";
        case String s -> "String: " + s;
        case null -> "Nulo";
        default -> "Outro tipo: " + obj.getClass().getSimpleName();
    };
}
```

### 3.2 Loops

#### for clássico

```java
// Sintaxe: for (inicialização; condição; incremento)
for (int i = 0; i < 10; i++) {
    System.out.println("i = " + i);
}
```

#### for-each (enhanced for)

```java
String[] frutas = {"Maçã", "Banana", "Laranja"};

for (String fruta : frutas) {
    System.out.println(fruta);
}
```

#### while

```java
int contador = 0;
while (contador < 5) {
    System.out.println("Contador: " + contador);
    contador++;
}
```

#### do-while

```java
int contador = 0;
do {
    System.out.println("Contador: " + contador);
    contador++;
} while (contador < 5);
```

> 💡 `do-while` executa **pelo menos uma vez**, mesmo que a condição seja `false`.

#### Exemplo Prático — Jogo da Adivinhação

```java
import java.util.Random;
import java.util.Scanner;

public class JogoAdivinhacao {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();
        int numeroSecreto = random.nextInt(100) + 1; // 1-100
        int tentativas = 0;
        int palpite;

        System.out.println("🎯 Adivinhe o número (1 a 100)!");

        do {
            System.out.print("Seu palpite: ");
            palpite = scanner.nextInt();
            tentativas++;

            if (palpite < numeroSecreto) {
                System.out.println("↑ Muito baixo!");
            } else if (palpite > numeroSecreto) {
                System.out.println("↓ Muito alto!");
            }
        } while (palpite != numeroSecreto);

        System.out.printf("🎉 Acertou em %d tentativas!%n", tentativas);
        scanner.close();
    }
}
```

### 3.3 Break e Continue

#### break — Sai do loop ou switch

```java
for (int i = 0; i < 100; i++) {
    if (i == 5) {
        break; // Sai do loop quando i == 5
    }
    System.out.println(i);
}
// Saída: 0, 1, 2, 3, 4
```

#### break com label — Sai de loops aninhados

```java
externo:
for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
        if (j == 3) {
            break externo; // Sai do loop EXTERNO
        }
        System.out.printf("(%d, %d) ", i, j);
    }
}
// Saída: (0, 0) (0, 1) (0, 2)
```

#### continue — Pula para a próxima iteração

```java
for (int i = 0; i < 10; i++) {
    if (i % 2 == 0) {
        continue; // Pula números pares
    }
    System.out.println(i); // Imprime apenas ímpares: 1, 3, 5, 7, 9
}
```

---

## 4. Arrays e Strings

### 4.1 Arrays Unidimensionais

#### Declaração e Inicialização

```java
// Formas de declarar um array
int[] numeros1 = new int[5];              // Array de 5 posições (preenchido com 0)
int[] numeros2 = {10, 20, 30, 40, 50};   // Inicialização direta
int[] numeros3 = new int[]{10, 20, 30};  // Anônimo
```

#### Acesso e Modificação

```java
int[] notas = {85, 90, 78, 92, 88};

System.out.println(notas[0]);     // 85 (primeiro elemento)
System.out.println(notas.length); // 5 (tamanho)

notas[2] = 95; // Modifica o terceiro elemento
```

#### Exemplo Prático — Encontrar o Maior e Menor

```java
public class MaiorMenor {
    public static void main(String[] args) {
        int[] temperaturas = {22, 18, 25, 30, 15, 28, 20};

        int maior = temperaturas[0];
        int menor = temperaturas[0];

        for (int i = 1; i < temperaturas.length; i++) {
            if (temperaturas[i] > maior) {
                maior = temperaturas[i];
            }
            if (temperaturas[i] < menor) {
                menor = temperaturas[i];
            }
        }

        System.out.println("🌡️ Maior temperatura: " + maior + "°C");
        System.out.println("🌡️ Menor temperatura: " + menor + "°C");
    }
}
```

### 4.2 Arrays Multidimensionais

#### Matriz 2D

```java
int[][] matriz = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};

// Acesso
System.out.println(matriz[1][2]); // 6 (linha 1, coluna 2)
System.out.println(matriz.length);    // 3 (número de linhas)
System.out.println(matriz[0].length); // 3 (número de colunas)

// Percorrer com for aninhado
for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[i].length; j++) {
        System.out.printf("%d ", matriz[i][j]);
    }
    System.out.println();
}
```

#### Exemplo Prático — Tabuada

```java
public class Tabuada {
    public static void main(String[] args) {
        int[][] tabuada = new int[10][11]; // Tabuadas de 1 a 10

        for (int i = 1; i <= 10; i++) {
            for (int j = 0; j <= 10; j++) {
                tabuada[i - 1][j] = i * j;
            }
        }

        // Exibir tabuada do 7
        System.out.println("📐 Tabuada do 7:");
        for (int j = 0; j <= 10; j++) {
            System.out.printf("7 x %2d = %3d%n", j, tabuada[6][j]);
        }
    }
}
```

### 4.3 Manipulação de Strings

Strings em Java são **imutáveis** — toda operação cria uma nova String.

#### Métodos Mais Usados

```java
String texto = "  Olá, Mundo!  ";

// Informações
texto.length()                    // 15 (com espaços)
texto.charAt(2)                   // 'l'
texto.indexOf("Mundo")            // 9
texto.contains("Mundo")           // true
texto.isEmpty()                   // false
texto.isBlank()                   // false (Java 11+)

// Transformação
texto.trim()                      // "Olá, Mundo!" (remove espaços)
texto.toUpperCase()               // "  OLÁ, MUNDO!  "
texto.toLowerCase()               // "  olá, mundo!  "
texto.replace("Mundo", "Java")   // "  Olá, Java!  "

// Extração
texto.substring(2, 8)             // "Olá, " (index 2 até 7)
texto.substring(2)                // "Olá, Mundo!  "

// Divisão e Junção
String csv = "maçã,banana,laranja";
csv.split(",")                    // ["maçã", "banana", "laranja"]

String[] frutas = {"A", "B", "C"};
String.join(" - ", frutas)        // "A - B - C"

// Conversão
String.valueOf(42)                // "42"
String.valueOf(3.14)              // "3.14"
Integer.parseInt("42")            // 42
Double.parseDouble("3.14")        // 3.14
```

#### Comparação de Strings

```java
String a = "hello";
String b = "hello";
String c = new String("hello");

a == b      // true  (mesmo objeto no String Pool)
a == c      // false (objetos diferentes)
a.equals(c) // true  (mesmo conteúdo) ← SEMPRE use equals()
a.equalsIgnoreCase("HELLO") // true
```

> ⚠️ **Erro clássico:** Nunca use `==` para comparar Strings. Sempre use `.equals()`.

#### Text Blocks (Java 15+)

```java
String json = """
        {
            "nome": "Ana",
            "idade": 25,
            "ativo": true
        }
        """;

String sql = """
        SELECT id, nome, email
        FROM usuarios
        WHERE ativo = true
        ORDER BY nome
        """;
```

### 4.4 StringBuilder

Para **concatenações em loop**, use `StringBuilder` (mais performático):

```java
StringBuilder sb = new StringBuilder();

sb.append("Primeira linha");
sb.append("\n");
sb.append("Segunda linha");
sb.append("\n");
sb.append("Terceira linha");

String resultado = sb.toString();

// Outros métodos úteis
sb.insert(0, "Início\n");    // Insere no início
sb.replace(0, 5, "Novo");    // Substitui substring
sb.delete(0, 4);             // Remove caracteres
sb.reverse();                // Inverte a string
sb.length();                 // Tamanho atual
```

#### Exemplo Prático — Gerador de CSV

```java
public class GeradorCSV {
    public static String gerarCSV(String[][] dados, String[] cabecalho) {
        StringBuilder csv = new StringBuilder();

        // Cabeçalho
        csv.append(String.join(",", cabecalho)).append("\n");

        // Dados
        for (String[] linha : dados) {
            csv.append(String.join(",", linha)).append("\n");
        }

        return csv.toString();
    }

    public static void main(String[] args) {
        String[] cabecalho = {"Nome", "Idade", "Cidade"};
        String[][] dados = {
            {"Ana", "25", "São Paulo"},
            {"Bruno", "30", "Rio de Janeiro"},
            {"Carlos", "22", "Belo Horizonte"}
        };

        System.out.println(gerarCSV(dados, cabecalho));
    }
}
```

---

## 5. Programação Orientada a Objetos

### 5.1 Classes e Objetos

Uma **classe** é o molde; um **objeto** é a instância.

```java
public class Carro {
    // Atributos (estado)
    String marca;
    String modelo;
    int ano;
    double velocidade;

    // Métodos (comportamento)
    void acelerar(double incremento) {
        velocidade += incremento;
        System.out.printf("🚀 %.0f km/h%n", velocidade);
    }

    void frear(double decremento) {
        velocidade = Math.max(0, velocidade - decremento);
        System.out.printf("🛑 %.0f km/h%n", velocidade);
    }

    void exibirInfo() {
        System.out.printf("%s %s (%d) — %.0f km/h%n",
                           marca, modelo, ano, velocidade);
    }
}
```

```java
// Criando objetos (instâncias)
public class Main {
    public static void main(String[] args) {
        Carro carro1 = new Carro();
        carro1.marca = "Toyota";
        carro1.modelo = "Corolla";
        carro1.ano = 2024;

        carro1.exibirInfo();  // Toyota Corolla (2024) — 0 km/h
        carro1.acelerar(60);  // 🚀 60 km/h
        carro1.acelerar(40);  // 🚀 100 km/h
        carro1.frear(30);     // 🛑 70 km/h
    }
}
```

### 5.2 Atributos e Métodos

#### Modificadores de Acesso

| Modificador | Classe | Pacote | Subclasse | Mundo |
|-------------|--------|--------|-----------|-------|
| `public` | ✅ | ✅ | ✅ | ✅ |
| `protected` | ✅ | ✅ | ✅ | ❌ |
| *(default/package)* | ✅ | ✅ | ❌ | ❌ |
| `private` | ✅ | ❌ | ❌ | ❌ |

#### Métodos

```java
public class Calculadora {

    // Método de instância
    public int somar(int a, int b) {
        return a + b;
    }

    // Método estático (pertence à classe, não ao objeto)
    public static int multiplicar(int a, int b) {
        return a * b;
    }

    // Sobrecarga de métodos (mesmo nome, parâmetros diferentes)
    public double somar(double a, double b) {
        return a + b;
    }

    public double somar(double a, double b, double c) {
        return a + b + c;
    }
}
```

```java
// Uso
Calculadora calc = new Calculadora();
calc.somar(2, 3);            // 5 (instância)
Calculadora.multiplicar(4, 5); // 20 (estático)
calc.somar(1.5, 2.5);        // 4.0 (sobrecarga)
```

### 5.3 Construtores

```java
public class Pessoa {
    String nome;
    int idade;
    String email;

    // Construtor vazio
    public Pessoa() {
        this.nome = "Desconhecido";
        this.idade = 0;
    }

    // Construtor com parâmetros
    public Pessoa(String nome, int idade) {
        this.nome = nome;   // 'this' distingue atributo de parâmetro
        this.idade = idade;
    }

    // Construtor completo
    public Pessoa(String nome, int idade, String email) {
        this(nome, idade);  // Encadeia com outro construtor (this())
        this.email = email;
    }
}
```

```java
Pessoa p1 = new Pessoa();
Pessoa p2 = new Pessoa("Ana", 25);
Pessoa p3 = new Pessoa("Bruno", 30, "bruno@email.com");
```

### 5.4 Encapsulamento

Oculta os detalhes internos e expõe apenas o necessário via **getters/setters**.

```java
public class ContaBancaria {
    private String titular;
    private double saldo;

    public ContaBancaria(String titular, double saldoInicial) {
        this.titular = titular;
        this.saldo = saldoInicial;
    }

    // Getter
    public String getTitular() {
        return titular;
    }

    // Getter com lógica
    public double getSaldo() {
        return saldo;
    }

    // Setter com validação
    public void setSaldo(double saldo) {
        if (saldo < 0) {
            throw new IllegalArgumentException("Saldo não pode ser negativo");
        }
        this.saldo = saldo;
    }

    // Método que usa o encapsulamento
    public boolean sacar(double valor) {
        if (valor <= 0) {
            System.out.println("❌ Valor inválido");
            return false;
        }
        if (valor > saldo) {
            System.out.println("❌ Saldo insuficiente");
            return false;
        }
        saldo -= valor;
        System.out.printf("💰 Saque de R$ %.2f realizado%n", valor);
        return true;
    }

    public void depositar(double valor) {
        if (valor <= 0) {
            System.out.println("❌ Valor inválido");
            return;
        }
        saldo += valor;
        System.out.printf("💰 Depósito de R$ %.2f realizado%n", valor);
    }

    @Override
    public String toString() {
        return String.format("Conta de %s — Saldo: R$ %.2f", titular, saldo);
    }
}
```

> 💡 **Dica:** Use `private` em todos os atributos e exponha via métodos públicos. Isso permite validar dados e manter invariantes.

### 5.5 Herança

```java
// Classe pai
public class Animal {
    String nome;
    int idade;

    public Animal(String nome, int idade) {
        this.nome = nome;
        this.idade = idade;
    }

    public void dormir() {
        System.out.println("💤 " + nome + " está dormindo...");
    }

    public void emitirSom() {
        System.out.println("🔊 " + nome + " faz um som genérico");
    }

    @Override
    public String toString() {
        return nome + " (" + idade + " anos)";
    }
}
```

```java
// Classe filha
public class Cachorro extends Animal {
    String raca;

    public Cachorro(String nome, int idade, String raca) {
        super(nome, idade); // Chama o construtor da classe pai
        this.raca = raca;
    }

    // Sobrescrita de método (override)
    @Override
    public void emitirSom() {
        System.out.println("🐕 " + nome + " diz: Au au!");
    }

    // Método exclusivo da subclasse
    public void buscar() {
        System.out.println("🎾 " + nome + " foi buscar a bolinha!");
    }
}
```

```java
Cachorro rex = new Cachorro("Rex", 3, "Labrador");
rex.dormir();       // 💤 Rex está dormindo... (herdado)
rex.emitirSom();    // 🐕 Rex diz: Au au! (sobrescrito)
rex.buscar();       // 🎾 Rex foi buscar a bolinha! (exclusivo)
```

#### Regras da Herança

- Java suporta **herança simples** (uma classe pai apenas)
- `extends` — herda atributos e métodos
- `super()` — chama o construtor do pai
- `super.metodo()` — chama método do pai
- Toda classe estende `Object` implicitamente

### 5.6 Polimorfismo

```java
public class Animal {
    public void emitirSom() {
        System.out.println("Som genérico");
    }
}

public class Cachorro extends Animal {
    @Override
    public void emitirSom() {
        System.out.println("Au au!");
    }
}

public class Gato extends Animal {
    @Override
    public void emitirSom() {
        System.out.println("Miau!");
    }
}

public class Passaro extends Animal {
    @Override
    public void emitirSom() {
        System.out.println("Piu piu!");
    }
}
```

```java
// Polimorfismo: tipo referência = Animal, tipo objeto = subclasse
Animal[] animais = {
    new Cachorro(),
    new Gato(),
    new Passaro()
};

for (Animal animal : animais) {
    animal.emitirSom(); // Cada animal emite seu som específico
}
// Au au!
// Miau!
// Piu piu!
```

#### Exemplo Prático — Sistema de Pagamentos

```java
public class Pagamento {
    public void processar(double valor) {
        System.out.printf("Processando pagamento genérico: R$ %.2f%n", valor);
    }
}

public class PagamentoCredito extends Pagamento {
    @Override
    public void processar(double valor) {
        double taxa = valor * 0.02; // 2% de taxa
        System.out.printf("💳 Crédito: R$ %.2f + R$ %.2f taxa = R$ %.2f%n",
                           valor, taxa, valor + taxa);
    }
}

public class PagamentoPix extends Pagamento {
    @Override
    public void processar(double valor) {
        System.out.printf("📱 PIX: R$ %.2f (sem taxa)%n", valor);
    }
}

public class PagamentoBoleto extends Pagamento {
    @Override
    public void processar(double valor) {
        double desconto = valor * 0.05; // 5% de desconto
        System.out.printf("📄 Boleto: R$ %.2f - R$ %.2f desconto = R$ %.2f%n",
                           valor, desconto, valor - desconto);
    }
}
```

```java
// Código cliente — não precisa saber o tipo específico
public static void efetuarPagamento(Pagamento pagamento, double valor) {
    pagamento.processar(valor); // Polimorfismo em ação
}

// Uso
Pagamento pagamento = obterTipoPagamento(); // Pode retornar qualquer subtipo
efetuarPagamento(pagamento, 100.00);
```

### 5.7 Classes Abstratas

Não podem ser instanciadas — servem como modelo para subclasses.

```java
public abstract class FormaGeometrica {
    String nome;

    public FormaGeometrica(String nome) {
        this.nome = nome;
    }

    // Método abstrato — OBRIGATÓRIO ser implementado pelas subclasses
    public abstract double calcularArea();

    public abstract double calcularPerimetro();

    // Método concreto — pode ser herdado diretamente
    public void exibirInfo() {
        System.out.printf("📐 %s — Área: %.2f | Perímetro: %.2f%n",
                           nome, calcularArea(), calcularPerimetro());
    }
}
```

```java
public class Circulo extends FormaGeometrica {
    private double raio;

    public Circulo(double raio) {
        super("Círculo");
        this.raio = raio;
    }

    @Override
    public double calcularArea() {
        return Math.PI * raio * raio;
    }

    @Override
    public double calcularPerimetro() {
        return 2 * Math.PI * raio;
    }
}

public class Retangulo extends FormaGeometrica {
    private double largura;
    private double altura;

    public Retangulo(double largura, double altura) {
        super("Retângulo");
        this.largura = largura;
        this.altura = altura;
    }

    @Override
    public double calcularArea() {
        return largura * altura;
    }

    @Override
    public double calcularPerimetro() {
        return 2 * (largura + altura);
    }
}
```

```java
// FormaGeometrica forma = new FormaGeometrica("Teste"); // ❌ ERRO!

FormaGeometrica[] formas = {
    new Circulo(5),
    new Retangulo(4, 6)
};

for (FormaGeometrica f : formas) {
    f.exibirInfo();
}
// 📐 Círculo — Área: 78.54 | Perímetro: 31.42
// 📐 Retângulo — Área: 24.00 | Perímetro: 20.00
```

### 5.8 Interfaces

Contrato que define o que uma classe **deve fazer** (não como).

```java
public interface Transportavel {
    // Constante (implícita: public static final)
    double PESO_MAXIMO = 50.0;

    // Métodos abstratos (implícita: public abstract)
    double obterPeso();
    String obterDestino();

    // Método default (Java 8+) — tem implementação padrão
    default boolean podeSerTransportado() {
        return obterPeso() <= PESO_MAXIMO;
    }

    // Método estático (Java 8+)
    static boolean validarPeso(double peso) {
        return peso > 0 && peso <= PESO_MAXIMO;
    }
}
```

```java
public class Pacote implements Transportavel {
    private String descricao;
    private double peso;
    private String destino;

    public Pacote(String descricao, double peso, String destino) {
        this.descricao = descricao;
        this.peso = peso;
        this.destino = destino;
    }

    @Override
    public double obterPeso() {
        return peso;
    }

    @Override
    public String obterDestino() {
        return destino;
    }

    @Override
    public String toString() {
        return String.format("📦 %s (%.1f kg) → %s [Transportável: %s]",
                descricao, peso, destino, podeSerTransportado() ? "Sim" : "Não");
    }
}
```

```java
Pacote p1 = new Pacote("Notebook", 2.5, "São Paulo");
Pacote p2 = new Pacote("Máquina de lavar", 55.0, "Rio de Janeiro");

System.out.println(p1); // 📦 Notebook (2.5 kg) → São Paulo [Transportável: Sim]
System.out.println(p2); // 📦 Máquina de lavar (55.0 kg) → Rio de Janeiro [Transportável: False]
```

#### Interface vs Classe Abstrata

| Aspecto | Interface | Classe Abstrata |
|---------|-----------|-----------------|
| Herança múltipla | ✅ Uma classe implementa várias | ❌ Uma classe estende uma |
| Construtores | ❌ | ✅ |
| Atributos | Apenas constantes | Variáveis de instância |
| Métodos | Abstratos + default + static | Abstratos + concretos |
| Quando usar | Contrato de comportamento | Modelo comum compartilhado |

#### Múltiplas Interfaces (Java 8+)

```java
public interface Limpavel {
    void limpar();
}

public interface Programavel {
    void executarPrograma(String nome);
}

public class Robo implements Limpavel, Programavel {
    @Override
    public void limpar() {
        System.out.println("🧹 Robô limpando...");
    }

    @Override
    public void executarPrograma(String nome) {
        System.out.println("🤖 Executando: " + nome);
    }
}
```

---

## 6. Tratamento de Exceções

### 6.1 Try-Catch-Finally

```java
public class TratamentoExcecoes {
    public static void main(String[] args) {
        try {
            int resultado = 10 / 0;
            System.out.println("Resultado: " + resultado); // Nunca executa
        } catch (ArithmeticException e) {
            System.err.println("❌ Erro aritmético: " + e.getMessage());
        } finally {
            System.out.println("✅ Bloco finally — SEMPRE executa");
        }
    }
}
```

#### Múltiplos Catch

```java
try {
    int[] numeros = {1, 2, 3};
    System.out.println(numeros[5]);        // ArrayIndexOutOfBoundsException
    System.out.println(Integer.parseInt("abc")); // NumberFormatException
} catch (ArrayIndexOutOfBoundsException e) {
    System.err.println("Índice inválido: " + e.getMessage());
} catch (NumberFormatException e) {
    System.err.println("Formato inválido: " + e.getMessage());
} catch (Exception e) {
    // Captura qualquer outra exceção (genérica)
    System.err.println("Erro inesperado: " + e.getMessage());
}
```

> 💡 Capture exceções específicas primeiro. `Exception` geral deve ser o último catch.

### 6.2 Exceções Checked vs Unchecked

| Tipo | Compile-time? | Exemplo | Devo tratar? |
|------|---------------|---------|--------------|
| **Checked** | Sim | `IOException`, `SQLException` | Obrigatório try-catch ou throws |
| **Unchecked** | Não | `NullPointerException`, `ArrayIndexOutOfBounds` | Recomendado |

```java
// Checked — OBRIGATÓRIO tratar
public void lerArquivo(String caminho) throws IOException {  // throws na assinatura
    BufferedReader reader = new BufferedReader(new FileReader(caminho));
    String linha;
    while ((linha = reader.readLine()) != null) {
        System.out.println(linha);
    }
    reader.close();
}

// OU tratar com try-catch
public void lerArquivo(String caminho) {
    try (BufferedReader reader = new BufferedReader(new FileReader(caminho))) {
        String linha;
        while ((linha = reader.readLine()) != null) {
            System.out.println(linha);
        }
    } catch (IOException e) {
        System.err.println("Erro ao ler arquivo: " + e.getMessage());
    }
}
```

### 6.3 Exceções Customizadas

```java
// Exceção customizada
public class SaldoInsuficienteException extends Exception {
    private double saldo;
    private double valorSaque;

    public SaldoInsuficienteException(double saldo, double valorSaque) {
        super(String.format("Saldo insuficiente: R$ %.2f. Tentativa de saque: R$ %.2f",
                             saldo, valorSaque));
        this.saldo = saldo;
        this.valorSaque = valorSaque;
    }

    public double getSaldo() { return saldo; }
    public double getValorSaque() { return valorSaque; }
    public double getValorFaltante() { return valorSaque - saldo; }
}
```

```java
public class ContaBancaria {
    private double saldo;

    public ContaBancaria(double saldoInicial) {
        this.saldo = saldoInicial;
    }

    public void sacar(double valor) throws SaldoInsuficienteException {
        if (valor > saldo) {
            throw new SaldoInsuficienteException(saldo, valor);
        }
        saldo -= valor;
        System.out.printf("✅ Saque de R$ %.2f realizado. Saldo: R$ %.2f%n",
                           valor, saldo);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        ContaBancaria conta = new ContaBancaria(500);

        try {
            conta.sacar(300);  // ✅ Saque de R$ 300,00 realizado. Saldo: R$ 200,00
            conta.sacar(300);  // ❌ Lança SaldoInsuficienteException
        } catch (SaldoInsuficienteException e) {
            System.err.println("❌ " + e.getMessage());
            System.err.printf("💸 Faltam R$ %.2f%n", e.getValorFaltante());
        }
    }
}
```

### 6.4 Try-with-resources (Java 7+)

Fecha recursos automaticamente ao sair do bloco.

```java
// ANTES (Java 6 e anterior)
BufferedReader reader = null;
try {
    reader = new BufferedReader(new FileReader("arquivo.txt"));
    String linha = reader.readLine();
    System.out.println(linha);
} catch (IOException e) {
    e.printStackTrace();
} finally {
    if (reader != null) {
        try {
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

// DEPOIS (Java 7+) — Try-with-resources
try (BufferedReader reader = new BufferedReader(new FileReader("arquivo.txt"))) {
    String linha = reader.readLine();
    System.out.println(linha);
} catch (IOException e) {
    e.printStackTrace();
}
// reader é fechado automaticamente!
```

#### Múltiplos Recursos

```java
try (
    var input = new FileInputStream("entrada.txt");
    var output = new FileOutputStream("saida.txt");
    var buffer = new BufferedInputStream(input)
) {
    byte[] dados = buffer.readAllBytes();
    output.write(dados);
} catch (IOException e) {
    System.err.println("Erro de E/S: " + e.getMessage());
}
```

> 💡 Recursos devem implementar `AutoCloseable` para usar try-with-resources.

---

## 7. Enum e Records

### 7.1 Enums

Tipos de dados com conjunto fixo de constantes.

#### Enum Simples

```java
public enum DiaSemana {
    DOMINGO, SEGUNDA, TERCA, QUARTA, QUINTA, SEXTA, SABADO;

    public boolean isDiaUtil() {
        return this != DOMINGO && this != SABADO;
    }
}
```

```java
DiaSemana hoje = DiaSemana.QUARTA;
System.out.println(hoje);                      // QUARTA
System.out.println(hoje.isDiaUtil());          // true
System.out.println(hoje.ordinal());            // 3 (0-indexed)
System.out.println(DiaSemana.valueOf("SEGUNDA")); // SEGUNDA

// Iterando
for (DiaSemana dia : DiaSemana.values()) {
    System.out.printf("%s — Dia útil: %s%n", dia, dia.isDiaUtil());
}
```

#### Enum com Atributos e Construtor

```java
public enum Mes {
    JANEIRO(31, "Janeiro"),
    FEVEREIRO(28, "Fevereiro"),
    MARCO(31, "Março"),
    ABRIL(30, "Abril"),
    MAIO(31, "Maio"),
    JUNHO(30, "Junho"),
    JULHO(31, "Julho"),
    AGOSTO(31, "Agosto"),
    SETEMBRO(30, "Setembro"),
    OUTUBRO(31, "Outubro"),
    NOVEMBRO(30, "Novembro"),
    DEZEMBRO(31, "Dezembro");

    private final int dias;
    private final String nomeCompleto;

    // Construtor — privado por padrão
    Mes(int dias, String nomeCompleto) {
        this.dias = dias;
        this.nomeCompleto = nomeCompleto;
    }

    public int getDias() { return dias; }
    public String getNomeCompleto() { return nomeCompleto; }
}
```

```java
System.out.println(Mes.ABRIL.getDias());        // 30
System.out.println(Mes.ABRIL.getNomeCompleto()); // Abril
```

#### Enum com Implementação de Interface

```java
public interface Calculavel {
    double calcular(double valor);
}

public enum Operacao implements Calculavel {
    SOMA("+", (a, b) -> a + b),
    SUBTRACAO("-", (a, b) -> a - b),
    MULTIPLICACAO("*", (a, b) -> a * b),
    DIVISAO("/", (a, b) -> a / b);

    private final String simbolo;
    private final java.util.function.BiOperator<Double> calculo;

    Operacao(String simbolo, java.util.function.BiOperator<Double> calculo) {
        this.simbolo = simbolo;
        this.calculo = calculo;
    }

    @Override
    public double calcular(double... operandos) {
        return calculo.apply(operandos[0], operandos[1]);
    }

    public String getSimbolo() { return simbolo; }
}
```

```java
double a = 10, b = 5;
System.out.printf("%.0f + %.0f = %.0f%n", a, b, Operacao.SOMA.calcular(a, b)); // 15
System.out.printf("%.0f * %.0f = %.0f%n", a, b, Operacao.MULTIPLICACAO.calcular(a, b)); // 50
```

#### Enum com Constantes Enum

```java
public enum NivelSeguranca {
    BAIXO,
    MEDIO,
    ALTO,
    ULTRA;

    public static NivelSeguranca fromString(String nivel) {
        return switch (nivel.toUpperCase()) {
            case "BAIXO", "B" -> BAIXO;
            case "MEDIO", "M" -> MEDIO;
            case "ALTO", "A" -> ALTO;
            case "ULTRA", "U" -> ULTRA;
            default -> throw new IllegalArgumentException("Nível inválido: " + nivel);
        };
    }
}
```

### 7.2 Records (Java 16+)

Classes imutáveis para transportar dados. Reduz boilerplate drasticamente.

#### Antes (Java tradicional)

```java
public class Pessoa {
    private final String nome;
    private final int idade;
    private final String email;

    public Pessoa(String nome, int idade, String email) {
        this.nome = nome;
        this.idade = idade;
        this.email = email;
    }

    public String getNome() { return nome; }
    public int getIdade() { return idade; }
    public String getEmail() { return email; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Pessoa)) return false;
        Pessoa pessoa = (Pessoa) o;
        return idade == pessoa.idade &&
               Objects.equals(nome, pessoa.nome) &&
               Objects.equals(email, pessoa.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome, idade, email);
    }

    @Override
    public String toString() {
        return "Pessoa{nome='" + nome + "', idade=" + idade + ", email='" + email + "'}";
    }
}
```

#### Depois (Record — Java 16+)

```java
public record Pessoa(String nome, int idade, String email) {}
```

> Isso gera automaticamente: construtor, getters (`nome()`, `idade()`, `email()`), `equals()`, `hashCode()`, `toString()`.

#### Records com Validacao

```java
public record Pessoa(String nome, int idade, String email) {
    // Bloco de validação compacto
    {
        if (nome == null || nome.isBlank()) {
            throw new IllegalArgumentException("Nome não pode ser vazio");
        }
        if (idade < 0 || idade > 150) {
            throw new IllegalArgumentException("Idade inválida: " + idade);
        }
        if (email == null || !email.contains("@")) {
            throw new IllegalArgumentException("Email inválido: " + email);
        }
    }

    // Métodos adicionais
    public boolean isMaiorDeIdade() {
        return idade >= 18;
    }

    // Canonical constructor (pode ter lógica)
    // Pessoa {
    //     // validação...
    // }
}
```

```java
Pessoa p = new Pessoa("Ana", 25, "ana@email.com");
System.out.println(p.nome());      // Ana (getter)
System.out.println(p);             // Pessoa[nome=Ana, idade=25, email=ana@email.com]

Pessoa copia = p.withNome("Maria"); // Java 21+ — com method on records
```

#### Records como DTOs

```java
// Resposta de API
public record ApiResponse<T>(
    int statusCode,
    String message,
    T data,
    long timestamp
) {
    public static <T> ApiResponse<T> success(T data) {
        return new ApiResponse<>(200, "Sucesso", data, System.currentTimeMillis());
    }

    public static <T> ApiResponse<T> error(String message) {
        return new ApiResponse<>(500, message, null, System.currentTimeMillis());
    }
}

// Uso
record Usuario(String id, String nome, String email) {}

ApiResponse<Usuario> resposta = ApiResponse.success(
    new Usuario("1", "João", "joao@email.com")
);
System.out.println(resposta);
```

#### Records Aninhados

```java
public record Pedido(
    String id,
    Cliente cliente,
    List<ItemPedido> itens
) {
    public record Cliente(String nome, String cpf) {}
    public record ItemPedido(String produto, int quantidade, double precoUnitario) {
        public double subtotal() {
            return quantidade * precoUnitario;
        }
    }

    public double total() {
        return itens.stream()
                   .mapToDouble(ItemPedido::subtotal)
                   .sum();
    }
}
```

---

## 📚 Resumo Geral

### Visão do Caminho de Aprendizado

```
1. Sintaxe Básica ─── Variáveis, Operadores, I/O
         │
2. Estruturas de Controle ─── if/else, switch, loops
         │
3. Arrays e Strings ─── Dados em coleções simples
         │
4. POO ─── Classes, Herança, Polimorfismo, Interfaces
         │
5. Exceções ─── Tratamento robusto de erros
         │
6. Enums e Records ─── Tipos de dados avançados
         │
7. Próximos passos: Generics, Collections, Streams, Lambdas...
```

### Tabela de Melhores Práticas

| Prática | ✅ Fazer | ❌ Evitar |
|---------|---------|-----------|
| Comparação | `a.equals(b)` | `a == b` (Strings) |
| Constantes | `enum` ou `static final` | Magic numbers |
| Exceções | `try-with-resources` | `finally` com `close()` manual |
| Herança | Composição quando possível | Herança profunda |
| Nomes | `camelCase` variáveis, `PascalCase` classes | Nomes genéricos (`x`, `temp`) |
| Recursos | Fechar `Scanner`, `Connection` | Deixar aberto |
| Records | Para DTOs simples | Para classes com comportamento complexo |
| Enums | Para conjuntos fixos | Para listas dinâmicas |

### Exercícios para Praticar

#### Nível 1 — Básico
1. [ ] Calculadora simples com operações (+, -, *, /)
2. [ ] Conversor de temperatura (Celsius ↔ Fahrenheit)
3. [ ] Verificador de número par/ímpar e positivo/negativo
4. [ ] Tabuada de qualquer número

#### Nível 2 — Arrays e Strings
5. [ ] Inverter um array sem usar outro array
6. [ ] Verificar se uma String é palíndromo
7. [ ] Encontrar o segundo maior elemento de um array
8. [ ] Contar vogais e consoantes em uma String

#### Nível 3 — POO
9. [ ] Sistema de biblioteca (Livro, Emprestimo, Usuario)
10. [ ] Jogo de RPG simples (Personagem, Arma, Inventario)
11. [ ] Sistema bancário com polimorfismo (ContaPoupanca, ContaCorrente)
12. [ ] Calculadora com interface `Operavel`

#### Nível 4 — Avançado
13. [ ] Mini-framework de validação com Exceptions customizadas
14. [ ] Sistema de pedidos com Records como DTOs
15. [ ] Enum para estados de um pedido (Pendente → Processando → Entregue → Cancelado)

---

## 🔗 Referências

- [Docs oficiais Oracle](https://docs.oracle.com/en/java/)
- [Baeldung — Tutoriais Java](https://www.baeldung.com/)
- [Java Tutorial (Oracle)](https://docs.oracle.com/javase/tutorial/)
- [OpenJDK](https://openjdk.org/)
- [Adoptium (JDK gratuito)](https://adoptium.net/)

---

> **📝 Nota:** Este guia cobre os fundamentos até Java 21. Para tópicos avançados como **Generics**, **Collections Framework**, **Streams & Lambdas**, **Concurrency**, **Modules**, e **Reactive Programming**, consulte o guia intermediário/avançado.
