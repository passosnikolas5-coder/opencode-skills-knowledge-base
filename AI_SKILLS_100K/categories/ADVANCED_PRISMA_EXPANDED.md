# 🟣 PRISMA AVANÇADO — Skills Completas

**Fonte:** https://github.com/prisma/prisma (45k+ stars)
**Descrição:** Prisma é um ORM (Object-Relational Mapping) de próxima geração para Node.js e TypeScript, oferecendo type-safety, migracões automáticas, e uma API intuitiva para trabalhar com bancos de dados SQL e NoSQL.

---

## 📋 Índice de Skills

1. [Schema — Modelos e Relações](#1-schema--modelos-e-relacoes)
2. [CRUD — Operações Básicas](#2-crud--operacoes-basicas)
3. [Filtros e Ordenação](#3-filtros-e-ordenacao)
4. [Paginação e Cursor](#4-paginação-e-cursor)
5. [Relações Avançadas](#5-relacoes-avancadas)
6. [Transações](#6-transacoes)
7. [Raw Queries](#7-raw-queries)
8. [Migrações](#8-migracoes)
9. [Seeding](#9-seeding)
10. [Database Views](#10-database-views)
11. [Multi-Schema Support](#11-multi-schema-support)
12. [CockroachDB e Diferentes Providers](#12-cockroachdb-e-diferentes-providers)
13. [Accelerate — Connection Pooling e Caching](#13-accelerate--connection-pooling-e-caching)
14. [Pulse — Eventos em Tempo Real](#14-pulse--eventos-em-tempo-real)
15. [Prisma Studio — Editor Visual](#15-prisma-studio--editor-visual)
16. [Performance e Otimização](#16-performance-e-otimizacao)
17. [Segurança e Best Practices](#17-seguranca-e-best-practices)
18. [Mensagens de Erro e Debugging](#18-mensagens-de-erro-e-debugging)
19. [Integração com Frameworks](#19-integracao-com-frameworks)
20. [CI/CD e Produção](#20-cicd-e-producao)

---

## 1. Schema — Modelos e Relações

### Definição de Modelos

```prisma
// prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id        String   @id @default(uuid())
  email     String   @unique
  name      String?
  role      Role     @default(USER)
  posts     Post[]
  profile   Profile?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@map("users")
  @@index([email])
}

model Post {
  id        String   @id @default(uuid())
  title     String
  content   String?
  published Boolean  @default(false)
  author    User     @relation(fields: [authorId], references: [id])
  authorId  String
  tags      Tag[]
  comments  Comment[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@index([authorId])
  @@index([published, createdAt])
}

model Profile {
  id     String  @id @default(uuid())
  bio    String?
  avatar String?
  user   User    @relation(fields: [userId], references: [id])
  userId String  @unique

  @@map("profiles")
}

model Tag {
  id    String @id @default(uuid())
  name  String @unique
  posts Post[]

  @@map("tags")
}

model Comment {
  id        String  @id @default(uuid())
  text      String
  post      Post    @relation(fields: [postId], references: [id])
  postId    String
  author    User?   @relation(fields: [authorId], references: [id])
  authorId  String?

  @@index([postId])
}

enum Role {
  USER
  EDITOR
  ADMIN
}
```

### MELHORIA — Schema Design

❌ **ERRADO:** Não definir índices para consultas frequentes
```prisma
// ❌ Consulta lenta sem índice
model Order {
  id     String @id
  userId String
  status String
  // Sem índice em userId
}
```

✅ **CORRETO:** Adicionar índices adequados
```prisma
// ✅ Com índices otimizados
model Order {
  id        String   @id
  userId    String
  status    String
  createdAt DateTime @default(now())

  @@index([userId])
  @@index([status])
  @@index([userId, status]) // Índice composto
  @@index([createdAt(sort: Desc)])
}
```

---

## 2. CRUD — Operações Básicas

```typescript
import { PrismaClient, Prisma } from "@prisma/client";

const prisma = new PrismaClient({
  log: ["query", "info", "warn", "error"],
});

// CREATE - Criar registro
const createUser = async (data: { email: string; name: string }) => {
  return prisma.user.create({
    data,
  });
};

// CREATE - Criar múltiplos registros
const createManyUsers = async (users: { email: string; name: string }[]) => {
  return prisma.user.createMany({
    data: users,
    skipDuplicates: true, // Ignorar duplicatas
  });
};

// READ - Buscar registro único
const findUserByEmail = async (email: string) => {
  return prisma.user.findUnique({
    where: { email },
    include: {
      profile: true,
      posts: {
        where: { published: true },
        orderBy: { createdAt: "desc" },
        take: 10,
      },
    },
  });
};

// READ - Buscar com condições
const findManyUsers = async (search?: string) => {
  const where: Prisma.UserWhereInput = search
    ? {
        OR: [
          { name: { contains: search, mode: "insensitive" } },
          { email: { contains: search, mode: "insensitive" } },
        ],
      }
    : {};

  return prisma.user.findMany({
    where,
    include: { profile: true },
    orderBy: { createdAt: "desc" },
  });
};

// UPDATE - Atualizar registro
const updateUser = async (id: string, data: Prisma.UserUpdateInput) => {
  return prisma.user.update({
    where: { id },
    data,
  });
};

// UPSERT - Criar ou atualizar
const upsertUser = async (email: string, data: Prisma.UserCreateInput) => {
  return prisma.user.upsert({
    where: { email },
    create: data,
    update: data,
  });
};

// DELETE - Deletar registro
const deleteUser = async (id: string) => {
  return prisma.user.delete({
    where: { id },
  });
};

// DELETE - Deletar múltiplos registros
const deleteInactiveUsers = async () => {
  return prisma.user.deleteMany({
    where: {
      posts: { none: {} },
      createdAt: { lt: new Date(Date.now() - 365 * 24 * 60 * 60 * 1000) },
    },
  });
};
```

### MELHORIA — Operações CRUD

❌ **ERRADO:** Não usar include/select adequadamente
```typescript
// ❌ Busca demais dados
const user = await prisma.user.findUnique({
  where: { id },
  include: {
    posts: true,
    comments: true,
    profile: true,
    // Inclui TUDO, mesmo desnecessário
  },
});
```

✅ **CORRETO:** Usar select para escolher campos específicos
```typescript
// ✅ Seleciona apenas o necessário
const user = await prisma.user.findUnique({
  where: { id },
  select: {
    id: true,
    name: true,
    email: true,
    posts: {
      select: {
        id: true,
        title: true,
        createdAt: true,
      },
      where: { published: true },
      take: 5,
    },
  },
});
```

---

## 3. Filtros e Ordenação

### Filtros Avançados

```typescript
// Filtro por múltiplos campos
const filterPosts = async (filters: {
  authorId?: string;
  published?: boolean;
  search?: string;
  startDate?: Date;
  endDate?: Date;
}) => {
  const where: Prisma.PostWhereInput = {};

  if (filters.authorId) {
    where.authorId = filters.authorId;
  }

  if (filters.published !== undefined) {
    where.published = filters.published;
  }

  if (filters.search) {
    where.OR = [
      { title: { contains: filters.search, mode: "insensitive" } },
      { content: { contains: filters.search, mode: "insensitive" } },
    ];
  }

  if (filters.startDate || filters.endDate) {
    where.createdAt = {};
    if (filters.startDate) where.createdAt.gte = filters.startDate;
    if (filters.endDate) where.createdAt.lte = filters.endDate;
  }

  return prisma.post.findMany({
    where,
    include: { author: { select: { id: true, name: true } } },
    orderBy: { createdAt: "desc" },
  });
};

// Filtros com relaciones
const searchUsersWithPosts = async (postTitle: string) => {
  return prisma.user.findMany({
    where: {
      posts: {
        some: {
          title: { contains: postTitle, mode: "insensitive" },
          published: true,
        },
      },
    },
    include: {
      posts: {
        where: { title: { contains: postTitle } },
        select: { id: true, title: true },
      },
    },
  });
};
```

### Ordenação Dinâmica

```typescript
type SortOrder = "asc" | "desc";

const getSortedUsers = async (
  sortBy: "name" | "email" | "createdAt",
  order: SortOrder = "desc"
) => {
  return prisma.user.findMany({
    orderBy: { [sortBy]: order },
  });
};

// Ordenação por múltiplos campos
const getSortedPosts = async () => {
  return prisma.post.findMany({
    orderBy: [
      { published: "desc" },
      { createdAt: "desc" },
      { title: "asc" },
    ],
  });
};
```

---

## 4. Paginação e Cursor

### Paginação Offset

```typescript
const getUsersPaginated = async (page: number = 1, pageSize: number = 20) => {
  const skip = (page - 1) * pageSize;

  const [users, total] = await prisma.$transaction([
    prisma.user.findMany({
      skip,
      take: pageSize,
      orderBy: { createdAt: "desc" },
      include: { profile: true },
    }),
    prisma.user.count(),
  ]);

  return {
    data: users,
    pagination: {
      page,
      pageSize,
      total,
      totalPages: Math.ceil(total / pageSize),
      hasNext: page * pageSize < total,
      hasPrev: page > 1,
    },
  };
};
```

### Paginação com Cursor

```typescript
const getUsersWithCursor = async (cursor?: string, limit: number = 20) => {
  const users = await prisma.user.findMany({
    take: limit + 1, // +1 para determinar se há mais
    cursor: cursor ? { id: cursor } : undefined,
    orderBy: { createdAt: "desc" },
    include: { profile: true },
  });

  const hasMore = users.length > limit;
  const data = hasMore ? users.slice(0, -1) : users;
  const nextCursor = hasMore ? data[data.length - 1].id : null;

  return {
    data,
    nextCursor,
    hasMore,
  };
};
```

### MELHORIA — Paginação

❌ **ERRADO:** Usar skip para páginas grandes
```typescript
// ❌ Performance degrada com skip grande
const users = await prisma.user.findMany({
  skip: 10000, // Offset alto é lento
  take: 20,
});
```

✅ **CORRETO:** Usar cursor para paginação eficiente
```typescript
// ✅ Cursor é consistente e rápido
const users = await prisma.user.findMany({
  take: 20,
  cursor: { id: lastSeenId },
  orderBy: { id: "asc" },
});
```

---

## 5. Relações Avançadas

### Relação Muitos-para-Muitos

```prisma
model Post {
  id    String @id @default(uuid())
  title String
  tags  Tag[] @relation("PostTags")
}

model Tag {
  id    String @id @default(uuid())
  name  String @unique
  posts Post[] @relation("PostTags")
}

// Tabela de junção explícita
model PostTag {
  postId String
  tagId  String
  post   Post @relation(fields: [postId], references: [id])
  tag    Tag  @relation(fields: [tagId], references: [id])

  @@id([postId, tagId])
}
```

### Operações com Relações

```typescript
// Criar com relações aninhadas
const createPostWithRelations = async (data: {
  title: string;
  content: string;
  authorId: string;
  tagNames: string[];
}) => {
  return prisma.post.create({
    data: {
      title: data.title,
      content: data.content,
      author: { connect: { id: data.authorId } },
      tags: {
        connectOrCreate: data.tagNames.map((name) => ({
          where: { name },
          create: { name },
        })),
      },
    },
    include: {
      author: true,
      tags: true,
    },
  });
};

// Atualizar relações
const addTagsToPost = async (postId: string, tagNames: string[]) => {
  return prisma.post.update({
    where: { id: postId },
    data: {
      tags: {
        connectOrCreate: tagNames.map((name) => ({
          where: { name },
          create: { name },
        })),
      },
    },
  });
};

// Remover relação
const removeTagFromPost = async (postId: string, tagId: string) => {
  return prisma.post.update({
    where: { id: postId },
    data: {
      tags: {
        disconnect: { id: tagId },
      },
    },
  });
};

// Consulta com relações complexas
const getPostsWithStats = async () => {
  return prisma.post.findMany({
    include: {
      author: {
        select: { id: true, name: true, email: true },
      },
      tags: true,
      _count: {
        select: { comments: true },
      },
    },
    orderBy: { createdAt: "desc" },
  });
};
```

### MELHORIA — Relações

❌ **ERRADO:** N+1 queries sem include
```typescript
// ❌ N+1 problem
const posts = await prisma.post.findMany();
for (const post of posts) {
  post.author = await prisma.user.findUnique({
    where: { id: post.authorId },
  });
}
```

✅ **CORRETO:** Usar include para eager loading
```typescript
// ✅ Eager loading com include
const posts = await prisma.post.findMany({
  include: {
    author: {
      select: { id: true, name: true },
    },
  },
});
```

---

## 6. Transações

### Transação Simples

```typescript
const transferBalance = async (
  fromId: string,
  toId: string,
  amount: number
) => {
  return prisma.$transaction(async (tx) => {
    const fromWallet = await tx.wallet.findUniqueOrThrow({
      where: { userId: fromId },
    });

    if (fromWallet.balance < amount) {
      throw new Error("Saldo insuficiente");
    }

    await tx.wallet.update({
      where: { userId: fromId },
      data: { balance: { decrement: amount } },
    });

    await tx.wallet.update({
      where: { userId: toId },
      data: { balance: { increment: amount } },
    });

    await tx.transactionLog.create({
      data: {
        fromId,
        toId,
        amount,
        type: "TRANSFER",
      },
    });

    return { success: true };
  });
};
```

### Transação Interativa (Batch)

```typescript
const batchUpdate = async () => {
  return prisma.$transaction(
    [
      prisma.user.update({
        where: { id: "user1" },
        data: { role: "EDITOR" },
      }),
      prisma.user.update({
        where: { id: "user2" },
        data: { role: "ADMIN" },
      }),
      prisma.user.update({
        where: { id: "user3" },
        data: { role: "USER" },
      }),
    ],
    {
      maxWait: 5000, // 5 segundos para obter transação
      timeout: 10000, // 10 segundos timeout
    }
  );
};

// Transação com isolamento
const isolatedTransaction = async () => {
  return prisma.$transaction(
    async (tx) => {
      // Operação serializável
      const order = await tx.$queryRaw`
        SELECT * FROM orders 
        WHERE id = ${orderId} 
        FOR UPDATE
      `;
      // Processar order...
    },
    {
      isolationLevel: "Serializable",
    }
  );
};
```

### MELHORIA — Transações

❌ **ERRADO:** Não usar transação para operações relacionadas
```typescript
// ❌ Não atômico
await prisma.user.update({ where: { id }, data: { balance: { decrement: 100 } } });
await prisma.transactionLog.create({ data: { type: "DEBIT", amount: 100 } });
// Se a segunda operação falhar, a primeira não é revertida
```

✅ **CORRETO:** Usar transação para garantir atomicidade
```typescript
// ✅ Atômico
await prisma.$transaction(async (tx) => {
  await tx.user.update({ where: { id }, data: { balance: { decrement: 100 } } });
  await tx.transactionLog.create({ data: { type: "DEBIT", amount: 100 } });
});
// Ambas as operações são commit ou rollback
```

---

## 7. Raw Queries

```typescript
// Query SQL bruta
const getRecentPosts = async (limit: number = 10) => {
  return prisma.$queryRaw`
    SELECT 
      p.id,
      p.title,
      p.content,
      u.name as author_name,
      u.email as author_email,
      p.created_at
    FROM posts p
    JOIN users u ON p.author_id = u.id
    WHERE p.published = true
    ORDER BY p.created_at DESC
    LIMIT ${limit}
  `;
};

// Query com parâmetros
const searchPosts = async (searchTerm: string, userId?: string) => {
  const whereClause = userId
    ? Prisma.sql`AND p.author_id = ${userId}`
    : Prisma.empty;

  return prisma.$queryRaw`
    SELECT 
      p.*,
      ts_rank(p.title, plainto_tsquery('portuguese', ${searchTerm})) as rank
    FROM posts p
    WHERE plainto_tsquery('portuguese', ${searchTerm}) @@ to_tsvector('portuguese', p.title)
    ${whereClause}
    ORDER BY rank DESC
    LIMIT 20
  `;
};

// Stored procedure
const calculateMonthlyReport = async (year: number, month: number) => {
  return prisma.$queryRaw`
    SELECT * FROM calculate_monthly_report(${year}, ${month})
  `;
};

// Query de agregação
const getPostStats = async () => {
  return prisma.$queryRaw`
    SELECT 
      u.id,
      u.name,
      COUNT(p.id) as total_posts,
      COUNT(CASE WHEN p.published THEN 1 END) as published_posts,
      AVG(LENGTH(p.content)) as avg_content_length
    FROM users u
    LEFT JOIN posts p ON u.id = p.author_id
    GROUP BY u.id, u.name
    ORDER BY total_posts DESC
  `;
};

// Raw query com $executeRaw
const updateBulkStatus = async (userIds: string[], status: string) => {
  return prisma.$executeRaw`
    UPDATE users 
    SET status = ${status}, updated_at = NOW()
    WHERE id IN (${Prisma.join(userIds)})
  `;
};
```

### MELHORIA — Raw Queries

❌ **ERRADO:** Usar template literals sem sanitização
```typescript
// ❌ Risco de SQL injection
const searchUsers = (term: string) => {
  return prisma.$queryRawUnsafe(
    `SELECT * FROM users WHERE name LIKE '%${term}%'`
  );
};
```

✅ **CORRETO:** Usar Prisma.sql para parâmetros
```typescript
// ✅ Seguro com parâmetros
const searchUsers = (term: string) => {
  return prisma.$queryRaw`
    SELECT * FROM users 
    WHERE name ILIKE ${`%${term}%`}
  `;
};
```

---

## 8. Migrações

### Criar Migração

```bash
# Criar migração
npx prisma migrate dev --name add_user_avatar

# Aplicar migrações em produção
npx prisma migrate deploy

# Reverter última migração
npx prisma migrate reset

# Status das migrações
npx prisma migrate status

# Gerar SQL da migração
npx prisma migrate diff --from-schema-datamodel prisma/schema.prisma --to-migrations
```

### Arquivo de Migração Gerado

```sql
-- migrations/20260915_add_user_avatar/migration.sql
ALTER TABLE "users" ADD COLUMN "avatar" TEXT;
ALTER TABLE "users" ADD COLUMN "bio" TEXT;
CREATE INDEX "users_email_idx" ON "users"("email");
```

### Migração Personalizada

```typescript
// migrations/20260915_data_migration/migration.ts
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  // Migração de dados
  const users = await prisma.user.findMany();

  for (const user of users) {
    const [firstName, ...lastNameParts] = user.name.split(" ");
    const lastName = lastNameParts.join(" ");

    await prisma.user.update({
      where: { id: user.id },
      data: {
        firstName,
        lastName,
      },
    });
  }

  console.log(`Migrados ${users.length} usuários`);
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
```

### MELHORIA — Migrações

❌ **ERRADO:** Ignorar migrações em produção
```bash
# ❌ Nunca fazer isso
npx prisma db push --accept-data-loss
```

✅ **CORRETO:** Usar migrate para todas as mudanças
```bash
# ✅ Criar e aplicar migrações
npx prisma migrate dev --name feature_name
npx prisma migrate deploy
```

---

## 9. Seeding

```typescript
// prisma/seed.ts
import { PrismaClient, Prisma } from "@prisma/client";
import { hash } from "bcryptjs";

const prisma = new PrismaClient();

async function main() {
  // Limpar dados existentes
  await prisma.comment.deleteMany();
  await prisma.post.deleteMany();
  await prisma.profile.deleteMany();
  await prisma.user.deleteMany();
  await prisma.tag.deleteMany();

  // Criar usuários
  const admin = await prisma.user.upsert({
    where: { email: "admin@example.com" },
    update: {},
    create: {
      email: "admin@example.com",
      name: "Admin User",
      role: "ADMIN",
      password: await hash("admin123", 12),
      profile: {
        create: {
          bio: "Administrador do sistema",
          avatar: "https://example.com/admin.jpg",
        },
      },
    },
  });

  const editor = await prisma.user.upsert({
    where: { email: "editor@example.com" },
    update: {},
    create: {
      email: "editor@example.com",
      name: "Editor User",
      role: "EDITOR",
      password: await hash("editor123", 12),
    },
  });

  const user = await prisma.user.upsert({
    where: { email: "user@example.com" },
    update: {},
    create: {
      email: "user@example.com",
      name: "Regular User",
      role: "USER",
      password: await hash("user123", 12),
    },
  });

  // Criar tags
  const tags = await Promise.all(
    ["JavaScript", "TypeScript", "React", "Node.js", "Prisma"].map((name) =>
      prisma.tag.upsert({
        where: { name },
        update: {},
        create: { name },
      })
    )
  );

  // Criar posts
  const posts = [
    {
      title: "Introdução ao Prisma",
      content: "Prisma é um ORM moderno para Node.js e TypeScript...",
      published: true,
      authorId: admin.id,
      tagNames: ["Prisma", "TypeScript", "Node.js"],
    },
    {
      title: "React Hooks Avançados",
      content: "Neste artigo, vamos explorar hooks avançados do React...",
      published: true,
      authorId: editor.id,
      tagNames: ["React", "JavaScript"],
    },
  ];

  for (const postData of posts) {
    const { tagNames, ...data } = postData;
    await prisma.post.create({
      data: {
        ...data,
        tags: {
          connectOrCreate: tagNames.map((name) => ({
            where: { name },
            create: { name },
          })),
        },
      },
    });
  }

  console.log("Seed concluído!");
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
```

### Configurar Seed no package.json

```json
{
  "prisma": {
    "seed": "ts-node prisma/seed.ts"
  }
}
```

### Executar Seed

```bash
# Executar seed
npx prisma db seed

# Resetar e seedar novamente
npx prisma migrate reset
npx prisma db seed
```

---

## 10. Database Views

```prisma
// Prisma suporta views como modelos
model PostStats {
  id           Int    @id
  authorId     String
  authorName   String
  postCount    Int
  publishedCount Int

  @@unique([authorId])
  @@map("post_stats_view")
}
```

### Criar View via Raw Query

```typescript
const createPostStatsView = async () => {
  await prisma.$executeRawUnsafe(`
    CREATE OR REPLACE VIEW post_stats_view AS
    SELECT 
      u.id as id,
      u.id as "authorId",
      u.name as "authorName",
      COUNT(p.id)::int as "postCount",
      COUNT(CASE WHEN p.published THEN 1 END)::int as "publishedCount"
    FROM users u
    LEFT JOIN posts p ON u.id = p.author_id
    GROUP BY u.id, u.name
  `);
};

// Usar a view
const getPostStats = async () => {
  return prisma.postStats.findMany();
};
```

---

## 11. Multi-Schema Support

```prisma
// prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id    String @id @default(uuid())
  email String @unique

  @@schema("public")
}

model Product {
  id    String @id @default(uuid())
  name  String

  @@schema("inventory")
}

model AuditLog {
  id   String @id @default(uuid())
  data Json

  @@schema("audit")
}
```

### Operações Multi-Schema

```typescript
// Query em schema específico
const getUsersFromPublic = async () => {
  return prisma.$queryRaw`SELECT * FROM public.users`;
};

const getProductsFromInventory = async () => {
  return prisma.$queryRaw`SELECT * FROM inventory.products`;
};

// Query combinada
const getUserPurchases = async (userId: string) => {
  return prisma.$queryRaw`
    SELECT 
      u.email,
      p.name as product_name
    FROM public.users u
    JOIN inventory.purchases pu ON u.id = pu.user_id
    JOIN inventory.products p ON pu.product_id = p.id
    WHERE u.id = ${userId}
  `;
};
```

---

## 12. CockroachDB e Diferentes Providers

### CockroachDB

```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "cockroachdb"
  url      = env("DATABASE_URL")
}

model Order {
  id        String   @id @default(gen_random_uuid())
  userId    String
  total     Decimal  @db.Decimal(10, 2)
  status    String
  createdAt DateTime @default(now()) @db.Timestamptz()

  @@index([userId])
}
```

### MySQL

```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "mysql"
  url      = env("DATABASE_URL")
}

model User {
  id    Int    @id @default(autoincrement())
  email String @unique @db.VarChar(255)
  name  String @db.VarChar(100)

  @@index([email])
}
```

### SQLite

```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "sqlite"
  url      = "file:./dev.db"
}

model Post {
  id        Int      @id @default(autoincrement())
  title     String
  content   String?
  createdAt DateTime @default(now())
}
```

---

## 13. Accelerate — Connection Pooling e Caching

```typescript
// Configurar Accelerate
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: process.env.ACCELERATE_URL, // URL do Accelerate
    },
  },
});

// O Accelerate gerencia connection pooling automaticamente
// e fornece cache global distribuído

// Configurar cache
const getCachedUser = async (id: string) => {
  return prisma.user.findUnique({
    where: { id },
    // Accelerate cache TTL configurado no painel
  });
};

// Invalidar cache
const invalidateCache = async (pattern: string) => {
  // Usar o API do Accelerate para invalidação
  const response = await fetch("https://api.prisma.io/accelerate/invalidate", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${process.env.ACCELERATE_API_KEY}`,
    },
    body: JSON.stringify({ pattern }),
  });
  return response.json();
};
```

### Benefícios do Accelerate

```typescript
// Conexões são gerenciadas pelo Accelerate
// - Connection pooling automático
// - Cache global distribuído
// - Prepared statements otimizados
// - Failover automático

// Não é necessário gerenciar conexões manualmente
const prisma = new PrismaClient(); // Accelerate lida com tudo
```

---

## 14. Pulse — Eventos em Tempo Real

```typescript
import { pulse } from "@prisma/pulse";

// Escutar mudanças em tabela específica
const watchOrders = async () => {
  const subscription = await pulse.order.create({
    name: "new-orders", // Nome da assinatura
    data: {
      create: true, // Escutar criações
      update: true, // Escutar atualizações
      delete: true, // Escutar exclusões
    },
  });

  for await (const event of subscription) {
    console.log("Evento:", event.action);
    console.log("Dados:", event.data);

    switch (event.action) {
      case "create":
        await sendNewOrderNotification(event.data);
        break;
      case "update":
        await updateOrderStatus(event.data);
        break;
      case "delete":
        await cleanupOrderResources(event.data);
        break;
    }
  }
};

// Escutar mudanças com filtros
const watchUserActivity = async (userId: string) => {
  const subscription = await pulse.post.create({
    name: "user-posts",
    data: {
      create: true,
      update: true,
    },
    where: {
      authorId: userId,
    },
  });

  for await (const event of subscription) {
    console.log(`Post ${event.action} por ${userId}`);
  }
};
```

---

## 15. Prisma Studio — Editor Visual

### Iniciar Prisma Studio

```bash
# Iniciar Prisma Studio
npx prisma studio

# Em porta específica
npx prisma studio --port 5556

# Com esquema específico
npx prisma studio --schema=./prisma/schema.prisma
```

### Funcionalidades

- **Visualização de dados:** Tabelas formatadas com todos os registros
- **Edição inline:** Editar valores diretamente na interface
- **Criação:** Adicionar novos registros via formulário
- **Exclusão:** Deletar registros com confirmação
- **Relações:** Navegar entre tabelas relacionadas
- **Filtros:** Buscar e filtrar dados
- **Export:** Exportar dados em JSON

---

## 16. Performance e Otimização

### Otimização de Consultas

```typescript
// Usar findMany com take para limitar resultados
const recentPosts = await prisma.post.findMany({
  take: 10,
  orderBy: { createdAt: "desc" },
  select: {
    id: true,
    title: true,
    createdAt: true,
  },
});

// Usar count em vez de findMany + length
const totalPosts = await prisma.post.count({
  where: { published: true },
});

// Usar aggregate para cálculos
const stats = await prisma.post.aggregate({
  _count: { id: true },
  _avg: { views: true },
  _sum: { likes: true },
  where: { published: true },
});

// Usar groupBy para agrupamento
const postsByAuthor = await prisma.post.groupBy({
  by: ["authorId"],
  _count: { id: true },
  where: { published: true },
  orderBy: { _count: { id: "desc" } },
});
```

### Gerenciamento de Conexões

```typescript
import { PrismaClient } from "@prisma/client";

// Singleton pattern para produção
const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined;
};

export const prisma =
  globalForPrisma.prisma ??
  new PrismaClient({
    log: process.env.NODE_ENV === "development" ? ["query"] : [],
  });

if (process.env.NODE_ENV !== "production") globalForPrisma.prisma = prisma;

// Fechar conexão graceful shutdown
process.on("beforeExit", async () => {
  await prisma.$disconnect();
});
```

### MELHORIA — Performance

❌ **ERRADO:** Criar novo PrismaClient a cada requisição
```typescript
// ❌ Resource leak
app.get("/users", async (req, res) => {
  const prisma = new PrismaClient(); // Conexão não fechada
  const users = await prisma.user.findMany();
  res.json(users);
});
```

✅ **CORRETO:** Usar singleton pattern
```typescript
// ✅ Conexão reutilizada
import { prisma } from "./lib/prisma";

app.get("/users", async (req, res) => {
  const users = await prisma.user.findMany();
  res.json(users);
});
```

---

## 17. Segurança e Best Practices

### Prevenção de SQL Injection

```typescript
// ✅ Prisma previne SQL injection automaticamente
const searchUsers = async (term: string) => {
  return prisma.user.findMany({
    where: {
      name: { contains: term, mode: "insensitive" },
    },
  });
};

// ✅ Raw queries seguras
const safeSearch = async (term: string) => {
  return prisma.$queryRaw`
    SELECT * FROM users 
    WHERE name ILIKE ${`%${term}%`}
  `;
};
```

### Validação de Dados

```typescript
import { z } from "zod";
import { Prisma } from "@prisma/client";

// Schema de validação com Zod
const createUserSchema = z.object({
  email: z.string().email("Email inválido"),
  name: z.string().min(2, "Nome deve ter pelo menos 2 caracteres"),
  password: z.string().min(8, "Senha deve ter pelo menos 8 caracteres"),
});

// Validar antes de criar
const createUserSafe = async (data: unknown) => {
  const validatedData = createUserSchema.parse(data);

  const hashedPassword = await hash(validatedData.password, 12);

  return prisma.user.create({
    data: {
      ...validatedData,
      password: hashedPassword,
    },
  });
};
```

### Variáveis de Ambiente

```env
# .env
DATABASE_URL="postgresql://user:password@localhost:5432/mydb?schema=public"
DIRECT_URL="postgresql://user:password@localhost:5432/mydb?schema=public"

# Para Accelerate
ACCELERATE_URL="prisma://accelerate.prisma-data.net/?api_key=..."
ACCELERATE_API_KEY="..."
```

### MELHORIA — Segurança

❌ **ERRADO:** Hardcoded credentials no schema
```prisma
// ❌ Nunca fazer isso
datasource db {
  provider = "postgresql"
  url      = "postgresql://admin:password123@localhost:5432/mydb"
}
```

✅ **CORRETO:** Usar variáveis de ambiente
```prisma
// ✅ Usar env()
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}
```

---

## 18. Mensagens de Erro e Debugging

### Erros Comuns e Soluções

```typescript
// Erro: Record to update not found
try {
  await prisma.user.update({
    where: { id: "nonexistent" },
    data: { name: "New Name" },
  });
} catch (error) {
  if (error instanceof Prisma.PrismaClientKnownRequestError) {
    if (error.code === "P2025") {
      console.error("Registro não encontrado");
    }
  }
}

// Erro: Unique constraint violation
try {
  await prisma.user.create({
    data: { email: "existing@email.com", name: "Test" },
  });
} catch (error) {
  if (error instanceof Prisma.PrismaClientKnownRequestError) {
    if (error.code === "P2002") {
      console.error("Email já existe");
    }
  }
}

// Erro: Foreign key constraint
try {
  await prisma.post.create({
    data: {
      title: "Test",
      authorId: "nonexistent-user",
    },
  });
} catch (error) {
  if (error instanceof Prisma.PrismaClientKnownRequestError) {
    if (error.code === "P2003") {
      console.error("Usuário não existe");
    }
  }
}
```

### Logging e Debugging

```typescript
const prisma = new PrismaClient({
  log: [
    { level: "query", emit: "event" },
    { level: "error", emit: "stdout" },
    { level: "warn", emit: "stdout" },
  ],
});

// Log de queries
prisma.$on("query", (e) => {
  console.log("Query: " + e.query);
  console.log("Duração: " + e.duration + "ms");
  console.log("Params: " + e.params);
});
```

---

## 19. Integração com Frameworks

### Next.js

```typescript
// lib/prisma.ts
import { PrismaClient } from "@prisma/client";

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined;
};

export const prisma = globalForPrisma.prisma ?? new PrismaClient();

if (process.env.NODE_ENV !== "production") globalForPrisma.prisma = prisma;

// app/api/users/route.ts
import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";

export async function GET() {
  const users = await prisma.user.findMany();
  return NextResponse.json(users);
}
```

### Express.js

```typescript
import express from "express";
import { PrismaClient } from "@prisma/client";

const app = express();
const prisma = new PrismaClient();

// Middleware de erro
const errorHandler = (err: Error, req: any, res: any, next: any) => {
  console.error(err.stack);
  res.status(500).json({ error: "Erro interno" });
};

app.use(errorHandler);

app.get("/users", async (req, res) => {
  const users = await prisma.user.findMany();
  res.json(users);
});

app.listen(3000, () => {
  console.log("Servidor rodando na porta 3000");
});
```

### Fastify

```typescript
import Fastify from "fastify";
import { PrismaClient } from "@prisma/client";

const fastify = Fastify({ logger: true });
const prisma = new PrismaClient();

fastify.get("/users", async () => {
  return prisma.user.findMany();
});

fastify.listen({ port: 3000 }, (err) => {
  if (err) {
    fastify.log.error(err);
    process.exit(1);
  }
});
```

---

## 20. CI/CD e Produção

### GitHub Actions

```yaml
# .github/workflows/prisma.yml
name: Prisma CI/CD

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  prisma:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:14
        env:
          POSTGRES_USER: test
          POSTGRES_PASSWORD: test
          POSTGRES_DB: test
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: 18
          
      - name: Install dependencies
        run: npm ci
        
      - name: Generate Prisma Client
        run: npx prisma generate
        
      - name: Run migrations
        run: npx prisma migrate deploy
        env:
          DATABASE_URL: postgresql://test:test@localhost:5432/test
          
      - name: Run seed
        run: npx prisma db seed
        env:
          DATABASE_URL: postgresql://test:test@localhost:5432/test
          
      - name: Run tests
        run: npm test
        env:
          DATABASE_URL: postgresql://test:test@localhost:5432/test
```

### Docker

```dockerfile
# Dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY prisma ./prisma/
RUN npx prisma generate

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

### docker-compose.yml

```yaml
version: "3.8"

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      DATABASE_URL: postgresql://postgres:postgres@db:5432/mydb
    depends_on:
      db:
        condition: service_healthy

  db:
    image: postgres:14-alpine
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
```

---

## 📚 Referências e Recursos

- [Documentação oficial Prisma](https://www.prisma.io/docs)
- [Prisma GitHub](https://github.com/prisma/prisma)
- [Prisma Data Platform](https://www.prisma.io/data-platform)
- [Prisma Examples](https://github.com/prisma/prisma-examples)
- [Prisma Blog](https://www.prisma.io/blog)
- [Prisma Slack](https://slack.prisma.io/)

---

**Última atualização:** Setembro 2026
**Versão do Prisma:** 6.x+
**Compatibilidade:** Node.js 18+, TypeScript 5.x+
