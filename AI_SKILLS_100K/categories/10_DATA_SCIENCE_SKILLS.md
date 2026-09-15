# 📊 Data Science Skills - 8.000 Skills

> **Todas as habilidades de ciência de dados documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| Machine Learning | 1.500 | Intermediário → Expert |
| Deep Learning | 1.200 | Intermediário → Expert |
| NLP | 1.000 | Intermediário → Expert |
| Computer Vision | 800 | Intermediário → Expert |
| MLOps | 800 | Intermediário → Expert |
| Data Engineering | 1.000 | Básico → Expert |
| Statistics | 600 | Básico → Expert |
| Visualization | 500 | Básico → Expert |
| Domain Applications | 600 | Intermediário → Expert |

---

## 🤖 Machine Learning (1.500)

### Supervised Learning (400)

#### DS001: Supervised Learning Mastery
```lua
-- SKILL: Supervised Learning Mastery
-- Nível: Intermediário → Expert
-- Contexto: Aprendizado supervisionado

-- ALGORITMOS:
-- 1. Linear Regression: continuous targets
-- 2. Logistic Regression: binary classification
-- 3. Decision Trees: interpretable
-- 4. Random Forest: ensemble, robust
-- 5. Gradient Boosting: XGBoost, LightGBM, CatBoost
-- 6. SVM: high-dimensional data
-- 7. KNN: instance-based
-- 8. Naive Bayes: probabilistic

-- MELHORIA:
-- ERRADO: Usar apenas um algoritmo
-- CERTO: Ensemble + cross-validation
```

### Unsupervised Learning (400)

#### DS002: Unsupervised Learning
```lua
-- SKILL: Unsupervised Learning
-- Nível: Intermediário → Expert
-- Contexto: Aprendizado não supervisionado

-- ALGORITMOS:
-- 1. K-Means: clustering
-- 2. DBSCAN: density-based clustering
-- 3. Hierarchical: agglomerative/divisive
-- 4. PCA: dimensionality reduction
-- 5. t-SNE: visualization
-- 6. UMAP: manifold learning
-- 7. Autoencoders: neural clustering
-- 8. Gaussian Mixture: probabilistic

-- MELHORIA:
-- ERRADO: K-Means para tudo
-- CERTO: Choose based on data structure
```

### Feature Engineering (300)

#### DS003: Feature Engineering
```lua
-- SKILL: Feature Engineering
-- Nível: Intermediário → Expert
-- Contexto: Criar features eficazes

-- TÉCNICAS:
-- 1. Encoding: one-hot, label, target
-- 2. Scaling: standard, min-max, robust
-- 3. Transformation: log, sqrt, box-cox
-- 4. Interaction: polynomial, ratios
-- 5. Aggregation: groupby statistics
-- 6. Text: TF-IDF, embeddings
-- 7. Date: cyclical, holidays
-- 8. Missing: imputation strategies

-- MELHORIA:
-- ERRADO: Apenas features numéricas
-- CERTO: Domain knowledge + feature selection
```

### Model Selection (400)

#### DS004: Model Selection & Tuning
```lua
-- SKILL: Model Selection & Tuning
-- Nível: Intermediário → Expert
-- Contexto: Selecionar e ajustar modelos

-- PROCESSO:
-- 1. Baseline: simple model first
-- 2. Cross-Validation: k-fold, stratified
-- 3. Hyperparameter Tuning: grid, random, bayesian
-- 4. Ensemble: stacking, blending
-- 5. Evaluation: metrics selection

-- MÉTRICAS:
-- Classification: accuracy, F1, AUC-ROC, PR-AUC
-- Regression: MAE, RMSE, R², MAPE
-- Ranking: NDCG, MAP, MRR

-- MELHORIA:
-- ERRADO: Overfitting to test set
-- CERTO: Proper train/validation/test split
```

---

## 🧠 Deep Learning (1.200)

### Neural Networks Fundamentals (300)

#### DS005: Neural Networks Fundamentals
```lua
-- SKILL: Neural Networks Fundamentals
-- Nível: Intermediário → Expert
-- Contexto: Fundamentos de redes neurais

-- CONCEITOS:
-- 1. Perceptron: basic unit
-- 2. Activation Functions: ReLU, sigmoid, softmax
-- 3. Loss Functions: cross-entropy, MSE
-- 4. Optimizers: SGD, Adam, AdamW
-- 5. Regularization: dropout, batch norm, weight decay
-- 6. Learning Rate Scheduling: cosine, warmup

-- MELHORIA:
-- ERRADO: Deep network for simple problem
-- CERTO: Start simple, increase complexity
```

### Transformers (300)

#### DS006: Transformers Architecture
```lua
-- SKILL: Transformers Architecture
-- Nível: Intermediário → Expert
-- Contexto: Arquitetura Transformer

-- COMPONENTES:
-- 1. Self-Attention: Q, K, V matrices
-- 2. Multi-Head Attention: parallel heads
-- 3. Positional Encoding: sequence order
-- 4. Feed-Forward Network: two linear layers
-- 5. Layer Normalization: pre/post norm
-- 6. Residual Connections: gradient flow

-- VARIANTES:
-- Encoder-only: BERT (classification)
-- Decoder-only: GPT (generation)
-- Encoder-Decoder: T5 (seq2seq)

-- MELHORIA:
-- ERRADO: Training from scratch
-- CERTO: Fine-tuning pre-trained models
```

### Diffusion Models (200)

#### DS007: Diffusion Models
```lua
-- SKILL: Diffusion Models
-- Nível: Avançado → Expert
-- Contexto: Modelos de difusão

-- CONCEITOS:
-- 1. Forward Process: add noise
-- 2. Reverse Process: denoise
-- 3. DDPM: denoising diffusion
-- 4. Stable Diffusion: latent space
-- 5. ControlNet: conditional generation
-- 6. LoRA: efficient fine-tuning

-- APLICAÇÕES:
-- Image generation, Inpainting
-- Super-resolution, Editing
-- Video generation, 3D generation
```

### Reinforcement Learning (200)

#### DS008: Reinforcement Learning
```lua
-- SKILL: Reinforcement Learning
-- Nível: Avançado → Expert
-- Contexto: Aprendizado por reforço

-- CONCEITOS:
-- 1. Agent-Environment: MDP framework
-- 2. Value Functions: Q(s,a), V(s)
-- 3. Policy Gradient: REINFORCE, PPO
-- 4. Model-Based: planning
-- 5. Multi-Agent: MARL

-- ALGORITMOS:
-- Q-Learning, DQN, A3C, PPO, SAC
-- DPO, RLHF (for LLMs)

-- MELHORIA:
-- ERRADO: Reward hacking
-- CERTO: Careful reward design + constraints
```

### Generative AI (200)

#### DS009: Generative AI
```lua
-- SKILL: Generative AI
-- Nível: Intermediário → Expert
-- Contexto: IA generativa

-- MODELOS:
-- 1. GPT: text generation
-- 2. DALL-E: image generation
-- 3. Whisper: speech-to-text
-- 4. Codex: code generation
-- 5. Sora: video generation
-- 6. MusicGen: music generation

-- TÉCNICAS:
-- Prompt Engineering
-- Fine-tuning (LoRA, QLoRA)
-- RAG (Retrieval-Augmented Generation)
-- Agents (tool use, planning)

-- MELHORIA:
-- ERRADO: Zero-shot everything
-- CERTO: Fine-tune + RAG for domain-specific
```

---

## 💬 NLP (1.000)

### Text Processing (200)

#### DS010: Text Processing
```lua
-- SKILL: Text Processing
-- Nível: Básico → Expert
-- Contexto: Processamento de texto

-- TÉCNICAS:
-- 1. Tokenization: word, subword, character
-- 2. Stemming/Lemmatization: normalization
-- 3. Stop Words: removal
-- 4. N-grams: n-grams features
-- 5. TF-IDF: term frequency
-- 6. Word Embeddings: Word2Vec, GloVe

-- MELHORIA:
-- ERRADO: Apenas bag-of-words
-- CERTO: Contextual embeddings (BERT)
```

### Language Models (300)

#### DS011: Language Models
```lua
-- SKILL: Language Models
-- Nível: Intermediário → Expert
-- Contexto: Modelos de linguagem

-- TIPOS:
-- 1. Statistical: n-gram models
-- 2. Neural: LSTM, Transformer
-- 3. Pre-trained: BERT, GPT, T5
-- 4. Large Language Models: GPT-4, Claude, Gemini

-- APLICAÇÕES:
-- Text Classification, NER, Sentiment Analysis
-- Question Answering, Summarization
-- Translation, Dialogue Systems

-- MELHORIA:
-- ERRADO: Training from scratch
-- CERTO: Fine-tune pre-trained + domain adaptation
```

### Advanced NLP (500)

#### DS012: Advanced NLP
```lua
-- SKILL: Advanced NLP
-- Nível: Avançado → Expert
-- Contexto: NLP avançado

-- TAREFAS:
-- 1. Named Entity Recognition: NER
-- 2. Relation Extraction: entities → relations
-- 3. Coreference Resolution: pronouns
-- 4. Question Answering: extractive, generative
-- 5. Summarization: extractive, abstractive
-- 6. Translation: neural machine translation
-- 7. Dialogue Systems: task-oriented, open-domain
-- 8. Sentiment Analysis: aspect-based

-- MÉTRICAS:
-- BLEU, ROUGE, METEOR (generation)
-- F1, Precision, Recall (classification)
-- Perplexity (language modeling)
```

---

## 👁️ Computer Vision (800)

### Image Processing (200)

#### DS013: Image Processing
```lua
-- SKILL: Image Processing
-- Nível: Intermediário → Expert
-- Contexto: Processamento de imagens

-- TÉCNICAS:
-- 1. Filtering: blur, sharpen, edge detection
-- 2. Morphology: erosion, dilation
-- 3. Color Space: RGB, HSV, LAB
-- 4. Histogram: equalization
-- 5. Segmentation: threshold, watershed

-- FERRAMENTAS:
-- OpenCV, PIL/Pillow, scikit-image
-- TensorFlow, PyTorch
```

### Object Detection (200)

#### DS014: Object Detection
```lua
-- SKILL: Object Detection
-- Nível: Intermediário → Expert
-- Contexto: Detecção de objetos

-- MODELOS:
-- 1. YOLO: real-time detection
-- 2. SSD: single-shot detector
-- 3. Faster R-CNN: two-stage
-- 4. DETR: transformer-based
-- 5. EfficientDet: efficient scaling

-- MÉTRICAS:
-- mAP (mean Average Precision)
-- IoU (Intersection over Union)
-- FPS (Frames Per Second)

-- MELHORIA:
-- ERRADO: Training from scratch
-- CERTO: Transfer learning + fine-tuning
```

### Image Segmentation (200)

#### DS015: Image Segmentation
```lua
-- SKILL: Image Segmentation
-- Nível: Intermediário → Expert
-- Contexto: Segmentação de imagens

-- TIPOS:
-- 1. Semantic: pixel-level classification
-- 2. Instance: individual objects
-- 3. Panoptic: semantic + instance

-- MODELOS:
-- U-Net: medical imaging
-- Mask R-CNN: instance segmentation
-- DeepLab: semantic segmentation
-- SAM: segment anything

-- APLICAÇÕES:
-- Medical imaging, Autonomous driving
-- Satellite imagery, AR/VR
```

### Video Analysis (200)

#### DS016: Video Analysis
```lua
-- SKILL: Video Analysis
-- Nível: Intermediário → Expert
-- Contexto: Análise de vídeo

-- TAREFAS:
-- 1. Action Recognition: classify actions
-- 2. Object Tracking: follow objects
-- 3. Video Captioning: describe content
-- 4. Anomaly Detection: detect unusual
-- 5. Video Summarization: key frames

-- MODELOS:
-- 3D CNNs: C3D, I3D
-- Two-Stream: RGB + Flow
-- Transformers: ViViT, TimeSformer
```

---

## 🔧 MLOps (800)

### ML Infrastructure (300)

#### DS017: ML Infrastructure
```lua
-- SKILL: ML Infrastructure
-- Nível: Intermediário → Expert
-- Contexto: Infraestrutura de ML

-- CONCEITOS:
-- 1. Experiment Tracking: MLflow, W&B
-- 2. Feature Store: Feast, Tecton
-- 3. Model Registry: MLflow Model Registry
-- 4. Pipeline Orchestration: Kubeflow, Airflow
-- 5. Serving: TensorFlow Serving, Triton

-- MELHORIA:
-- ERRADO: Manual model deployment
-- CERTO: Automated ML pipeline
```

### Model Deployment (200)

#### DS018: Model Deployment
```lua
-- SKILL: Model Deployment
-- Nível: Intermediário → Expert
-- Contexto: Deploy de modelos

-- ESTRATÉGIAS:
-- 1. Batch: scheduled predictions
-- 2. Real-time: API serving
-- 3. Edge: on-device inference
-- 4. Streaming: real-time pipeline

-- PLATAFORMAS:
-- AWS SageMaker, Google Vertex AI
-- Azure ML, Databricks
-- Seldon Core, BentoML

-- MELHORIA:
-- ERRADO: Jupyter notebook em produção
-- CERTO: Containerized + monitored model
```

### Monitoring & Observability (150)

#### DS019: ML Monitoring
```lua
-- SKILL: ML Monitoring
-- Nível: Intermediário → Expert
-- Contexto: Monitorar modelos

-- MONITORED:
-- 1. Data Drift: input distribution change
-- 2. Concept Drift: relationship change
-- 3. Model Performance: accuracy decay
-- 4. Infrastructure: latency, throughput
-- 5. Business Metrics: revenue, conversion

-- FERRAMENTAS:
-- Evidently AI, WhyLabs
-- NannyML, Fiddler AI
-- Grafana + Prometheus

-- MELHORIA:
-- ERRADO: Deploy and forget
-- CERTO: Continuous monitoring + retraining
```

### ML Governance (150)

#### DS020: ML Governance
```lua
-- SKILL: ML Governance
-- Nível: Avançado → Expert
-- Contexto: Governança de ML

-- CONCEITOS:
-- 1. Model Cards: documentation
-- 2. Fairness: bias detection
-- 3. Explainability: SHAP, LIME
-- 4. Reproducibility: version control
-- 5. Compliance: GDPR, AI Act

-- MELHORIA:
-- ERRADO: Black box models
-- CERTO: Explainable + auditable models
```

---

## 🔧 Data Engineering (1.000)

### Data Pipelines (300)

#### DS021: Data Pipelines
```lua
-- SKILL: Data Pipelines
-- Nível: Intermediário → Expert
-- Contexto: Pipelines de dados

-- FERRAMENTAS:
-- 1. Apache Airflow: orchestration
-- 2. Apache Spark: big data processing
-- 3. dbt: data transformation
-- 4. Apache Kafka: streaming
-- 5. Apache Flink: stream processing

-- PADRÕES:
-- ETL (Extract, Transform, Load)
-- ELT (Extract, Load, Transform)
-- CDC (Change Data Capture)
-- Lambda Architecture
-- Kappa Architecture

-- MELHORIA:
-- ERRADO: Batch only
-- CERTO: Real-time + batch hybrid
```

### Data Warehousing (250)

#### DS022: Data Warehousing
```lua
-- SKILL: Data Warehousing
-- Nível: Intermediário → Expert
-- Contexto: Data warehouse

-- PLATAFORMAS:
-- 1. Snowflake: cloud data platform
-- 2. BigQuery: Google analytics
-- 3. Redshift: AWS data warehouse
-- 4. Databricks: lakehouse
-- 5. ClickHouse: OLAP database

-- CONCEITOS:
-- Star Schema: dimension + fact tables
-- Slowly Changing Dimensions (SCD)
-- Data Vault: audit trail
-- Data Mesh: domain ownership

-- MELHORIA:
-- ERRADO: One giant table
-- CERTO: Proper dimensional modeling
```

### Data Quality (250)

#### DS023: Data Quality
```lua
-- SKILL: Data Quality
-- Nível: Intermediário → Expert
-- Contexto: Qualidade de dados

-- DIMENSÕES:
-- 1. Accuracy: correct values
-- 2. Completeness: no missing
-- 3. Consistency: no conflicts
-- 4. Timeliness: up to date
-- 5. Validity: format rules
-- 6. Uniqueness: no duplicates

-- FERRAMENTAS:
-- Great Expectations, Deequ
-- Soda, Elementary
-- dbt tests, Monte Carlo

-- MELHORIA:
-- ERRADO: Fix data after problems
-- CERTO: Preventive quality checks
```

### Streaming (200)

#### DS024: Real-time Streaming
```lua
-- SKILL: Real-time Streaming
-- Nível: Intermediário → Expert
-- Contexto: Streaming em tempo real

-- PLATAFORMAS:
-- 1. Apache Kafka: event streaming
-- 2. Apache Pulsar: cloud-native
-- 3. AWS Kinesis: managed streaming
-- 4. Google Pub/Sub: messaging
-- 5. Azure Event Hubs: big data

-- PADRÕES:
-- Event Sourcing
-- CQRS (Command Query Responsibility Segregation)
-- Saga Pattern
-- Dead Letter Queue

-- MELHORIA:
-- ERRADO: Batch for real-time needs
-- CERTO: Streaming + windowing + state management
```

---

## 📈 Statistics (600)

### Descriptive Statistics (150)

#### DS025: Descriptive Statistics
```lua
-- SKILL: Descriptive Statistics
-- Nível: Básico → Expert
-- Contexto: Estatística descritiva

-- CONCEITOS:
-- 1. Central Tendency: mean, median, mode
-- 2. Dispersion: variance, std, IQR
-- 3. Distribution: skewness, kurtosis
-- 4. Correlation: Pearson, Spearman
-- 5. Visualization: histograms, box plots

-- MELHORIA:
-- ERRADO: Apenas média
-- CERTO: Full distribution analysis
```

### Inferential Statistics (200)

#### DS026: Inferential Statistics
```lua
-- SKILL: Inferential Statistics
-- Nível: Intermediário → Expert
-- Contexto: Estatística inferencial

-- CONCEITOS:
-- 1. Hypothesis Testing: p-value, significance
-- 2. Confidence Intervals: estimation
-- 3. T-tests: comparing means
-- 4. ANOVA: multiple groups
-- 5. Chi-Square: categorical data
-- 6. Regression: linear, logistic

-- MELHORIA:
-- ERRADO: P-value hacking
-- CERTO: Effect size + confidence intervals
```

### Bayesian Statistics (150)

#### DS027: Bayesian Statistics
```lua
-- SKILL: Bayesian Statistics
-- Nível: Intermediário → Expert
-- Contexto: Estatística bayesiana

-- CONCEITOS:
-- 1. Prior Distribution: initial belief
-- 2. Likelihood: data evidence
-- 3. Posterior Distribution: updated belief
-- 4. Bayesian Inference: MCMC, variational
-- 5. Bayesian Optimization: hyperparameter tuning

-- VANTAGENS:
-- Incorporates prior knowledge
-- Handles uncertainty naturally
-- Works with small datasets
-- Provides full distributions

-- FERRAMENTAS:
-- PyMC, Stan, NumPyro
-- Bayesian Optimization (Optuna)
```

### Experimental Design (100)

#### DS028: Experimental Design
```lua
-- SKILL: Experimental Design
-- Nível: Intermediário → Expert
-- Contexto: Design de experimentos

-- CONCEITOS:
-- 1. Randomization: eliminate bias
-- 2. Blocking: control variation
-- 3. Replication: ensure reliability
-- 4. Factorial Design: multiple factors
-- 5. A/B Testing: online experiments

-- MELHORIA:
-- ERRADO: Observational studies only
-- CERTO: Controlled experiments when possible
```

---

## 📊 Data Visualization (500)

### Dashboard Design (200)

#### DS029: Dashboard Design
```lua
-- SKILL: Dashboard Design
-- Nível: Intermediário → Expert
-- Contexto: Design de dashboards

-- PRINCÍPIOS:
-- 1. Clarity: simple, understandable
-- 2. Accuracy: no misleading
-- 3. Efficiency: minimal ink
-- 4. Aesthetics: engaging

-- FERRAMENTAS:
-- Tableau, Power BI, Looker
-- Metabase, Apache Superset
-- Grafana, Kibana

-- MELHORIA:
-- ERRADO: Dashboard overload
-- CERTO: Key metrics + drill-down capability
```

### Advanced Visualization (150)

#### DS030: Advanced Visualization
```lua
-- SKILL: Advanced Visualization
-- Nível: Intermediário → Expert
-- Contexto: Visualização avançada

-- TIPOS:
-- 1. Network: graph visualization
-- 2. Geographic: maps, choropleth
-- 3. Hierarchical: treemaps, sunbursts
-- 4. Temporal: timelines, Gantt
-- 5. Multidimensional: parallel coordinates

-- FERRAMENTAS:
-- D3.js: web visualization
-- Plotly: interactive charts
-- Vega-Lite: grammar of graphics
-- Observable: notebook-based
```

### Storytelling with Data (150)

#### DS031: Storytelling with Data
```lua
-- SKILL: Storytelling with Data
-- Nível: Intermediário → Expert
-- Contexto: Contar histórias com dados

-- CONCEITOS:
-- 1. Narrative: clear story arc
-- 2. Visualization: support the story
-- 3. Context: audience awareness
-- 4. Simplification: remove noise
-- 5. Emotion: make it memorable

-- MELHORIA:
-- ERRADO: Raw data dump
-- CERTO: Curated narrative with visuals
```

---

## 🏭 Domain Applications (600)

### Healthcare (150)

#### DS032: Healthcare AI
```lua
-- SKILL: Healthcare AI
-- Nível: Intermediário → Expert
-- Contexto: IA em saúde

-- APLICAÇÕES:
-- 1. Medical Imaging: X-ray, MRI, CT
-- 2. Drug Discovery: molecular modeling
-- 3. Clinical NLP: electronic health records
-- 4. Predictive Analytics: readmission risk
-- 5. Genomics: variant calling

-- DESAFIOS:
-- Data privacy (HIPAA)
-- Class II medical devices
-- Clinical validation
-- Explainability requirements
```

### Finance (150)

#### DS033: Financial AI
```lua
-- SKILL: Financial AI
-- Nível: Intermediário → Expert
-- Contexto: IA em finanças

-- APLICAÇÕES:
-- 1. Fraud Detection: anomaly detection
-- 2. Credit Scoring: risk assessment
-- 3. Algorithmic Trading: quantitative
-- 4. Portfolio Optimization: asset allocation
-- 5. NLP: sentiment analysis, news

-- DESAFIOS:
-- Regulatory compliance
-- Explainability (fair lending)
-- Model risk management
-- Real-time requirements
```

### E-commerce (150)

#### DS034: E-commerce AI
```lua
-- SKILL: E-commerce AI
-- Nível: Intermediário → Expert
-- Contexto: IA em e-commerce

-- APLICAÇÕES:
-- 1. Recommendation: collaborative, content-based
-- 2. Search: relevance, ranking
-- 3. Pricing: dynamic pricing
-- 4. Inventory: demand forecasting
-- 5. Customer Segmentation: clustering

-- MÉTRICAS:
-- Click-Through Rate (CTR)
-- Conversion Rate
-- Average Order Value (AOV)
-- Customer Lifetime Value (CLV)
```

### Manufacturing (150)

#### DS035: Manufacturing AI
```lua
-- SKILL: Manufacturing AI
-- Nível: Intermediário → Expert
-- Contexto: IA em manufatura

-- APLICAÇÕES:
-- 1. Quality Control: defect detection
-- 2. Predictive Maintenance: equipment failure
-- 3. Supply Chain: demand forecasting
-- 4. Process Optimization: parameters
-- 5. Robotics: vision-guided

-- BENEFÍCIOS:
-- Reduced downtime
-- Improved quality
-- Cost savings
-- Safety improvements
```

---

*Data Science Skills v1.0 - Setembro 2026*