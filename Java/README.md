# ☕ Java Complete Knowledge Base

> **A mais completa e detalhada base de conhecimento de Java** - Do básico ao avançado, com frameworks, ferramentas e exemplos profissionais.

[![Java](https://img.shields.io/badge/Java-17+-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://dev.java/)
[![Spring Boot](https://img.shields.io/badge/Spring_Boot-3.0+-6DB33F?style=for-the-badge&logo=springboot&logoColor=white)](https://spring.io/projects/spring-boot)
[![Maven](https://img.shields.io/badge/Maven-3.9+-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)](https://maven.apache.org/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

---

## 📊 Visão Geral

Esta base de conhecimento cobre **TUDO** sobre Java, desde os fundamentos até tópicos avançados e frameworks modernos.

### 🎯 O que você vai aprender

| Área | Conteúdo | Nível |
|------|----------|-------|
| **Fundamentos** | Sintaxe, OOP, Collections, Generics | ⭐ Básico |
| **Java Avançado** | Streams, Concorrência, Reflection | ⭐⭐⭐ Avançado |
| **Frameworks** | Spring Boot, Hibernate, Jakarta EE | ⭐⭐ Intermediário |
| **Ferramentas** | Maven, Gradle, JUnit, Docker | ⭐⭐ Intermediário |
| **Arquitetura** | Microserviços, Cloud Native, Design Patterns | ⭐⭐⭐ Avançado |

---

## 🗂️ Estrutura do Repositório

```
Java/
├── README.md                          # Este arquivo
├── FUNDAMENTOS.md                     # Guia dos fundamentos
├── AVANCADO.md                        # Tópicos avançados
├── FRAMEWORKS.md                      # Frameworks populares
├── FERRAMENTAS.md                     # Ferramentas e ecossistema
├── EXEMPLOS.md                        # Exemplos práticos
├── CHEATSHEET.md                      # Referência rápida
│
├── fundamentos/                       # Detalhes dos fundamentos
│   ├── sintaxe.md
│   ├── poo.md
│   ├── collections.md
│   ├── generics.md
│   ├── lambdas.md
│   └── streams.md
│
├── avancado/                          # Tópicos avançados
│   ├── concorrencia.md
│   ├── reflection.md
│   ├── annotations.md
│   ├── jdbc.md
│   └── nio.md
│
├── frameworks/                        # Frameworks
│   ├── spring-boot.md
│   ├── spring-mvc.md
│   ├── spring-data.md
│   ├── spring-security.md
│   ├── hibernate.md
│   └── jakarta-ee.md
│
├── ferramentas/                       # Ferramentas
│   ├── maven.md
│   ├── gradle.md
│   ├── junit.md
│   ├── docker.md
│   └── ide.md
│
└── exemplos/                          # Exemplos práticos
    ├── backend/
    ├── web/
    ├── microservices/
    └── tests/
```

---

## 🚀 Início Rápido

### Pré-requisitos

```bash
# Verificar Java instalado
java -version

# Output esperado:
# openjdk version "17.0.x" 2026-xx-xx

# Verificar Maven
mvn -version

# Verificar Gradle
gradle --version
```

### Primeiro Projeto

```bash
# Criar projeto com Maven
mvn archetype:generate \
  -DgroupId=com.example \
  -DartifactId=my-app \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeVersion=1.4 \
  -DinteractiveMode=false

# Entrar no diretório
cd my-app

# Compilar e executar
mvn compile
mvn exec:java -Dexec.mainClass="com.example.App"
```

### Hello World

```java
// src/main/java/com/example/App.java
package com.example;

public class App {
    public static void main(String[] args) {
        System.out.println("Olá, Mundo!");
        
        // Java 17+ - Text Blocks
        String json = """
                {
                    "name": "Java",
                    "version": 17
                }
                """;
        System.out.println(json);
    }
}
```

---

## 📚 Guias de Estudo

### Para Iniciantes (40 horas)

1. **[Fundamentos](FUNDAMENTOS.md)** - 20 horas
   - Sintaxe básica
   - Tipos de dados
   - Estruturas de controle
   - Programação orientada a objetos

2. **[Exemplos Básicos](exemplos/)** - 10 horas
   - Hello World
   - Calculadora
   - Lista de tarefas

3. **[Ferramentas](FERRAMENTAS.md)** - 10 horas
   - IDE setup
   - Maven básico
   - Git para Java

### Para Intermediários (80 horas)

1. **[Java Avançado](AVANCADO.md)** - 30 horas
   - Collections avançado
   - Generics
   - Lambda e Streams
   - Concorrência

2. **[Frameworks](FRAMEWORKS.md)** - 30 horas
   - Spring Boot
   - Hibernate
   - JUnit 5

3. **[Exemplos Intermediários](exemplos/)** - 20 horas
   - API REST
   - CRUD com banco
   - Testes unitários

### Para Avançados (120+ horas)

1. **[Arquitetura](FRAMEWORKS.md#arquitetura)** - 40 horas
   - Microserviços
   - Design Patterns
   - Clean Architecture

2. **[Cloud Native](FRAMEWORKS.md#cloud-native)** - 40 horas
   - Docker + Kubernetes
   - CI/CD
   - Observabilidade

3. **[Exemplos Avançados](exemplos/)** - 40 horas
   - Sistema completo
   - Microserviços
       - Sistema completo
   - Microserviços
   - Deploy em produção

---

## 🎯 Habilidades por Nível

### Nível 1: Básico (0-6 meses)
- [ ] Sintaxe Java
- [ ] Tipos primitivos e wrappers
- [ ] Estruturas de controle (if, switch, loops)
- [ ] Arrays
- [ ] Programação Orientada a Objetos (classes, objetos, herança)
- [ ] Tratamento de exceções
- [ ] Leitura e escrita de arquivos

### Nível 2: Intermediário (6-18 meses)
- [ ] Collections Framework (List, Set, Map)
- [ ] Generics
- [ ] Lambda Expressions
- [ ] Streams API
- [ ] Optional
- [ ] Annotations
- [ ] JDBC
- [ ] Maven/Gradle
- [ ] JUnit 5

### Nível 3: Avançado (18-36 meses)
- [ ] Concorrência e Multithreading
- [ ] CompletableFuture
- [ ] Reflection
- [ ] Annotations customizadas
- [ ] Design Patterns
- [ ] Spring Framework
- [ ] Hibernate/JPA
- [ ] Microserviços
- [ ] Docker

### Nível 4: Expert (36+ meses)
- [ ] Arquitetura de software
- [ ] Cloud Native
- [ ] Kubernetes
- [ ] Observabilidade
- [ ] Performance Tuning
- [ ] Segurança
- [ ] Entregas contínuas

---

## 🔗 Recursos Recomendados

### Documentação Oficial
- [Java Documentation](https://docs.oracle.com/en/java/)
- [Spring Documentation](https://docs.spring.io/spring-framework/reference/)
- [Hibernate Documentation](https://hibernate.org/orm/documentation/)

### Cursos Online
- [Java Masterclass - Udemy](https://www.udemy.com/course/java-the-complete-java-developer-course/)
- [Spring Boot - Udemy](https://www.udemy.com/course/spring-boot-the-practical-guide/)
- [Java Concurrency - Pluralsight](https://www.pluralsight.com/courses/java-concurrency-fundamentals)

### Livros Recomendados
- "Effective Java" - Joshua Bloch
- "Java Concurrency in Practice" - Brian Goetz
- "Clean Code" - Robert C. Martin
- "Spring in Action" - Craig Walls

### Comunidades
- [Stack Overflow - Java](https://stackoverflow.com/questions/tagged/java)
- [Reddit - r/java](https://www.reddit.com/r/java/)
- [Java Community](https://community.oracle.com/java)

---

## 📈 Progresso do Estudo

### Semana 1-2: Fundamentos
- [x] Configurar ambiente
- [x] Aprender sintaxe básica
- [x] Entender OOP
- [x] Praticar com exercícios

### Semana 3-4: Collections e Generics
- [ ] Estudar List, Set, Map
- [ ] Entender Generics
- [ ] Praticar com exemplos

### Semana 5-8: Java Avançado
- [ ] Lambda Expressions
- [ ] Streams API
- [ ] Concorrência básica

### Semana 9-12: Frameworks
- [ ] Spring Boot básico
- [ ] Criar API REST
- [ ] Hibernate básico

### Semana 13-16: Projetos Práticos
- [ ] CRUD completo
- [ ] Sistema de autenticação
- [ ] Deploy em nuvem

---

## 🤝 Contribuição

Contribuições são bem-vindas! Veja [CONTRIBUTING.md](../CONTRIBUTING.md) para detalhes.

---

## 📞 Contato

- **GitHub**: [@passosnikolas5-coder](https://github.com/passosnikolas5-coder)
- **Repositório**: [opencode-skills-knowledge-base](https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base)

---

**Feito com ❤️ para a comunidade Java**

*Última atualização: Setembro 2026*