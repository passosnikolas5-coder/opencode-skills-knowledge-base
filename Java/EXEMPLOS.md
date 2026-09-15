# ☕ Java Profissional — Exemplos Completos e Funcionais

> **Guia definitivo** com 7 projetos práticos, arquiteturas modernas e código production-ready.

---

## 📋 Índice

| # | Projeto | Tecnologias |
|---|---------|-------------|
| 1 | [API REST Completa](#1-api-rest-completa-com-spring-boot) | Spring Boot, JPA, H2 |
| 2 | [Autenticação JWT](#2-sistema-de-autenticação-jwt) | Spring Security, JWT |
| 3 | [Microserviço com Spring Cloud](#3-microserviço-com-spring-cloud) | Eureka, Gateway, Circuit Breaker |
| 4 | [Consumer com Kafka](#4-consumer-com-kafka) | Apache Kafka, Spring Kafka |
| 5 | [Aplicação com Cache](#5-aplicação-com-cache-redis) | Redis, Spring Cache |
| 6 | [Testes Completos](#6-testes-completos) | JUnit 5, Mockito, TestContainers |
| 7 | [Docker e Deploy](#7-docker-e-deploy) | Docker, Kubernetes, GitHub Actions |

---

# 1. API REST Completa com Spring Boot

## 🏗️ Estrutura do Projeto

```
user-api/
├── src/
│   ├── main/
│   │   ├── java/com/example/userapi/
│   │   │   ├── UserApiApplication.java
│   │   │   ├── controller/
│   │   │   │   └── UserController.java
│   │   │   ├── service/
│   │   │   │   ├── UserService.java
│   │   │   │   └── UserServiceImpl.java
│   │   │   ├── repository/
│   │   │   │   └── UserRepository.java
│   │   │   ├── model/
│   │   │   │   ├── entity/
│   │   │   │   │   └── User.java
│   │   │   │   ├── dto/
│   │   │   │   │   ├── UserRequest.java
│   │   │   │   │   └── UserResponse.java
│   │   │   │   └── mapper/
│   │   │   │       └── UserMapper.java
│   │   │   ├── exception/
│   │   │   │   ├── ResourceNotFoundException.java
│   │   │   │   ├── BadRequestException.java
│   │   │   │   └── GlobalExceptionHandler.java
│   │   │   └── config/
│   │   │       └── SwaggerConfig.java
│   │   └── resources/
│   │       ├── application.yml
│   │       └── data.sql
│   └── test/
│       └── java/com/example/userapi/
│           ├── controller/
│           │   └── UserControllerTest.java
│           ├── service/
│           │   └── UserServiceTest.java
│           └── integration/
│               └── UserRepositoryTest.java
├── pom.xml
└── README.md
```

## 📦 pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.0</version>
        <relativePath/>
    </parent>

    <groupId>com.example</groupId>
    <artifactId>user-api</artifactId>
    <version>1.0.0</version>
    <name>user-api</name>
    <description>API REST completa de gestão de usuários</description>

    <properties>
        <java.version>17</java.version>
        <mapstruct.version>1.5.5.Final</mapstruct.version>
    </properties>

    <dependencies>
        <!-- Spring Boot Starters -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>

        <!-- Database -->
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>

        <!-- Mapping -->
        <dependency>
            <groupId>org.mapstruct</groupId>
            <artifactId>mapstruct</artifactId>
            <version>${mapstruct.version}</version>
        </dependency>

        <!-- Documentation -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
            <version>2.3.0</version>
        </dependency>

        <!-- DevTools -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>

        <!-- Test -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <annotationProcessorPaths>
                        <path>
                            <groupId>org.mapstruct</groupId>
                            <artifactId>mapstruct-processor</artifactId>
                            <version>${mapstruct.version}</version>
                        </path>
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                            <version>1.18.30</version>
                        </path>
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok-mapstruct-binding</artifactId>
                            <version>0.2.0</version>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

## ⚙️ application.yml

```yaml
spring:
  application:
    name: user-api

  # ===== H2 Database (Desenvolvimento) =====
  datasource:
    url: jdbc:h2:mem:userdb
    driver-class-name: org.h2.Driver
    username: sa
    password:

  # ===== PostgreSQL (Produção) =====
  # datasource:
  #   url: jdbc:postgresql://localhost:5432/userdb
  #   driver-class-name: org.postgresql.Driver
  #   username: postgres
  #   password: secret

  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        format_sql: true
        dialect: org.hibernate.dialect.H2Dialect

  h2:
    console:
      enabled: true
      path: /h2-console

  # ===== Jackson =====
  jackson:
    serialization:
      write-dates-as-timestamps: false
    default-property-inclusion: non_null

# ===== Server =====
server:
  port: 8080

# ===== Actuator =====
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics
  endpoint:
    health:
      show-details: when_authorized

# ===== Swagger / OpenAPI =====
springdoc:
  api-docs:
    path: /api-docs
  swagger-ui:
    path: /swagger-ui.html
    operations-sorter: method
```

## 🧱 Entidade — User.java

```java
package com.example.userapi.model.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Nome é obrigatório")
    @Size(min = 2, max = 100, message = "Nome deve ter entre 2 e 100 caracteres")
    @Column(nullable = false)
    private String name;

    @NotBlank(message = "Email é obrigatório")
    @Email(message = "Email deve ser válido")
    @Column(nullable = false, unique = true)
    private String email;

    @NotBlank(message = "Telefone é obrigatório")
    @Pattern(regexp = "^\\+?[1-9]\\d{1,14}$", message = "Formato de telefone inválido")
    @Column(nullable = false)
    private String phone;

    @Column(nullable = false)
    @Builder.Default
    private Boolean active = true;

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;
}
```

## 📤 DTO — UserRequest.java

```java
package com.example.userapi.model.dto;

import jakarta.validation.constraints.*;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserRequest {

    @NotBlank(message = "Nome é obrigatório")
    @Size(min = 2, max = 100, message = "Nome deve ter entre 2 e 100 caracteres")
    private String name;

    @NotBlank(message = "Email é obrigatório")
    @Email(message = "Email deve ser válido")
    private String email;

    @NotBlank(message = "Telefone é obrigatório")
    @Pattern(regexp = "^\\+?[1-9]\\d{1,14}$", message = "Formato de telefone inválido")
    private String phone;
}
```

## 📥 DTO — UserResponse.java

```java
package com.example.userapi.model.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserResponse {

    private Long id;
    private String name;
    private String email;
    private String phone;
    private Boolean active;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
```

## 🗺️ Mapper — UserMapper.java

```java
package com.example.userapi.model.mapper;

import com.example.userapi.model.dto.UserRequest;
import com.example.userapi.model.dto.UserResponse;
import com.example.userapi.model.entity.User;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring")
public interface UserMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "active", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    User toEntity(UserRequest request);

    UserResponse toResponse(User entity);

    List<UserResponse> toResponseList(List<User> entities);
}
```

## 📦 Repository — UserRepository.java

```java
package com.example.userapi.repository;

import com.example.userapi.model.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);

    boolean existsByEmail(String email);

    Page<User> findByActiveTrue(Pageable pageable);

    @Query("SELECT u FROM User u WHERE " +
           "LOWER(u.name) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(u.email) LIKE LOWER(CONCAT('%', :search, '%'))")
    Page<User> searchByTerm(@Param("search") String search, Pageable pageable);
}
```

## 🧠 Service — UserService.java (Interface)

```java
package com.example.userapi.service;

import com.example.userapi.model.dto.UserRequest;
import com.example.userapi.model.dto.UserResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface UserService {

    UserResponse create(UserRequest request);

    UserResponse findById(Long id);

    Page<UserResponse> findAll(Pageable pageable);

    UserResponse update(Long id, UserRequest request);

    void deactivate(Long id);

    void delete(Long id);

    Page<UserResponse> search(String term, Pageable pageable);
}
```

## 🧠 Service — UserServiceImpl.java

```java
package com.example.userapi.service;

import com.example.userapi.exception.BadRequestException;
import com.example.userapi.exception.ResourceNotFoundException;
import com.example.userapi.model.dto.UserRequest;
import com.example.userapi.model.dto.UserResponse;
import com.example.userapi.model.entity.User;
import com.example.userapi.model.mapper.UserMapper;
import com.example.userapi.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper;

    @Override
    public UserResponse create(UserRequest request) {
        log.info("Criando novo usuário: {}", request.getEmail());

        if (userRepository.existsByEmail(request.getEmail())) {
            throw new BadRequestException("Email já está em uso: " + request.getEmail());
        }

        User user = userMapper.toEntity(request);
        user.setActive(true);

        User savedUser = userRepository.save(user);
        log.info("Usuário criado com ID: {}", savedUser.getId());

        return userMapper.toResponse(savedUser);
    }

    @Override
    @Transactional(readOnly = true)
    public UserResponse findById(Long id) {
        log.info("Buscando usuário com ID: {}", id);

        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado com ID: " + id));

        return userMapper.toResponse(user);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<UserResponse> findAll(Pageable pageable) {
        log.info("Listando todos os usuários - Página: {}", pageable.getPageNumber());

        return userRepository.findByActiveTrue(pageable)
                .map(userMapper::toResponse);
    }

    @Override
    public UserResponse update(Long id, UserRequest request) {
        log.info("Atualizando usuário com ID: {}", id);

        User existingUser = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado com ID: " + id));

        if (!existingUser.getEmail().equals(request.getEmail())
                && userRepository.existsByEmail(request.getEmail())) {
            throw new BadRequestException("Email já está em uso: " + request.getEmail());
        }

        existingUser.setName(request.getName());
        existingUser.setEmail(request.getEmail());
        existingUser.setPhone(request.getPhone());

        User updatedUser = userRepository.save(existingUser);
        log.info("Usuário atualizado com sucesso: {}", id);

        return userMapper.toResponse(updatedUser);
    }

    @Override
    public void deactivate(Long id) {
        log.info("Desativando usuário com ID: {}", id);

        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado com ID: " + id));

        user.setActive(false);
        userRepository.save(user);

        log.info("Usuário desativado com sucesso: {}", id);
    }

    @Override
    public void delete(Long id) {
        log.info("Deletando usuário com ID: {}", id);

        if (!userRepository.existsById(id)) {
            throw new ResourceNotFoundException("Usuário não encontrado com ID: " + id);
        }

        userRepository.deleteById(id);
        log.info("Usuário deletado com sucesso: {}", id);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<UserResponse> search(String term, Pageable pageable) {
        log.info("Buscando usuários com termo: {}", term);

        return userRepository.searchByTerm(term, pageable)
                .map(userMapper::toResponse);
    }
}
```

## 🎮 Controller — UserController.java

```java
package com.example.userapi.controller;

import com.example.userapi.model.dto.UserRequest;
import com.example.userapi.model.dto.UserResponse;
import com.example.userapi.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
@Tag(name = "Usuários", description = "API de gestão de usuários")
public class UserController {

    private final UserService userService;

    @PostMapping
    @Operation(summary = "Criar novo usuário", responses = {
            @ApiResponse(responseCode = "201", description = "Usuário criado com sucesso"),
            @ApiResponse(responseCode = "400", description = "Dados inválidos")
    })
    public ResponseEntity<UserResponse> create(
            @Valid @RequestBody UserRequest request) {
        UserResponse response = userService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    @Operation(summary = "Buscar usuário por ID")
    public ResponseEntity<UserResponse> findById(
            @Parameter(description = "ID do usuário") @PathVariable Long id) {
        UserResponse response = userService.findById(id);
        return ResponseEntity.ok(response);
    }

    @GetMapping
    @Operation(summary = "Listar todos os usuários com paginação")
    public ResponseEntity<Page<UserResponse>> findAll(
            @PageableDefault(size = 10, sort = "name") Pageable pageable) {
        Page<UserResponse> page = userService.findAll(pageable);
        return ResponseEntity.ok(page);
    }

    @PutMapping("/{id}")
    @Operation(summary = "Atualizar usuário existente")
    public ResponseEntity<UserResponse> update(
            @PathVariable Long id,
            @Valid @RequestBody UserRequest request) {
        UserResponse response = userService.update(id, request);
        return ResponseEntity.ok(response);
    }

    @PatchMapping("/{id}/deactivate")
    @Operation(summary = "Desativar usuário (soft delete)")
    public ResponseEntity<Void> deactivate(@PathVariable Long id) {
        userService.deactivate(id);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Deletar usuário permanentemente")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        userService.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/search")
    @Operation(summary = "Buscar usuários por termo")
    public ResponseEntity<Page<UserResponse>> search(
            @RequestParam String term,
            @PageableDefault(size = 10) Pageable pageable) {
        Page<UserResponse> page = userService.search(term, pageable);
        return ResponseEntity.ok(page);
    }
}
```

## 🚨 Exceções

```java
// ResourceNotFoundException.java
package com.example.userapi.exception;

public class ResourceNotFoundException extends RuntimeException {

    public ResourceNotFoundException(String message) {
        super(message);
    }

    public ResourceNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}
```

```java
// BadRequestException.java
package com.example.userapi.exception;

public class BadRequestException extends RuntimeException {

    public BadRequestException(String message) {
        super(message);
    }
}
```

```java
// GlobalExceptionHandler.java
package com.example.userapi.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleNotFound(
            ResourceNotFoundException ex) {
        log.warn("Recurso não encontrado: {}", ex.getMessage());

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                "timestamp", LocalDateTime.now(),
                "status", 404,
                "error", "Not Found",
                "message", ex.getMessage()
        ));
    }

    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<Map<String, Object>> handleBadRequest(
            BadRequestException ex) {
        log.warn("Requisição inválida: {}", ex.getMessage());

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of(
                "timestamp", LocalDateTime.now(),
                "status", 400,
                "error", "Bad Request",
                "message", ex.getMessage()
        ));
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, Object>> handleValidation(
            MethodArgumentNotValidException ex) {

        Map<String, String> errors = new HashMap<>();

        ex.getBindingResult().getAllErrors().forEach(error -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of(
                "timestamp", LocalDateTime.now(),
                "status", 400,
                "error", "Validation Error",
                "details", errors
        ));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> handleGeneral(Exception ex) {
        log.error("Erro inesperado: ", ex);

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "timestamp", LocalDateTime.now(),
                "status", 500,
                "error", "Internal Server Error",
                "message", "Ocorreu um erro inesperado"
        ));
    }
}
```

## 🚀 Application Entry Point

```java
package com.example.userapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class UserApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(UserApiApplication.class, args);
    }
}
```

## 🧪 Testes

```java
// UserControllerTest.java
package com.example.userapi.controller;

import com.example.userapi.model.dto.UserRequest;
import com.example.userapi.model.dto.UserResponse;
import com.example.userapi.service.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.bean.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(UserController.class)
class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private UserService userService;

    private UserRequest validRequest;
    private UserResponse validResponse;

    @BeforeEach
    void setUp() {
        validRequest = UserRequest.builder()
                .name("João Silva")
                .email("joao@example.com")
                .phone("+5511999999999")
                .build();

        validResponse = UserResponse.builder()
                .id(1L)
                .name("João Silva")
                .email("joao@example.com")
                .phone("+5511999999999")
                .active(true)
                .build();
    }

    @Test
    void shouldCreateUserSuccessfully() throws Exception {
        when(userService.create(any(UserRequest.class))).thenReturn(validResponse);

        mockMvc.perform(post("/api/v1/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(validRequest)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.name").value("João Silva"))
                .andExpect(jsonPath("$.email").value("joao@example.com"));
    }

    @Test
    void shouldReturn400WhenNameIsBlank() throws Exception {
        UserRequest invalidRequest = UserRequest.builder()
                .name("")
                .email("joao@example.com")
                .phone("+5511999999999")
                .build();

        mockMvc.perform(post("/api/v1/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(invalidRequest)))
                .andExpect(status().isBadRequest());
    }

    @Test
    void shouldReturn400WhenEmailIsInvalid() throws Exception {
        UserRequest invalidRequest = UserRequest.builder()
                .name("João Silva")
                .email("invalid-email")
                .phone("+5511999999999")
                .build();

        mockMvc.perform(post("/api/v1/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(invalidRequest)))
                .andExpect(status().isBadRequest());
    }

    @Test
    void shouldFindUserById() throws Exception {
        when(userService.findById(1L)).thenReturn(validResponse);

        mockMvc.perform(get("/api/v1/users/{id}", 1L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.name").value("João Silva"));
    }

    @Test
    void shouldUpdateUserSuccessfully() throws Exception {
        UserRequest updateRequest = UserRequest.builder()
                .name("João Santos")
                .email("joao.santos@example.com")
                .phone("+5511888888888")
                .build();

        UserResponse updatedResponse = UserResponse.builder()
                .id(1L)
                .name("João Santos")
                .email("joao.santos@example.com")
                .phone("+5511888888888")
                .active(true)
                .build();

        when(userService.update(any(Long.class), any(UserRequest.class)))
                .thenReturn(updatedResponse);

        mockMvc.perform(put("/api/v1/users/{id}", 1L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(updateRequest)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value("João Santos"));
    }

    @Test
    void shouldDeactivateUser() throws Exception {
        mockMvc.perform(patch("/api/v1/users/{id}/deactivate", 1L))
                .andExpect(status().isNoContent());
    }

    @Test
    void shouldDeleteUser() throws Exception {
        mockMvc.perform(delete("/api/v1/users/{id}", 1L))
                .andExpect(status().isNoContent());
    }
}
```

```java
// UserServiceTest.java
package com.example.userapi.service;

import com.example.userapi.exception.BadRequestException;
import com.example.userapi.exception.ResourceNotFoundException;
import com.example.userapi.model.dto.UserRequest;
import com.example.userapi.model.dto.UserResponse;
import com.example.userapi.model.entity.User;
import com.example.userapi.model.mapper.UserMapper;
import com.example.userapi.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private UserMapper userMapper;

    @InjectMocks
    private UserServiceImpl userService;

    private User user;
    private UserRequest request;
    private UserResponse response;

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .name("João Silva")
                .email("joao@example.com")
                .phone("+5511999999999")
                .active(true)
                .build();

        request = UserRequest.builder()
                .name("João Silva")
                .email("joao@example.com")
                .phone("+5511999999999")
                .build();

        response = UserResponse.builder()
                .id(1L)
                .name("João Silva")
                .email("joao@example.com")
                .phone("+5511999999999")
                .active(true)
                .build();
    }

    @Test
    void shouldCreateUserSuccessfully() {
        when(userRepository.existsByEmail(any(String.class))).thenReturn(false);
        when(userMapper.toEntity(any(UserRequest.class))).thenReturn(user);
        when(userRepository.save(any(User.class))).thenReturn(user);
        when(userMapper.toResponse(any(User.class))).thenReturn(response);

        UserResponse result = userService.create(request);

        assertNotNull(result);
        assertEquals("João Silva", result.getName());
        assertEquals("joao@example.com", result.getEmail());
        verify(userRepository).save(any(User.class));
    }

    @Test
    void shouldThrowWhenEmailAlreadyExists() {
        when(userRepository.existsByEmail(any(String.class))).thenReturn(true);

        assertThrows(BadRequestException.class, () -> userService.create(request));
        verify(userRepository, never()).save(any(User.class));
    }

    @Test
    void shouldFindUserById() {
        when(userRepository.findById(any(Long.class))).thenReturn(Optional.of(user));
        when(userMapper.toResponse(any(User.class))).thenReturn(response);

        UserResponse result = userService.findById(1L);

        assertNotNull(result);
        assertEquals(1L, result.getId());
    }

    @Test
    void shouldThrowWhenUserNotFound() {
        when(userRepository.findById(any(Long.class))).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> userService.findById(1L));
    }

    @Test
    void shouldDeactivateUser() {
        when(userRepository.findById(any(Long.class))).thenReturn(Optional.of(user));
        when(userRepository.save(any(User.class))).thenReturn(user);

        assertDoesNotThrow(() -> userService.deactivate(1L));
        verify(userRepository).save(any(User.class));
    }

    @Test
    void shouldDeleteUser() {
        when(userRepository.existsById(any(Long.class))).thenReturn(true);

        assertDoesNotThrow(() -> userService.delete(1L));
        verify(userRepository).deleteById(any(Long.class));
    }

    @Test
    void shouldThrowWhenDeletingNonExistentUser() {
        when(userRepository.existsById(any(Long.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> userService.delete(1L));
    }
}
```

## ▶️ Como Rodar

```bash
# Clonar e entrar no diretório
cd user-api

# Executar
mvn spring-boot:run

# Acessar
# API:      http://localhost:8080/api/v1/users
# Swagger:  http://localhost:8080/swagger-ui.html
# H2:       http://localhost:8080/h2-console
```

## 📌 Dicas

| Dica | Descrição |
|------|-----------|
| ✅ Use DTOs | Nunca exponha entidades diretamente |
| ✅ Valide com `@Valid` | Validação automática no controller |
| ✅ Trate exceções globalmente | `@RestControllerAdvice` centraliza tratamentos |
| ✅ Use Pageable | Nunca retorne listas sem paginação |
| ✅ Adicione Swagger | Documentação automática da API |

---

# 2. Sistema de Autenticação JWT

## 🏗️ Estrutura do Projeto

```
auth-api/
├── src/main/java/com/example/auth/
│   ├── AuthApplication.java
│   ├── config/
│   │   ├── SecurityConfig.java
│   │   ├── JwtConfig.java
│   │   └── JwtAuthenticationFilter.java
│   ├── controller/
│   │   ├── AuthController.java
│   │   └── UserController.java
│   ├── dto/
│   │   ├── LoginRequest.java
│   │   ├── RegisterRequest.java
│   │   ├── AuthResponse.java
│   │   └── MessageResponse.java
│   ├── model/
│   │   ├── User.java
│   │   └── Role.java
│   ├── repository/
│   │   └── UserRepository.java
│   ├── service/
│   │   ├── AuthService.java
│   │   ├── UserService.java
│   │   └── JwtService.java
│   └── exception/
│       └── GlobalExceptionHandler.java
└── src/main/resources/
    └── application.yml
```

## ⚙️ application.yml

```yaml
spring:
  application:
    name: auth-api
  datasource:
    url: jdbc:h2:mem:authdb
    driver-class-name: org.h2.Driver
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true

server:
  port: 8081

# JWT Configuration
jwt:
  secret: mySecretKeyForJWTTokenGenerationThatIsLongEnough2024!
  expiration: 86400000  # 24 horas em milissegundos
  token-prefix: "Bearer "
  header: "Authorization"
```

## 🔑 Modelo de Roles

```java
// Role.java
package com.example.auth.model;

public enum Role {
    ROLE_USER,
    ROLE_MODERATOR,
    ROLE_ADMIN
}
```

## 👤 Entidade User

```java
// User.java
package com.example.auth.model;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.*;
import java.util.stream.Collectors;

@Entity
@Table(name = "users")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, unique = true)
    private String email;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "user_roles", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    @Builder.Default
    private Set<Role> roles = new HashSet<>();

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority(role.name()))
                .collect(Collectors.toList());
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
```

## 🎫 JWT Service

```java
// JwtService.java
package com.example.auth.service;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

@Service
@Slf4j
public class JwtService {

    @Value("${jwt.secret}")
    private String secretKey;

    @Value("${jwt.expiration}")
    private long jwtExpiration;

    /**
     * Extrair o username do token
     */
    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    /**
     * Extrair data de expiração
     */
    public Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    /**
     * Extrair claim genérica
     */
    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    /**
     * Gerar token para um UserDetails
     */
    public String generateToken(UserDetails userDetails) {
        return generateToken(new HashMap<>(), userDetails);
    }

    /**
     * Gerar token com claims extras
     */
    public String generateToken(Map<String, Object> extraClaims, UserDetails userDetails) {
        return Jwts.builder()
                .setClaims(extraClaims)
                .setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + jwtExpiration))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    /**
     * Validar token
     */
    public boolean isTokenValid(String token, UserDetails userDetails) {
        final String username = extractUsername(token);
        return (username.equals(userDetails.getUsername())) && !isTokenExpired(token);
    }

    /**
     * Verificar se token expirou
     */
    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    /**
     * Extrair todas as claims
     */
    private Claims extractAllClaims(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(getSigningKey())
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ExpiredJwtException e) {
            log.error("Token expirado: {}", e.getMessage());
            throw e;
        } catch (JwtException e) {
            log.error("Token inválido: {}", e.getMessage());
            throw e;
        }
    }

    /**
     * Chave de assinatura
     */
    private SecretKey getSigningKey() {
        byte[] keyBytes = java.util.Base64.getDecoder().decode(
                java.util.Base64.getEncoder().encodeToString(secretKey.getBytes()));
        return Keys.hmacShaKeyFor(keyBytes);
    }
}
```

## 🔐 Security Filter

```java
// JwtAuthenticationFilter.java
package com.example.auth.config;

import com.example.auth.service.JwtService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@RequiredArgsConstructor
@Slf4j
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final UserDetailsService userDetailsService;

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain) throws ServletException, IOException {

        // Extrair header JWT
        final String authHeader = request.getHeader("Authorization");

        if (!StringUtils.hasText(authHeader) || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        // Extrair token
        final String jwt = authHeader.substring(7);

        try {
            // Extrair username do token
            final String username = jwtService.extractUsername(jwt);

            // Se username existe e não está autenticado
            if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {

                UserDetails userDetails = userDetailsService.loadUserByUsername(username);

                // Validar token
                if (jwtService.isTokenValid(jwt, userDetails)) {

                    UsernamePasswordAuthenticationToken authToken =
                            new UsernamePasswordAuthenticationToken(
                                    userDetails,
                                    null,
                                    userDetails.getAuthorities()
                            );

                    authToken.setDetails(
                            new WebAuthenticationDetailsSource().buildDetails(request)
                    );

                    SecurityContextHolder.getContext().setAuthentication(authToken);
                    log.debug("Usuário autenticado: {}", username);
                }
            }
        } catch (Exception e) {
            log.error("Erro na autenticação JWT: {}", e.getMessage());
        }

        filterChain.doFilter(request, response);
    }
}
```

## ⚙️ Security Config

```java
// SecurityConfig.java
package com.example.auth.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtAuthenticationFilter jwtAuthFilter;
    private final UserDetailsService userDetailsService;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                // Endpoints públicos
                .requestMatchers("/api/v1/auth/**").permitAll()
                .requestMatchers("/h2-console/**").permitAll()
                .requestMatchers("/swagger-ui/**", "/api-docs/**").permitAll()

                // Admin apenas
                .requestMatchers(HttpMethod.DELETE, "/api/v1/users/**").hasRole("ADMIN")
                .requestMatchers(HttpMethod.PUT, "/api/v1/users/**").hasRole("ADMIN")

                // Qualquer autenticado
                .anyRequest().authenticated()
            )
            .headers(headers -> headers.frameOptions(frame -> frame.disable())) // H2
            .sessionManagement(session ->
                session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            )
            .authenticationProvider(authenticationProvider())
            .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(
            AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }
}
```

## 📝 DTOs de Auth

```java
// LoginRequest.java
package com.example.auth.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LoginRequest {

    @NotBlank(message = "Username é obrigatório")
    private String username;

    @NotBlank(message = "Password é obrigatório")
    private String password;
}
```

```java
// RegisterRequest.java
package com.example.auth.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RegisterRequest {

    @NotBlank(message = "Username é obrigatório")
    @Size(min = 3, max = 20, message = "Username deve ter entre 3 e 20 caracteres")
    private String username;

    @NotBlank(message = "Email é obrigatório")
    @Email(message = "Email deve ser válido")
    private String email;

    @NotBlank(message = "Password é obrigatório")
    @Size(min = 6, max = 40, message = "Password deve ter entre 6 e 40 caracteres")
    private String password;
}
```

```java
// AuthResponse.java
package com.example.auth.dto;

import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuthResponse {

    private String token;
    private String type = "Bearer";
    private Long id;
    private String username;
    private String email;
    private java.util.Set<String> roles;
}
```

## 🔧 Auth Service

```java
// AuthService.java
package com.example.auth.service;

import com.example.auth.dto.*;
import com.example.auth.model.Role;
import com.example.auth.model.User;
import com.example.auth.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class AuthService implements UserDetailsService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    /**
     * Login - Autenticar usuário e retornar JWT
     */
    public AuthResponse login(LoginRequest request) {
        log.info("Tentativa de login para: {}", request.getUsername());

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String token = jwtService.generateToken(userDetails);

        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("Usuário não encontrado"));

        return AuthResponse.builder()
                .token(token)
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .roles(user.getRoles().stream()
                        .map(Role::name)
                        .collect(Collectors.toSet()))
                .build();
    }

    /**
     * Register - Registrar novo usuário
     */
    public AuthResponse register(RegisterRequest request) {
        log.info("Registro de novo usuário: {}", request.getUsername());

        // Verificar se username já existe
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new RuntimeException("Username já está em uso");
        }

        // Verificar se email já existe
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email já está em uso");
        }

        // Criar usuário com role padrão
        User user = User.builder()
                .username(request.getUsername())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .roles(Set.of(Role.ROLE_USER))
                .build();

        User savedUser = userRepository.save(user);

        // Gerar token
        String token = jwtService.generateToken(savedUser);

        return AuthResponse.builder()
                .token(token)
                .id(savedUser.getId())
                .username(savedUser.getUsername())
                .email(savedUser.getEmail())
                .roles(savedUser.getRoles().stream()
                        .map(Role::name)
                        .collect(Collectors.toSet()))
                .build();
    }

    /**
     * UserDetailsService - Carregar usuário por username
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(
                        "Usuário não encontrado: " + username));
    }
}
```

## 🎮 Auth Controller

```java
// AuthController.java
package com.example.auth.controller;

import com.example.auth.dto.*;
import com.example.auth.service.AuthService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
@Tag(name = "Autenticação", description = "Login e Registro")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    @Operation(summary = "Login do usuário")
    public ResponseEntity<AuthResponse> login(
            @Valid @RequestBody LoginRequest request) {
        AuthResponse response = authService.login(request);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/register")
    @Operation(summary = "Registro de novo usuário")
    public ResponseEntity<AuthResponse> register(
            @Valid @RequestBody RegisterRequest request) {
        AuthResponse response = authService.register(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}
```

## ▶️ Como Rodar e Testar

```bash
# Iniciar
mvn spring-boot:run

# Registrar usuário
curl -X POST http://localhost:8081/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "email": "admin@example.com",
    "password": "123456"
  }'

# Login
curl -X POST http://localhost:8081/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "123456"
  }'

# Usar token em requisições autenticadas
curl http://localhost:8081/api/v1/users \
  -H "Authorization: Bearer <SEU_TOKEN_AQUI>"
```

## 📌 Dicas JWT

| Dica | Descrição |
|------|-----------|
| ✅ Chave secreta forte | Use pelo menos 256 bits |
| ✅ Tokens curtos | Expiração de 15min-24h |
| ✅ Nunca armazene JWT | Não salve em localStorage em produção |
| ✅ HTTPS sempre | JWT em plaintext = vulnerabilidade |
| ✅ Refresh tokens | Para sessões longas, use refresh tokens |

---

# 3. Microserviço com Spring Cloud

## 🏗️ Arquitetura

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   API Gateway   │────▶│   User Service  │     │  Order Service  │
│   (Port 8080)   │     │   (Port 8081)   │     │  (Port 8082)    │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
         │              ┌────────┴────────┐              │
         └─────────────▶│     Eureka      │◀─────────────┘
                        │  (Port 8761)    │
                        └─────────────────┘
```

## 📦 Estrutura Multi-Módulo

```
spring-cloud-demo/
├── eureka-server/
│   └── src/main/java/com/example/eureka/
│       └── EurekaServerApplication.java
├── api-gateway/
│   └── src/main/java/com/example/gateway/
│       ├── GatewayApplication.java
│       └── config/
│           └── RouteConfig.java
├── user-service/
│   └── src/main/java/com/example/user/
│       ├── UserServiceApplication.java
│       ├── controller/UserController.java
│       ├── service/UserService.java
│       └── model/User.java
├── order-service/
│   └── src/main/java/com/example/order/
│       ├── OrderServiceApplication.java
│       ├── controller/OrderController.java
│       ├── service/OrderService.java
│       └── client/UserClient.java
└── pom.xml (parent)
```

## 🌐 Eureka Server

```java
// EurekaServerApplication.java
package com.example.eureka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class EurekaServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(EurekaServerApplication.class, args);
    }
}
```

```yaml
# eureka-server/src/main/resources/application.yml
server:
  port: 8761

eureka:
  client:
    register-with-eureka: false
    fetch-registry: false
  server:
    wait-time-in-ms-when-sync-empty: 0

spring:
  application:
    name: eureka-server
```

## 🚪 API Gateway

```java
// GatewayApplication.java
package com.example.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class GatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
    }
}
```

```java
// config/RouteConfig.java
package com.example.gateway.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
public class RouteConfig {

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()

            // User Service Routes
            .route("users", r -> r
                .path("/api/v1/users/**")
                .filters(f -> f
                    .stripPrefix(0)
                    .addRequestHeader("X-Source", "gateway")
                    .retry(config -> config
                        .setRetries(3)
                        .setBackoff(java.time.Duration.ofMillis(100),
                                    java.time.Duration.ofMillis(1000),
                                    2, true)
                    )
                )
                .uri("lb://user-service")
            )

            // Order Service Routes
            .route("orders", r -> r
                .path("/api/v1/orders/**")
                .filters(f -> f
                    .stripPrefix(0)
                    .circuitBreaker(config -> config
                        .setName("orderService")
                        .setFallbackUri("forward:/fallback/orders")
                    )
                )
                .uri("lb://order-service")
            )

            // Auth Service Routes
            .route("auth", r -> r
                .path("/api/v1/auth/**")
                .filters(f -> f.stripPrefix(0))
                .uri("lb://auth-service")
            )

            .build();
    }

    @Bean
    public CorsWebFilter corsWebFilter() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOrigins(List.of("http://localhost:3000"));
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        config.setAllowedHeaders(List.of("*"));
        config.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source =
                new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);

        return new CorsWebFilter(source);
    }
}
```

```yaml
# api-gateway/src/main/resources/application.yml
server:
  port: 8080

spring:
  application:
    name: api-gateway
  cloud:
    gateway:
      discovery:
        locator:
          enabled: true
          lower-case-service-id: true
    loadbalancer:
      ribbon:
        enabled: true

eureka:
  client:
    service-url:
      defaultZone: http://localhost:8761/eureka/
  instance:
    prefer-ip-address: true

management:
  endpoints:
    web:
      exposure:
        include: health,gateway
  endpoint:
    gateway:
      enabled: true
```

## 🔌 User Client (Feign + Circuit Breaker)

```java
// client/UserClient.java
package com.example.order.client;

import com.example.order.dto.UserResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(
    name = "user-service",
    fallbackFactory = UserClientFallbackFactory.class
)
public interface UserClient {

    @GetMapping("/api/v1/users/{id}")
    UserResponse getUserById(@PathVariable("id") Long id);
}
```

```java
// client/UserClientFallbackFactory.java
package com.example.order.client;

import com.example.order.dto.UserResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class UserClientFallbackFactory implements FallbackFactory<UserClient> {

    @Override
    public UserClient create(Throwable cause) {
        log.error("Circuit breaker ativado para UserClient: {}", cause.getMessage());

        return new UserClient() {
            @Override
            public UserResponse getUserById(Long id) {
                log.warn("Fallback: retornando usuário mockado para ID {}", id);
                return UserResponse.builder()
                        .id(id)
                        .name("Usuário Indisponível")
                        .email("indisponivel@example.com")
                        .build();
            }
        };
    }
}
```

## ▶️ Como Rodar

```bash
# Terminal 1: Eureka Server
cd eureka-server && mvn spring-boot:run

# Terminal 2: User Service
cd user-service && mvn spring-boot:run

# Terminal 3: Order Service
cd order-service && mvn spring-boot:run

# Terminal 4: API Gateway
cd api-gateway && mvn spring-boot:run

# Acessar Eureka Dashboard
# http://localhost:8761

# Acessar via Gateway
# http://localhost:8080/api/v1/users/1
```

## 📌 Dicas Microserviços

| Dica | Descrição |
|------|-----------|
| ✅ Circuit Breaker | Use Resilience4j para tolerância a falhas |
| ✅ Retry com backoff | Não sobrecarregue serviços com retry imediato |
| ✅ Fallbacks | Sempre tenha um plano B nos clientes |
| ✅ Health Checks | Implemente actuator em todos os serviços |
| ✅ Log correlation | Use Request IDs para rastrear requisições |

---

# 4. Consumer com Kafka

## 🏗️ Estrutura

```
kafka-demo/
├── src/main/java/com/example/kafka/
│   ├── KafkaDemoApplication.java
│   ├── producer/
│   │   └── MessageProducer.java
│   ├── consumer/
│   │   └── MessageConsumer.java
│   ├── config/
│   │   ├── KafkaProducerConfig.java
│   │   ├── KafkaConsumerConfig.java
│   │   └── KafkaTopicConfig.java
│   └── model/
│       └── MessageEvent.java
└── src/main/resources/
    └── application.yml
```

## ⚙️ application.yml

```yaml
spring:
  application:
    name: kafka-demo
  kafka:
    bootstrap-servers: localhost:9092

    # ===== Producer Config =====
    producer:
      key-serializer: org.apache.kafka.common.serialization.StringSerializer
      value-serializer: org.springframework.kafka.support.serializer.JsonSerializer
      acks: all
      retries: 3
      properties:
        max.block.ms: 5000
        linger.ms: 20
        batch.size: 16384
        enable.idempotence: true

    # ===== Consumer Config =====
    consumer:
      group-id: my-consumer-group
      auto-offset-reset: earliest
      key-deserializer: org.apache.kafka.common.serialization.StringDeserializer
      value-deserializer: org.springframework.kafka.support.serializer.JsonDeserializer
      properties:
        spring.json.trusted.packages: "com.example.kafka.model"
        max.poll.records: 100
        session.timeout.ms: 30000
        heartbeat.interval.ms: 10000

    # ===== Listener Config =====
    listener:
      ack-mode: manual_immediate
      concurrency: 3
      type: batch

server:
  port: 8083
```

## 📨 Modelo de Evento

```java
// MessageEvent.java
package com.example.kafka.model;

import lombok.*;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MessageEvent {

    @Builder.Default
    private String id = UUID.randomUUID().toString();
    private String type;
    private String payload;
    private String source;
    @Builder.Default
    private LocalDateTime timestamp = LocalDateTime.now();
    private int retryCount;
}
```

## 📤 Producer

```java
// MessageProducer.java
package com.example.kafka.producer;

import com.example.kafka.model.MessageEvent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.SendResult;
import org.springframework.stereotype.Component;

import java.util.concurrent.CompletableFuture;

@Component
@RequiredArgsConstructor
@Slf4j
public class MessageProducer {

    private final KafkaTemplate<String, MessageEvent> kafkaTemplate;

    private static final String TOPIC = "user-events";

    /**
     * Enviar mensagem com callback
     */
    public void sendMessage(MessageEvent event) {
        log.info("Enviando mensagem para tópico {}: {}", TOPIC, event.getId());

        CompletableFuture<SendResult<String, MessageEvent>> future =
                kafkaTemplate.send(TOPIC, event.getId(), event);

        future.whenComplete((result, ex) -> {
            if (ex == null) {
                log.info("Mensagem enviada com sucesso - partition: {}, offset: {}",
                        result.getRecordMetadata().partition(),
                        result.getRecordMetadata().offset());
            } else {
                log.error("Falha ao enviar mensagem: {}", ex.getMessage());
            }
        });
    }

    /**
     * Enviar mensagem para tópico específico
     */
    public void sendToTopic(String topic, String key, MessageEvent event) {
        log.info("Enviando mensagem para tópico {} com key: {}", topic, key);

        kafkaTemplate.send(topic, key, event);
    }

    /**
     * Enviar mensagem com headers
     */
    public void sendMessageWithHeaders(MessageEvent event, String traceId) {
        var headers = new org.springframework.messaging.MessageHeaders(null);
        var message = org.springframework.messaging.support.MessageBuilder
                .withPayload(event)
                .setHeader("trace-id", traceId)
                .setHeader("source", "order-service")
                .build();

        kafkaTemplate.send(TOPIC, message);
        log.info("Mensagem enviada com trace-id: {}", traceId);
    }
}
```

## 📥 Consumer

```java
// MessageConsumer.java
package com.example.kafka.consumer;

import com.example.kafka.model.MessageEvent;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.annotation.RetryableTopic;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.retry.annotation.Backoff;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class MessageConsumer {

    /**
     * Consumer básico
     */
    @KafkaListener(
        topics = "user-events",
        groupId = "my-consumer-group",
        containerFactory = "kafkaListenerContainerFactory"
    )
    public void consume(
            ConsumerRecord<String, MessageEvent> record,
            Acknowledgment ack) {

        log.info("Mensagem recebida - partition: {}, offset: {}, key: {}",
                record.partition(), record.offset(), record.key());

        try {
            MessageEvent event = record.value();
            processEvent(event);
            ack.acknowledge();
            log.info("Mensagem processada com sucesso: {}", event.getId());

        } catch (Exception e) {
            log.error("Erro ao processar mensagem: {}", e.getMessage());
            // Não acknowledge - será reprocessado
        }
    }

    /**
     * Consumer com retry automático
     */
    @RetryableTopic(
        attempts = "3",
        backoff = @Backoff(delay = 1000, multiplier = 2.0),
        defaultTopic = "user-events-dlt"
    )
    @KafkaListener(topics = "user-events")
    public void consumeWithRetry(
            ConsumerRecord<String, MessageEvent> record,
            Acknowledgment ack) {

        MessageEvent event = record.value();

        if (event.getRetryCount() >= 3) {
            log.warn("Máximo de retries atingido para evento: {}", event.getId());
            // Enviar para dead letter topic
            return;
        }

        processEvent(event);
        ack.acknowledge();
    }

    /**
     * Consumer para dead letter topic
     */
    @KafkaListener(
        topics = "user-events-dlt",
        groupId = "dlt-handler"
    )
    public void handleDeadLetter(
            ConsumerRecord<String, MessageEvent> record) {

        log.error("DLT: Mensagem falhou permanentemente - key: {}, value: {}",
                record.key(), record.value());

        // Aqui você pode:
        // - Salvar em banco para análise
        // - Enviar alerta
        // - Notificar administrador
    }

    /**
     * Listener múltiplos tópicos
     */
    @KafkaListener(
        topics = {"user-events", "order-events", "payment-events"},
        groupId = "multi-topic-consumer"
    )
    public void consumeMultipleTopics(
            ConsumerRecord<String, MessageEvent> record,
            @Header(KafkaHeaders.RECEIVED_TOPIC) String topic) {

        log.info("Mensagem recebida do tópico {}: {}", topic, record.value().getType());
    }

    /**
     * Processar evento
     */
    private void processEvent(MessageEvent event) {
        log.info("Processando evento tipo: {}", event.getType());

        switch (event.getType()) {
            case "USER_CREATED":
                handleUserCreated(event);
                break;
            case "USER_UPDATED":
                handleUserUpdated(event);
                break;
            case "USER_DELETED":
                handleUserDeleted(event);
                break;
            default:
                log.warn("Tipo de evento desconhecido: {}", event.getType());
        }
    }

    private void handleUserCreated(MessageEvent event) {
        log.info("Usuário criado: {}", event.getPayload());
    }

    private void handleUserUpdated(MessageEvent event) {
        log.info("Usuário atualizado: {}", event.getPayload());
    }

    private void handleUserDeleted(MessageEvent event) {
        log.info("Usuário deletado: {}", event.getPayload());
    }
}
```

## 🔧 Configuração Kafka

```java
// config/KafkaTopicConfig.java
package com.example.kafka.config;

import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.config.TopicBuilder;

@Configuration
public class KafkaTopicConfig {

    @Bean
    public NewTopic userEventsTopic() {
        return TopicBuilder.name("user-events")
                .partitions(3)
                .replicas(1)
                .build();
    }

    @Bean
    public NewTopic deadLetterTopic() {
        return TopicBuilder.name("user-events-dlt")
                .partitions(1)
                .replicas(1)
                .build();
    }

    @Bean
    public NewTopic orderEventsTopic() {
        return TopicBuilder.name("order-events")
                .partitions(3)
                .replicas(1)
                .build();
    }
}
```

```java
// config/KafkaConsumerConfig.java
package com.example.kafka.config;

import com.example.kafka.model.MessageEvent;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.config.ConcurrentKafkaListenerContainerFactory;
import org.springframework.kafka.core.*;
import org.springframework.kafka.support.serializer.ErrorHandlingDeserializer;
import org.springframework.kafka.support.serializer.JsonDeserializer;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class KafkaConsumerConfig {

    @Value("${spring.kafka.bootstrap-servers}")
    private String bootstrapServers;

    @Bean
    public ConsumerFactory<String, MessageEvent> consumerFactory() {
        Map<String, Object> props = new HashMap<>();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        props.put(ConsumerConfig.GROUP_ID_CONFIG, "my-consumer-group");
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, false);

        // Error handling deserializer
        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG,
                ErrorHandlingDeserializer.class);
        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG,
                ErrorHandlingDeserializer.class);
        props.put(ErrorHandlingDeserializer.KEY_DESERIALIZER_CLASS,
                StringDeserializer.class);
        props.put(ErrorHandlingDeserializer.VALUE_DESERIALIZER_CLASS,
                JsonDeserializer.class);
        props.put(JsonDeserializer.TRUSTED_PACKAGES, "com.example.kafka.model");

        return new DefaultKafkaConsumerFactory<>(props);
    }

    @Bean
    public ConcurrentKafkaListenerContainerFactory<String, MessageEvent>
            kafkaListenerContainerFactory() {

        ConcurrentKafkaListenerContainerFactory<String, MessageEvent> factory =
                new ConcurrentKafkaListenerContainerFactory<>();

        factory.setConsumerFactory(consumerFactory());
        factory.setConcurrency(3);
        factory.getContainerProperties().setAckMode(
                org.springframework.kafka.listener.ContainerProperties.AckMode.MANUAL_IMMEDIATE
        );

        // Retry template
        factory.setRetryTemplate(new org.springframework.retry.support.RetryTemplate());

        return factory;
    }
}
```

## ▶️ Como Rodar

```bash
# Iniciar Kafka com Docker
docker run -d --name kafka \
  -p 9092:9092 \
  -e KAFKA_NODE_ID=1 \
  -e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092 \
  -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092 \
  -e KAFKA_CONTROLLER_QUORUM_VOTERS=1@localhost:9093 \
  -e KAFKA_PROCESS_ROLES=broker,controller \
  apache/kafka:latest

# Iniciar aplicação
mvn spring-boot:run

# Criar tópicos
kafka-topics --bootstrap-server localhost:9092 \
  --create --topic user-events --partitions 3

# Enviar mensagem de teste
kafka-console-producer --bootstrap-server localhost:9092 \
  --topic user-events

# Consumir mensagens
kafka-console-consumer --bootstrap-server localhost:9092 \
  --topic user-events --from-beginning
```

## 📌 Dicas Kafka

| Dica | Descrição |
|------|-----------|
| ✅ ACK manual | Controle quando confirmar processamento |
| ✅ Dead Letter Topics | Mensagens que falharam precisam de tratamento |
| ✅ Idempotência | Processe mensagens mais de uma vez sem efeito colateral |
| ✅ Partitions | Particione por chave para ordenação |
| ✅ Monitoring | Use Kafka Lag Exporter para monitorar atrasos |

---

# 5. Aplicação com Cache Redis

## 🏗️ Estrutura

```
cache-demo/
├── src/main/java/com/example/cache/
│   ├── CacheDemoApplication.java
│   ├── config/
│   │   └── RedisConfig.java
│   ├── controller/
│   │   └── ProductController.java
│   ├── service/
│   │   └── ProductService.java
│   ├── model/
│   │   └── Product.java
│   └── repository/
│       └── ProductRepository.java
└── src/main/resources/
    └── application.yml
```

## ⚙️ application.yml

```yaml
spring:
  application:
    name: cache-demo

  # ===== Redis =====
  data:
    redis:
      host: localhost
      port: 6379
      timeout: 5000ms
      lettuce:
        pool:
          max-active: 16
          max-idle: 8
          min-idle: 2
          max-wait: 5000ms

  # ===== H2 (fallback) =====
  datasource:
    url: jdbc:h2:mem:cachedb
    driver-class-name: org.h2.Driver
  jpa:
    hibernate:
      ddl-auto: update

# ===== Cache Config =====
spring.cache:
  type: redis
  redis:
    time-to-live: 600000  # 10 minutos
    cache-null-values: false
    key-prefix: "myapp:"
    use-key-prefix: true

# ===== Cache Names =====
# Definidos via anotações @CacheConfig

server:
  port: 8084
```

## 🔴 Redis Config

```java
// config/RedisConfig.java
package com.example.cache.config;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.jsontype.impl.LaissezFaireSubTypeValidator;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableCaching
public class RedisConfig {

    /**
     * Configurar Redis Template com serialização JSON
     */
    @Bean
    public RedisTemplate<String, Object> redisTemplate(
            RedisConnectionFactory connectionFactory) {

        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);

        // Serializador JSON
        ObjectMapper mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
        mapper.activateDefaultTyping(
                LaissezFaireSubTypeValidator.instance,
                ObjectMapper.DefaultTyping.NON_FINAL
        );
        mapper.registerModule(new JavaTimeModule());

        GenericJackson2JsonRedisSerializer jsonSerializer =
                new GenericJackson2JsonRedisSerializer(mapper);

        // Serializadores
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(jsonSerializer);
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(jsonSerializer);
        template.afterPropertiesSet();

        return template;
    }

    /**
     * Configurar Cache Manager com TTLs diferentes por cache
     */
    @Bean
    public CacheManager cacheManager(RedisConnectionFactory connectionFactory) {

        ObjectMapper mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
        mapper.activateDefaultTyping(
                LaissezFaireSubTypeValidator.instance,
                ObjectMapper.DefaultTyping.NON_FINAL
        );
        mapper.registerModule(new JavaTimeModule());

        GenericJackson2JsonRedisSerializer jsonSerializer =
                new GenericJackson2JsonRedisSerializer(mapper);

        // TTLs diferentes por cache
        Map<String, RedisCacheConfiguration> cacheConfigs = new HashMap<>();

        // Cache de produtos: 5 minutos
        cacheConfigs.put("products",
                createCacheConfig(Duration.ofMinutes(5)));

        // Cache de categorias: 30 minutos (muda pouco)
        cacheConfigs.put("categories",
                createCacheConfig(Duration.ofMinutes(30)));

        // Cache de busca: 2 minutos (dados mais voláteis)
        cacheConfigs.put("search",
                createCacheConfig(Duration.ofMinutes(2)));

        // Cache de estatísticas: 1 hora
        cacheConfigs.put("stats",
                createCacheConfig(Duration.ofHours(1)));

        RedisCacheConfiguration defaultConfig =
                RedisCacheConfiguration.defaultCacheConfig()
                        .serializeValuesWith(
                                RedisSerializationContext.SerializationPair
                                        .fromSerializer(jsonSerializer)
                        )
                        .serializeKeysWith(
                                RedisSerializationContext.SerializationPair
                                        .fromSerializer(new StringRedisSerializer())
                        )
                        .entryTtl(Duration.ofMinutes(10));

        return RedisCacheManager.builder(connectionFactory)
                .cacheDefaults(defaultConfig)
                .withInitialCacheConfigurations(cacheConfigs)
                .transactionAware()
                .build();
    }

    /**
     * Criar configuração de cache com TTL
     */
    private RedisCacheConfiguration createCacheConfig(Duration ttl) {
        return RedisCacheConfiguration.defaultCacheConfig()
                .entryTtl(ttl)
                .disableCachingNullValues();
    }
}
```

## 📦 Modelo

```java
// Product.java
package com.example.cache.model;

import jakarta.persistence.*;
import lombok.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "products")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String description;

    @Column(nullable = false)
    private BigDecimal price;

    @Column(nullable = false)
    private String category;

    @Column(nullable = false)
    @Builder.Default
    private Integer stock = 0;

    @Column(nullable = false)
    @Builder.Default
    private Boolean active = true;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
```

## 🧠 Service com Cache

```java
// ProductService.java
package com.example.cache.service;

import com.example.cache.model.Product;
import com.example.cache.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
@CacheConfig(cacheNames = "products")
public class ProductService {

    private final ProductRepository productRepository;

    /**
     * Criar produto - invalida cache de listagem
     */
    @Transactional
    @CacheEvict(allEntries = true, beforeInvocation = false)
    public Product create(Product product) {
        log.info("Criando produto: {}", product.getName());
        return productRepository.save(product);
    }

    /**
     * Buscar produto por ID - cache individual
     */
    @Transactional(readOnly = true)
    @Cacheable(key = "#id", unless = "#result == null")
    public Product findById(Long id) {
        log.info("Buscando produto no banco - ID: {}", id);
        return productRepository.findById(id).orElse(null);
    }

    /**
     * Listar todos - cache da lista
     */
    @Transactional(readOnly = true)
    @Cacheable(key = "'all:' + #pageable.pageNumber + ':' + #pageable.pageSize")
    public Page<Product> findAll(Pageable pageable) {
        log.info("Buscando todos os produtos no banco");
        return productRepository.findByActiveTrue(pageable);
    }

    /**
     * Buscar por categoria
     */
    @Transactional(readOnly = true)
    @Cacheable(key = "'category:' + #category")
    public List<Product> findByCategory(String category) {
        log.info("Buscando produtos por categoria: {}", category);
        return productRepository.findByCategoryAndActiveTrue(category);
    }

    /**
     * Buscar por termo
     */
    @Transactional(readOnly = true)
    @Cacheable(value = "search", key = "#term")
    public List<Product> search(String term) {
        log.info("Buscando produtos com termo: {}", term);
        return productRepository.searchByName(term);
    }

    /**
     * Atualizar produto - invalida caches relacionados
     */
    @Transactional
    @Caching(
        evict = {
            @CacheEvict(key = "#id"),
            @CacheEvict(allEntries = true),
            @CacheEvict(value = "search", allEntries = true),
            @CacheEvict(value = "categories", allEntries = true)
        }
    )
    public Product update(Long id, Product updatedProduct) {
        log.info("Atualizando produto - ID: {}", id);

        Product existing = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Produto não encontrado"));

        existing.setName(updatedProduct.getName());
        existing.setDescription(updatedProduct.getDescription());
        existing.setPrice(updatedProduct.getPrice());
        existing.setCategory(updatedProduct.getCategory());
        existing.setStock(updatedProduct.getStock());

        return productRepository.save(existing);
    }

    /**
     * Deletar produto
     */
    @Transactional
    @Caching(
        evict = {
            @CacheEvict(key = "#id"),
            @CacheEvict(allEntries = true),
            @CacheEvict(value = "search", allEntries = true),
            @CacheEvict(value = "categories", allEntries = true)
        }
    )
    public void delete(Long id) {
        log.info("Deletando produto - ID: {}", id);
        productRepository.deleteById(id);
    }

    /**
     * Buscar estatísticas (cache longo)
     */
    @Cacheable(value = "stats", key = "'product_count'")
    @Transactional(readOnly = true)
    public long countActiveProducts() {
        log.info("Calculando estatísticas (operação custosa)");
        return productRepository.countByActiveTrue();
    }

    /**
     * Limpar todo o cache manualmente
     */
    @CacheEvict(allEntries = true)
    public void clearCache() {
        log.info("Cache limpo manualmente");
    }
}
```

## 🎮 Controller

```java
// ProductController.java
package com.example.cache.controller;

import com.example.cache.model.Product;
import com.example.cache.service.ProductService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @PostMapping
    public ResponseEntity<Product> create(@RequestBody Product product) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(productService.create(product));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Product> findById(@PathVariable Long id) {
        return ResponseEntity.ok(productService.findById(id));
    }

    @GetMapping
    public ResponseEntity<Page<Product>> findAll(Pageable pageable) {
        return ResponseEntity.ok(productService.findAll(pageable));
    }

    @GetMapping("/category/{category}")
    public ResponseEntity<List<Product>> findByCategory(
            @PathVariable String category) {
        return ResponseEntity.ok(productService.findByCategory(category));
    }

    @GetMapping("/search")
    public ResponseEntity<List<Product>> search(@RequestParam String term) {
        return ResponseEntity.ok(productService.search(term));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Product> update(
            @PathVariable Long id,
            @RequestBody Product product) {
        return ResponseEntity.ok(productService.update(id, product));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        productService.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/cache/clear")
    public ResponseEntity<String> clearCache() {
        productService.clearCache();
        return ResponseEntity.ok("Cache limpo com sucesso");
    }

    @GetMapping("/stats/count")
    public ResponseEntity<Long> countProducts() {
        return ResponseEntity.ok(productService.countActiveProducts());
    }
}
```

## ▶️ Como Rodar

```bash
# Iniciar Redis
docker run -d --name redis -p 6379:6379 redis:7-alpine

# Iniciar aplicação
mvn spring-boot:run

# Criar produto
curl -X POST http://localhost:8084/api/v1/products \
  -H "Content-Type: application/json" \
  -d '{"name":"Notebook","price":4999.99,"category":"electronics","stock":10}'

# Primeira busca (banco) - verifique os logs
curl http://localhost:8084/api/v1/products/1

# Segunda busca (cache) - mais rápida
curl http://localhost:8084/api/v1/products/1

# Verificar cache no Redis
docker exec -it redis redis-cli
> KEYS myapp:*
> GET myapp:products::1
```

## 📌 Dicas Cache

| Dica | Descrição |
|------|-----------|
| ✅ TTLs diferentes | Dados estáticos = TTL alto, dinâmicos = TTL baixo |
| ✅ Evite thundering herd | Use `@Cacheable` com `sync=true` |
| ✅ Cache invalidation | Sempre evict quando dados mudam |
| ✅ Null values | Evite cachear `null` (`disableCachingNullValues`) |
| ✅ Key design | Use chaves descritivas e namespaces |

---

# 6. Testes Completos

## 🏗️ Estrutura

```
src/test/java/com/example/demo/
├── unit/
│   ├── service/
│   │   └── UserServiceTest.java
│   └── mapper/
│       └── UserMapperTest.java
├── integration/
│   ├── UserRepositoryTest.java
│   ├── UserServiceIntegrationTest.java
│   └── UserControllerIntegrationTest.java
├── web/
│   └── UserControllerMockMvcTest.java
└── container/
    └── UserRepositoryContainerTest.java
```

## 🧪 Testes Unitários

```java
// UserServiceTest.java
package com.example.demo.unit.service;

import com.example.demo.exception.ResourceNotFoundException;
import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("UserService - Testes Unitários")
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserService userService;

    private User user;

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .name("João Silva")
                .email("joao@example.com")
                .phone("+5511999999999")
                .active(true)
                .build();
    }

    @Nested
    @DisplayName("findById")
    class FindById {

        @Test
        @DisplayName("Deve retornar usuário quando encontrado")
        void shouldReturnUserWhenFound() {
            when(userRepository.findById(1L)).thenReturn(Optional.of(user));

            User result = userService.findById(1L);

            assertThat(result).isNotNull();
            assertThat(result.getId()).isEqualTo(1L);
            assertThat(result.getName()).isEqualTo("João Silva");

            verify(userRepository, times(1)).findById(1L);
        }

        @Test
        @DisplayName("Deve lançar exceção quando não encontrado")
        void shouldThrowWhenNotFound() {
            when(userRepository.findById(any(Long.class)))
                    .thenReturn(Optional.empty());

            assertThatThrownBy(() -> userService.findById(999L))
                    .isInstanceOf(ResourceNotFoundException.class)
                    .hasMessageContaining("não encontrado");

            verify(userRepository, never()).save(any());
        }
    }

    @Nested
    @DisplayName("create")
    class Create {

        @Test
        @DisplayName("Deve criar usuário com sucesso")
        void shouldCreateUser() {
            when(userRepository.existsByEmail(any(String.class))).thenReturn(false);
            when(userRepository.save(any(User.class))).thenReturn(user);

            User result = userService.create(user);

            assertThat(result).isNotNull();
            assertThat(result.getName()).isEqualTo("João Silva");
            verify(userRepository).save(any(User.class));
        }

        @Test
        @DisplayName("Deve lançar exceção quando email duplicado")
        void shouldThrowWhenEmailDuplicate() {
            when(userRepository.existsByEmail(any(String.class))).thenReturn(true);

            assertThatThrownBy(() -> userService.create(user))
                    .isInstanceOf(IllegalArgumentException.class)
                    .hasMessageContaining("já está em uso");

            verify(userRepository, never()).save(any());
        }
    }
}
```

## 🔗 Testes de Integração

```java
// UserRepositoryTest.java
package com.example.demo.integration;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;

import static org.assertj.core.api.Assertions.*;

@DataJpaTest
@ActiveProfiles("test")
@DisplayName("UserRepository - Testes de Integração")
class UserRepositoryTest {

    @Autowired
    private UserRepository userRepository;

    @BeforeEach
    void setUp() {
        userRepository.deleteAll();

        userRepository.save(User.builder()
                .name("João Silva")
                .email("joao@example.com")
                .phone("+5511999999999")
                .active(true)
                .build());

        userRepository.save(User.builder()
                .name("Maria Santos")
                .email("maria@example.com")
                .phone("+5511888888888")
                .active(true)
                .build());
    }

    @Test
    @DisplayName("Deve salvar e buscar usuário")
    void shouldSaveAndFindUser() {
        User user = User.builder()
                .name("Pedro Lima")
                .email("pedro@example.com")
                .phone("+5511777777777")
                .active(true)
                .build();

        User saved = userRepository.save(user);

        assertThat(saved.getId()).isNotNull();
        assertThat(saved.getName()).isEqualTo("Pedro Lima");
    }

    @Test
    @DisplayName("Deve verificar se email existe")
    void shouldCheckEmailExists() {
        assertThat(userRepository.existsByEmail("joao@example.com")).isTrue();
        assertThat(userRepository.existsByEmail("novo@example.com")).isFalse();
    }

    @Test
    @DisplayName("Deve buscar por email")
    void shouldFindByEmail() {
        var result = userRepository.findByEmail("joao@example.com");

        assertThat(result).isPresent();
        assertThat(result.get().getName()).isEqualTo("João Silva");
    }

    @Test
    @DisplayName("Deve buscar apenas usuários ativos")
    void shouldFindActiveUsers() {
        userRepository.save(User.builder()
                .name("Inativo")
                .email("inativo@example.com")
                .phone("+5511666666666")
                .active(false)
                .build());

        var activeUsers = userRepository.findByActiveTrue(
                org.springframework.data.domain.PageRequest.of(0, 10));

        assertThat(activeUsers.getTotalElements()).isEqualTo(2);
    }
}
```

## 🌐 Testes MockMvc

```java
// UserControllerMockMvcTest.java
package com.example.demo.web;

import com.example.demo.controller.UserController;
import com.example.demo.model.User;
import com.example.demo.service.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.bean.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(UserController.class)
@DisplayName("UserController - MockMvc Tests")
class UserControllerMockMvcTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private UserService userService;

    private User user;

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .name("João Silva")
                .email("joao@example.com")
                .phone("+5511999999999")
                .active(true)
                .build();
    }

    @Test
    @DisplayName("GET /api/v1/users/{id} - Deve retornar 200")
    void shouldReturnUserById() throws Exception {
        when(userService.findById(1L)).thenReturn(user);

        mockMvc.perform(get("/api/v1/users/{id}", 1L)
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.name").value("João Silva"))
                .andExpect(jsonPath("$.email").value("joao@example.com"));
    }

    @Test
    @DisplayName("POST /api/v1/users - Deve criar usuário")
    void shouldCreateUser() throws Exception {
        when(userService.create(any(User.class))).thenReturn(user);

        mockMvc.perform(post("/api/v1/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(user)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value("João Silva"));
    }

    @Test
    @DisplayName("POST /api/v1/users - Deve retornar 400 com dados inválidos")
    void shouldReturn400WithInvalidData() throws Exception {
        User invalidUser = User.builder()
                .name("")
                .email("invalid")
                .build();

        mockMvc.perform(post("/api/v1/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(invalidUser)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("GET /api/v1/users - Deve listar todos")
    void shouldListAllUsers() throws Exception {
        when(userService.findAll()).thenReturn(List.of(user));

        mockMvc.perform(get("/api/v1/users")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].name").value("João Silva"));
    }

    @Test
    @DisplayName("DELETE /api/v1/users/{id} - Deve deletar usuário")
    void shouldDeleteUser() throws Exception {
        mockMvc.perform(delete("/api/v1/users/{id}", 1L))
                .andExpect(status().isNoContent());
    }
}
```

## 🐳 TestContainers

```java
// UserRepositoryContainerTest.java
package com.example.demo.container;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@Testcontainers
@ActiveProfiles("test")
@DisplayName("UserRepository - TestContainers (MySQL)")
class UserRepositoryContainerTest {

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
    private UserRepository userRepository;

    @BeforeEach
    void setUp() {
        userRepository.deleteAll();
    }

    @Test
    @DisplayName("Deve salvar usuário no MySQL real")
    void shouldSaveUserInMySQL() {
        User user = User.builder()
                .name("João Silva")
                .email("joao@example.com")
                .phone("+5511999999999")
                .active(true)
                .build();

        User saved = userRepository.save(user);

        assertThat(saved.getId()).isNotNull();
        assertThat(userRepository.findById(saved.getId())).isPresent();
    }

    @Test
    @DisplayName("Deve buscar por email no MySQL")
    void shouldFindByEmailInMySQL() {
        userRepository.save(User.builder()
                .name("Maria Santos")
                .email("maria@example.com")
                .phone("+5511888888888")
                .active(true)
                .build());

        var result = userRepository.findByEmail("maria@example.com");

        assertThat(result).isPresent();
        assertThat(result.get().getName()).isEqualTo("Maria Santos");
    }
}
```

## ▶️ Como Rodar os Testes

```bash
# Todos os testes
mvn test

# Testes específicos
mvn test -Dtest="UserServiceTest"
mvn test -Dtest="UserRepositoryTest"
mvn test -Dtest="UserControllerMockMvcTest"
mvn test -Dtest="UserRepositoryContainerTest"

# Com cobertura
mvn test jacoco:report
# Abrir target/site/jacoco/index.html

# Apenas testes de integração
mvn test -Dgroups="integration"
```

## 📌 Dicas de Testes

| Dica | Descrição |
|------|-----------|
| ✅ Testcontainers | Teste contra bancos reais em containers |
| ✅ AssertJ | Assertions mais expressivas que JUnit |
| ✅ @Nested | Organize testes por funcionalidade |
| ✅ @DisplayName | Nomes descritivos nos testes |
| ✅ @DataJpaTest | Teste rápido de repository com H2 em memória |

---

# 7. Docker e Deploy

## 🐳 Dockerfile Multi-Stage

```dockerfile
# ============================================
# Stage 1: Build
# ============================================
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copiar apenas arquivos que afetam a dependência
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .

# Baixar dependências (camada cacheável)
RUN mvn dependency:go-offline -B

# Copiar código-fonte
COPY src ./src

# Build da aplicação
RUN mvn package -DskipTests -B

# ============================================
# Stage 2: Runtime
# ============================================
FROM eclipse-temurin:17-jre-alpine AS runtime

# Criar usuário não-root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Instalar curl para healthcheck
RUN apk add --no-cache curl

WORKDIR /app

# Copiar JAR do build
COPY --from=build /app/target/*.jar app.jar

# Propriedades de segurança
RUN chown -R appuser:appgroup /app
USER appuser

# Expor porta
EXPOSE 8080

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

# Comando de entrada
ENTRYPOINT ["java", \
  "-XX:+UseContainerSupport", \
  "-XX:MaxRAMPercentage=75.0", \
  "-XX:InitialRAMPercentage=50.0", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-jar", "app.jar"]
```

## 🐳 docker-compose.yml

```yaml
version: '3.8'

services:
  # ===== Aplicação =====
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: user-api
    ports:
      - "8080:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=production
      - SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/userdb
      - SPRING_DATASOURCE_USERNAME=postgres
      - SPRING_DATASOURCE_PASSWORD=secret
      - SPRING_JPA_HIBERNATE_DDL_AUTO=validate
      - JWT_SECRET=myProductionSecretKeyThatIsVeryLong2024!
      - JAVA_OPTS=-Xms256m -Xmx512m
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    networks:
      - app-network
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M

  # ===== PostgreSQL =====
  postgres:
    image: postgres:16-alpine
    container_name: postgres
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_DB=userdb
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=secret
      - PGDATA=/var/lib/postgresql/data/pgdata
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - app-network

  # ===== Redis =====
  redis:
    image: redis:7-alpine
    container_name: redis
    ports:
      - "6379:6379"
    command: redis-server --appendonly yes --maxmemory 256mb --maxmemory-policy allkeys-lru
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - app-network

  # ===== Kafka =====
  kafka:
    image: apache/kafka:latest
    container_name: kafka
    ports:
      - "9092:9092"
    environment:
      - KAFKA_NODE_ID=1
      - KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092
      - KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
      - KAFKA_CONTROLLER_QUORUM_VOTERS=1@kafka:9093
      - KAFKA_PROCESS_ROLES=broker,controller
      - KAFKA_LOG_RETENTION_HOURS=168
    networks:
      - app-network

  # ===== pgAdmin (Administração) =====
  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: pgadmin
    ports:
      - "5050:80"
    environment:
      - PGADMIN_DEFAULT_EMAIL=admin@example.com
      - PGADMIN_DEFAULT_PASSWORD=admin
    depends_on:
      - postgres
    networks:
      - app-network

volumes:
  postgres_data:
  redis_data:

networks:
  app-network:
    driver: bridge
```

## ☸️ Kubernetes Deployment

```yaml
# k8s/namespace.yml
apiVersion: v1
kind: Namespace
metadata:
  name: user-api
  labels:
    app: user-api
```

```yaml
# k8s/configmap.yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: user-api-config
  namespace: user-api
data:
  SPRING_PROFILES_ACTIVE: "production"
  SPRING_DATASOURCE_URL: "jdbc:postgresql://postgres-service:5432/userdb"
  SPRING_JPA_HIBERNATE_DDL_AUTO: "validate"
```

```yaml
# k8s/secret.yml
apiVersion: v1
kind: Secret
metadata:
  name: user-api-secrets
  namespace: user-api
type: Opaque
stringData:
  SPRING_DATASOURCE_USERNAME: "postgres"
  SPRING_DATASOURCE_PASSWORD: "secret"
  JWT_SECRET: "myProductionSecretKeyThatIsVeryLong2024!"
```

```yaml
# k8s/deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: user-api
  namespace: user-api
  labels:
    app: user-api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: user-api
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: user-api
    spec:
      containers:
        - name: user-api
          image: registry.example.com/user-api:latest
          ports:
            - containerPort: 8080
          envFrom:
            - configMapRef:
                name: user-api-config
            - secretRef:
                name: user-api-secrets
          resources:
            requests:
              memory: "256Mi"
              cpu: "250m"
            limits:
              memory: "512Mi"
              cpu: "500m"
          livenessProbe:
            httpGet:
              path: /actuator/health/liveness
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 5
            failureThreshold: 3
          readinessProbe:
            httpGet:
              path: /actuator/health/readiness
              port: 8080
            initialDelaySeconds: 20
            periodSeconds: 5
            timeoutSeconds: 3
            failureThreshold: 3
          startupProbe:
            httpGet:
              path: /actuator/health
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 5
            failureThreshold: 30
```

```yaml
# k8s/service.yml
apiVersion: v1
kind: Service
metadata:
  name: user-api-service
  namespace: user-api
spec:
  selector:
    app: user-api
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
  type: ClusterIP
```

```yaml
# k8s/hpa.yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: user-api-hpa
  namespace: user-api
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: user-api
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
```

```yaml
# k8s/ingress.yml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: user-api-ingress
  namespace: user-api
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    cert-manager.io/cluster-issuer: letsencrypt-prod
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - api.example.com
      secretName: user-api-tls
  rules:
    - host: api.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: user-api-service
                port:
                  number: 80
```

## 🔄 GitHub Actions CI/CD

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  JAVA_VERSION: '17'
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  # ===== Build e Test =====
  build:
    name: Build & Test
    runs-on: ubuntu-latest

    services:
      postgres:
        image: postgres:16-alpine
        env:
          POSTGRES_DB: testdb
          POSTGRES_USER: test
          POSTGRES_PASSWORD: test
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

      redis:
        image: redis:7-alpine
        ports:
          - 6379:6379
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up JDK
        uses: actions/setup-java@v4
        with:
          java-version: ${{ env.JAVA_VERSION }}
          distribution: 'temurin'
          cache: maven

      - name: Build & Test
        run: mvn clean verify -B
        env:
          SPRING_DATASOURCE_URL: jdbc:postgresql://localhost:5432/testdb
          SPRING_DATASOURCE_USERNAME: test
          SPRING_DATASOURCE_PASSWORD: test

      - name: Upload Coverage
        uses: codecov/codecov-action@v3
        with:
          file: target/site/jacoco/jacoco.xml

  # ===== Security Scan =====
  security:
    name: Security Scan
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: '.'
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload Trivy scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'

  # ===== Docker Build & Push =====
  docker:
    name: Docker Build & Push
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main'

    permissions:
      contents: read
      packages: write

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Login to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=sha
            type=ref,event=branch
            type=semver,pattern={{version}}

      - name: Build and Push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  # ===== Deploy =====
  deploy:
    name: Deploy to Production
    runs-on: ubuntu-latest
    needs: [build, docker]
    if: github.ref == 'refs/heads/main'

    environment:
      name: production
      url: https://api.example.com

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Deploy to Kubernetes
        uses: azure/k8s-deploy@v4
        with:
          namespace: user-api
          manifests: k8s/
          images: |
            ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
```

## ▶️ Como Rodar

```bash
# ===== Docker =====
# Build da imagem
docker build -t user-api:latest .

# Rodar container
docker run -d -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://host.docker.internal:5432/userdb \
  --name user-api \
  user-api:latest

# Docker Compose (tudo junto)
docker-compose up -d

# Ver logs
docker-compose logs -f app

# Parar tudo
docker-compose down

# ===== Kubernetes =====
# Criar namespace
kubectl apply -f k8s/namespace.yml

# Deploy config e secrets
kubectl apply -f k8s/configmap.yml
kubectl apply -f k8s/secret.yml

# Deploy aplicação
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yml
kubectl apply -f k8s/hpa.yml
kubectl apply -f k8s/ingress.yml

# Verificar pods
kubectl get pods -n user-api

# Ver logs
kubectl logs -f deployment/user-api -n user-api

# Scaling manual
kubectl scale deployment user-api --replicas=5 -n user-api
```

## 📌 Dicas Docker & Deploy

| Dica | Descrição |
|------|-----------|
| ✅ Multi-stage build | Imagem menor (~200MB vs ~700MB) |
| ✅ Usuário non-root | Nunca rode como root em produção |
| ✅ Health checks | Kubernetes e Docker precisam deles |
| ✅ Resource limits | Sempre defina CPU e memória |
| ✅ Rolling updates | `maxUnavailable: 0` para zero downtime |
| ✅ Secrets | Use Kubernetes Secrets ou Vault, nunca hardcode |

---

## 📊 Resumo dos Projetos

| # | Projeto | Arquivos | Linhas de Código |
|---|---------|----------|-----------------|
| 1 | API REST Completa | 15+ | ~500 |
| 2 | Autenticação JWT | 12+ | ~600 |
| 3 | Microserviço Cloud | 10+ | ~400 |
| 4 | Kafka Consumer | 8+ | ~350 |
| 5 | Cache Redis | 7+ | ~300 |
| 6 | Testes Completos | 6+ | ~400 |
| 7 | Docker & Deploy | 8+ | ~350 |
| **Total** | | **66+** | **~2900** |

---

> **Última atualização:** 2026-09-14
>
> **Tecnologias:** Java 17 · Spring Boot 3.2 · Spring Cloud · Apache Kafka · Redis · Docker · Kubernetes · GitHub Actions
