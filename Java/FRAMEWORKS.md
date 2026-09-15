# 🚀 Guia Completo e Profissional de Frameworks Java

> **Última atualização:** Setembro 2026  
> **Nível:** Intermediário → Avançado  
> **Público-alvo:** Desenvolvedores Java que buscam domínio dos principais frameworks e padrões arquiteturais

---

## 📑 Índice

1. [Spring Framework](#1-spring-framework)
2. [Hibernate/JPA](#2-hibernatejpa)
3. [Jakarta EE](#3-jakarta-ee)
4. [Outros Frameworks](#4-outros-frameworks)
5. [Arquitetura](#5-arquitetura)

---

## 1. 🌱 Spring Framework

### 1.1 Spring Core

#### O que é
O **Spring Core** é o módulo foundational do ecossistema Spring. Ele fornece o **Container IoC (Inversion of Control)** e o mecanismo de **Dependency Injection (DI)** que sustentam todo o framework. É ele que gerencia o ciclo de vida dos objetos (beans) e suas dependências de forma declarativa.

#### Por que usar
| Benefício | Descrição |
|-----------|-----------|
| **Desacoplamento** | Componentes não criam suas dependências diretamente |
| **Testabilidade** | Fácil substituição de implementações em testes |
| **Reutilização** | Beans são gerenciados e reutilizáveis |
| **Configuração centralizada** | XML, Anotações ou Java Config |
| **Extensibilidade** | Base para todos os módulos Spring |

#### Configuração

**pom.xml (Maven):**
```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>6.2.0</version>
</dependency>
```

#### Exemplos Práticos

**Dependency Injection com Anotações:**
```java
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class OrderService {

    private final PaymentRepository paymentRepository;
    private final NotificationService notificationService;

    // Constructor Injection (recomendado)
    @Autowired
    public OrderService(PaymentRepository paymentRepository,
                        NotificationService notificationService) {
        this.paymentRepository = paymentRepository;
        this.notificationService = notificationService;
    }

    public Order processOrder(Order order) {
        paymentRepository.save(order.getPayment());
        notificationService.sendOrderConfirmation(order);
        return order;
    }
}
```

**Java Config (sem XML):**
```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    @Bean
    public PaymentRepository paymentRepository() {
        return new JdbcPaymentRepository(dataSource());
    }

    @Bean
    public DataSource dataSource() {
        HikariDataSource ds = new HikariDataSource();
        ds.setJdbcUrl("jdbc:mysql://localhost:3306/mydb");
        ds.setUsername("root");
        ds.setPassword("password");
        return ds;
    }
}
```

**ApplicationContext:**
```java
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class Main {
    public static void main(String[] args) {
        var context = new AnnotationConfigApplicationContext(AppConfig.class);

        OrderService orderService = context.getBean(OrderService.class);
        orderService.processOrder(new Order());

        context.close();
    }
}
```

#### Bean Lifecycle

```
Instantiation → Populate Properties → BeanNameAware → BeanFactoryAware
→ ApplicationContextAware → BeanPostProcessor.postProcessBeforeInitialization
→ @PostConstruct → InitializingBean.afterPropertiesSet → Custom init
→ BeanPostProcessor.postProcessAfterInitialization → READY
→ @PreDestroy → DisposableBean.destroy → Custom destroy
```

#### Melhores Práticas
- ✅ Prefira **Constructor Injection** sobre field injection
- ✅ Use `@Component`, `@Service`, `@Repository` para auto-detecção
- ✅ Mantenha beans como **singletons** por padrão
- ❌ Evite acoplamento circular
- ❌ Não use `new` para criar beans gerenciados pelo Spring

---

### 1.2 Spring Boot

#### O que é
O **Spring Boot** é uma extensão do Spring que simplifica o setup e o desenvolvimento de aplicações Spring. Ele oferece **auto-configuração**, **embedded servers** (Tomcat, Jetty), **actuator** para monitoramento, e uma abordagem **convention over configuration**.

#### Por que usar
| Benefício | Descrição |
|-----------|-----------|
| **Setup rápido** | Aplicação funcional em minutos |
| **Auto-configuração** | Configura automática baseada em dependências |
| **Embedded Server** | Não precisa deploy externo |
| **Production-ready** | Actuator, métricas, health checks |
| **Starter POMs** | Dependências agrupadas por funcionalidade |

#### Configuração

**pom.xml:**
```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.3.0</version>
</parent>

<dependencies>
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
        <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
        <scope>runtime</scope>
    </dependency>
</dependencies>
```

**application.yml:**
```yaml
spring:
  application:
    name: my-api

  datasource:
    url: jdbc:postgresql://localhost:5432/mydb
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5

  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: false
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true

  profiles:
    active: dev

server:
  port: 8080
  servlet:
    context-path: /api/v1

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  endpoint:
    health:
      show-details: when-authorized
```

#### Profiles

```java
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

@Configuration
@Profile("dev")
public class DevDataSourceConfig {
    @Bean
    public DataSource dataSource() {
        // H2 in-memory database for development
        return new EmbeddedDatabaseBuilder()
            .setType(EmbeddedDatabaseType.H2)
            .addScript("schema.sql")
            .build();
    }
}

@Configuration
@Profile("prod")
public class ProdDataSourceConfig {
    @Bean
    public DataSource dataSource() {
        HikariDataSource ds = new HikariDataSource();
        ds.setJdbcUrl(env.getProperty("PROD_DB_URL"));
        return ds;
    }
}
```

**Ativando profile:**
```bash
# Via variável de ambiente
export SPRING_PROFILES_ACTIVE=prod

# Via argumento
java -jar app.jar --spring.profiles.active=prod

# Via application.yml
spring.profiles.active: dev
```

#### Actuator - Health Check

```java
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;

@Component
public class DatabaseHealthIndicator implements HealthIndicator {

    private final JdbcTemplate jdbcTemplate;

    public DatabaseHealthIndicator(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Health health() {
        try {
            jdbcTemplate.queryForObject("SELECT 1", Integer.class);
            return Health.up()
                .withDetail("database", "accessible")
                .withDetail("message", "Connection OK")
                .build();
        } catch (Exception e) {
            return Health.down()
                .withDetail("database", "unaccessible")
                .withDetail("error", e.getMessage())
                .build();
        }
    }
}
```

#### Melhores Práticas
- ✅ Use `application.yml` sobre `application.properties`
- ✅ Externe configurações via variáveis de ambiente
- ✅ Use **Profiles** para separar ambientes
- ✅ Exponha apenas endpoints necessários no Actuator
- ✅ Use `spring-boot-starter-*` para dependências
- ❌ Não hardcode senhas no código fonte
- ❌ Não use `ddl-auto: update` em produção

---

### 1.3 Spring MVC

#### O que é
O **Spring MVC** é o módulo web do Spring que implementa o padrão **Model-View-Controller**. Ele processa requisições HTTP, mapeia para handlers, valida dados, e retorna responses estruturadas.

#### Por que usar
| Benefício | Descrição |
|-----------|-----------|
| **RESTful** | Suporte nativo a APIs REST |
| **Validação** | Integração com Bean Validation (JSR 380) |
| **Exception Handling** | Tratamento centralizado de erros |
| **Content Negotiation** | JSON, XML, etc. |
| **Extensível** | Interceptors, resolvers, converters |

#### Exemplos Práticos

**Controller REST Completo:**
```java
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/v1/products")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public ResponseEntity<List<ProductResponse>> findAll(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        List<ProductResponse> products = productService.findAll(page, size);
        return ResponseEntity.ok(products);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductResponse> findById(@PathVariable Long id) {
        ProductResponse product = productService.findById(id);
        return ResponseEntity.ok(product);
    }

    @PostMapping
    public ResponseEntity<ProductResponse> create(
            @Valid @RequestBody CreateProductRequest request) {
        ProductResponse created = productService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductResponse> update(
            @PathVariable Long id,
            @Valid @RequestBody UpdateProductRequest request) {
        ProductResponse updated = productService.update(id, request);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id) {
        productService.delete(id);
    }
}
```

**Request/Response DTOs:**
```java
import jakarta.validation.constraints.*;

public record CreateProductRequest(
    @NotBlank(message = "Nome é obrigatório")
    @Size(min = 3, max = 100, message = "Nome deve ter entre 3 e 100 caracteres")
    String name,

    @NotBlank(message = "Descrição é obrigatória")
    String description,

    @NotNull(message = "Preço é obrigatório")
    @DecimalMin(value = "0.01", message = "Preço deve ser maior que zero")
    BigDecimal price,

    @NotNull(message = "Categoria é obrigatória")
    Long categoryId
) {}
```

**Exception Handler Global:**
```java
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(ResourceNotFoundException ex) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.NOT_FOUND.value(),
            ex.getMessage(),
            LocalDateTime.now()
        );
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(MethodArgumentNotValidException ex) {
        List<String> messages = ex.getBindingResult()
            .getFieldErrors()
            .stream()
            .map(fe -> fe.getField() + ": " + fe.getDefaultMessage())
            .toList();

        ErrorResponse error = new ErrorResponse(
            HttpStatus.BAD_REQUEST.value(),
            "Erros de validação",
            LocalDateTime.now(),
            messages
        );
        return ResponseEntity.badRequest().body(error);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGeneric(Exception ex) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.INTERNAL_SERVER_ERROR.value(),
            "Erro interno do servidor",
            LocalDateTime.now()
        );
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
    }
}
```

**Validation - Custom Constraint:**
```java
import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = PriceValidator.class)
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface PositivePrice {
    String message() default "Preço deve ser positivo";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}

public class PriceValidator implements ConstraintValidator<PositivePrice, BigDecimal> {
    @Override
    public boolean isValid(BigDecimal value, ConstraintValidatorContext context) {
        return value != null && value.compareTo(BigDecimal.ZERO) > 0;
    }
}
```

#### Melhores Práticas
- ✅ Use `@RestController` (não `@Controller` + `@ResponseBody`)
- ✅ Valide entradas com `@Valid`
- ✅ Use DTOs, nunca exponha entidades diretamente
- ✅ Trate exceções globalmente com `@RestControllerAdvice`
- ✅ Use `ResponseEntity` para códigos HTTP semânticos
- ❌ Não retorne entidades JPA diretamente
- ❌ Não ignore exceções silenciosamente

---

### 1.4 Spring Data

#### O que é
O **Spring Data** é um módulo que simplifica o acesso a dados, fornecendo abstrações reutilizáveis e implementações de repositório para diferentes tecnologias (JPA, MongoDB, Redis, etc.).

#### Por que usar
| Benefício | Descrição |
|-----------|-----------|
| **Boilerplate zero** | Implementações automáticas de CRUD |
| **Query Methods** | Consultas derivadas do nome do método |
| **Pagination** | Suporte nativo a paginação |
| **Specification** | Consultas dinâmicas tipadas |
| **Auditing** | Criação/atualização automática de metadados |

#### Repositories

```java
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    // Query derivada do nome
    List<Product> findByCategoryId(Long categoryId);

    Optional<Product> findByNameIgnoreCase(String name);

    List<Product> findByPriceBetween(BigDecimal min, BigDecimal max);

    // JPQL customizado
    @Query("SELECT p FROM Product p WHERE p.name LIKE %:keyword% OR p.description LIKE %:keyword%")
    Page<Product> searchByKeyword(@Param("keyword") String keyword, Pageable pageable);

    // Native Query
    @Query(value = "SELECT * FROM products p WHERE p.category_id = :categoryId AND p.active = true",
           nativeQuery = true)
    List<Product> findActiveProductsByCategory(@Param("categoryId") Long categoryId);

    // Delete
    @Modifying
    @Query("DELETE FROM Product p WHERE p.category.id = :categoryId")
    void deleteAllByCategoryId(@Param("categoryId") Long categoryId);
}
```

**Specification (Consultas Dinâmicas):**
```java
import org.springframework.data.jpa.domain.Specification;

public class ProductSpecs {

    public static Specification<Product> hasName(String name) {
        return (root, query, cb) ->
            name == null ? null : cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%");
    }

    public static Specification<Product> inCategory(Long categoryId) {
        return (root, query, cb) ->
            categoryId == null ? null : cb.equal(root.get("category").get("id"), categoryId);
    }

    public static Specification<Product> priceBetween(BigDecimal min, BigDecimal max) {
        return (root, query, cb) -> {
            if (min == null && max == null) return null;
            if (min == null) return cb.lessThanOrEqualTo(root.get("price"), max);
            if (max == null) return cb.greaterThanOrEqualTo(root.get("price"), min);
            return cb.between(root.get("price"), min, max);
        };
    }
}

// Uso no Service
public List<Product> searchProducts(String name, Long categoryId, BigDecimal minPrice, BigDecimal maxPrice) {
    Specification<Product> spec = Specification
        .where(ProductSpecs.hasName(name))
        .and(ProductSpecs.inCategory(categoryId))
        .and(ProductSpecs.priceBetween(minPrice, maxPrice));

    return productRepository.findAll(spec);
}
```

**JPA Entity:**
```java
import jakarta.persistence.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Table(name = "products")
@EntityListeners(AuditingEntityListener.class)
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(length = 500)
    private String description;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @Column(nullable = false)
    private Boolean active = true;

    @CreatedDate
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;
}
```

#### MongoDB com Spring Data

```java
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

public interface EventRepository extends MongoRepository<Event, String> {

    List<Event> findByEventTypeAndTimestampAfter(String eventType, LocalDateTime after);

    @Query("{ 'metadata.userId': ?0, 'timestamp': { $gte: ?1, $lte: ?2 } }")
    List<Event> findUserEventsBetween(String userId, LocalDateTime start, LocalDateTime end);
}
```

#### Redis com Spring Data

```java
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CacheRepository {

    private final RedisTemplate<String, Object> redisTemplate;

    public CacheRepository(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public void set(String key, Object value, Duration ttl) {
        redisTemplate.opsForValue().set(key, value, ttl);
    }

    public Object get(String key) {
        return redisTemplate.opsForValue().get(key);
    }

    public void delete(String key) {
        redisTemplate.delete(key);
    }
}
```

#### Melhores Práticas
- ✅ Use **Query Methods** para consultas simples
- ✅ Use `@Query` para JPQL complexo
- ✅ Use **Specification** para filtros dinâmicos
- ✅ Prefira `fetch` sobre `JOIN FETCH` quando possível
- ✅ Use `Pageable` para paginação
- ❌ Não carregue relações desnecessárias (N+1 problem)
- ❌ Não faça queries dentro de loops

---

### 1.5 Spring Security

#### O que é
O **Spring Security** é o framework de segurança do Spring que fornece autenticação e autorização robustas para aplicações Java. Suporta múltiplos mecanismos: Basic, Form Login, JWT, OAuth2, LDAP, etc.

#### Por que usar
| Benefício | Descrição |
|-----------|-----------|
| **Proteção completa** | CSRF, XSS, Session Fixation |
| **Múltiplos mecanismos** | JWT, OAuth2, SAML, LDAP |
| **Granular** | Controle de acesso por URL, método, role |
| **Comunidade** | Amplamente adotado e documentado |
| **Integração** | Funciona com qualquer framework Spring |

#### Configuração

**Security Filter Chain (Spring Boot 3.x):**
```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final JwtAuthenticationFilter jwtFilter;
    private final CustomAuthenticationEntryPoint entryPoint;

    public SecurityConfig(JwtAuthenticationFilter jwtFilter,
                          CustomAuthenticationEntryPoint entryPoint) {
        this.jwtFilter = jwtFilter;
        this.entryPoint = entryPoint;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .sessionManagement(session ->
                session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .exceptionHandling(ex -> ex.authenticationEntryPoint(entryPoint))
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/v1/auth/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/v1/products/**").permitAll()
                .requestMatchers("/api/v1/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
            )
            .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

#### Autenticação com JWT

```java
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;

@Component
public class JwtTokenProvider {

    @Value("${jwt.secret}")
    private String jwtSecret;

    @Value("${jwt.expiration}")
    private long jwtExpiration;

    public String generateToken(Authentication authentication) {
        UserDetails userPrincipal = (UserDetails) authentication.getPrincipal();
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + jwtExpiration);

        return Jwts.builder()
            .subject(userPrincipal.getUsername())
            .issuedAt(now)
            .expiration(expiryDate)
            .signWith(getSigningKey())
            .compact();
    }

    public String getUsernameFromToken(String token) {
        return Jwts.parser()
            .verifyWith(getSigningKey())
            .build()
            .parseSignedClaims(token)
            .getPayload()
            .getSubject();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().verifyWith(getSigningKey()).build().parseSignedClaims(token);
            return true;
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(jwtSecret.getBytes());
    }
}
```

```java
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtTokenProvider tokenProvider;
    private final CustomUserDetailsService userDetailsService;

    public JwtAuthenticationFilter(JwtTokenProvider tokenProvider,
                                    CustomUserDetailsService userDetailsService) {
        this.tokenProvider = tokenProvider;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        String token = extractToken(request);

        if (StringUtils.hasText(token) && tokenProvider.validateToken(token)) {
            String username = tokenProvider.getUsernameFromToken(token);
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);

            UsernamePasswordAuthenticationToken authentication =
                new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

            SecurityContextHolder.getContext().setAuthentication(authentication);
        }

        filterChain.doFilter(request, response);
    }

    private String extractToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }
}
```

#### Autorização com Method Security

```java
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

    @PreAuthorize("hasRole('ADMIN')")
    public void adminOnlyOperation() {
        // Apenas administradores podem executar
    }

    @PreAuthorize("#userId == authentication.principal.id or hasRole('ADMIN')")
    public UserDTO getUserProfile(Long userId) {
        // O próprio usuário ou um admin pode acessar
        return userService.findById(userId);
    }

    @PreAuthorize("hasAuthority('READ_PRODUCTS')")
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }
}
```

#### OAuth2 com Spring Security

```java
import org.springframework.context.annotation.Bean;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientManager;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientProviderBuilder;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.web.DefaultOAuth2AuthorizedClientManager;
import org.springframework.security.oauth2.client.web.OAuth2AuthorizedClientRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;

@Configuration
public class OAuth2ClientConfig {

    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        ClientRegistration registration = ClientRegistration
            .withRegistrationId("github")
            .clientId("your-client-id")
            .clientSecret("your-client-secret")
            .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
            .scope("read:user", "user:email")
            .authorizationUri("https://github.com/login/oauth/authorize")
            .tokenUri("https://github.com/login/oauth/access_token")
            .userInfoUri("https://api.github.com/user")
            .userNameAttributeName("id")
            .clientName("GitHub")
            .build();

        return new InMemoryClientRegistrationRepository(registration);
    }

    @Bean
    public OAuth2AuthorizedClientManager authorizedClientManager(
            ClientRegistrationRepository clientRegistrationRepository,
            OAuth2AuthorizedClientRepository authorizedClientRepository) {

        var authorizedClientProvider = OAuth2AuthorizedClientProviderBuilder.builder()
            .authorizationCode()
            .refreshToken()
            .build();

        var authorizedClientManager = new DefaultOAuth2AuthorizedClientManager(
            clientRegistrationRepository, authorizedClientRepository);
        authorizedClientManager.setAuthorizedClientProvider(authorizedClientProvider);

        return authorizedClientManager;
    }
}
```

#### Melhores Práticas
- ✅ Use **STATELESS** sessions para APIs REST
- ✅ Armazene senhas com `BCryptPasswordEncoder`
- ✅ Use HTTPS em produção
- ✅ Implemente refresh tokens
- ✅ Limite tentativas de login (rate limiting)
- ✅ Use `@PreAuthorize` para controle granular
- ❌ Nunca armazene senhas em texto plano
- ❌ Não desative CSRF sem motivo
- ❌ Não exponha erros detalhados de autenticação

---

## 2. 💾 Hibernate/JPA

### O que é
O **Hibernate** é o ORM (Object-Relational Mapping) mais popular para Java. O **JPA (Java Persistence API)** é a especificação (interface), e o Hibernate é sua implementação mais usada. Juntos, mapeiam objetos Java para tabelas de banco de dados.

### Por que usar
| Benefício | Descrição |
|-----------|-----------|
| **Mapeamento ORM** | Objetos ↔ Tabelas automaticamente |
| **HQL/JPQL** | Consultas orientadas a objeto |
| **Cache** | L1 e L2 para performance |
| **Lazy Loading** | Carregamento sob demanda |
| **Migrations** | Integração com Flyway/Liquibase |

### Configuração

**persistence.xml:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<persistence xmlns="https://jakarta.ee/xml/ns/persistence"
             version="3.1">

    <persistence-unit name="myPU" transaction-type="RESOURCE_LOCAL">
        <provider>org.hibernate.jpa.HibernatePersistenceProvider</provider>

        <class>com.example.entity.Product</class>
        <class>com.example.entity.Category</class>

        <properties>
            <property name="jakarta.persistence.jdbc.driver" value="org.postgresql.Driver"/>
            <property name="jakarta.persistence.jdbc.url" value="jdbc:postgresql://localhost:5432/mydb"/>
            <property name="jakarta.persistence.jdbc.user" value="postgres"/>
            <property name="jakarta.persistence.jdbc.password" value="password"/>

            <property name="hibernate.dialect" value="org.hibernate.dialect.PostgreSQLDialect"/>
            <property name="hibernate.hbm2ddl.auto" value="validate"/>
            <property name="hibernate.show_sql" value="false"/>
            <property name="hibernate.format_sql" value="true"/>
            <property name="hibernate.use_sql_comments" value="true"/>

            <!-- Cache L2 -->
            <property name="hibernate.cache.use_second_level_cache" value="true"/>
            <property name="hibernate.cache.region.factory_class"
                      value="org.hibernate.cache.jcache.JCacheRegionFactory"/>
            <property name="hibernate.javax.cache.provider"
                      value="org.ehcache.jsr107.EhcacheCachingProvider"/>
        </properties>
    </persistence-unit>
</persistence>
```

### Entidades e Relationships

```java
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "authors")
public class Author {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(unique = true)
    private String email;

    // OneToMany: Um autor tem muitos livros
    @OneToMany(mappedBy = "author", cascade = CascadeType.ALL, orphanRemoval = true)
    @Fetch(FetchMode.JOIN) // ou LAZY para carregamento sob demanda
    private List<Book> books = new ArrayList<>();

    // ManyToMany: Um autor pode ter muitas categorias
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "author_categories",
        joinColumns = @JoinColumn(name = "author_id"),
        inverseJoinColumns = @JoinColumn(name = "category_id")
    )
    private Set<Category> categories = new HashSet<>();

    // Métodos auxiliares para manter consistência
    public void addBook(Book book) {
        books.add(book);
        book.setAuthor(this);
    }

    public void removeBook(Book book) {
        books.remove(book);
        book.setAuthor(null);
    }
}

@Entity
@Table(name = "books")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(length = 2000)
    private String description;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "author_id", nullable = false)
    private Author author;

    // OneToOne: Um livro pode ter uma imagem de capa
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "cover_image_id")
    private CoverImage coverImage;
}

@Entity
@Table(name = "categories")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;
}
```

**Cache L2 com EhCache:**
```java
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name = "products")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "productCache")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    private String name;

    // ...
}
```

### JPQL vs Criteria API

```java
// JPQL - Mais legível
@Query("SELECT p FROM Product p WHERE p.category.name = :categoryName AND p.price < :maxPrice")
List<Product> findAffordableProductsInCategory(
    @Param("categoryName") String categoryName,
    @Param("maxPrice") BigDecimal maxPrice
);

// Criteria API - Mais flexível (consultas dinâmicas)
public List<Product> findProducts(String categoryName, BigDecimal maxPrice, Boolean active) {
    CriteriaBuilder cb = entityManager.getCriteriaBuilder();
    CriteriaQuery<Product> query = cb.createQuery(Product.class);
    Root<Product> root = query.from(Product.class);

    List<Predicate> predicates = new ArrayList<>();

    if (categoryName != null) {
        predicates.add(cb.equal(root.get("category").get("name"), categoryName));
    }
    if (maxPrice != null) {
        predicates.add(cb.lessThan(root.get("price"), maxPrice));
    }
    if (active != null) {
        predicates.add(cb.equal(root.get("active"), active));
    }

    query.where(predicates.toArray(new Predicate[0]));
    query.orderBy(cb.asc(root.get("name")));

    return entityManager.createQuery(query).getResultList();
}
```

### Migrations

**Flyway:**
```sql
-- V1__create_products_table.sql
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id BIGINT NOT NULL REFERENCES categories(id),
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_active ON products(active);

-- V2__add_product_image.sql
ALTER TABLE products ADD COLUMN image_url VARCHAR(500);
```

**Flyway Config (Spring Boot):**
```yaml
spring:
  flyway:
    enabled: true
    locations: classpath:db/migration
    baseline-on-migrate: true
    validate-on-migrate: true
```

### Melhores Práticas
- ✅ Use `FetchType.LAZY` por padrão
- ✅ Prefira JPQL sobre Criteria API para consultas simples
- ✅ Use **DTOs** para projeções (evite carregar entidades completas)
- ✅ Use `@Cache` para dados imutáveis
- ✅ Use **migrations** (Flyway/Liquibase), nunca DDL manual
- ✅ Configure connection pooling (HikariCP)
- ❌ Não use `cascade = CascadeType.ALL` indiscriminadamente
- ❌ Não ignore o **N+1 problem**
- ❌ Não use `ddl-auto: update` em produção

---

## 3. 🏢 Jakarta EE

### O que é
O **Jakarta EE** (anteriormente Java EE) é o conjunto de especificações para aplicações corporativas Java. Ele define padrões para Servlets, JSP, EJB, JMS, JAX-RS, e mais.

### Módulos Principais

#### Servlets

```java
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = "/api/users/*", loadOnStartup = 1)
public class UserServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pathInfo = req.getPathInfo();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (pathInfo == null || pathInfo.equals("/")) {
            // Listar todos os usuários
            List<User> users = userService.findAll();
            String json = toJson(users);
            resp.getWriter().write(json);
        } else {
            // Buscar por ID
            Long id = Long.parseLong(pathInfo.substring(1));
            User user = userService.findById(id);
            if (user != null) {
                resp.getWriter().write(toJson(user));
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("{\"error\": \"User not found\"}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String body = req.getReader().lines().collect(Collectors.joining());
        User user = fromJson(body, User.class);
        User created = userService.create(user);

        resp.setStatus(HttpServletResponse.SC_CREATED);
        resp.getWriter().write(toJson(created));
    }
}
```

#### JSP + JSTL

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Lista de Produtos</title>
</head>
<body>
    <h1>Produtos Disponíveis</h1>

    <c:if test="${not empty products}">
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Preço</th>
                    <th>Categoria</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>
                            <fmt:formatNumber value="${product.price}"
                                            type="currency"
                                            currencyCode="BRL"/>
                        </td>
                        <td>${product.category.name}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty products}">
        <p>Nenhum produto encontrado.</p>
    </c:if>
</body>
</html>
```

#### EJB (Enterprise JavaBeans)

```java
import jakarta.ejb.*;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class OrderProcessorBean {

    @EJB
    private InventoryServiceBean inventoryService;

    @EJB
    private PaymentServiceBean paymentService;

    @Asynchronous
    @TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
    public void processOrderAsync(Order order) {
        inventoryService.reserveItems(order.getItems());
        paymentService.charge(order.getPayment());
        sendConfirmationEmail(order);
    }

    @Lock(LockType.READ)
    @AccessTimeout(value = 5, unit = TimeUnit.SECONDS)
    public Order getOrderStatus(Long orderId) {
        return orderRepository.findById(orderId);
    }
}
```

#### JAX-RS (REST API)

```java
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;
import java.util.List;

@Path("/api/v1/products")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ProductResource {

    @Inject
    private ProductService productService;

    @GET
    public Response getAllProducts(
            @QueryParam("page") @DefaultValue("0") int page,
            @QueryParam("size") @DefaultValue("20") int size) {
        List<ProductDTO> products = productService.findAll(page, size);
        return Response.ok(products).build();
    }

    @GET
    @Path("/{id}")
    public Response getProductById(@PathParam("id") Long id) {
        ProductDTO product = productService.findById(id);
        if (product == null) {
            return Response.status(Response.Status.NOT_FOUND)
                .entity(new ErrorResponse("Product not found"))
                .build();
        }
        return Response.ok(product).build();
    }

    @POST
    public Response createProduct(CreateProductRequest request,
                                  @Context UriInfo uriInfo) {
        ProductDTO created = productService.create(request);
        UriBuilder builder = uriInfo.getAbsolutePathBuilder();
        builder.path(String.valueOf(created.getId()));
        return Response.created(builder.build()).entity(created).build();
    }

    @PUT
    @Path("/{id}")
    public Response updateProduct(@PathParam("id") Long id,
                                   UpdateProductRequest request) {
        ProductDTO updated = productService.update(id, request);
        return Response.ok(updated).build();
    }

    @DELETE
    @Path("/{id}")
    public Response deleteProduct(@PathParam("id") Long id) {
        productService.delete(id);
        return Response.noContent().build();
    }
}
```

#### JMS (Java Message Service)

```java
import jakarta.annotation.Resource;
import jakarta.jms.*;

@MessageDriven(name = "OrderNotificationMDB",
              activationConfig = {
                  @ActivationConfigProperty(
                      propertyName = "destination",
                      propertyValue = "queue/order-notifications"),
                  @ActivationConfigProperty(
                      propertyName = "destinationType",
                      propertyValue = "jakarta.jms.Queue")
              })
public class OrderNotificationMDB implements MessageListener {

    @Resource(lookup = "ConnectionFactory")
    private ConnectionFactory connectionFactory;

    @Resource(lookup = "queue/order-notifications")
    private Queue orderQueue;

    @Override
    public void onMessage(Message message) {
        try {
            if (message instanceof TextMessage textMessage) {
                String orderJson = textMessage.getText();
                Order order = objectMapper.readValue(orderJson, Order.class);

                processOrderNotification(order);

                System.out.println("Order processed: " + order.getId());
            }
        } catch (JMSException | JsonProcessingException e) {
            throw new RuntimeException("Failed to process message", e);
        }
    }

    private void processOrderNotification(Order order) {
        emailService.sendOrderConfirmation(order);
        inventoryService.reserveItems(order.getItems());
    }
}
```

### Melhores Práticas Jakarta EE
- ✅ Use **Servlets** apenas quando necessário (prefira JAX-RS/Spring MVC)
- ✅ Use **EJB** para transações complexas em aplicações monolíticas
- ✅ Use **JMS** para comunicação assíncrona entre sistemas
- ✅ Prefira **JAX-RS** sobre Servlets para REST APIs
- ✅ Use **JSTL** em JSPs (nunca scriptlets)
- ❌ Não misture lógica de negócio em Servlets/JSPs
- ❌ Não use EJB para tudo (overhead desnecessário)

---

## 4. 🧰 Outros Frameworks

### 4.1 Apache Commons

#### O que é
Biblioteca de utilitários genéricos para Java. Oferece Classes, Lang, Collections, IO, e muitos outros módulos.

#### Configuração
```xml
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-lang3</artifactId>
    <version>3.14.0</version>
</dependency>
```

#### Uso Prático

```java
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.time.DateFormatUtils;

public class CommonsExamples {

    // StringUtils - Manipulação de strings
    public void stringExamples() {
        String result = StringUtils.defaultIfBlank("  ", "default");  // "default"
        boolean isEmpty = StringUtils.isEmpty("  ");                   // false
        boolean isBlank = StringUtils.isBlank("  ");                   // true
        String padded = StringUtils.leftPad("42", 5, '0');           // "00042"
        String reversed = StringUtils.reverse("hello");               // "olleh"
        List<String> list = StringUtils.splitPreserveAllTokens("a,,b,", ","); // ["a","","b",""]
    }

    // CollectionUtils - Operações com coleções
    public void collectionExamples() {
        List<String> list = List.of("a", "b", "c");
        boolean isEmpty = CollectionUtils.isEmpty(null);              // true
        boolean contains = CollectionUtils.contains(list, "b");       // true
        List<String> merged = CollectionUtils.union(list, List.of("d")); // [a,b,c,d]
        List<String> intersection = CollectionUtils.intersection(list, List.of("b", "c", "d")); // [b,c]
    }

    // FileUtils - Operações com arquivos
    public void fileExamples() throws IOException {
        String content = FileUtils.readFileToString(new File("data.txt"), StandardCharsets.UTF_8);
        FileUtils.writeStringToFile(new File("output.txt"), "Hello", StandardCharsets.UTF_8);
        FileUtils.copyDirectory(new File("src"), new File("dest"));
        FileUtils.deleteDirectory(new File("temp"));
        Collection<File> files = FileUtils.listFiles(new File("docs"), new String[]{"pdf"}, true);
    }

    // DateUtils
    public void dateExamples() {
        String formatted = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
        Date parsed = DateUtils.parseDate("2024-01-15", new String[]{"yyyy-MM-dd"});
        boolean isDate = DateUtils.isDate("2024-01-15", new String[]{"yyyy-MM-dd"});
    }
}
```

---

### 4.2 Google Guava

#### O que é
Biblioteca Google para coleções, caching, hashing, reflexão, e utilitários IO. Uma das bibliotecas Java mais utilizadas.

#### Configuração
```xml
<dependency>
    <groupId>com.google.guava</groupId>
    <artifactId>guava</artifactId>
    <version>33.2.0-jre</version>
</dependency>
```

#### Uso Prático

```java
import com.google.common.base.Preconditions;
import com.google.common.collect.*;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.google.common.hash.Hashing;
import com.google.common.io.Files;
import com.google.common.util.concurrent.RateLimiter;

public class GuavaExamples {

    // Collections avançadas
    public void collectionExamples() {
        // Immutable collections
        ImmutableList<String> immutable = ImmutableList.of("a", "b", "c");

        // Multimap
        Multimap<String, Integer> multimap = ArrayListMultimap.create();
        multimap.put("fruits", 1);
        multimap.put("fruits", 2);
        multimap.put("vegetables", 3);

        // BiMap
        BiMap<String, Integer> biMap = HashBiMap.create();
        biMap.put("one", 1);
        String key = biMap.inverse().get(1);  // "one"

        // Table
        Table<String, String, Integer> table = HashBasedTable.create();
        table.put("row1", "col1", 100);
        table.put("row1", "col2", 200);
        Map<String, Integer> row1 = table.row("row1");

        // Range
        Range<Integer> range = Range.closed(1, 100);
        boolean contains = range.contains(50);  // true
    }

    // Cache
    public void cacheExample() {
        LoadingCache<String, User> userCache = CacheBuilder.newBuilder()
            .maximumSize(1000)
            .expireAfterWrite(Duration.ofMinutes(10))
            .recordStats()
            .build(new CacheLoader<>() {
                @Override
                public User load(String username) {
                    return userRepository.findByUsername(username)
                        .orElseThrow(() -> new UserNotFoundException(username));
                }
            });

        User user = userCache.get("john_doe");
        CacheStats stats = userCache.stats();
    }

    // Preconditions
    public void preconditionExamples(String name, int age) {
        Preconditions.checkNotNull(name, "Name must not be null");
        Preconditions.checkArgument(age >= 0, "Age must be positive, got: %s", age);
        Preconditions.checkState(age >= 18, "Must be at least 18 years old");
    }

    // RateLimiter
    public void rateLimiterExample() {
        RateLimiter limiter = RateLimiter.create(10.0); // 10 requests per second

        for (int i = 0; i < 100; i++) {
            limiter.acquire(); // Blocks until a permit is available
            processRequest(i);
        }
    }

    // Hashing
    public void hashingExample() {
        String hash = Hashing.sha256().hashString(StandardCharsets.UTF_8).toString();
        byte[] md5 = Hashing.md5().hashBytes(data).asBytes();
    }
}
```

---

### 4.3 Lombok

#### O que é
Biblioteca que reduz boilerplate Java gerando automaticamente getters, setters, constructors, builders, etc. via anotações em tempo de compilação.

#### Configuração
```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.32</version>
    <scope>provided</scope>
</dependency>
```

#### Uso Prático

```java
import lombok.*;
import lombok.extern.slf4j.Slf4j;

@Data                           // Gera getters, setters, equals, hashCode, toString
@Builder                        // Gera Builder pattern
@NoArgsConstructor              // Gera construtor sem argumentos
@AllArgsConstructor             // Gera construtor com todos os argumentos
@ToString(callSuper = true)     // Inclui campos da classe pai
@EqualsAndHashCode(callSuper = true)
@Slf4j                          // Gera logger estático
public class User extends BaseEntity {

    @NonNull                    // Gera null check no construtor
    private String name;

    @NonNull
    private String email;

    @Getter(AccessLevel.NONE)   // Não gera getter para password
    @Setter(AccessLevel.NONE)   // Não gera setter para password
    private String password;

    @Builder.Default             // Valor padrão no builder
    private boolean active = true;

    @Singular                     // Builder para coleções
    private List<String> roles;

    @Value                        // Classe imutável (tudo final)
    public static class UserDTO {
        private Long id;
        private String name;
        private String email;
    }

    // Método customizado com Lombok
    @Generated
    public String getDisplayName() {
        return name + " <" + email + ">";
    }
}

// Usando o builder
User user = User.builder()
    .name("João Silva")
    .email("joao@example.com")
    .password("secret123")
    .role("ADMIN")
    .role("USER")
    .build();
```

---

### 4.4 MapStruct

#### O que é
Gerador de código para mapeamento entre beans Java. Compara com o ModelMapper mas gera código estático e tipado em tempo de compilação.

#### Configuração
```xml
<dependency>
    <groupId>org.mapstruct</groupId>
    <artifactId>mapstruct</artifactId>
    <version>1.6.0</version>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok-mapstruct-binding</artifactId>
    <version>0.2.0</version>
</dependency>
```

#### Uso Prático

```java
import org.mapstruct.*;
import org.springframework.stereotype.Component;

@Mapper(componentModel = "spring",
        unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface UserMapper {

    @Mapping(source = "name", target = "fullName")
    @Mapping(source = "createdAt", target = "createdDate", dateFormat = "yyyy-MM-dd")
    @Mapping(target = "roles", expression = "java(user.getRoles().stream().map(Role::getName).toList())")
    UserDTO toDTO(User user);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(source = "fullName", target = "name")
    User toEntity(UserDTO dto);

    List<UserDTO> toDTOList(List<User> users);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void updateEntityFromDTO(UserDTO dto, @MappingTarget User user);
}

// Usando no Service
@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final UserRepository userRepository;

    public UserServiceImpl(UserMapper userMapper, UserRepository userRepository) {
        this.userMapper = userMapper;
        this.userRepository = userRepository;
    }

    public UserDTO create(CreateUserRequest request) {
        User user = userMapper.toEntity(request);
        User saved = userRepository.save(user);
        return userMapper.toDTO(saved);
    }

    public void update(Long id, UpdateUserRequest request) {
        User user = userRepository.findById(id).orElseThrow();
        userMapper.updateEntityFromDTO(request, user);
        userRepository.save(user);
    }
}
```

---

### 4.5 Jackson

#### O que é
Biblioteca para serialização/deserialização JSON em Java. O padrão de facto para Spring Boot.

#### Configuração
```xml
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.17.0</version>
</dependency>
```

#### Uso Prático

```java
import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

public class JacksonExamples {

    // ObjectMapper configurado
    private final ObjectMapper objectMapper = new ObjectMapper()
        .registerModule(new JavaTimeModule())
        .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
        .setSerializationInclusion(JsonInclude.Include.NON_NULL)
        .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

    // Anotações no Model
    @JsonIgnoreProperties(ignoreUnknown = true)
    @JsonPropertyOrder({"id", "name", "email"})
    public static class UserDTO {
        private Long id;

        @JsonProperty("user_name")  // Mapeia para JSON "user_name"
        private String name;

        private String email;

        @JsonIgnore                 // Ignorado na serialização
        private String password;

        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        private LocalDateTime createdAt;

        @JsonAlias({"usr", "username"})  // Aceita múltiplos nomes na deserialização
        @JsonProperty("login")
        private String username;

        // Getters e Setters
    }

    // Uso do ObjectMapper
    public void serializationExample() throws JsonProcessingException {
        UserDTO user = new UserDTO();
        user.setId(1L);
        user.setName("João");
        user.setEmail("joao@example.com");

        String json = objectMapper.writeValueAsString(user);
        // {"id":1,"user_name":"João","email":"joao@example.com"}
    }

    public void deserializationExample() throws JsonProcessingException {
        String json = """
            {"id":1,"user_name":"João","email":"joao@example.com","created_at":"2024-01-15 10:30:00"}
            """;

        UserDTO user = objectMapper.readValue(json, UserDTO.class);
    }

    // Custom Serializer
    public static class MoneySerializer extends JsonSerializer<Money> {
        @Override
        public void serialize(Money value, JsonGenerator gen, SerializerProvider provider)
                throws IOException {
            gen.writeString(value.getAmount() + " " + value.getCurrency());
        }
    }

    @JsonSerialize(using = MoneySerializer.class)
    private Money price;
}
```

---

## 5. 🏗️ Arquitetura

### 5.1 Clean Architecture

#### O que é
Padrão arquitetural criado por Robert C. Martin que separa o software em **camadas concêntricas**: Entities → Use Cases → Interface Adapters → Frameworks & Drivers. O código depende das camadas internas, nunca das externas.

```
┌─────────────────────────────────────────┐
│           Frameworks & Drivers           │ ← Spring, Hibernate, DB
│  ┌───────────────────────────────────┐  │
│  │       Interface Adapters           │ ← Controllers, Presenters
│  │  ┌─────────────────────────────┐  │  │
│  │  │        Use Cases             │  │  ← Services (lógica de negócio)
│  │  │  ┌───────────────────────┐  │  │  │
│  │  │  │      Entities          │  │  │  ← Domain Models
│  │  │  └───────────────────────┘  │  │  │
│  │  └─────────────────────────────┘  │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

#### Estrutura de Projeto

```
src/main/java/com/example/
├── domain/                          ← Entidades e regras de negócio
│   ├── model/
│   │   ├── Order.java
│   │   ├── Product.java
│   │   └── Money.java
│   ├── repository/
│   │   ├── OrderRepository.java     ← Interface (contrato)
│   │   └── ProductRepository.java
│   └── service/
│       ├── OrderService.java        ← Interface
│       └── PricingService.java
│
├── application/                     ← Casos de uso
│   ├── usecase/
│   │   ├── CreateOrderUseCase.java
│   │   ├── GetOrderUseCase.java
│   │   └── CancelOrderUseCase.java
│   └── dto/
│       ├── CreateOrderRequest.java
│       └── OrderResponse.java
│
├── infrastructure/                  ← Implementações externas
│   ├── persistence/
│   │   ├── entity/
│   │   │   └── OrderEntity.java     ← JPA Entity
│   │   ├── repository/
│   │   │   └── OrderRepositoryImpl.java
│   │   └── mapper/
│   │       └── OrderMapper.java
│   ├── messaging/
│   │   └── KafkaEventPublisher.java
│   └── config/
│       └── DataSourceConfig.java
│
├── presentation/                    ← Camada de entrada
│   ├── controller/
│   │   └── OrderController.java
│   ├── dto/
│   │   ├── CreateOrderRequest.java
│   │   └── OrderResponse.java
│   └── exception/
│       └── GlobalExceptionHandler.java
│
└── Main.java
```

#### Exemplo Prático

```java
// DOMAIN - Entidade (pura, sem dependências externas)
public class Order {
    private final OrderId id;
    private final List<OrderItem> items;
    private final Money totalAmount;
    private OrderStatus status;

    public Order(OrderId id, List<OrderItem> items) {
        this.id = id;
        this.items = items;
        this.totalAmount = calculateTotal();
        this.status = OrderStatus.PENDING;
    }

    public void cancel() {
        if (status != OrderStatus.PENDING) {
            throw new OrderCannotBeCancelledException(id);
        }
        this.status = OrderStatus.CANCELLED;
    }

    private Money calculateTotal() {
        return items.stream()
            .map(OrderItem::getSubtotal)
            .reduce(Money.ZERO, Money::add);
    }
}

// DOMAIN - Interface de repositório
public interface OrderRepository {
    Order findById(OrderId id);
    List<Order> findAll();
    Order save(Order order);
    void delete(OrderId id);
}

// APPLICATION - Caso de uso
@Service
public class CreateOrderUseCase {

    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final EventPublisher eventPublisher;

    public CreateOrderUseCase(OrderRepository orderRepository,
                               ProductRepository productRepository,
                               EventPublisher eventPublisher) {
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
        this.eventPublisher = eventPublisher;
    }

    @Transactional
    public OrderResponse execute(CreateOrderRequest request) {
        // 1. Validação
        List<Product> products = productRepository.findByIds(request.productIds());

        // 2. Criação da entidade
        List<OrderItem> items = products.stream()
            .map(p -> new OrderItem(p.getId(), p.getPrice(), 1))
            .toList();
        Order order = new Order(OrderId.generate(), items);

        // 3. Persistência
        orderRepository.save(order);

        // 4. Publicação de evento
        eventPublisher.publish(new OrderCreatedEvent(order.getId()));

        // 5. Retorno
        return OrderResponse.from(order);
    }
}

// INFRASTRUCTURE - Implementação do repositório
@Repository
public class OrderRepositoryImpl implements OrderRepository {

    private final JpaOrderRepository jpaRepository;
    private final OrderMapper mapper;

    public OrderRepositoryImpl(JpaOrderRepository jpaRepository, OrderMapper mapper) {
        this.jpaRepository = jpaRepository;
        this.mapper = mapper;
    }

    @Override
    public Order findById(OrderId id) {
        OrderEntity entity = jpaRepository.findById(id.value())
            .orElseThrow(() -> new OrderNotFoundException(id));
        return mapper.toDomain(entity);
    }

    @Override
    public Order save(Order order) {
        OrderEntity entity = mapper.toEntity(order);
        return mapper.toDomain(jpaRepository.save(entity));
    }
}

// PRESENTATION - Controller
@RestController
@RequestMapping("/api/v1/orders")
public class OrderController {

    private final CreateOrderUseCase createOrderUseCase;
    private final GetOrderUseCase getOrderUseCase;

    public OrderController(CreateOrderUseCase createOrderUseCase,
                           GetOrderUseCase getOrderUseCase) {
        this.createOrderUseCase = createOrderUseCase;
        this.getOrderUseCase = getOrderUseCase;
    }

    @PostMapping
    public ResponseEntity<OrderResponse> createOrder(@Valid @RequestBody CreateOrderRequest request) {
        OrderResponse response = createOrderUseCase.execute(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponse> getOrder(@PathVariable Long id) {
        OrderResponse response = getOrderUseCase.execute(id);
        return ResponseEntity.ok(response);
    }
}
```

---

### 5.2 Hexagonal Architecture (Ports & Adapters)

#### O que é
Arquitetura onde o **core da aplicação** define **portas** (interfaces) e **adapters** implementam essas portas para se comunicar com o mundo exterior (DB, APIs, UI).

```
          ┌──────────────┐
          │   UI / REST  │
          │   (Adapter)  │
          └──────┬───────┘
                 │
                 ▼
    ┌────────────────────────┐
    │    Input Ports          │ ← Use Cases
    │  (Use Case Interface)  │
    └────────────┬───────────┘
                 │
    ┌────────────▼───────────┐
    │     Domain Core         │ ← Lógica de negócio pura
    │   (Entities, Rules)    │
    └────────────┬───────────┘
                 │
    ┌────────────▼───────────┐
    │    Output Ports         │ ← Repository Interfaces
    │  (Repository Interface)│
    └────────────┬───────────┘
                 │
          ┌──────┴───────┐
          │              │
   ┌──────▼──────┐ ┌────▼────────┐
   │  Database   │ │  Message    │
   │  (Adapter)  │ │  Queue      │
   └─────────────┘ └─────────────┘
```

#### Exemplo Prático

```java
// DOMAIN - Porta de entrada (Input Port)
public interface CreateOrderPort {
    OrderResponse createOrder(CreateOrderRequest request);
}

// DOMAIN - Porta de saída (Output Port)
public interface OrderPersistencePort {
    Order save(Order order);
    Optional<Order> findById(OrderId id);
}

// APPLICATION - Implementação da porta de entrada
@Service
public class CreateOrderAdapter implements CreateOrderPort {

    private final OrderPersistencePort persistencePort;
    private final NotificationPort notificationPort;

    public CreateOrderAdapter(OrderPersistencePort persistencePort,
                              NotificationPort notificationPort) {
        this.persistencePort = persistencePort;
        this.notificationPort = notificationPort;
    }

    @Override
    public OrderResponse createOrder(CreateOrderRequest request) {
        Order order = OrderFactory.create(request);
        Order saved = persistencePort.save(order);
        notificationPort.notifyOrderCreated(saved);
        return OrderResponse.from(saved);
    }
}

// INFRASTRUCTURE - Adapter de persistência (JPA)
@Repository
public class OrderJpaAdapter implements OrderPersistencePort {

    private final JpaOrderRepository jpaRepo;
    private final OrderMapper mapper;

    public OrderJpaAdapter(JpaOrderRepository jpaRepo, OrderMapper mapper) {
        this.jpaRepo = jpaRepo;
        this.mapper = mapper;
    }

    @Override
    public Order save(Order order) {
        OrderJpaEntity entity = mapper.toJpaEntity(order);
        return mapper.toDomain(jpaRepo.save(entity));
    }
}

// INFRASTRUCTURE - Adapter de notificação (Email)
@Component
public class EmailNotificationAdapter implements NotificationPort {

    private final JavaMailSender mailSender;

    public EmailNotificationAdapter(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    @Override
    public void notifyOrderCreated(Order order) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(order.getCustomerEmail());
        message.setSubject("Pedido #" + order.getId() + " criado");
        message.setText("Seu pedido foi processado com sucesso!");
        mailSender.send(message);
    }
}
```

---

### 5.3 DDD (Domain-Driven Design)

#### O que é
Abordagem de design de software que coloca o **domínio do negócio** no centro do desenvolvimento. Usa conceitos como Bounded Contexts, Aggregates, Value Objects, e Ubiquitous Language.

#### Conceitos-Chave

```java
// VALUE OBJECT - Imutável, identidade pelo valor
public record Money(BigDecimal amount, Currency currency) {

    public Money {
        if (amount == null || currency == null) {
            throw new IllegalArgumentException("Amount and currency must not be null");
        }
        if (amount.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Amount must not be negative");
        }
    }

    public static Money of(double amount, String currency) {
        return new Money(BigDecimal.valueOf(amount), Currency.getInstance(currency));
    }

    public Money add(Money other) {
        if (!this.currency.equals(other.currency)) {
            throw new CurrencyMismatchException(this.currency, other.currency);
        }
        return new Money(this.amount.add(other.amount), this.currency);
    }

    public Money multiply(int quantity) {
        return new Money(this.amount.multiply(BigDecimal.valueOf(quantity)), this.currency);
    }

    public static final Money ZERO = new Money(BigDecimal.ZERO, Currency.getInstance("BRL"));
}

// ENTITY - Identidade única
public class Product {
    private final ProductId id;
    private String name;
    private Money price;
    private ProductCategory category;

    public Product(ProductId id, String name, Money price, ProductCategory category) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.category = category;
    }

    public void updatePrice(Money newPrice) {
        if (newPrice.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
            throw new InvalidPriceException(newPrice);
        }
        this.price = newPrice;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Product product)) return false;
        return id.equals(product.id);
    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }
}

// AGGREGATE ROOT
public class Order {
    private final OrderId id;
    private List<OrderItem> items;
    private OrderStatus status;
    private Money totalAmount;
    private CustomerId customerId;

    // Aggregate Root controla a consistência
    public void addItem(Product product, int quantity) {
        if (status != OrderStatus.DRAFT) {
            throw new OrderCannotBeModifiedException(id);
        }
        OrderItem item = new OrderItem(product.getId(), product.getPrice(), quantity);
        items.add(item);
        recalculateTotal();
    }

    public void removeItem(ProductId productId) {
        if (status != OrderStatus.DRAFT) {
            throw new OrderCannotBeModifiedException(id);
        }
        items.removeIf(item -> item.productId().equals(productId));
        recalculateTotal();
    }

    public void submit() {
        if (items.isEmpty()) {
            throw new EmptyOrderException(id);
        }
        this.status = OrderStatus.SUBMITTED;
    }

    private void recalculateTotal() {
        this.totalAmount = items.stream()
            .map(OrderItem::subtotal)
            .reduce(Money.ZERO, Money::add);
    }
}

// DOMAIN EVENT
public record OrderCreatedEvent(
    OrderId orderId,
    CustomerId customerId,
    Money totalAmount,
    LocalDateTime occurredAt
) {
    public OrderCreatedEvent(OrderId orderId, CustomerId customerId, Money totalAmount) {
        this(orderId, customerId, totalAmount, LocalDateTime.now());
    }
}

// REPOSITORY Interface
public interface OrderRepository {
    Order findById(OrderId id);
    List<Order> findByStatus(OrderStatus status);
    Order save(Order order);
    void delete(OrderId id);
}

// DOMAIN SERVICE
public class PricingDomainService {

    public Money calculateDiscount(Order order, Customer customer) {
        Money total = order.getTotalAmount();
        if (customer.isPremium()) {
            return total.multiply(10).divide(100); // 10% discount
        }
        return Money.ZERO;
    }
}
```

**Bounded Contexts:**
```
┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐
│   Order Context   │  │  Inventory Context │  │  Payment Context  │
│                   │  │                   │  │                   │
│  - Order          │  │  - Product        │  │  - Payment        │
│  - OrderItem      │  │  - Stock          │  │  - Transaction    │
│  - CustomerId     │  │  - Warehouse      │  │  - Invoice        │
│                   │  │                   │  │                   │
│  PostgreSQL       │  │  MongoDB          │  │  PostgreSQL       │
└──────────────────┘  └──────────────────┘  └──────────────────┘
```

---

### 5.4 Microserviços

#### O que é
Arquitetura onde uma aplicação é composta por **serviços pequenos e independentes** que se comunicam via HTTP/gRPC ou mensagens.

#### Estrutura Típica

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Gateway    │────▶│   Auth      │────▶│   Users     │
│   (Spring   │     │   Service   │     │   Service   │
│    Cloud)   │     └─────────────┘     └──────┬──────┘
└──────┬──────┘                                │
       │                                  ┌────▼─────┐
       ├─────────────────────────────────▶│  Orders   │
       │                                  │  Service  │
       ├──────────────┐                   └────┬─────┘
       │              │                        │
  ┌────▼──────┐  ┌────▼──────┐          ┌─────▼──────┐
  │ Products  │  │ Payments  │          │ Inventory  │
  │ Service   │  │ Service   │          │ Service    │
  └───────────┘  └───────────┘          └────────────┘
```

#### Configuração com Spring Cloud

```yaml
# application.yml - API Gateway
spring:
  cloud:
    gateway:
      routes:
        - id: user-service
          uri: lb://user-service
          predicates:
            - Path=/api/v1/users/**
          filters:
            - StripPrefix=1
            - name: CircuitBreaker
              args:
                name: userServiceCB
                fallbackUri: forward:/fallback/users

        - id: order-service
          uri: lb://order-service
          predicates:
            - Path=/api/v1/orders/**
          filters:
            - StripPrefix=1

      default-filters:
        - name: Retry
          args:
            retries: 3
            methods: GET
            backoff:
              firstBackoff: 100ms
              maxBackoff: 500ms
              factor: 2
```

**Service Discovery:**
```java
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}

// Feign Client para comunicação entre serviços
@FeignClient(name = "user-service", fallbackFactory = UserServiceFallback.class)
public interface UserServiceClient {

    @GetMapping("/api/v1/users/{id}")
    UserDTO getUserById(@PathVariable("id") Long id);

    @PostMapping("/api/v1/users")
    UserDTO createUser(@RequestBody CreateUserRequest request);
}

@Component
public class UserServiceFallback implements FallbackFactory<UserServiceClient> {
    @Override
    public UserServiceClient create(Throwable cause) {
        return new UserServiceClient() {
            @Override
            public UserDTO getUserById(Long id) {
                return UserDTO.defaultValue(); // Fallback
            }

            @Override
            public UserDTO createUser(CreateUserRequest request) {
                throw new ServiceUnavailableException("User service unavailable", cause);
            }
        };
    }
}
```

**Circuit Breaker:**
```java
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import io.github.resilience4j.retry.annotation.Retry;
import io.github.resilience4j.bulkhead.annotation.Bulkhead;

@Service
public class OrderService {

    private final UserServiceClient userServiceClient;

    @CircuitBreaker(name = "userService", fallbackMethod = "getUserFallback")
    @Retry(name = "userService")
    @Bulkhead(name = "userService")
    public UserDTO getUser(Long userId) {
        return userServiceClient.getUserById(userId);
    }

    public UserDTO getUserFallback(Long userId, Throwable t) {
        log.warn("Fallback for user {}: {}", userId, t.getMessage());
        return UserDTO.defaultValue();
    }
}

# Circuit Breaker Config
resilience4j:
  circuitbreaker:
    instances:
      userService:
        slidingWindowSize: 10
        failureRateThreshold: 50
        waitDurationInOpenState: 10s
        permittedNumberOfCallsInHalfOpenState: 3
        automaticTransitionFromOpenToHalfOpenEnabled: true
  retry:
    instances:
      userService:
        maxAttempts: 3
        waitDuration: 500ms
```

---

### 5.5 Event-Driven Architecture

#### O que é
Arquitetura onde os componentes se comunicam por meio de **eventos** (mensagens assíncronas). O produtor emite eventos e consumidores reagem a eles, desacoplando os serviços.

#### Exemplo com Spring + Kafka

```java
// Evento
public record OrderCreatedEvent(
    String orderId,
    String customerId,
    List<String> productIds,
    BigDecimal totalAmount,
    LocalDateTime occurredAt
) {}

// Publisher
@Service
public class OrderEventPublisher {

    private final KafkaTemplate<String, Object> kafkaTemplate;

    public OrderEventPublisher(KafkaTemplate<String, Object> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    public void publishOrderCreated(OrderCreatedEvent event) {
        kafkaTemplate.send("order-events", event.orderId(), event)
            .addCallback(
                result -> log.info("Event published: {}", event.orderId()),
                ex -> log.error("Failed to publish event: {}", ex.getMessage())
            );
    }
}

// Consumer
@Service
public class OrderEventHandler {

    @KafkaListener(
        topics = "order-events",
        groupId = "inventory-service",
        containerFactory = "kafkaListenerContainerFactory"
    )
    public void handleOrderCreated(
            @Payload OrderCreatedEvent event,
            @Header(KafkaHeaders.RECEIVED_KEY) String key,
            Acknowledgment ack) {
        try {
            log.info("Processing order created: {}", event.orderId());

            // Reservar estoque
            for (String productId : event.productIds()) {
                inventoryService.reserve(productId, 1);
            }

            // Publicar evento de estoque reservado
            StockReservedEvent stockEvent = new StockReservedEvent(
                event.orderId(), event.productIds(), LocalDateTime.now()
            );
            kafkaTemplate.send("stock-events", event.orderId(), stockEvent);

            ack.acknowledge();
            log.info("Order processed successfully: {}", event.orderId());

        } catch (Exception e) {
            log.error("Failed to process order: {}", event.orderId(), e);
            // Dead Letter Queue ou retry
            kafkaTemplate.send("order-events-dlq", key, event);
            ack.acknowledge();
        }
    }
}

// Configuração
@Configuration
@EnableKafka
public class KafkaConfig {

    @Bean
    public NewTopic orderEventsTopic() {
        return TopicBuilder.name("order-events")
            .partitions(3)
            .replicas(3)
            .config(TopicConfig.REPLICATION_FACTOR_CONFIG, "3")
            .build();
    }

    @Bean
    public ConcurrentKafkaListenerContainerFactory<String, Object>
            kafkaListenerContainerFactory(
                ConsumerFactory<String, Object> consumerFactory) {

        ConcurrentKafkaListenerContainerFactory<String, Object> factory =
            new ConcurrentKafkaListenerContainerFactory<>();
        factory.setConsumerFactory(consumerFactory);
        factory.getContainerProperties().setAckMode(ContainerProperties.AckMode.MANUAL_IMMEDIATE);
        factory.setConcurrency(3);
        return factory;
    }
}
```

**Event Sourcing:**
```java
@Entity
@Table(name = "events")
public class DomainEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String aggregateId;

    @Column(nullable = false)
    private String eventType;

    @Column(nullable = false, columnDefinition = "jsonb")
    private String payload;

    @Column(nullable = false)
    private LocalDateTime timestamp;

    @Column(nullable = false)
    private int version;
}

@Service
public class OrderAggregate {

    private final EventStore eventStore;

    public Order createOrder(CreateOrderCommand command) {
        // 1. Validar
        validate(command);

        // 2. Criar entidade
        Order order = Order.create(command);

        // 3. Salvar evento
        DomainEvent event = new DomainEvent(
            order.getId(),
            "OrderCreated",
            objectMapper.writeValueAsString(order),
            LocalDateTime.now(),
            1
        );
        eventStore.save(event);

        return order;
    }

    public Order loadOrder(String orderId) {
        List<DomainEvent> events = eventStore.findByAggregateId(orderId);
        Order order = Order.empty();
        for (DomainEvent event : events) {
            order.apply(event);
        }
        return order;
    }
}
```

#### Melhores Práticas Arquiteturais
- ✅ **Clean Architecture**: Separe domínio de infraestrutura
- ✅ **DDD**: Modele o domínio com precisão
- ✅ **Microserviços**: Mantenha serviços pequenos e coesos
- ✅ **Event-Driven**: Use eventos para desacoplar serviços
- ✅ **Circuit Breaker**: Proteja contra falhas em cascata
- ✅ **Idempotência**: Torne operações idempotentes
- ✅ **Observabilidade**: Logs, métricas, tracing (OpenTelemetry)
- ❌ Não crie microserviços sem necessidade
- ❌ Não ignore a consistência eventual
- ❌ Não acople serviços diretamente

---

## 📊 Tabela Comparativa de Frameworks

| Framework | Uso Principal | Complexidade | Curva de Aprendizado | Comunidade |
|-----------|---------------|--------------|----------------------|------------|
| **Spring Boot** | APIs REST, Web | ⭐⭐⭐ | ⭐⭐⭐ | 🔥🔥🔥🔥🔥 |
| **Spring Security** | Autenticação/Autorização | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 🔥🔥🔥🔥🔥 |
| **Hibernate/JPA** | Persistência de dados | ⭐⭐⭐ | ⭐⭐⭐ | 🔥🔥🔥🔥 |
| **Jakarta EE** | Aplicações corporativas | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 🔥🔥🔥 |
| **Lombok** | Redução de boilerplate | ⭐ | ⭐ | 🔥🔥🔥🔥 |
| **MapStruct** | Mapeamento de objetos | ⭐⭐ | ⭐⭐ | 🔥🔥🔥 |
| **Jackson** | Serialização JSON | ⭐⭐ | ⭐⭐ | 🔥🔥🔥🔥🔥 |
| **Guava** | Utilitários | ⭐⭐ | ⭐⭐ | 🔥🔥🔥🔥 |
| **Apache Commons** | Utilitários | ⭐⭐ | ⭐⭐ | 🔥🔥🔥🔥 |

---

## 🔗 Referências Oficiais

| Recurso | URL |
|---------|-----|
| Spring Framework | https://spring.io/projects/spring-framework |
| Spring Boot | https://spring.io/projects/spring-boot |
| Spring Security | https://spring.io/projects/spring-security |
| Spring Data | https://spring.io/projects/spring-data |
| Hibernate | https://hibernate.org/ |
| Jakarta EE | https://jakarta.ee/ |
| Lombok | https://projectlombok.org/ |
| MapStruct | https://mapstruct.org/ |
| Jackson | https://github.com/FasterXML/jackson |
| Google Guava | https://github.com/google/guava |
| Apache Commons | https://commons.apache.org/ |
| Flyway | https://flywaydb.org/ |
| Liquibase | https://www.liquibase.org/ |

---

> **📝 Nota:** Este guia é uma referência abrangente, mas não substitui a prática. Recomenda-se criar projetos-piloto para cada framework antes de usá-los em produção.
