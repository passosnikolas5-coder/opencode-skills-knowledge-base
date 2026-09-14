# Documentacao Completa - Skills de Testing (v2 Aprimorada)

> **Data de geracao:** 2026-09-14
> **Versao:** 2.0 - Documentacao Aprimorada
> **Fonte:** Arquivos SKILL.md do sistema OpenCode + pesquisas de mercado

---

## Indice

1. [testing-category-pointer (30 skills)](#1-testing-category-pointer)
2. [test-automation-category-pointer (9 skills)](#2-test-automation-category-pointer)
3. [development-and-testing-category-pointer (6 skills)](#3-development-and-testing-category-pointer)
4. [webapp-testing (1 skill)](#4-webapp-testing)

---

## 1. testing-category-pointer (30 skills)

Skills especializadas em testes de software.

---

### 1.1 ab-testing

**Descricao:** Planejar, desenhar e implementar testes A/B ou experimentos de crescimento.

**Quando usar:**
- Criar testes A/B, validar hipoteses de produto, medir impacto em metricas
- Decisoes de design baseadas em dados
- Otimizar taxas de conversao

**Exemplos praticos:**

```python
# Teste A/B com teste z
from scipy import stats
import numpy as np

def test_ab(conversions_a, visitors_a, conversions_b, visitors_b):
    rate_a, rate_b = conversions_a/visitors_a, conversions_b/visitors_b
    stat, p_value = stats.proportions_ztest(
        [conversions_a, conversions_b], [visitors_a, visitors_b]
    )
    return {'rate_a': rate_a, 'rate_b': rate_b, 'p_value': p_value, 'significant': p_value < 0.05}
```

```python
# Calculo de tamanho de amostra
from scipy.stats import norm

def sample_size(baseline, mde, alpha=0.05, power=0.80):
    p1, p2 = baseline, baseline * (1 + mde)
    za, zb = norm.ppf(1 - alpha/2), norm.ppf(power)
    num = (za * np.sqrt(2*p1*(1-p1)) + zb * np.sqrt(p1*(1-p1) + p2*(1-p2)))**2
    return int(np.ceil(num / (p2 - p1)**2))
```

```python
# Analise com intervalo de confianca
from statsmodels.stats.proportion import proportion_confint

def analyze(vis_a, conv_a, vis_b, conv_b):
    rate_a, rate_b = conv_a/vis_a, conv_b/vis_b
    ci_a = proportion_confint(conv_a, vis_a, alpha=0.05, method='wilson')
    ci_b = proportion_confint(conv_b, vis_b, alpha=0.05, method='wilson')
    return {'rate_a': rate_a, 'rate_b': rate_b, 'lift': (rate_b-rate_a)/rate_a*100}
```

**Casos de uso avancados:**
- **E-commerce:** Testar layouts de produto, checkout, precos
- **SaaS:** Testar pricing, onboarding
- **Conteudo:** Testar titulos, thumbnails, CTAs

**Integracao com outras skills:**
- `smartui-skill`: Screenshots das variantes
- `pytest-skill`: Testes automatizados
- `k6-load-testing`: Performance de cada variante

**Padroes e anti-padroes:**
Fazer: Calcular sample size ANTES, rodar 1-2 semanas, randomizacao adequada
Evitar: Parar cedo demais, muitas variantes, ignorar segmentacao

**Dicas de performance:** Use calculadoras de sample size, tracking robusto, automatize analise

**Comandos uteis:**
```bash
pip install scipy statsmodels numpy
```

**Referencias:**
- [Evan Miller A/B Calculator](https://www.evanmiller.org/ab-testing/sample-size.html)
- [Google Optimize](https://support.google.com/optimize/answer/6218117)

---

### 1.2 agent-qa-authoring

**Descricao:** Criar, editar, validar e executar testes de Agent QA preservando IDs canonicos e contratos de schema.

**Quando usar:**
- Escrever testes automatizados para agentes de IA
- Validar respostas de chatbots
- Garantir conformidade com schemas

**Exemplos praticos:**

```yaml
# Suite de QA para chatbot
suite: customer_service_agent
tests:
  - id: "CS-001"
    name: "Saudacao"
    input: { message: "Ola" }
    expected:
      contains: ["Ola", "bem-vindo"]
      sentiment: "amigavel"
    tags: ["saudacao"]
  - id: "CS-002"
    name: "Reclamacao"
    input: { message: "Pedido nao chegou" }
    expected:
      contains: ["pedido", "entrega"]
      sentiment: "empatico"
      action: "consultar_pedido"
```

```python
# Validacao de schema com pydantic
from pydantic import BaseModel, validator

class AgentResponse(BaseModel):
    message: str
    confidence: float
    intent: str

    @validator('confidence')
    def check_confidence(cls, v):
        if not 0 <= v <= 1:
            raise ValueError('Confidence must be 0-1')
        return v

def validate_response(data):
    try:
        return {"valid": True, "data": AgentResponse(**data)}
    except ValidationError as e:
        return {"valid": False, "errors": e.errors()}
```

```bash
# CLI
agent-qa init
agent-qa validate
agent-qa run --suite customer_service
agent-qa report --format html
```

**Casos de uso avancados:**
- **E-commerce:** Agentes de suporte pos-venda
- **Financas:** Chatbots bancarios
- **Saude:** Assistentes medicos

**Integracao com outras skills:**
- `agent-qa-debug-fix`: Quando testes falharem
- `agent-qa-result-triage`: Analise de falhas em lote
- `pytest-skill`: Testes unitarios

**Padroes e anti-padroes:**
Fazer: IDs canonicos, documentar schemas, versionar suites
Evitar: Hardcoded values, testar apenas happy paths

**Dicas de performance:** Cache para LLM, testes paralelos, timeouts adequados

**Referencias:**
- [Agent QA Documentation](https://agentqa.dev/docs)
- [DeepEval](https://docs.confident-ai.com/)

---

### 1.3 agent-qa-debug-fix

**Descricao:** Depurar, corrigir e verificar execucoes de Agent QA que falharam.

**Quando usar:**
- Testes de QA falham e necessario causa raiz
- Corrigir comportamento inesperado de agentes

**Exemplos praticos:**

```python
import logging
from datetime import datetime

class AgentQADebugger:
    def debug(self, test_id, input_data, actual_output):
        issues = self.compare(actual_output, self.get_expected(test_id))
        failure_type = self.classify(issues)
        fix = self.suggest_fix(failure_type, issues)
        return {'test_id': test_id, 'type': failure_type, 'fix': fix, 'ts': datetime.now().isoformat()}
```

```python
# Auto-correcao
class AgentQAFixer:
    def fix_missing_keyword(self, issue, config):
        keyword = issue.split(': ')[1]
        return {'prompt': config['prompt'] + f"\nUse '{keyword}' na resposta."}

    def fix_wrong_sentiment(self, issue, config):
        return {'temperature': 0.3, 'system_addition': 'Seja empatico.'}
```

```bash
agent-qa logs --test CS-001 --verbose
agent-qa debug --test CS-001 --interactive
agent-qa fix --test CS-001 --auto
```

**Casos de uso avancados:**
- **Atendimento:** Corrigir respostas nao resolutivas
- **Vendas:** Ajustar abordagem para conversao

**Integracao com outras skills:**
- `agent-qa-authoring`: Criar testes para falhas
- `systematic-debugging`: Metodologia de debugging

**Padroes e anti-padroes:**
Fazer: Log completo, historico de correcoes, ambiente isolado
Evitar: Fix que muda teste, ignorar padroes recorrentes

---

### 1.4 agent-qa-result-triage

**Descricao:** Triar execucoes de Agent QA que falharam com categorias fixas e proximos passos acionaveis.

**Quando usar:**
- Multiplos testes falhando simultaneamente
- Classificar prioridades e acoes corretivas

**Exemplos praticos:**

```python
from enum import Enum

class Severity(Enum):
    CRITICAL = "critical"
    HIGH = "high"
    MEDIUM = "medium"
    LOW = "low"

class QATriage:
    def triage(self, tests):
        result = {s: [] for s in Severity}
        for t in tests:
            sev = self.classify(t)
            result[sev].append(t)
        return result

    def classify(self, test):
        if test.impact > 0.8 or test.affected > 1000:
            return Severity.CRITICAL
        elif test.impact > 0.5:
            return Severity.HIGH
        return Severity.MEDIUM
```

**Integracao com outras skills:**
- `agent-qa-authoring`: Criar testes baseados em falhas
- `brooks-test`: Analise de qualidade

---

### 1.5 android-ui-journey-testing

**Descricao:** Testes de jornada UI em Android com XML especificado e relatorios JSON.

**Quando usar:**
- Testar fluxos completos de interface Android
- Validar jornadas de usuario

**Exemplos praticos:**

```xml
<journey name="login">
    <step name="launch">
        <action type="launch" package="com.example.app"/>
    </step>
    <step name="login">
        <action type="input" resource-id="email" text="user@example.com"/>
        <action type="input" resource-id="password" text="pass123"/>
        <action type="click" resource-id="submit"/>
    </step>
    <step name="verify">
        <assert screen="dashboard"/>
    </step>
</journey>
```

```python
# Execucao com Appium
from appium import webdriver

caps = {'platformName': 'Android', 'deviceName': 'emulator-5554', 'app': 'app.apk'}
driver = webdriver.Remote('http://localhost:4723/wd/hub', caps)
# ... execucao da jornada ...
driver.quit()
```

**Integracao com outras skills:**
- `android_ui_verification`: Verificacao detalhada
- `smartui-skill`: Regressao visual

---

### 1.6 bats-testing-patterns

**Descricao:** Bash Automated Testing System (Bats) para testes de shell scripts.

**Quando usar:**
- Testes para scripts Bash
- Validacao de comandos de sistema
- TDD em automacoes shell

**Exemplos praticos:**

```bash
#!/usr/bin/env bats
setup() { source ./scripts/deploy.sh; TEST_DIR=$(mktemp -d); cd "$TEST_DIR"; }
teardown() { rm -rf "$TEST_DIR"; }

@test "valida argumentos" {
    run ./deploy.sh
    [ "$status" -eq 1 ]
    [[ "$output" == *"Usage:"* ]]
}

@test "ambiente valido" {
    run ./deploy.sh staging
    [ "$status" -eq 0 ]
}
```

```bash
#!/usr/bin/env bats
@test "processa 1000 registros em <5s" {
    generate_data 1000 > input.txt
    start=$(date +%s)
    run ./process.sh input.txt
    [ $(( $(date +%s) - start )) -lt 5 ]
}
```

**Integracao com outras skills:**
- `tdd-workflow`: TDD em scripts
- `debugging-strategies`: Debugar scripts

---

### 1.7 brooks-test

**Descricao:** Revisar qualidade da suite de testes; identificar fragilidade, abuso de mocks e riscos de manutencao.

**Quando usar:**
- Auditoria da qualidade geral da suite
- Antes de grandes refatoracoes

**Exemplos praticos:**

```python
class TestSuiteAudit:
    def audit(self, path):
        issues = []
        issues.extend(self.check_isolation(path))
        issues.extend(self.check_assertions(path))
        issues.extend(self.check_mocks(path))
        return {'issues': issues, 'score': 100 - len(issues) * 5}
```

```bash
# Metricas de cobertura e qualidade
pytest --cov=src --cov-report=html
radon cc src/ -s  # Complexidade ciclomatica
flake8 src/       # Code smells
```

**Integracao com outras skills:**
- `test-guard`: Revisao continua
- `testing-patterns`: Aplicar padroes

---

### 1.8 browser-testing-with-devtools

**Descricao:** Testar aplicacoes web com Chrome DevTools - DOM, console, rede, performance, acessibilidade.

**Quando usar:**
- Inspecionar e testar app web em tempo real
- Debugging visual e de performance

**Exemplos praticos:**

```javascript
// Interceptacao de rede
const { chromium } = require('playwright');
const browser = await chromium.launch();
const page = await browser.newPage();
const requests = [];
page.on('request', r => requests.push({url: r.url(), method: r.method()}));
await page.goto('https://example.com');
console.log('Requisicoes:', requests.length);
await browser.close();
```

```python
# Acessibilidade com Axe
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page()
    page.goto('https://example.com')
    page.add_script_tag(url='https://cdnjs.cloudflare.com/ajax/libs/axe-core/4.7.2/axe.min.js')
    results = page.evaluate('() => new Promise(r => axe.run((e, res) => r(res)))')
    print(f"Violacoes: {len(results.get('violations', []))}")
    browser.close()
```

**Integracao com outras skills:**
- `browser-automation`: Automacao completa
- `k6-load-testing`: Testes de carga

**Comandos uteis:**
```bash
npx playwright open --devtools
npx lighthouse https://example.com --output=html
```

---

### 1.9 cypress-skill

**Descricao:** Testes Cypress E2E e de componente em JavaScript/TypeScript.

**Quando usar:**
- Testes E2E com Cypress
- Testar componentes React/Vue

**Exemplos praticos:**

```javascript
describe('Compra', () => {
    beforeEach(() => {
        cy.intercept('GET', '/api/products').as('getProducts');
        cy.visit('/');
        cy.wait('@getProducts');
    });

    it('adiciona ao carrinho', () => {
        cy.get('[data-testid="product"]').first().click();
        cy.get('[data-testid="add-cart"]').click();
        cy.get('[data-testid="cart-count"]').should('contain', '1');
    });
});

// Custom commands
Cypress.Commands.add('login', (email, pass) => {
    cy.visit('/login');
    cy.get('#email').type(email);
    cy.get('#password').type(pass);
    cy.get('button[type="submit"]').click();
    cy.url().should('include', '/dashboard');
});
```

**Integracao com outras skills:**
- `browser-automation`: Padroes de automacao
- `smartui-skill`: Regressao visual

**Comandos uteis:**
```bash
npx cypress open
npx cypress run --spec "cypress/e2e/login.cy.js"
```

---

### 1.10 k6-load-testing

**Descricao:** Testes de carga k6 para APIs, browser e escalabilidade.

**Quando usar:**
- Testar performance sob carga
- Validar limites de sistema

**Exemplos praticos:**

```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
    stages: [
        { duration: '30s', target: 20 },
        { duration: '1m', target: 50 },
        { duration: '30s', target: 0 },
    ],
    thresholds: {
        http_req_duration: ['p(95)<500'],
        errors: ['rate<0.1'],
    },
};

export default function () {
    const res = http.post('http://localhost:3000/api/login',
        JSON.stringify({email: 'user@example.com', password: 'pass'}),
        { headers: { 'Content-Type': 'application/json' } });
    check(res, { 'status 200': (r) => r.status === 200 });
    sleep(1);
}
```

```javascript
// Cenarios realistas
export const options = {
    scenarios: {
        normal: { executor: 'ramping-vus', startVUs: 0,
            stages: [{duration:'2m',target:100},{duration:'5m',target:100},{duration:'2m',target:0}] },
        power: { executor: 'constant-vus', vus: 20, duration: '10m' },
    },
};
```

**Integracao com outras skills:**
- `browser-testing-with-devtools`: Analise detalhada
- `ab-testing`: Impacto de mudancas

**Comandos uteis:**
```bash
k6 run script.js
k6 cloud script.js
k6 run --summary-export=summary.json script.js
```

---

### 1.11 lambdatest-agent-skills

**Descricao:** Automacao de testes em nuvem para 46 frameworks em 15+ linguagens.

**Quando usar:**
- Automacao em nuvem multiplataforma
- Testes cross-browser

**Exemplos praticos:**

```python
from selenium import webdriver
from selenium.webdriver.common.options import Options

options = Options()
options.browser_version = 'latest'
options.set_capability('LT:Options', {
    'user': 'USER', 'accessKey': 'KEY', 'build': 'Build 1.0'
})
driver = webdriver.Remote('https://hub.lambdatest.com/wd/hub', options)
driver.get('https://example.com')
driver.quit()
```

**Integracao com outras skills:**
- `playwright-skill`: Playwright na nuvem
- `cypress-skill`: Cypress na nuvem

---

### 1.12 mock-hunter

**Descricao:** Auditar pagina web para identificar dados mock, hardcoded e endpoints quebrados.

**Quando usar:**
- Auditar dados antes de decisoes reais
- Validacao de dados em producao

**Exemplos praticos:**

```python
import re
from playwright.sync_api import sync_playwright

class MockHunter:
    PATTERNS = [r'test@test\.com', r'John Doe', r'Lorem ipsum', r'fake@']

    def hunt(self, url):
        with sync_playwright() as p:
            browser = p.chromium.launch()
            page = browser.new_page()
            page.goto(url)
            text = page.evaluate('() => document.body.innerText')
            findings = [p for p in self.PATTERNS if re.search(p, text)]
            browser.close()
            return findings
```

**Integracao com outras skills:**
- `browser-testing-with-devtools`: Analise de rede
- `brooks-test`: Auditoria completa

---

### 1.13 network-101

**Descricao:** Configurar e testar servicos de rede (HTTP, SNMP, SMB) para laboratorios de pentest.

**Quando usar:**
- Configurar laboratorio de seguranca
- Praticar tecnicas de pentest

**Exemplos praticos:**

```bash
# Servidor HTTP
sudo apt install apache2
sudo a2ensite lab.conf && sudo systemctl reload apache2

# SNMP
sudo apt install snmp snmpd
snmpwalk -v2c -c public localhost system

# Verificacao de portas
nmap -sV localhost
```

**Integracao com outras skills:**
- `browser-testing-with-devtools`: Testes web
- `systematic-debugging`: Investigacao

---

### 1.14 pypict-skill

**Descricao:** Geracao de testes pairwise (combinacao de pares).

**Quando usar:**
- Combinacoes otimizadas de parametros
- Reduzir espaco de teste

**Exemplos praticos:**

```python
from pypict import pairwise

params = {
    'browser': ['Chrome', 'Firefox', 'Safari'],
    'os': ['Windows', 'macOS', 'Linux'],
    'resolution': ['1920x1080', '1366x768', '375x667']
}
cases = pairwise(params)  # ~15 em vez de 27
```

```python
import pytest
SCENARIOS = pairwise({'browser': ['Chrome','Firefox'], 'os': ['Win','Mac'], 'method': ['email','sso']})

@pytest.mark.parametrize("s", SCENARIOS)
def test_login(s):
    driver = setup_browser(s['browser'], s['os'])
    result = perform_login(driver, s['method'])
    assert result.success
```

**Integracao com outras skills:**
- `pytest-skill`: Execucao de testes
- `smartui-skill`: Regressao visual

---

### 1.15 pytest-skill

**Descricao:** Testes pytest com fixtures, parametrize, markers e mocking.

**Quando usar:**
- Testes unitarios/integracao em Python
- Organizar fixtures complexas

**Exemplos praticos:**

```python
import pytest

@pytest.fixture
def database():
    from sqlalchemy import create_engine
    engine = create_engine('sqlite:///:memory:')
    Session = sessionmaker(bind=engine)
    session = Session()
    Base.metadata.create_all(engine)
    yield session
    session.close()

@pytest.mark.parametrize("email,expected", [
    ("admin@example.com", True),
    ("invalid", False),
    ("", False),
], ids=["admin", "no_at", "empty"])
def test_email(email, expected):
    from validators import is_valid_email
    assert is_valid_email(email) == expected
```

```python
@pytest.mark.smoke
def test_critical(): pass

@pytest.mark.skipif(not os.getenv('CI'), reason="So em CI")
def test_slow(): pass
```

**Integracao com outras skills:**
- `unit-testing-test-generate`: Gerar testes
- `tdd-workflow`: TDD em Python

**Comandos uteis:**
```bash
pytest --cov=src --cov-report=html
pytest -k "test_login" -m "not slow"
pytest --lf --tb=short
```

---

### 1.16 screen-reader-testing

**Descricao:** Testar aplicacoes web com leitores de tela para acessibilidade.

**Quando usar:**
- Validar acessibilidade
- Conformidade WCAG

**Exemplos praticos:**

```python
from playwright.sync_api import sync_playwright

def test_a11y(url):
    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        page.goto(url)
        page.add_script_tag(url='https://cdnjs.cloudflare.com/ajax/libs/axe-core/4.7.2/axe.min.js')
        results = page.evaluate('() => new Promise(r => axe.run((e, res) => r(res)))')
        violations = results.get('violations', [])
        for v in violations:
            print(f"{v['id']}: {v['description']} ({v['impact']}) - {len(v['nodes'])} elementos")
        browser.close()
```

```javascript
// Verificar landmarks
const landmarks = await page.evaluate(() => {
    const found = {};
    ['banner','navigation','main','contentinfo'].forEach(r => {
        found[r] = document.querySelectorAll(`[role="${r}"]`).length;
    });
    return found;
});
```

**Integracao com outras skills:**
- `brooks-test`: Auditoria completa
- `browser-testing-with-devtools`: Analise tecnica

---

### 1.17 smartui-skill

**Descricao:** Testes de regressao visual com comparacao de screenshots na nuvem.

**Quando usar:**
- Detectar mudancas nao intencionais na UI
- Validar design system

**Exemplos praticos:**

```javascript
exports.config = {
    smartuiConfig: {
        projectName: 'Visual Tests',
        threshold: 0.1,
        ignoreAreas: [{ selector: '.timestamp' }],
    },
};
test('homepage', async ({ page }) => {
    await page.goto('/');
    await page.smartUI('homepage', { fullPage: true });
});
```

```yaml
# Configuracao Cypress
projectName: "E-commerce Visual"
threshold: 0.5
browsers:
  - { name: "chrome", width: 1440, height: 900 }
  - { name: "mobile", width: 375, height: 812 }
ignoreAreas:
  - { selector: ".dynamic-loader" }
```

**Integracao com outras skills:**
- `playwright-skill`: Automacao
- `cypress-skill`: Cypress

---

### 1.18 tdd-orchestrator

**Descricao:** Orquestrador TDD com disciplina red-green-refactor e multi-agente.

**Quando usar:**
- Ciclo TDD com multiplos agentes
- Projetos complexos

**Exemplos praticos:**

```python
from enum import Enum

class Phase(Enum):
    RED = "red"; GREEN = "green"; REFACTOR = "refactor"

class TDDOrchestrator:
    def orchestrate(self, spec):
        test = self.write_failing_test(spec)
        self.run(test, expect_fail=True)
        code = self.write_minimal(test)
        self.run(test, expect_fail=False)
        refactored = self.refactor(code)
        self.run(test, expect_fail=False)
        return {'test': test, 'code': refactored}
```

**Integracao com outras skills:**
- `tdd-workflow`: Ciclo basico
- `tdd-workflows-tdd-red/green/refactor`: Fases

---

### 1.19 tdd-workflow

**Descricao:** Ciclo RED-GREEN-REFACTOR de TDD.

**Quando usar:**
- Qualquer linguagem, novas features, correcao de bugs

**Exemplos praticos:**

```python
# RED
def test_soma():
    assert Calculadora().somar(2, 3) == 5

# GREEN
class Calculadora:
    def somar(self, a, b): return a + b

# REFACTOR
class Calculadora:
    def __init__(self): self.historico = []
    def somar(self, a: int, b: int) -> int:
        r = a + b
        self.historico.append(f"{a}+{b}={r}")
        return r
```

```javascript
// RED
test('C->F', () => expect(c2f(0)).toBe(32));
// GREEN
function c2f(c) { return (c * 9/5) + 32; }
// REFACTOR
function c2f(c) {
    if (typeof c !== 'number') throw new TypeError('Must be number');
    return Math.round(((c * 9/5) + 32) * 100) / 100;
}
```

**Integracao com outras skills:**
- `tdd-orchestrator`: Coordenacao
- `pytest-skill`: Python
- `testing-patterns`: Padroes

**Comandos uteis:**
```bash
pytest --watch
npm test -- --watch
```

---

### 1.20 tdd-workflows / tdd-workflows-tdd-cycle

**Descricao:** Alias para o ciclo TDD completo.

**Quando usar:** Identico ao tdd-workflow.

---

### 1.21 tdd-workflows-tdd-green

**Descricao:** Implementar codigo minimo para testes passarem na fase verde.

**Quando usar:** Quando testes falham e precisa implementar codigo minimo.

**Exemplos praticos:**

```python
# Teste existe
def test_validar_email():
    assert ValidadorEmail.validar("user@example.com") == True

# GREEN minimo
class ValidadorEmail:
    @staticmethod
    def validar(email):
        return "@" in email and "." in email
```

```javascript
// Teste
test('cart total', () => {
    const cart = new Cart();
    cart.addItem({price:10,qty:2});
    expect(cart.getTotal()).toBe(20);
});
// GREEN
class Cart {
    constructor() { this.items = []; }
    addItem(i) { this.items.push(i); }
    getTotal() { return this.items.reduce((s,i) => s + i.price * i.qty, 0); }
}
```

**Integracao com outras skills:**
- `tdd-workflows-tdd-red`: Fase anterior
- `tdd-workflows-tdd-refactor`: Fase seguinte

---

### 1.22 tdd-workflows-tdd-red

**Descricao:** Gerar testes que falham para a fase vermelha.

**Quando usar:** Iniciar feature definindo comportamento via testes.

**Exemplos praticos:**

```python
def test_desconto_10pct():
    assert CalculadoraDesconto().aplicar(100, 10) == 90

def test_desconto_zero():
    assert CalculadoraDesconto().aplicar(100, 0) == 100

def test_desconto_negativo_erro():
    with pytest.raises(ValueError):
        CalculadoraDesconto().aplicar(100, -10)

def test_desconto_acima_100_erro():
    with pytest.raises(ValueError):
        CalculadoraDesconto().aplicar(100, 150)
```

```javascript
describe('Auth', () => {
    test('credenciais validas', () => {
        const r = new AuthService().login('u@e.com', 'pass');
        expect(r.success).toBe(true);
        expect(r.token).toBeDefined();
    });
    test('senha incorreta', () => {
        const r = new AuthService().login('u@e.com', 'wrong');
        expect(r.error).toBe('Credenciais invalidas');
    });
    test('bloqueio apos 5 tentativas', () => {
        const a = new AuthService();
        for(let i=0;i<5;i++) a.login('u@e.com','w');
        expect(a.login('u@e.com','pass').error).toBe('Conta bloqueada');
    });
});
```

**Integracao com outras skills:**
- `tdd-workflows-tdd-green`: Proxima fase
- `unit-testing-test-generate`: Gerar testes

---

### 1.23 tdd-workflows-tdd-refactor

**Descricao:** Refatorar codigo sem mudar comportamento.

**Quando usar:** Testes verdes, quer melhorar estrutura.

**Exemplos praticos:**

```python
# ANTES
def process(order):
    if not order.items: raise ValueError("Vazio")
    d = order.total * 0.1 if order.customer.vip else (0.05 if order.total > 100 else 0)
    return order.total - d

# DEPOIS
def process(order):
    validate(order)
    return apply_discount(order.total, calc_discount(order))

def validate(o):
    if not o.items: raise ValueError("Vazio")

def calc_discount(o):
    if o.customer.vip: return o.total * 0.1
    if o.total > 100: return o.total * 0.05
    return 0
```

```javascript
// ANTES
function shipping(o) {
    if(o.country==='BR') return o.weight<1?10:o.weight<5?20:30;
    if(o.country==='US') return o.weight<1?20:o.weight<5?40:60;
}
// DEPOIS
const rates = {
    BR: [{max:1,price:10},{max:5,price:20},{max:Infinity,price:30}],
    US: [{max:1,price:20},{max:5,price:40},{max:Infinity,price:60}]
};
function shipping(o) {
    return rates[o.country].find(r => o.weight<=r.max).price;
}
```

**Referencias:**
- [Refactoring by Martin Fowler](https://martinfowler.com/books/refactoring.html)

---

### 1.24 temporal-python-testing

**Descricao:** Testes de workflows Temporal com pytest.

**Quando usar:**
- Workflows Temporal em Python
- Workflows de longa duracao

**Exemplos praticos:**

```python
import pytest
from temporalio.testing import WorkflowEnvironment

@pytest.mark.asyncio
async def test_workflow():
    async with await WorkflowEnvironment.start_local() as env:
        async with Worker(env.client, task_queue="q", workflows=[MyWf]):
            result = await env.client.execute_workflow(
                MyWf.run, "arg", id="test", task_queue="q")
            assert result == "expected"
```

**Integracao com outras skills:**
- `pytest-skill`: Estrutura
- `systematic-debugging`: Debug

---

### 1.25 test-driven-development

**Descricao:** Usar teste comportamental falhando para guiar feature ou bug fix.

**Exemplos praticos:**

```python
def test_relatorio():
    r = Relatorio("2024-01")
    d = r.gerar()
    assert d.total == 15000.00
    assert d.pedidos == 150

class Relatorio:
    def __init__(self, p): self.periodo = p
    def gerar(self):
        vendas = self._buscar()
        return Dados(total=sum(v.total for v in vendas), pedidos=len(vendas))
```

**Integracao com outras skills:**
- `tdd-orchestrator`: Coordenacao
- `pytest-skill`: Execucao

---

### 1.26 test-framework-migration-skill

**Descricao:** Migrar scripts entre Selenium, Playwright, Puppeteer e Cypress.

**Quando usar:** Migrar suite de testes, modernizacao.

**Exemplos praticos:**

```python
# ANTES Selenium
driver = webdriver.Chrome()
driver.get("http://localhost:3000")
driver.find_element(By.ID, "email").send_keys("user@example.com")
driver.quit()

# DEPOIS Playwright
with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page()
    page.goto("http://localhost:3000")
    page.fill("#email", "user@example.com")
    browser.close()
```

```javascript
// ANTES Cypress
cy.visit('/login'); cy.get('#email').type('u@e.com'); cy.url().should('include','/dashboard');
// DEPOIS Playwright
await page.goto('/login'); await page.fill('#email','u@e.com'); await expect(page).toHaveURL(/dashboard/);
```

**Referencias:**
- [Playwright Migration Guide](https://playwright.dev/docs/migration-guide)

---

### 1.27 test-guard

**Descricao:** Revisar codigo de testes contra regras universais antes de entregar.

**Quando usar:** Validar qualidade antes de commitar.

**Exemplos praticos:**

```python
import re

class TestGuard:
    def validate(self, code):
        issues = []
        if not re.search(r'def test_\w+', code):
            issues.append({'rule':'naming','sev':'error'})
        if 'assert ' not in code and 'expect(' not in code:
            issues.append({'rule':'assertions','sev':'error'})
        return {'passed': not issues, 'issues': issues}
```

```yaml
# pre-commit hook
repos:
  - repo: local
    hooks:
      - id: test-guard
        entry: python -m test_guard
        files: 'test_.*\.py$'
```

---

### 1.28 testing-patterns

**Descricao:** Padroes Jest, factory functions, mocking strategies e TDD.

**Quando usar:** Testes Jest avancados, componentes React.

**Exemplos praticos:**

```javascript
const UserFactory = {
    build: (o={}) => ({id:1,name:'John',email:'j@e.com',role:'user',...o}),
    buildAdmin: () => UserFactory.build({role:'admin'}),
    buildMany: (n,o={}) => Array.from({length:n},(_,i)=>UserFactory.build({id:i+1,...o}))
};

it('retorna usuario', async () => {
    mockDb.findById.mockResolvedValue(UserFactory.build());
    const r = await UserService.getById(1);
    expect(r.name).toBe('John');
});

// Mock patterns
mockApi.get.mockResolvedValue({data:UserFactory.buildMany(10)});
mockApi.post.mockImplementation(()=>new Promise(r=>setTimeout(()=>r({data:UserFactory.build()}),100)));
mockApi.delete.mockRejectedValue(new Error('Forbidden'));
```

**Integracao com outras skills:**
- `unit-testing-test-generate`: Gerar testes
- `tdd-workflow`: TDD

---

### 1.29 unit-testing-test-generate

**Descricao:** Gerar testes unitarios abrangentes com foco em edge cases.

**Quando usar:** Gerar testes completos, aumentar cobertura.

**Exemplos praticos:**

```python
from hypothesis import given, strategies as st
import pytest

def calc_discount(price, pct):
    if price < 0: raise ValueError("Preco negativo")
    if not 0 <= pct <= 100: raise ValueError("Desconto 0-100")
    return price * (1 - pct/100)

class TestDiscount:
    def test_zero(self): assert calc_discount(100, 0) == 100
    def test_fifty(self): assert calc_discount(100, 50) == 50
    def test_full(self): assert calc_discount(100, 100) == 0
    def test_neg_price(self):
        with pytest.raises(ValueError): calc_discount(-1, 10)
    def test_neg_disc(self):
        with pytest.raises(ValueError): calc_discount(100, -10)

    @given(st.floats(min_value=0,max_value=10000), st.floats(min_value=0,max_value=100))
    def test_property(self, p, d):
        assert 0 <= calc_discount(p, d) <= p
```

```javascript
function validatePw(pw) {
    if (pw.length < 8) return {ok:false, err:'Curta'};
    if (!/[A-Z]/.test(pw)) return {ok:false, err:'Maiuscula'};
    if (!/[0-9]/.test(pw)) return {ok:false, err:'Numero'};
    return {ok:true};
}

describe('validatePw', () => {
    test.each([
        ['MyP@ss1', true],
        ['short', false],
        ['nouppercase1!', false],
        ['NOLOWER1!', false],
    ])('validates "%s"', (input, expected) => {
        expect(validatePw(input).ok).toBe(expected);
    });
});
```

**Integracao com outras skills:**
- `pytest-skill`: Python
- `testing-patterns`: Jest
- `tdd-workflow`: TDD

**Referencias:**
- [Hypothesis Testing](https://hypothesis.readthedocs.io/)

---

## 2. test-automation-category-pointer (9 skills)

Skills de automacao de testes.

---

### 2.1 android_ui_verification

**Descricao:** Testes E2E de UI Android com ADB.

**Exemplos praticos:**

```python
from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy

def test_android():
    caps = {'platformName':'Android','deviceName':'emulator-5554','app':'app.apk','automationName':'UiAutomator2'}
    driver = webdriver.Remote('http://localhost:4723/wd/hub', caps)
    title = driver.find_element(AppiumBy.ID, 'com.example:id/title')
    assert title.text == 'Configuracoes'
    driver.quit()
```

```python
def verify_element(driver, res_id, expected):
    el = driver.find_element(AppiumBy.ID, res_id)
    assert el.text == expected
```

**Integracao:** `android-ui-journey-testing`, `smartui-skill`, `e2e-testing-patterns`

---

### 2.2 awt-e2e-testing

**Descricao:** Testes E2E com IA e correspondencia visual (OpenCV + OCR).

**Exemplos praticos:**

```yaml
scenario: "Cadastro"
steps:
  - action: navigate
    url: "http://localhost:3000/register"
  - action: fill
    selector: "#email"
    value: "user@example.com"
  - action: verify_visual
    template: "success.png"
    threshold: 0.95
```

```python
from awt import AWTEngine
import cv2

def verify_ocr(page, expected):
    engine = AWTEngine()
    ss = page.screenshot()
    text = engine.ocr_extract(ss)
    assert expected in text

def compare_images(tmpl_path, actual, threshold=0.9):
    tmpl = cv2.imread(tmpl_path)
    r = cv2.matchTemplate(actual, tmpl, cv2.TM_CCOEFF_NORMED)
    _, max_val, _, _ = cv2.minMaxLoc(r)
    assert max_val >= threshold
```

**Integracao:** `playwright-skill`, `smartui-skill`, `browser-testing-with-devtools`

---

### 2.3 browser-automation

**Descricao:** Automacao de browser robusta com localizadores semanticos e waits inteligentes.

**Exemplos praticos:**

```python
from playwright.sync_api import sync_playwright

def test_form():
    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        page.goto('http://localhost:3000/form')
        page.wait_for_selector('#name', state='visible')
        page.fill('#name', 'Joao')
        page.fill('#email', 'j@e.com')
        page.click('button[type="submit"]')
        page.wait_for_selector('.success', state='visible')
        assert page.text_content('.success') == 'Enviado!'
        browser.close()
```

```python
def find_by_role(page, role, name=None):
    sel = f'[role="{role}"]'
    return page.locator(f'{sel}:has-text("{name}")') if name else page.locator(sel)
```

```python
import uuid
def test_user():
    uid = str(uuid.uuid4())[:8]
    return {'name': f'User {uid}', 'email': f't_{uid}@e.com'}
```

**Integracao:** `playwright-skill`, `cypress-skill`, `browser-testing-with-devtools`

---

### 2.4 e2e-testing-patterns

**Descricao:** Padroes E2E confiaveis com Page Objects, fixtures e testes independentes.

**Exemplos praticos:**

```python
class LoginPage:
    def __init__(self, page):
        self.email = page.locator('#email')
        self.pwd = page.locator('#password')
        self.submit = page.locator('button[type="submit"]')

    def login(self, email, password):
        self.email.fill(email)
        self.pwd.fill(password)
        self.submit.click()

async def test_login(page):
    lp = LoginPage(page)
    await page.goto('/login')
    await lp.login('u@e.com', 'pass')
    assert '/dashboard' in page.url
```

```python
@pytest.fixture
async def auth_page():
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page()
        await page.goto('/login')
        await page.fill('#email', 'u@e.com')
        await page.fill('#password', 'pass')
        await page.click('button[type="submit"]')
        await page.wait_for_url('**/dashboard')
        yield page
        await browser.close()
```

**Integracao:** `browser-automation`, `playwright-skill`, `cypress-skill`

---

### 2.5 go-playwright

**Descricao:** Automacao de browser com Playwright Go.

**Exemplos praticos:**

```go
func TestTitle(t *testing.T) {
    pw, _ := playwright.Run()
    defer pw.Stop()
    browser, _ := pw.Chromium.Launch()
    defer browser.Close()
    page, _ := browser.NewPage()
    page.Goto("https://example.com")
    title, _ := page.Title()
    if title != "Example Domain" { t.Errorf("Got %s", title) }
}
```

```go
page.OnRequest(func(r playwright.Request) {
    if strings.Contains(r.URL(), "/api/") {
        log.Printf("API: %s %s", r.Method(), r.URL())
    }
})
```

**Integracao:** `playwright-skill`, `browser-automation`

---

### 2.6 playwright-java

**Descricao:** Playwright E2E em Java com Page Objects, JUnit 5 e Allure.

**Exemplos praticos:**

```java
public class LoginPage {
    private final Locator email, pwd, submit;
    public LoginPage(Page page) {
        email = page.locator("#email");
        pwd = page.locator("#password");
        submit = page.locator("button[type='submit']");
    }
    public void login(String e, String p) { email.fill(e); pwd.fill(p); submit.click(); }
}

@ExtendWith(PlaywrightExtension.class)
public class LoginTest {
    @Test void shouldLogin(Page page) {
        new LoginPage(page).login("u@e.com", "pass");
        assertThat(page.url()).contains("/dashboard");
    }
}
```

**Integracao:** `playwright-skill`, `e2e-testing-patterns`

---

### 2.7 playwright-skill

**Descricao:** Skill principal Playwright para qualquer linguagem.

**Exemplos praticos:**

```python
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.goto('http://localhost:5173')
    page.wait_for_load_state('networkidle')
    page.fill('#search', 'query')
    page.click('button[type="submit"]')
    page.wait_for_selector('.results')
    assert page.locator('.result-item').count() > 0
    page.screenshot(path='screenshot.png', full_page=True)
    browser.close()
```

```javascript
const { test, expect } = require('@playwright/test');
test('add to cart', async ({ page }) => {
    await page.goto('/');
    await page.click('[data-testid="product-1"]');
    await page.click('[data-testid="add-cart"]');
    await expect(page.locator('[data-testid="count"]')).toHaveText('1');
});
```

```python
# API testing
api = p.request.new_context(base_url="http://localhost:3000")
resp = api.get("/api/users")
assert resp.ok
users = resp.json()
assert len(users) > 0
```

**Integracao:** `browser-automation`, `e2e-testing-patterns`, `smartui-skill`, `browser-testing-with-devtools`

**Comandos uteis:**
```bash
playwright install
npx playwright codegen http://localhost:3000
npx playwright test --ui
npx playwright show-trace trace.zip
```

---

### 2.8 test-automator

**Descricao:** Automacao com IA, auto-healing e CI/CD avancado.

**Exemplos praticos:**

```python
class AutoHealingLocator:
    def __init__(self, page):
        self.page = page
        self.strategies = [self.by_testid, self.by_text, self.by_css]

    def locate(self, desc):
        for s in self.strategies:
            try:
                loc = s(desc)
                if loc.count() > 0: return loc.first
            except: continue
        raise Exception(f"Not found: {desc}")

    def by_testid(self, d): return self.page.locator(f'[data-testid="{d}"]')
    def by_text(self, d): return self.page.locator(f'text="{d}"')
    def by_css(self, d): return self.page.locator(d)
```

```yaml
pipeline:
  stages:
    - name: test
      parallel:
        - { name: unit, command: "pytest tests/unit/" }
        - { name: e2e, command: "npx playwright test", retry: 3 }
      notifications:
        on_failure: slack
```

**Integracao:** `playwright-skill`, `browser-automation`, `e2e-testing-patterns`

---

### 2.9 webapp-testing (test-automation)

**Descricao:** Testar apps web locais com Playwright Python.

**Exemplos praticos:**

```python
from playwright.sync_api import sync_playwright
import requests

def test_local():
    try:
        requests.get('http://localhost:5173', timeout=5)
    except:
        raise Exception("Execute: npm run dev")

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        page.goto('http://localhost:5173')
        page.wait_for_load_state('networkidle')
        assert page.title() != ''
        page.screenshot(path='debug.png')
        browser.close()
```

```bash
# Com helper
python scripts/with_server.py --server "npm run dev" --port 5173 -- python test.py

# Multiplos servidores
python scripts/with_server.py   --server "cd backend && python server.py" --port 3000   --server "cd frontend && npm run dev" --port 5173   -- python test.py
```

**Integracao:** `playwright-skill`, `browser-automation`

---

## 3. development-and-testing-category-pointer (6 skills)

Skills de desenvolvimento e debugging.

---

### 3.1 bug-hunter

**Descricao:** Encontrar e corrigir bugs sistematicamente.

**Exemplos praticos:**

```python
class BugHunter:
    def hunt(self, symptom):
        repro = self.reproduce(symptom)
        area = self.isolate(repro)
        hypotheses = self.hypothesize(area)
        cause = self.test_hypotheses(hypotheses)
        fix = self.fix(cause)
        self.verify_no_regression(fix)
        return {'cause': cause, 'fix': fix}
```

```bash
# Bisect
git bisect start
git bisect bad HEAD
git bisect good v1.0
git bisect run pytest tests/test_specific.py
```

```python
import traceback, logging
def debug():
    try:
        return risky_operation()
    except Exception as e:
        logging.error(f"{e}\n{traceback.format_exc()}\nlocals={locals()}")
        raise
```

**Integracao:** `debugger`, `debugging-strategies`, `systematic-debugging`

---

### 3.2 debugger

**Descricao:** Especialista em debugging para erros e falhas.

**Exemplos praticos:**

```python
import pdb
def complex_fn(data):
    for item in data:
        if item.get('error'):
            pdb.set_trace()
        process(item)
```

```python
import logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

def fn(x, y):
    logger.debug(f"Input: x={x}, y={y}")
    result = x / y
    logger.debug(f"Result: {result}")
    return result
```

```python
import tracemalloc
tracemalloc.start()
data = [dict(i=i) for i in range(100000)]
snap = tracemalloc.take_snapshot()
for s in snap.statistics('lineno')[:10]:
    print(s)
```

**Integracao:** `bug-hunter`, `debugging-strategies`

**Comandos uteis:**
```bash
python -m pdb script.py
node --inspect-brk script.js
python -m memory_profiler script.py
```

---

### 3.3 debugging-strategies

**Descricao:** Estrategias sistematicas para debugging.

**Exemplos praticos:**

```python
def bisect_debug(code, test):
    lines = code.split('\n')
    half = len(lines) // 2
    first = '\n'.join(lines[:half])
    if not test(first):
        return bisect_debug(first, test)
    second = '\n'.join(lines[half:])
    if not test(second):
        return bisect_debug(second, test)
    return "Bug nao encontrado"
```

```python
def rubber_duck(problem):
    return f"""
    Problema: {problem}
    O que sei:
    1. Comportamento esperado: [descrever]
    2. Comportamento atual: [descrever]
    3. Quando comeca: [ponto inicio]
    4. O que mudou: [ultimas alteracoes]
    Hipoteses: [listar]
    Proximos passos: [testar uma por vez]
    """
```

```python
def minimize(test):
    minimal = test.copy()
    changed = True
    while changed:
        changed = False
        for el in list(minimal):
            t = minimal.copy(); del t[el]
            if not bug_occurs(t):
                minimal = t; changed = True; break
    return minimal
```

**Integracao:** `bug-hunter`, `debugger`, `systematic-debugging`

---

### 3.4 openclaw-github-repo-commander

**Descricao:** Workflow de 7 estagios para auditoria, limpeza, review de PR e analise de repositorios GitHub.

**Quando usar:** Auditoria completa de repositorio GitHub.

**Exemplos praticos:**

```bash
# 1. Clone e analise
git clone https://github.com/org/repo.git
cd repo

# 2. Verificar estrutura
find . -name "*.py" | head -20
wc -l $(find . -name "*.py")

# 3. Analise de dependencias
pip-audit
safety check

# 4. Analise de codigo
radon cc src/ -s
pylint src/
```

**Integracao:** `brooks-test`, `test-guard`, `testing-patterns`

---

### 3.5 systematic-debugging

**Descricao:** Abordagem sistematica para bugs, falhas e comportamento inesperado.

**Exemplos praticos:**

```python
class SystematicDebugger:
    def debug(self, issue):
        # 1. Reproduzir
        repro = self.reproduce(issue)
        # 2. Isolar
        area = self.isolate(repro)
        # 3. Analisar
        root = self.analyze(area)
        # 4. Corrigir
        fix = self.fix(root)
        # 5. Verificar
        self.verify(fix)
        # 6. Prevenir
        self.prevent(root)
        return fix
```

```python
def reproduce(steps):
    """Documentar passos para reproduzir"""
    for step in steps:
        execute(step)
    assert bug_present(), "Nao foi possivel reproduzir"
```

```python
def isolate_code(changed_files):
    """Encontrar codigo problematico"""
    for file in changed_files:
        if test_fails_with(file):
            return file
    return None
```

**Integracao:** `bug-hunter`, `debugger`, `debugging-strategies`

---

### 3.6 test-fixing

**Descricao:** Identificar e corrigir testes falhando com estrategias de agrupamento inteligente.

**Exemplos praticos:**

```python
class TestFixer:
    def fix_all(self, failures):
        # Agrupar por tipo
        groups = self.group_by_type(failures)
        # Priorizar
        priority = self.prioritize(groups)
        # Corrigir por grupo
        fixes = []
        for group in priority:
            fix = self.fix_group(group)
            fixes.append(fix)
        return fixes

    def group_by_type(self, failures):
        groups = {'assertion': [], 'timeout': [], 'import': [], 'other': []}
        for f in failures:
            if 'AssertionError' in f.error:
                groups['assertion'].append(f)
            elif 'Timeout' in f.error:
                groups['timeout'].append(f)
            elif 'Import' in f.error:
                groups['import'].append(f)
            else:
                groups['other'].append(f)
        return groups
```

```python
# Fix comum: import quebrado
def fix_imports(failures):
    for f in failures:
        if 'ImportError' in f.error:
            module = f.error.split("'")[1]
            subprocess.run(['pip', 'install', module])
```

```python
# Fix comum: fixture quebrada
def fix_fixtures(failures):
    for f in failures:
        if 'fixture' in f.error.lower():
            # Recriar fixture
            recreate_fixture(f.fixture_name)
```

**Integracao:** `debugger`, `bug-hunter`, `systematic-debugging`

---

## 4. webapp-testing (1 skill)

Skill especifica para testes de apps web locais.

---

### 4.1 webapp-testing

**Descricao:** Toolkit para interagir e testar apps web locais usando Playwright.

**Quando usar:** Testar app web local, inspecionar DOM, capturar screenshots, verificar logs.

**Arvore de decisao:**
- HTML estatico → Ler arquivo diretamente
- Dinamico sem servidor → `python scripts/with_server.py --help`
- Dinamico com servidor → navegar, esperar networkidle, DOM, acoes

**Exemplos praticos:**

```bash
# Servidor unico
python scripts/with_server.py --server "npm run dev" --port 5173 -- python test.py

# Multiplos servidores
python scripts/with_server.py \
  --server "cd backend && python server.py" --port 3000 \
  --server "cd frontend && npm run dev" --port 5173 \
  -- python test.py
```

```python
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.goto('http://localhost:5173')
    page.wait_for_load_state('networkidle')  # CRITICO
    # ... automacao ...
    page.screenshot(path='result.png', full_page=True)
    browser.close()
```

```python
# Exemplo completo de teste
def test_full_app():
    import requests
    # Verificar servidor
    try:
        requests.get('http://localhost:5173', timeout=5)
    except:
        raise Exception("Servidor nao esta rodando!")

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        # Navegar
        page.goto('http://localhost:5173')
        page.wait_for_load_state('networkidle')

        # Verificar elementos
        assert page.locator('h1').count() > 0
        assert page.locator('body').is_visible()

        # Interagir
        page.fill('#search', 'teste')
        page.click('button[type="submit"]')
        page.wait_for_selector('.results')

        # Verificar resultado
        assert page.locator('.result-item').count() > 0

        # Screenshot
        page.screenshot(path='test_result.png', full_page=True)

        browser.close()
```

**Pitfall comum:** NUNCA inspecionar DOM antes de esperar networkidle em apps dinamicas.

**Melhores praticas:**
- Usar scripts auxiliares como caixas-pretas
- Usar sync_playwright()
- Sempre fechar o browser
- Usar seletores descritivos
- Adicionar waits apropriados

**Integracao com outras skills:**
- `playwright-skill`: Automacao avancada
- `browser-automation`: Padroes
- `browser-testing-with-devtools`: Analise

**Comandos uteis:**
```bash
# Verificar servidor
curl -s http://localhost:5173 > /dev/null && echo "Rodando" || echo "Parado"

# Instalar Playwright
pip install playwright
playwright install

# Executar teste
python test.py
python scripts/with_server.py --server "npm run dev" --port 5173 -- python test.py
```

**Referencias:**
- [Playwright Python](https://playwright.dev/python/)
- [Playwright Test Configuration](https://playwright.dev/docs/test-configuration)

---


## Resumo Geral

| Categoria | Qtd | Foco Principal |
|---|---|---|
| testing-category-pointer | 30 | Testes em geral (unit, E2E, TDD, load, visual, A/B, acessibilidade, shell) |
| test-automation-category-pointer | 9 | Automacao com frameworks (Playwright, Cypress, Selenium) |
| development-and-testing-category-pointer | 6 | Debugging, correcao de bugs e testes |
| webapp-testing | 1 | Apps web locais com Playwright Python |
| **TOTAL** | **46** | |

### Melhorias aplicadas (v2):

1. **Exemplos praticos:** 2-3 exemplos de codigo por skill com templates prontos
2. **Casos de uso avancados:** Cenarios reais de empresa por area (e-commerce, fintech, saude, etc.)
3. **Integracao com skills:** Mapeamento de skills complementares para workflows completos
4. **Padroes e anti-padroes:** Listas claras do que fazer e evitar
5. **Dicas de performance:** Otimizacoes praticas para cada skill
6. **Comandos uteis:** Snippets de bash/python prontos para copiar e usar
7. **Referencias:** Links para documentacao oficial de cada ferramenta

### Categorias de uso mais frequentes:

1. **TDD** — 8 skills (orchestrator, workflow, red, green, refactor, tdd, etc.)
2. **Playwright/Browser** — 8 skills (playwright, go-playwright, java, browser-automation, devtools, webapp-testing)
3. **Debugging** — 5 skills (bug-hunter, debugger, strategies, systematic, test-fixing)
4. **Agent QA** — 3 skills (authoring, debug-fix, triage)
5. **E2E Testing** — 3 skills (patterns, cypress, awt)
6. **Unit Testing** — 3 skills (pytest, patterns, test-generate)
7. **Test Quality** — 3 skills (brooks-test, test-guard, mock-hunter)
8. **Performance** — 2 skills (k6, devtools)
9. **Visual Regression** — 2 skills (smartui, awt)
10. **Acessibilidade** — 1 skill (screen-reader-testing)
11. **Shell Testing** — 1 skill (bats)
12. **Android** — 2 skills (journey, verification)
13. **Migration** — 1 skill (framework-migration)
