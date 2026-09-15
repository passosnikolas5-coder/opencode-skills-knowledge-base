# 📐 Statistics Skills - 3.000 Skills

> **Todas as habilidades de estatística documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| Descriptive Statistics | 500 | Básico → Expert |
| Inferential Statistics | 600 | Intermediário → Expert |
| Regression Analysis | 500 | Intermediário → Expert |
| Experimental Design | 500 | Intermediário → Expert |
| Bayesian Statistics | 400 | Avançado → Expert |
| Applied Statistics | 500 | Intermediário → Expert |

---

## 📈 Descriptive Statistics (500)

### Central Tendency (150)

#### STA001: Measures of Central Tendency
```lua
-- SKILL: Measures of Central Tendency
-- Nível: Básico → Expert
-- Contexto: Medidas de tendência central

-- MEDIDAS:
-- 1. Mean: arithmetic average
-- 2. Median: middle value
-- 3. Mode: most frequent value
-- 4. Trimmed Mean: robust to outliers
-- 5. Weighted Mean: importance-based

-- QUANDO USAR:
-- Mean: symmetric distributions
-- Median: skewed distributions
-- Mode: categorical data

-- MELHORIA:
-- ERRADO: Always using mean
-- CERTO: Choosing appropriate measure
```

### Dispersion (100)

#### STA002: Measures of Dispersion
```lua
-- SKILL: Measures of Dispersion
-- Nível: Básico → Expert
-- Contexto: Medidas de dispersão

-- MEDIDAS:
-- 1. Range: max - min
-- 2. Variance: average squared deviation
-- 3. Standard Deviation: sqrt of variance
-- 4. IQR: interquartile range
-- 5. Coefficient of Variation: relative dispersion

-- MELHORIA:
-- ERRADO: No dispersion analysis
-- CERTO: Understanding data spread
```

### Distribution Shapes (100)

#### STA003: Distribution Shapes
```lua
-- SKILL: Distribution Shapes
-- Nível: Básico → Expert
-- Contexto: Formas de distribuição

-- FORMAS:
-- 1. Symmetric: normal, uniform
-- 2. Skewed Right: positive skew
-- 3. Skewed Left: negative skew
-- 4. Bimodal: two peaks
-- 5. Multimodal: multiple peaks

-- MÉTODAS:
-- Histogram, Box Plot, Q-Q Plot

-- MELHORIA:
-- ERRADO: Assuming normality
-- CERTO: Checking distribution shape
```

### Outlier Detection (150)

#### STA004: Outlier Detection
```lua
-- SKILL: Outlier Detection
-- Nível: Intermediário → Expert
-- Contexto: Detecção de outliers

-- MÉTODOS:
-- 1. Z-Score: |z| > 3
-- 2. IQR: below Q1-1.5*IQR or above Q3+1.5*IQR
-- 3. Modified Z-Score: median-based
-- 4. Grubbs Test: formal test
-- 5. DBSCAN: density-based clustering

-- MELHORIA:
-- ERRADO: Removing all outliers
-- CERTO: Understanding and handling outliers appropriately
```

### Summary Statistics (100)

#### STA005: Summary Statistics
```lua
-- SKILL: Summary Statistics
-- Nível: Básico → Expert
-- Contexto: Estatísticas resumidas

-- CONCEITOS:
-- 1. Five-Number Summary: min, Q1, median, Q3, max
-- 2. Shape: skewness, kurtosis
-- 3. Correlation: linear association
-- 4. Cross-Tabulation: categorical relationships
-- 5. Visualization: charts, graphs

-- MELHORIA:
-- ERRADO: Raw data only
-- CERTO: Clear, visual summaries
```

---

## 🔬 Inferential Statistics (600)

### Hypothesis Testing (200)

#### STA006: Hypothesis Testing
```lua
-- SKILL: Hypothesis Testing
-- Nível: Intermediário → Expert
-- Contexto: Testes de hipótese

-- PROCESSO:
-- 1. H₀: null hypothesis
-- 2. H₁: alternative hypothesis
-- 3. α: significance level (0.05)
-- 4. Test Statistic: calculated value
-- 5. P-Value: probability of result
-- 6. Decision: reject or fail to reject

-- ERROS:
-- Type I: false positive (α)
-- Type II: false negative (β)

-- MELHORIA:
-- ERRADO: P-hacking
-- CERTO: Pre-specified hypotheses + proper interpretation
```

### Confidence Intervals (100)

#### STA007: Confidence Intervals
```lua
-- SKILL: Confidence Intervals
-- Nível: Intermediário → Expert
-- Contexto: Intervalos de confiança

-- CONCEITOS:
-- 1. Point Estimate: single value
-- 2. Margin of Error: ± value
-- 3. Confidence Level: 95%, 99%
-- 4. Width: precision trade-off
-- 5. Interpretation: repeated sampling

-- FÓRMULA:
-- Estimate ± z * (σ/√n)

-- MELHORIA:
-- ERRADO: Point estimates only
-- CERTO: Intervals with confidence levels
```

### Sample Size Determination (100)

#### STA008: Sample Size Determination
```lua
-- SKILL: Sample Size Determination
-- Nível: Intermediário → Expert
-- Contexto: Determinação do tamanho da amostra

-- CONCEITOS:
-- 1. Margin of Error: precision needed
-- 2. Confidence Level: 95%, 99%
-- 3. Variability: population variance
-- 4. Effect Size: meaningful difference
-- 5. Power: probability of detection

-- MELHORIA:
-- ERRADO: Arbitrary sample sizes
-- CERTO: Power analysis for sample size
```

### Parametric Tests (100)

#### STA009: Parametric Tests
```lua
-- SKILL: Parametric Tests
-- Nível: Intermediário → Expert
-- Contexto: Testes paramétricos

-- TESTES:
-- 1. T-Test: one sample, two sample
-- 2. ANOVA: one-way, two-way
-- 3. Paired T-Test: before/after
-- 4. Welch's T-Test: unequal variances
-- 5. Repeated Measures: within-subjects

-- PRESSUPOSTOS:
-- Normality, Independence, Homogeneity

-- MELHORIA:
-- ERRADO: Using without checking assumptions
-- CERTO: Verifying assumptions first
```

### Non-Parametric Tests (100)

#### STA010: Non-Parametric Tests
```lua
-- SKILL: Non-Parametric Tests
-- Nível: Intermediário → Expert
-- Contexto: Testes não-paramétricos

-- TESTES:
-- 1. Mann-Whitney U: two independent groups
-- 2. Wilcoxon Signed-Rank: paired data
-- 3. Kruskal-Wallis: multiple groups
-- 4. Chi-Square: categorical association
-- 5. Fisher's Exact: small samples

-- QUANDO USAR:
-- Small samples, ordinal data
-- Violated normality assumption

-- MELHORIA:
-- ERRADO: Always using parametric tests
-- CERTO: Choosing appropriate test
```

---

## 📉 Regression Analysis (500)

### Simple Linear Regression (100)

#### STA011: Simple Linear Regression
```lua
-- SKILL: Simple Linear Regression
-- Nível: Intermediário → Expert
-- Contexto: Regressão linear simples

-- CONCEITOS:
-- 1. Model: y = β₀ + β₁x + ε
-- 2. Coefficients: slope, intercept
-- 3. R²: coefficient of determination
-- 4. Residuals: errors
-- 5. Assumptions: linearity, normality

-- MELHORIA:
-- ERRADO: R² as only metric
-- CERTO: Residual analysis + assumptions checking
```

### Multiple Regression (100)

#### STA012: Multiple Regression
```lua
-- SKILL: Multiple Regression
-- Nível: Intermediário → Expert
-- Contexto: Regressão múltipla

-- CONCEITOS:
-- 1. Model: y = β₀ + β₁x₁ + β₂x₂ + ... + ε
-- 2. Adjusted R²: accounts for predictors
-- 3. Multicollinearity: VIF
-- 4. Variable Selection: forward, backward
-- 5. Interaction Effects: combined influence

-- MELHORIA:
-- ERRADO: Throwing in all variables
-- CERTO: Careful variable selection
```

### Logistic Regression (100)

#### STA013: Logistic Regression
```lua
-- SKILL: Logistic Regression
-- Nível: Intermediário → Expert
-- Contexto: Regressão logística

-- CONCEITOS:
-- 1. Binary Outcome: 0/1
-- 2. Odds Ratio: interpretation
-- 3. Log-Likelihood: model fit
-- 4. Classification: threshold
-- 5. ROC Curve: performance

-- MELHORIA:
-- ERRADO: Linear regression for binary outcomes
-- CERTO: Logistic regression for classification
```

### Time Series Regression (100)

#### STA014: Time Series Regression
```lua
-- SKILL: Time Series Regression
-- Nível: Intermediário → Expert
-- Contexto: Regressão de séries temporais

-- CONCEITOS:
-- 1. Trend: long-term movement
-- 2. Seasonality: periodic patterns
-- 3. Autocorrelation: serial dependence
-- 4. Stationarity: constant properties
-- 5. Forecasting: prediction

-- MÉTODOS:
-- ARIMA, Exponential Smoothing
-- Prophet, Structural Models

-- MELHORIA:
-- ERRADO: Ignoring time dependence
-- CERTO: Proper time series methods
```

### Non-Linear Regression (100)

#### STA015: Non-Linear Regression
```lua
-- SKILL: Non-Linear Regression
-- Nível: Intermediário → Expert
-- Contexto: Regressão não-linear

-- MODELOS:
-- 1. Polynomial: curved relationships
-- 2. Exponential: growth, decay
-- 3. Logarithmic: diminishing returns
-- 4. Sigmoidal: S-shaped curves
-- 5. Power: scale relationships

-- MELHORIA:
-- ERRADO: Linear assumption always
-- CERTO: Appropriate model for data
```

---

## 🧪 Experimental Design (500)

### Randomized Control Trials (150)

#### STA016: Randomized Control Trials
```lua
-- SKILL: Randomized Control Trials
-- Nível: Intermediário → Expert
-- Contexto: Ensaios clínicos randomizados

-- ELEMENTOS:
-- 1. Randomization: treatment assignment
-- 2. Control Group: baseline comparison
-- 3. Blinding: single, double
-- 4. Sample Size: power analysis
-- 5. Analysis: intention-to-treat

-- MELHORIA:
-- ERRADO: No randomization
-- CERTO: Proper RCT design
```

### Factorial Design (100)

#### STA017: Factorial Design
```lua
-- SKILL: Factorial Design
-- Nível: Intermediário → Expert
-- Contexto: Design fatorial

-- CONCEITOS:
-- 1. Factors: independent variables
-- 2. Levels: values of each factor
-- 3. Interactions: combined effects
-- 4. Main Effects: individual effects
-- 5. Fractional: reduced complexity

-- MELHORIA:
-- ERRADO: One-factor-at-a-time
-- CERTO: Factorial for interaction detection
```

### Response Surface Methods (100)

#### STA018: Response Surface Methods
```lua
-- SKILL: Response Surface Methods
-- Nível: Avançado → Expert
-- Contexto: Métodos de superfície de resposta

-- CONCEITOS:
-- 1. Central Composite: rotatable design
-- 2. Box-Behnken: efficient design
-- 3. Optimization: find best conditions
-- 4. Contour Plots: visual optimization
-- 5. Desirability: multi-response

-- MELHORIA:
-- ERRADO: No optimization design
-- CERTO: RSM for process optimization
```

### Quasi-Experimental (150)

#### STA019: Quasi-Experimental Design
```lua
-- SKILL: Quasi-Experimental Design
-- Nível: Intermediário → Expert
-- Contexto: Design quasi-experimental

-- MÉTODOS:
-- 1. Difference-in-Differences: before/after
-- 2. Regression Discontinuity: cutoff
-- 3. Propensity Score Matching: matching
-- 4. Instrumental Variables: causal
-- 5. Interrupted Time Series: intervention

-- MELHORIA:
-- ERRADO: No causal inference
-- CERTO: Quasi-experimental for causal claims
```

---

## 🔄 Bayesian Statistics (400)

### Bayesian Inference (150)

#### STA020: Bayesian Inference
```lua
-- SKILL: Bayesian Inference
-- Nível: Avançado → Expert
-- Contexto: Inferência bayesiana

-- CONCEITOS:
-- 1. Prior: initial belief
-- 2. Likelihood: data evidence
-- 3. Posterior: updated belief
-- 4. Credible Interval: Bayesian CI
-- 5. Bayes Factor: evidence strength

-- MELHORIA:
-- ERRADO: Frequentist only
-- CERTO: Bayesian for uncertainty quantification
```

### MCMC Methods (100)

#### STA021: MCMC Methods
```lua
-- SKILL: MCMC Methods
-- Nível: Avançado → Expert
-- Contexto: Métodos MCMC

-- MÉTODOS:
-- 1. Metropolis-Hastings: basic MCMC
-- 2. Gibbs Sampling: conditional distributions
-- 3. Hamiltonian MC: efficient sampling
-- 4. NUTS: No-U-Turn Sampler
-- 5. Convergence: diagnostics

-- FERRAMENTAS:
-- Stan, PyMC, JAGS

-- MELHORIA:
-- ERRADO: No convergence checking
-- CERTO: Proper MCMC diagnostics
```

### Bayesian Modeling (150)

#### STA022: Bayesian Modeling
```lua
-- SKILL: Bayesian Modeling
-- Nível: Avançado → Expert
-- Contexto: Modelagem bayesiana

-- MODELOS:
-- 1. Hierarchical: multilevel
-- 2. Mixture: latent classes
-- 3. State-Space: time-varying
-- 4. Gaussian Process: non-parametric
-- 5. Bayesian Networks: graphical

-- MELHORIA:
-- ERRADO: Simple Bayesian only
-- CERTO: Advanced Bayesian models for complex problems
```

---

## 📊 Applied Statistics (500)

### Biostatistics (100)

#### STA023: Biostatistics
```lua
-- SKILL: Biostatistics
-- Nível: Intermediário → Expert
-- Contexto: Bioestatística

-- APLICAÇÕES:
-- 1. Clinical Trials: RCT design
-- 2. Epidemiology: risk, prevalence
-- 3. Survival Analysis: time-to-event
-- 4. Genomics: GWAS, multiple testing
-- 5. meta-analysis: combining studies

-- MELHORIA:
-- ERRADO: Standard stats for biology
-- CERTO: Specialized biostatistical methods
```

### Econometrics (100)

#### STA024: Econometrics
```lua
-- SKILL: Econometrics
-- Nível: Intermediário → Expert
-- Contexto: Econometria

-- MÉTODOS:
-- 1. Panel Data: fixed effects, random effects
-- 2. Instrumental Variables: endogeneity
-- 3. Time Series: ARIMA, GARCH
-- 4. Limited Dependent Variables: Tobit, Probit
-- 5. Causal Inference: DID, RDD

-- MELHORIA:
-- ERRADO: Simple regression for economics
-- CERTO: Proper econometric methods
```

### Psychometrics (100)

#### STA025: Psychometrics
```lua
-- SKILL: Psychometrics
-- Nível: Intermediário → Expert
-- Contexto: Psicometria

-- CONCEITOS:
-- 1. Reliability: Cronbach's alpha
-- 2. Validity: construct, criterion
-- 3. Item Response Theory: IRT
-- 4. Factor Analysis: latent variables
-- 5. Test Development: norming, scaling

-- MELHORIA:
-- ERRADO: No measurement theory
-- CERTO: Psychometric rigor in testing
```

### Social Statistics (100)

#### STA026: Social Statistics
```lua
-- SKILL: Social Statistics
-- Nível: Intermediário → Expert
-- Contexto: Estatística social

-- MÉTODOS:
-- 1. Survey Analysis: weighting, design effects
-- 2. Multilevel Modeling: nested data
-- 3. Structural Equation: latent relationships
-- 4. Qualitative-Quantitative Mixed: mixed methods
-- 5. Longitudinal: panel studies

-- MELHORIA:
-- ERRADO: Ignoring survey design
-- CERTO: Design-appropriate analysis
```

### Industrial Statistics (100)

#### STA027: Industrial Statistics
```lua
-- SKILL: Industrial Statistics
-- Nível: Intermediário → Expert
-- Contexto: Estatística industrial

-- APLICAÇÕES:
-- 1. Quality Control: SPC, control charts
-- 2. Reliability: failure analysis
-- 3. Design of Experiments: process optimization
-- 4. Acceptance Sampling: lot inspection
-- 5. Process Capability: Cpk, Ppk

-- MELHORIA:
-- ERRADO: No statistical quality control
-- CERTO: Statistical methods for quality
```

---

*Statistics Skills v1.0 - Setembro 2026*