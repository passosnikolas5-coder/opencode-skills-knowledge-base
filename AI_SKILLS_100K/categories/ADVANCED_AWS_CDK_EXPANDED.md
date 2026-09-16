# ☁️ AWS CDK AVANÇADO — Cloud Development Kit

**Fonte:** https://github.com/aws/aws-cdk (13k+ stars)
**Descrição:** AWS CDK (Cloud Development Kit) é um framework de código para definir infraestrutura de nuvem AWS usando linguagens de programação familiares como TypeScript, Python, Java e Go.

---

## 1. Stacks — Estrutura Base

```typescript
import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';

export class MyStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    new cdk.aws_s3.Bucket(this, 'MyBucket', {
      bucketName: 'meu-bucket-unico-123',
      versioned: true,
      encryption: cdk.aws_s3.BucketEncryption.S3_MANAGED,
    });
  }
}

const app = new cdk.App();
new MyStack(app, 'ProductionStack', {
  env: { account: '123456789012', region: 'us-east-1' },
});
```

**❌ ERRADO:** Criar stacks sem definir account/region explicitamente.
**✅ CORRETO:** Sempre especificar environment para evitar conflitos.

---

## 2. Constructs — L1, L2 e L3

```typescript
// L1 (Cfn*) - Mapeamento direto do CloudFormation
new cdk.aws_lambda.CfnFunction(this, 'RawLambda', {
  functionName: 'minha-funcao',
  runtime: 'python3.9',
  handler: 'index.handler',
  code: 'lambda/',
});

// L2 (Abstrações) - Recomendado
const fn = new cdk.aws_lambda.Function(this, 'MyLambda', {
  functionName: 'minha-funcao',
  runtime: cdk.aws_lambda.Runtime.PYTHON_3_9,
  handler: 'index.handler',
  code: cdk.aws_lambda.Code.fromAsset('lambda/'),
});

// L3 (Patterns) - Soluções completas
new cdk.aws_apigateway.LambdaRestApi(this, 'MyApi', {
  handler: fn,
});
```

**❌ ERRADO:** Usar L1 (Cfn*) para tudo, perdendo abstrações.
**✅ CORRETO:** Preferir L2/L3 para produtividade e melhores práticas.

---

## 3. CDK CLI — Comandos Essenciais

```bash
cdk init app --language typescript    # Inicia novo projeto
cdk bootstrap                         # Configura recursos CDK na conta
cdk synth                             # Gera template CloudFormation
cdk diff                              # Compara com deploy atual
cdk deploy                            # Faz deploy da stack
cdk destroy                           # Destrói a stack
cdk list                              # Lista todas as stacks
cdk context --reset                   # Limpa cache de contexto
cdk doctor                            # Verifica configuração
```

**❌ ERRADO:** Não rodar bootstrap antes do primeiro deploy.
**✅ CORRETO:** Executar cdk bootstrap para criar buckets e roles necessárias.

---

## 4. CDK Pipelines — CI/CD Nativo

```typescript
import { CodePipeline, CodePipelineSource, ShellStep } from 'aws-cdk-lib/pipelines';

const pipeline = new CodePipeline(this, 'Pipeline', {
  pipelineName: 'MeuPipeline',
  synth: new ShellStep('Synth', {
    input: CodePipelineSource.gitHub('org/repo', 'main'),
    commands: ['npm ci', 'npm run build', 'npx cdk synth'],
  }),
});

// Stage de produção
pipeline.addStage(new MyApplicationStage(this, 'Production', {
  env: { account: '123456789012', region: 'us-east-1' },
}));
```

**❌ ERRADO:** Não usar pipelines para deploy automatizado.
**✅ CORRETO:** Usar CDK Pipelines para CI/CD com approvação manual em produção.

---

## 5. Aspects — Validação e Tagging

```typescript
import { IAspect, IConstruct } from 'aws-cdk-lib';

// Aspect para forçar tags em todos os recursos
class AddEnvironmentTag implements IAspect {
  visit(node: IConstruct) {
    if (cdk.CfnResource.isCfnResource(node)) {
      node.addPropertyOverride('Tags', [
        { Key: 'Environment', Value: 'production' },
        { Key: 'ManagedBy', Value: 'CDK' },
      ]);
    }
  }
}

cdk.Aspects.of(this).add(new AddEnvironmentTag());
```

**❌ ERRADO:** Adicionar tags manualmente em cada recurso.
**✅ CORRETO:** Usar Aspects para aplicar tags e validações globalmente.

---

## 6. Context e Context Values

```typescript
// Usando context values
const isProd = this.node.tryGetContext('isProd') === 'true';

new cdk.aws_ec2.Instance(this, 'Instance', {
  instanceType: isProd 
    ? cdk.aws_ec2.InstanceType.of(cdk.aws_ec2.InstanceClass.M5, cdk.aws_ec2.InstanceSize.LARGE)
    : cdk.aws_ec2.InstanceType.of(cdk.aws_ec2.InstanceClass.T3, cdk.aws_ec2.InstanceSize.MICRO),
});

// cdk.json
{
  "context": {
    "isProd": "true",
    "environment": "production"
  }
}
```

**❌ ERRADO:** Não usar context para ambientes diferentes.
**✅ CORRETO:** Parametrizar com context para flexibilidade entre dev/prod.

---

## 7. Assets — Código e Arquivos

```typescript
// Lambda com código local
const lambda = new cdk.aws_lambda.Function(this, 'MyLambda', {
  runtime: cdk.aws_lambda.Runtime.NODEJS_18_X,
  handler: 'index.handler',
  code: cdk.aws_lambda.Code.fromAsset('./lambda'),
});

// Asset Docker
const asset = new cdk.aws_docker_assets.DockerImageAsset(this, 'MyImage', {
  directory: './app',
});

// Arquivo estático
new cdk.aws_s3_assets.Asset(this, 'StaticFile', {
  path: './config/settings.json',
});
```

**❌ ERRADO:** Não estruturar assets adequadamente.
**✅ CORRETO:** Manter assets organizados e usar .cdkignore para excluir desnecessários.

---

## 8. Nested Stacks — Stacks Aninhadas

```typescript
const networkStack = new cdk.NestedStack(this, 'NetworkStack');
const vpc = new cdk.aws_ec2.Vpc(networkStack, 'Vpc', {
  maxAzs: 2,
});

const appStack = new cdk.NestedStack(this, 'AppStack');
new cdk.aws_ec2.Instance(appStack, 'AppInstance', {
  vpc: vpc,
  instanceType: cdk.aws_ec2.InstanceType.of(
    cdk.aws_ec2.InstanceClass.T3,
    cdk.aws_ec2.InstanceSize.MICRO
  ),
});
```

**❌ ERRADO:** Criar muitas stacks separadas sem necessidade.
**✅ CORRETO:** Usar nested stacks para agrupar recursos relacionados.

---

## 9. Cross-Stack References — Referências Entre Stacks

```typescript
// Stack de rede
export class NetworkStack extends cdk.Stack {
  public readonly vpc: cdk.aws_ec2.IVpc;

  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);
    this.vpc = new cdk.aws_ec2.Vpc(this, 'Vpc');
  }
}

// Stack de aplicação
export class AppStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props: { vpc: cdk.aws_ec2.IVpc }) {
    super(scope, id, props);
    new cdk.aws_rds.DatabaseInstance(this, 'DB', {
      vpc: props.vpc,
    });
  }
}
```

**❌ ERRADO:** Não usar referências entre stacks.
**✅ CORRETO:** Exportar recursos e importar em outras stacks para desacoplamento.

---

## 10. Environment Configuration

```typescript
const app = new cdk.App();

// Múltiplos ambientes
const devEnv = { account: '111111111111', region: 'us-east-1' };
const prodEnv = { account: '222222222222', region: 'us-west-2' };

new MyStack(app, 'DevStack', { env: devEnv });
new MyStack(app, 'ProdStack', { env: prodEnv });
```

**❌ ERRADO:** Não definir ambiente explicitamente.
**✅ CORRETO:** Criar constantes de ambiente para cada target de deploy.

---

## 11. Custom Constructs — Construindo Abstrações

```typescript
export interface MyServiceProps {
  vpc: cdk.aws_ec2.IVpc;
  environment: string;
}

export class MyService extends Construct {
  public readonly endpoint: string;

  constructor(scope: Construct, id: string, props: MyServiceProps) {
    super(scope, id);

    const cluster = new cdk.aws_ecs.Cluster(this, 'Cluster', {
      vpc: props.vpc,
    });

    const service = new cdk.aws_ecs.FargateService(this, 'Service', {
      cluster,
      desiredCount: props.environment === 'prod' ? 3 : 1,
    });

    this.endpoint = service.serviceArn;
  }
}
```

**❌ ERRADO:** Não criar abstrações para padrões reutilizáveis.
**✅ CORRETO:** Criar constructs customizados para encapsular complexidade.

---

## 12. Testing Constructs

```typescript
import { Template, Match } from 'aws-cdk-lib/assertions';

test('Lambda function created', () => {
  const app = new cdk.App();
  const stack = new MyStack(app, 'TestStack');

  const template = Template.fromStack(stack);

  template.hasResourceProperties('AWS::Lambda::Function', {
    Runtime: 'python3.9',
    Handler: 'index.handler',
  });
});

test('Bucket has versioning', () => {
  template.hasResourceProperties('AWS::S3::Bucket', {
    VersioningConfiguration: {
      Status: 'Enabled',
    },
  });
});
```

**❌ ERRADO:** Não testar infraestrutura.
**✅ CORRETO:** Usar assertions para validar recursos criados pelo template.

---

## 13. Migration from CloudFormation

```typescript
// Usando CfnOutput para bridge
const bucket = new cdk.aws_s3.Bucket(this, 'MyBucket');

new cdk.CfnOutput(this, 'BucketName', {
  value: bucket.bucketName,
  exportName: 'MyBucketName',
});

// Importando recursos existentes
const existingBucket = cdk.aws_s3.Bucket.fromBucketName(
  this, 'ExistingBucket', 'meu-bucket-existente'
);
```

**❌ ERRADO:** Refazer toda infraestrutura do zero.
**✅ CORRETO:** Usar CDK para gerenciar gradualmente sobre stacks existentes.

---

## 14. Best Practices — Práticas Recomendadas

```typescript
// ✓ Usar L2 constructs
// ✓ Definir environment explicitamente
// ✓ Usar Tags consistentes
// ✓ Estruturar por camadas (network, app, data)
// ✓ Manter stacks enxutas
// ✓ Usar nested stacks quando apropriado
// ✓ Versionar código IaC
// ✓ Testar antes de deploy
// ✓ Usar aspectos para validações
// ✓ Documentar outputs importantes
```

**❌ ERRADO:** Criar monolitos com muitos recursos em uma stack.
**✅ CORRETO:** Seguir princípios SOLID para infraestrutura.

---

## 15. Permissions and IAM

```typescript
const fn = new cdk.aws_lambda.Function(this, 'MyLambda', {
  runtime: cdk.aws_lambda.Runtime.NODEJS_18_X,
  handler: 'index.handler',
  code: cdk.aws_lambda.Code.fromAsset('lambda'),
});

// Método seguro - grant
const bucket = new cdk.aws_s3.Bucket(this, 'MyBucket');
bucket.grantRead(fn);

// Explícito - addToPolicy
fn.addToRolePolicy(new cdk.aws_iam.PolicyStatement({
  actions: ['s3:GetObject'],
  resources: [`${bucket.bucketArn}/*`],
}));
```

**❌ ERRADO:** Usar policy broad (* actions).
**✅ CORRETO:** Aplicar least privilege com grant ou policy explícita.

---

## 16. Outputs e Exportação

```typescript
new cdk.CfnOutput(this, 'ApiEndpoint', {
  value: api.url,
  description: 'URL da API REST',
  exportName: 'ApiEndpoint',
});

new cdk.CfnOutput(this, 'VpcId', {
  value: vpc.vpcId,
});
```

**❌ ERRADO:** Não exportar valores importantes entre stacks.
**✅ CORRETO:** Usar CfnOutput para compartilhar dados entre stacks.

---

## 17. Módulos CDK

```typescript
import { VpcStack } from './lib/vpc-stack';
import { DatabaseStack } from './lib/database-stack';
import { AppStack } from './lib/app-stack';

const app = new cdk.App();

const network = new VpcStack(app, 'NetworkStack');
const database = new DatabaseStack(app, 'DatabaseStack', {
  vpc: network.vpc,
});
new AppStack(app, 'AppStack', {
  vpc: network.vpc,
  databaseEndpoint: database.endpoint,
});
```

**❌ ERRADO:** Tudo em uma única stack gigante.
**✅ CORRETO:** Dividir em stacks modulares com responsabilidades claras.

---

## 18. CloudFormation Import

```bash
# Gerar CDK a partir de CloudFormation existente
cdk import --from cfn-template.json

# Ou usar cfn2ts para gerar tipos
npx cfn2ts --input cfn-template.json
```

**❌ ERRADO:** Ignorar stacks CloudFormation existentes.
**✅ CORRETO:** Importar gradualmente para CDK mantendo compatibilidade.

---

## 19. Asset Bundling

```typescript
const fn = new cdk.aws_lambda.Function(this, 'MyLambda', {
  runtime: cdk.aws_lambda.Runtime.PYTHON_3_9,
  handler: 'index.handler',
  code: cdk.aws_lambda.Code.fromAsset('lambda', {
    bundling: {
      image: cdk.aws_lambda.Runtime.PYTHON_3_9.bundlingImage,
      command: [
        'bash', '-c',
        'pip install -r requirements.txt -t /asset-output && cp -au *.py /asset-output',
      ],
    },
  }),
});
```

**❌ ERRADO:** Não considerar dependências no deploy.
**✅ CORRETO:** Usar bundling para incluir dependências automaticamente.

---

## 20. CDK Best Practices Final

```typescript
// ✓ Separar concerns: Network → Data → App → API
// ✓ Usar construtores reutilizáveis
// ✓ Testar cada construct isoladamente
// ✓ Versionar com tags git
// ✓ Usar CI/CD com CDK Pipelines
// ✓ Documentar com JSDoc em constructs
// ✓ Validar com Aspects antes do deploy
// ✓ Monitorar com CDK Nag para segurança
// ✓ Usar context para configuração
// ✓ Manter stacks abaixo de 500 linhas
```

**❌ ERRADO:** Deploy direto sem testes ou validação.
**✅ CORRETO:** Pipeline completo com synth, test, diff, approve, deploy.

---

**Referências:**
- AWS CDK Docs: https://docs.aws.amazon.com/cdk/v2/guide/
- CDK Patterns: https://cdkpatterns.com/
- CDK API Reference: https://docs.aws.amazon.com/cdk/api/v2/
