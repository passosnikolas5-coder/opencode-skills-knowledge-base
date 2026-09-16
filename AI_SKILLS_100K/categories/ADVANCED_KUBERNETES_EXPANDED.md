# ☸️ Kubernetes Avançado — Skills Expandidas

> **Fonte:** https://github.com/kubernetes/kubernetes (115k+ estrelas)
> **Descrição:** Plataforma de orquestração de containers para automação de deployment, escalabilidade e gerenciamento de aplicações containerizadas.

---

## 📋 Índice de Skills

1. Pods (Multi-Container, Init, Sidecar)
2. Deployments (Rollouts, Rollbacks, Scaling)
3. Services (ClusterIP, NodePort, LoadBalancer)
4. Ingress (Routing, TLS)
5. ConfigMaps e Secrets
6. PersistentVolumes e PersistentVolumeClaims
7. StatefulSets
8. DaemonSets
9. Jobs e CronJobs
10. Horizontal Pod Autoscaler (HPA)
11. NetworkPolicies
12. RBAC (Role, ClusterRole, Binding)
13. Helm (Charts, Values, Releases)
14. Kustomize (Overlays, Patches)
15. kubectl (Comandos Essenciais)
16. Kubernetes API (CRDs, Operators)
17. Monitoring (Prometheus, Grafana)
18. Resource Quotas e LimitRanges
19. Pod Security Standards
20. Troubleshooting e Debugging

---

## 1. Pods

### Pod Multi-Container

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
  labels:
    app: web
spec:
  containers:
    # Container principal - Web Server
    - name: nginx
      image: nginx:1.25-alpine
      ports:
        - containerPort: 80
      volumeMounts:
        - name: shared-content
          mountPath: /usr/share/nginx/html

    # Container sidecar - File Sync
    - name: file-sync
      image: busybox
      command: ['sh', '-c', 'while true; do wget -q -O- http://api-server/content > /shared/index.html; sleep 30; done']
      volumeMounts:
        - name: shared-content
          mountPath: /shared

  volumes:
    - name: shared-content
      emptyDir: {}
```

### Pod com Init Containers

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app-with-init
spec:
  initContainers:
    # Esperar database estar pronto
    - name: wait-for-db
      image: busybox
      command: ['sh', '-c', 'until nc -z postgres-service 5432; do echo waiting for db; sleep 2; done']

    # Esperar Redis estar pronto
    - name: wait-for-redis
      image: busybox
      command: ['sh', '-c', 'until nc -z redis-service 6379; do echo waiting for redis; sleep 2; done']

    # Migrar database
    - name: db-migration
      image: myapp/migrate:latest
      env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: url

  containers:
    - name: app
      image: myapp:latest
      ports:
        - containerPort: 8080
      env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: url
        - name: REDIS_URL
          value: "redis://redis-service:6379"
```

### Pod Sidecar Pattern

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: logging-sidecar
spec:
  containers:
    # Aplicação principal
    - name: app
      image: myapp:latest
      volumeMounts:
        - name: logs
          mountPath: /var/log/app

    # Sidecar para coleta de logs
    - name: log-collector
      image: fluent/fluent-bit:latest
      volumeMounts:
        - name: logs
          mountPath: /var/log/app
          readOnly: true
        - name: fluent-config
          mountPath: /fluent-bit/etc/

    # Sidecar para métricas
    - name: metrics-exporter
      image: prom/statsd-exporter:latest
      ports:
        - containerPort: 9125
          name: statsd
        - containerPort: 9102
          name: metrics

  volumes:
    - name: logs
      emptyDir: {}
    - name: fluent-config
      configMap:
        name: fluent-bit-config
```

### MELHORIA

```
❌ ERRADO: Criar pods manualmente sem controller
kubectl run nginx --image=nginx
# Pod não é gerenciado, não renasca em falhas

✅ CORRETO: Usar Deployment para gerenciar pods
kubectl create deployment nginx --image=nginx --replicas=3
# Pods gerenciados, auto-healing, scaling automático
```

---

## 2. Deployments

### Deployment Completo

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
  labels:
    app: api
  annotations:
    deployment.kubernetes.io/revision: "1"
spec:
  replicas: 3
  selector:
    matchLabels:
      app: api
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: api
          image: myapp/api:v1.2.0
          ports:
            - containerPort: 8080
          env:
            - name: DB_HOST
              valueFrom:
                configMapKeyRef:
                  name: app-config
                  key: db-host
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: db-password
          resources:
            requests:
              cpu: "250m"
              memory: "256Mi"
            limits:
              cpu: "500m"
              memory: "512Mi"
          livenessProbe:
            httpGet:
              path: /healthz
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 5
          startupProbe:
            httpGet:
              path: /healthz
              port: 8080
            failureThreshold: 30
            periodSeconds: 10
```

### Rollout e Rollback

```bash
# Verificar status do rollout
kubectl rollout status deployment/api-server

# Ver histórico
kubectl rollout history deployment/api-server

# Atualizar imagem
kubectl set image deployment/api-server api=myapp/api:v1.3.0

# Rollback para versão anterior
kubectl rollout undo deployment/api-server

# Rollback para versão específica
kubectl rollout undo deployment/api-server --to-revision=2

# Pausar rollout
kubectl rollout pause deployment/api-server

# Retomar rollout
kubectl rollout resume deployment/api-server

# Restart de pods
kubectl rollout restart deployment/api-server
```

### Scaling

```bash
# Escalar manualmente
kubectl scale deployment api-server --replicas=5

# Autoscaling (ver seção HPA)
kubectl autoscale deployment api-server --min=3 --max=10 --cpu-percent=70
```

### MELHORIA

```
❌ ERRADO: Usar recreate strategy para produção
spec:
  strategy:
    type: Recreate
# Downtime durante atualização

✅ CORRETO: Usar rolling update com zero downtime
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
# Novos pods prontos antes de remover antigos
```

---

## 3. Services

### Tipos de Service

```yaml
# ClusterIP (padrão) - Acesso interno
apiVersion: v1
kind: Service
metadata:
  name: api-service
spec:
  type: ClusterIP
  selector:
    app: api
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
      name: http

---
# NodePort - Acesso externo via node
apiVersion: v1
kind: Service
metadata:
  name: api-nodeport
spec:
  type: NodePort
  selector:
    app: api
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30080
      protocol: TCP

---
# LoadBalancer - Balanceador de carga externo
apiVersion: v1
kind: Service
metadata:
  name: api-loadbalancer
  annotations:
    # AWS
    service.beta.kubernetes.io/aws-load-balancer-type: nlb
    # GCP
    cloud.google.com/load-balancer-type: Internal
spec:
  type: LoadBalancer
  selector:
    app: api
  ports:
    - port: 80
      targetPort: 8080
  loadBalancerSourceRanges:
    - 10.0.0.0/8

---
# Headless Service - Para StatefulSets
apiVersion: v1
kind: Service
metadata:
  name: postgres-headless
spec:
  type: ClusterIP
  clusterIP: None
  selector:
    app: postgres
  ports:
    - port: 5432
      targetPort: 5432
```

### Service com ExternalName

```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-db
spec:
  type: ExternalName
  externalName: postgres.external-domain.com
```

### MELHORIA

```
❌ ERRADO: Usar NodePort para produção
# Inseguro, difícil gerenciar, sem SSL

✅ CORRETO: Usar LoadBalancer ou Ingress
apiVersion: v1
kind: Service
metadata:
  name: api
spec:
  type: LoadBalancer
  # Ou usar Ingress para roteamento avançado
```

---

## 4. Ingress

### Ingress com TLS

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/rate-limit: "100"
    nginx.ingress.kubernetes.io/rate-limit-window: "1m"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - api.example.com
        - www.example.com
      secretName: api-tls
  rules:
    - host: api.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: api-service
                port:
                  number: 80
          - path: /websocket
            pathType: Prefix
            backend:
              service:
                name: websocket-service
                port:
                  number: 8080
    - host: www.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: frontend-service
                port:
                  number: 80
```

### Ingress com Rate Limiting e CORS

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api-cors
  annotations:
    nginx.ingress.kubernetes.io/enable-cors: "true"
    nginx.ingress.kubernetes.io/cors-allow-origin: "https://example.com"
    nginx.ingress.kubernetes.io/cors-allow-methods: "GET, POST, PUT, DELETE"
    nginx.ingress.kubernetes.io/cors-allow-headers: "Content-Type, Authorization"
    nginx.ingress.kubernetes.io/limit-rps: "10"
    nginx.ingress.kubernetes.io/limit-burst-multiplier: "5"
spec:
  ingressClassName: nginx
  rules:
    - host: api.example.com
      http:
        paths:
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: api-service
                port:
                  number: 80
```

### MELHORIA

```
❌ ERRADO: Ingress sem TLS
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myingress
spec:
  rules:
    - host: api.example.com
      http:
        paths:
          - path: /
            backend:
              service:
                name: my-service
                port:
                  number: 80
# Tráfego em texto plano, inseguro

✅ CORRETO: Ingress com TLS e cert-manager
metadata:
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
spec:
  tls:
    - hosts:
        - api.example.com
      secretName: api-tls
# HTTPS automático com Let's Encrypt
```

---

## 5. ConfigMaps e Secrets

### ConfigMap

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  # Configuração simples
  DATABASE_HOST: "postgres-service"
  DATABASE_PORT: "5432"
  LOG_LEVEL: "info"

  # Arquivo de configuração
  nginx.conf: |
    server {
      listen 80;
      server_name example.com;
      location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
      }
    }

  # JSON config
  config.json: |
    {
      "debug": false,
      "cache_ttl": 3600,
      "max_connections": 100
    }
```

### Secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  # Valores em base64
  DB_PASSWORD: cGFzc3dvcmQxMjM=
  API_KEY: YWJjZGVmZzEyMzQ1Ng==
  JWT_SECRET: c2VjcmV0a2V5MTIzNDU2Nzg5

---
# Secret para TLS
apiVersion: v1
kind: Secret
metadata:
  name: tls-secret
type: kubernetes.io/tls
data:
  tls.crt: LS0tLS1CRUdJTi...
  tls.key: LS0tLS1CRUdJTi...

---
# Secret para Docker Registry
apiVersion: v1
kind: Secret
metadata:
  name: registry-secret
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: eyJhdXRocyI6...
```

### Uso de ConfigMap e Secret em Pods

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
spec:
  template:
    spec:
      containers:
        - name: api
          image: myapp:latest
          env:
            # De ConfigMap
            - name: DATABASE_HOST
              valueFrom:
                configMapKeyRef:
                  name: app-config
                  key: DATABASE_HOST

            # De Secret
            - name: DATABASE_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: DB_PASSWORD

          # ConfigMap como volume
          volumeMounts:
            - name: config-volume
              mountPath: /etc/config
            - name: secret-volume
              mountPath: /etc/secrets
              readOnly: true

      volumes:
        - name: config-volume
          configMap:
            name: app-config
        - name: secret-volume
          secret:
            secretName: app-secrets
```

### MELHORIA

```
❌ ERRADO: Colocar secrets em ConfigMap
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-secrets
data:
  DB_PASSWORD: "minha-senha"  # Não criptografado!

✅ CORRETO: Usar Secret
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  DB_PASSWORD: bWluaGEtc2VuaGE=  # Base64 encoded
# Usar external secrets operator para produção
```

---

## 6. PersistentVolumes e PersistentVolumeClaims

### PersistentVolume

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 100Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: nfs-server.example.com
    path: /exports/data

---
# StorageClass para provisionamento dinâmico
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-ssd
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp3
  fsType: ext4
reclaimPolicy: Delete
allowVolumeExpansion: true
volumeBindingMode: WaitForFirstConsumer
```

### PersistentVolumeClaim

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: fast-ssd
  resources:
    requests:
      storage: 50Gi
  selector:
    matchLabels:
      app: postgres
```

### Uso em StatefulSet

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
spec:
  serviceName: postgres
  replicas: 3
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:16
          ports:
            - containerPort: 5432
          env:
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: postgres-secrets
                  key: password
          volumeMounts:
            - name: postgres-data
              mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
    - metadata:
        name: postgres-data
      spec:
        accessModes:
          - ReadWriteOnce
        storageClassName: fast-ssd
        resources:
          requests:
            storage: 50Gi
```

### MELHORIA

```
❌ ERRADO: Usar emptyDir para dados persistentes
volumes:
  - name: data
    emptyDir: {}
# Dados perdidos quando pod é reiniciado

✅ CORRETO: Usar PersistentVolumeClaim
volumes:
  - name: data
    persistentVolumeClaim:
      claimName: my-pvc
# Dados persistentes mesmo com restart
```

---

## 7. StatefulSets

### StatefulSet Completo

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: redis-cluster
spec:
  serviceName: redis-headless
  replicas: 6
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
        - name: redis
          image: redis:7-alpine
          ports:
            - containerPort: 6379
              name: redis
            - containerPort: 16379
              name: gossip
          command:
            - redis-server
            - /conf/redis.conf
          volumeMounts:
            - name: redis-data
              mountPath: /data
            - name: redis-config
              mountPath: /conf

      initContainers:
        # Configurar cluster
        - name: init-redis
          image: redis:7-alpine
          command:
            - bash
            - -c
            - |
              # Copiar configuração base
              cp /config/redis.conf /conf/redis.conf

              # Encontrar índice do pod
              HOSTNAME=$(hostname)
              INDEX=${HOSTNAME##*-}

              # Adicionar configurações específicas
              echo "cluster-announce-ip $(hostname -i)" >> /conf/redis.conf
              echo "cluster-announce-port 6379" >> /conf/redis.conf
              echo "cluster-announce-bus-port 16379" >> /conf/redis.conf
          volumeMounts:
            - name: redis-config
              mountPath: /conf

  volumeClaimTemplates:
    - metadata:
        name: redis-data
      spec:
        accessModes:
          - ReadWriteOnce
        storageClassName: fast-ssd
        resources:
          requests:
            storage: 10Gi

---
apiVersion: v1
kind: Service
metadata:
  name: redis-headless
spec:
  type: ClusterIP
  clusterIP: None
  selector:
    app: redis
  ports:
    - port: 6379
      name: redis
    - port: 16379
      name: gossip
```

### MELHORIA

```
❌ ERRADO: Usar Deployment para Redis Cluster
# Pods não têm identidade estável, nomes aleatórios
# Dificuldade em formar cluster

✅ CORRETO: Usar StatefulSet
# Nomes estáveis (redis-0, redis-1, redis-2...)
# VolumeClaimTemplates persistentes
# Identidade estável para cluster
```

---

## 8. DaemonSets

### DaemonSet para Infraestrutura

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd
  namespace: kube-system
  labels:
    app: fluentd
spec:
  selector:
    matchLabels:
      app: fluentd
  template:
    metadata:
      labels:
        app: fluentd
    spec:
      tolerations:
        - key: node-role.kubernetes.io/control-plane
          operator: Exists
          effect: NoSchedule
        - key: node.kubernetes.io/not-ready
          operator: Exists
          effect: NoExecute
          tolerationSeconds: 300
        - key: node.kubernetes.io/unreachable
          operator: Exists
          effect: NoExecute
          tolerationSeconds: 300

      containers:
        - name: fluentd
          image: fluent/fluentd-kubernetes-daemonset:v1.16
          env:
            - name: FLUENTD_CONF
              value: "fluent.conf"
            - name: FLUENT_ELASTICSEARCH_HOST
              value: "elasticsearch.logging.svc.cluster.local"
            - name: FLUENT_ELASTICSEARCH_PORT
              value: "9200"
          resources:
            limits:
              cpu: 500m
              memory: 512Mi
            requests:
              cpu: 100m
              memory: 200Mi
          volumeMounts:
            - name: varlog
              mountPath: /var/log
              readOnly: true
            - name: containers
              mountPath: /var/lib/docker/containers
              readOnly: true

      volumes:
        - name: varlog
          hostPath:
            path: /var/log
        - name: containers
          hostPath:
            path: /var/lib/docker/containers

  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
```

### DaemonSet para Monitoramento

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      hostNetwork: true
      hostPID: true
      containers:
        - name: node-exporter
          image: prom/node-exporter:v1.7.0
          args:
            - '--path.procfs=/host/proc'
            - '--path.sysfs=/host/sys'
            - '--path.rootfs=/host/root'
            - '--web.listen-address=:9100'
          ports:
            - containerPort: 9100
              hostPort: 9100
          resources:
            limits:
              cpu: 100m
              memory: 128Mi
          volumeMounts:
            - name: proc
              mountPath: /host/proc
              readOnly: true
            - name: sys
              mountPath: /host/sys
              readOnly: true
            - name: root
              mountPath: /host/root
              readOnly: true

      volumes:
        - name: proc
          hostPath:
            path: /proc
        - name: sys
          hostPath:
            path: /sys
        - name: root
          hostPath:
            path: /
```

### MELHORIA

```
❌ ERRADO: Rodar node-exporter como Deployment
# Apenas um pod, não cobre todos os nós

✅ CORRETO: Usar DaemonSet
# Garante um pod por nó
# Coleta métricas de todos os nodes
```

---

## 9. Jobs e CronJobs

### Job

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-backup
spec:
  completions: 1
  parallelism: 1
  backoffLimit: 3
  activeDeadlineSeconds: 3600
  template:
    spec:
      containers:
        - name: backup
          image: postgres:16
          command:
            - bash
            - -c
            - |
              pg_dump -h postgres-service -U postgres mydb | gzip > /backup/backup-$(date +%Y%m%d-%H%M%S).sql.gz
          env:
            - name: PGPASSWORD
              valueFrom:
                secretKeyRef:
                  name: postgres-secrets
                  key: password
          volumeMounts:
            - name: backup-storage
              mountPath: /backup

      volumes:
        - name: backup-storage
          persistentVolumeClaim:
            claimName: backup-pvc

      restartPolicy: OnFailure
```

### CronJob

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: db-backup-cron
spec:
  schedule: "0 2 * * *"  # Todo dia às 2:00
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 5
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: backup
              image: postgres:16
              command:
                - bash
                - -c
                - |
                  pg_dump -h postgres-service -U postgres mydb | gzip > /backup/backup-$(date +%Y%m%d).sql.gz
              env:
                - name: PGPASSWORD
                  valueFrom:
                    secretKeyRef:
                      name: postgres-secrets
                      key: password
              volumeMounts:
                - name: backup-storage
                  mountPath: /backup

          volumes:
            - name: backup-storage
              persistentVolumeClaim:
                claimName: backup-pvc

          restartPolicy: OnFailure
```

### Job com Parallelismo

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: parallel-process
spec:
  completions: 10
  parallelism: 5
  template:
    spec:
      containers:
        - name: worker
          image: myapp/worker:latest
          env:
            - name: TASK_ID
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
      restartPolicy: Never
```

### MELHORIA

```
❌ ERRADO: CronJob sem limites
spec:
  schedule: "0 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: job
              image: myjob:latest
# Sem limite de tempo, sem política de concorrência

✅ CORRETO: Com limites e políticas
spec:
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 5
  concurrencyPolicy: Forbid
  jobTemplate:
    spec:
      activeDeadlineSeconds: 3600
      backoffLimit: 3
```

---

## 10. Horizontal Pod Autoscaler (HPA)

### HPA com CPU e Memory

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api-server
  minReplicas: 3
  maxReplicas: 20
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
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 60
      policies:
        - type: Percent
          value: 100
          periodSeconds: 60
        - type: Pods
          value: 4
          periodSeconds: 60
      selectPolicy: Max
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 10
          periodSeconds: 60
      selectPolicy: Min
```

### HPA com Métricas Customizadas

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-custom-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api-server
  minReplicas: 2
  maxReplicas: 50
  metrics:
    # Métrica customizada do Prometheus
    - type: Pods
      pods:
        metric:
          name: http_requests_per_second
        target:
          type: AverageValue
          averageValue: "1000"

    # Métrica externa
    - type: External
      external:
        metric:
          name: queue_messages_ready
          selector:
            matchLabels:
              queue: "my-queue"
        target:
          type: AverageValue
          averageValue: "30"
```

### MELHORIA

```
❌ ERRADO: HPA sem estabilização
spec:
  minReplicas: 1
  maxReplicas: 100
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
# Escala muito rápido, pode causar thrashing

✅ CORRETO: Com estabilização e políticas
spec:
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 60
    scaleDown:
      stabilizationWindowSeconds: 300
  # Evita escala desnecessária
```

---

## 11. NetworkPolicies

### NetworkPolicy Completa

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-network-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
    - Ingress
    - Egress
  ingress:
    # Permitir tráfego do nginx
    - from:
        - podSelector:
            matchLabels:
              app: nginx
      ports:
        - protocol: TCP
          port: 8080

    # Permitir tráfego de qualquer namespace
    - from:
        - namespaceSelector: {}
      ports:
        - protocol: TCP
          port: 8080
  egress:
    # Permitir acesso a PostgreSQL
    - to:
        - podSelector:
            matchLabels:
              app: postgres
      ports:
        - protocol: TCP
          port: 5432

    # Permitir acesso DNS
    - to:
        - namespaceSelector: {}
      ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53

    # Permitir acesso externo
    - to:
        - ipBlock:
            cidr: 0.0.0.0/0
            except:
              - 10.0.0.0/8
              - 172.16.0.0/12
              - 192.168.0.0/16
```

### NetworkPolicy Default Deny

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
  namespace: production
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
```

### MELHORIA

```
❌ ERRADO: Sem NetworkPolicy
# Todos os pods podem se comunicar livremente
# Segurança zero entre namespaces

✅ CORRETO: Default deny + políticas específicas
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
# Bloqueia tudo, depois libera apenas o necessário
```

---

## 12. RBAC

### Role e RoleBinding

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: development
  name: pod-reader
rules:
  - apiGroups: [""]
    resources: ["pods", "pods/log"]
    verbs: ["get", "list", "watch"]
  - apiGroups: ["apps"]
    resources: ["deployments", "replicasets"]
    verbs: ["get", "list"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: development
subjects:
  - kind: User
    name: jane.doe
    apiGroup: rbac.authorization.k8s.io
  - kind: Group
    name: dev-team
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

### ClusterRole e ClusterRoleBinding

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: secret-reader
rules:
  - apiGroups: [""]
    resources: ["secrets"]
    verbs: ["get", "list"]
  - apiGroups: [""]
    resources: ["configmaps"]
    verbs: ["get", "list"]
  - apiGroups: ["networking.k8s.io"]
    resources: ["ingresses"]
    verbs: ["get", "list", "watch"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: read-secrets
subjects:
  - kind: ServiceAccount
    name: external-secrets
    namespace: kube-system
roleRef:
  kind: ClusterRole
  name: secret-reader
  apiGroup: rbac.authorization.k8s.io
```

### MELHORIA

```
❌ ERRADO: Usar cluster-admin para tudo
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-binding
subjects:
  - kind: User
    name: dev@company.com
roleRef:
  kind: ClusterRole
  name: cluster-admin  # Permissões demais!
  apiGroup: rbac.authorization.k8s.io

✅ CORRETO: Roles最小权限
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: development
  name: pod-manager
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "create", "delete"]
# Apenas o necessário para a função
```

---

## 13. Helm

### Estrutura de Chart

```
my-chart/
├── Chart.yaml
├── values.yaml
├── templates/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   └── _helpers.tpl
└── charts/
```

### Chart.yaml

```yaml
apiVersion: v2
name: myapp
description: My application Helm chart
type: application
version: 0.1.0
appVersion: "1.0.0"
dependencies:
  - name: postgresql
    version: "13.2.24"
    repository: "https://charts.bitnami.com/bitnami"
    condition: postgresql.enabled
  - name: redis
    version: "18.6.1"
    repository: "https://charts.bitnami.com/bitnami"
    condition: redis.enabled
```

### values.yaml

```yaml
replicaCount: 3

image:
  repository: myapp
  pullPolicy: IfNotPresent
  tag: "latest"

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  hosts:
    - host: myapp.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: myapp-tls
      hosts:
        - myapp.example.com

resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi

autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70

postgresql:
  enabled: true
  auth:
    postgresPassword: "changeme"

redis:
  enabled: true
```

### Template Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "myapp.fullname" . }}
  labels:
    {{- include "myapp.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "myapp.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "myapp.selectorLabels" . | nindent 8 }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: {{ .Values.service.port }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
```

### Comandos Helm

```bash
# Instalar chart
helm install myrelease ./my-chart -f values-prod.yaml

# Atualizar
helm upgrade myrelease ./my-chart -f values-prod.yaml

# Rollback
helm rollback myrelease 1

# Desinstalar
helm uninstall myrelease

# Listar releases
helm list

# Ver histórico
helm history myrelease

# Renderizar templates
helm template myrelease ./my-chart

# Verificar configuração
helm lint ./my-chart
```

### MELHORIA

```
❌ ERRADO: Gerenciar manifests manualmente
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
# Difícil versionar, rollback manual

✅ CORRETO: Usar Helm
helm upgrade myrelease ./chart -f values.yaml
# Versionamento, rollback fácil, gerenciamento de dependências
```

---

## 14. Kustomize

### Estrutura Kustomize

```
base/
├── kustomization.yaml
├── deployment.yaml
├── service.yaml
└── configmap.yaml

overlays/
├── dev/
│   ├── kustomization.yaml
│   └── patches/
├── staging/
│   ├── kustomization.yaml
│   └── patches/
└── prod/
    ├── kustomization.yaml
    └── patches/
```

### Base

```yaml
# base/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - deployment.yaml
  - service.yaml
  - configmap.yaml

commonLabels:
  app: myapp
  env: base
```

### Overlay de Produção

```yaml
# overlays/prod/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

namespace: production

commonLabels:
  env: production

patches:
  - target:
      kind: Deployment
      name: myapp
    patch: |
      - op: replace
        path: /spec/replicas
        value: 5
      - op: replace
        path: /spec/template/spec/containers/0/resources/limits/cpu
        value: "1"
      - op: replace
        path: /spec/template/spec/containers/0/resources/limits/memory
        value: "1Gi"

configMapGenerator:
  - name: app-config
    behavior: merge
    literals:
      - LOG_LEVEL=warn
      - DEBUG=false

secretGenerator:
  - name: app-secrets
    behavior: merge
    literals:
      - API_KEY=prod-secret-key
    type: Opaque
```

### Comandos Kustomize

```bash
# Renderizar overlay
kubectl apply -k overlays/prod/

# Preview sem aplicar
kubectl kustomize overlays/prod/

# Build local
kustomize build overlays/prod/ | kubectl apply -f -

# Com kubectl (kustomize integrado)
kubectl apply -k overlays/prod/
```

### MELHORIA

```
❌ ERRADO: Copiar arquivos para cada ambiente
cp deployment.yaml deployment-prod.yaml
# Duplicação, inconsistências

✅ CORRETO: Usar Kustomize overlays
kubectl apply -k overlays/prod/
# Base compartilada, patches específicos por ambiente
```

---

## 15. kubectl

### Comandos Essenciais

```bash
# GET - Listar recursos
kubectl get pods -n production
kubectl get deployments --all-namespaces
kubectl get svc -o wide
kubectl get pods -l app=api
kubectl get all -n production

# DESCRIBE - Detalhes
kubectl describe pod mypod -n production
kubectl describe node worker-1
kubectl describe svc my-service

# LOGS - Logs
kubectl logs mypod -n production
kubectl logs mypod -c sidecar  # container específico
kubectl logs -f mypod  # stream
kubectl logs --previous mypod  # pod anterior

# EXEC - Executar comandos
kubectl exec -it mypod -- /bin/sh
kubectl exec -it mypod -c sidecar -- /bin/sh
kubectl exec mypod -- curl localhost:8080/health

# APPLY - Aplicar manifestos
kubectl apply -f deployment.yaml
kubectl apply -k overlays/prod/
kubectl apply -f https://example.com/manifest.yaml

# DELETE - Remover recursos
kubectl delete pod mypod
kubectl delete -f deployment.yaml
kubectl delete pods -l app=api

# SCALE - Escalar
kubectl scale deployment api --replicas=5

# PORT-FORWARD - Acesso local
kubectl port-forward svc/my-service 8080:80
kubectl port-forward pod/mypod 3000:3000

# EXPOSE - Criar service
kubectl expose deployment api --port=80 --target-port=8080

# CP - Copiar arquivos
kubectl cp mypod:/var/log/app.log ./app.log
kubectl cp ./config.yaml mypod:/app/config.yaml

# EVENTS - Eventos
kubectl get events --sort-by='.lastTimestamp'
kubectl get events -n production

# TOP - Uso de recursos
kubectl top nodes
kubectl top pods -n production
```

### Comandos Avançados

```bash
# Buscar e substituir
kubectl get deployment api -o json | \
  jq '.spec.template.spec.containers[0].image = "myapp:v2"' | \
  kubectl apply -f -

# Rotular nodes
kubectl label nodes worker-1 disktype=ssd

# Taint nodes
kubectl taint nodes worker-1 dedicated=gpu:NoSchedule

# Anotações
kubectl annotate pods mypod description="my annotation"

# Configurar contexto
kubectl config get-contexts
kubectl config use-context production

# dry-run
kubectl apply -f deployment.yaml --dry-run=client
kubectl apply -f deployment.yaml --dry-run=server

# Debug
kubectl debug pod/mypod -it --image=busybox
kubectl debug node/worker-1 -it --image=busybox
```

### MELHORIA

```
❌ ERRADO: Editar diretamente
kubectl edit deployment api
# Erros de digitação, sem versionamento

✅ CORRETO: Usar apply com manifests
kubectl apply -f deployment.yaml
# Versionado, auditável, reproduzível
```

---

## 16. Kubernetes API (CRDs e Operators)

### Custom Resource Definition

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: databases.mycompany.com
spec:
  group: mycompany.com
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                engine:
                  type: string
                  enum: ["postgres", "mysql", "mongodb"]
                version:
                  type: string
                storage:
                  type: string
                replicas:
                  type: integer
            status:
              type: object
              properties:
                ready:
                  type: boolean
                endpoint:
                  type: string
  scope: Namespaced
  names:
    plural: databases
    singular: database
    kind: Database
    shortNames:
      - db
```

### Custom Resource

```yaml
apiVersion: mycompany.com/v1
kind: Database
metadata:
  name: production-db
  namespace: production
spec:
  engine: postgres
  version: "16"
  storage: "100Gi"
  replicas: 3
```

### Operator Pattern

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: database-operator
  namespace: system
spec:
  replicas: 1
  selector:
    matchLabels:
      app: database-operator
  template:
    metadata:
      labels:
        app: database-operator
    spec:
      serviceAccountName: database-operator
      containers:
        - name: operator
          image: mycompany/database-operator:v1.0
          env:
            - name: WATCH_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
          resources:
            limits:
              cpu: 500m
              memory: 512Mi
```

### MELHORIA

```
❌ ERRADO: Gerenciar tudo com ConfigMap e Scripts
# Sem controle de ciclo de vida, sem reconciliação

✅ CORRETO: Criar Operator com CRD
# Controle de ciclo de vida automático
# Reconciliação continue
# Extensão do Kubernetes
```

---

## 17. Monitoring (Prometheus e Grafana)

### ServiceMonitor para Prometheus

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: api-monitor
  namespace: monitoring
  labels:
    release: prometheus
spec:
  selector:
    matchLabels:
      app: api
  endpoints:
    - port: metrics
      interval: 30s
      path: /metrics
```

### PrometheusRule

```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: api-alerts
  namespace: monitoring
spec:
  groups:
    - name: api.rules
      rules:
        - alert: HighErrorRate
          expr: |
            sum(rate(http_requests_total{status=~"5.."}[5m]))
            / sum(rate(http_requests_total[5m])) > 0.05
          for: 5m
          labels:
            severity: critical
          annotations:
            summary: "Alta taxa de erro na API"
            description: "Mais de 5% dos requests retornaram erro"

        - alert: HighLatency
          expr: |
            histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket[5m])) by (le)) > 1
          for: 5m
          labels:
            severity: warning
          annotations:
            summary: "Latência alta na API"
            description: "P99 latency maior que 1 segundo"

        - alert: PodCrashLooping
          expr: rate(kube_pod_container_status_restarts_total[15m]) * 60 * 5 > 0
          for: 5m
          labels:
            severity: critical
          annotations:
            summary: "Pod em crash loop"
```

### Dashboard Grafana

```json
{
  "dashboard": {
    "title": "API Dashboard",
    "panels": [
      {
        "title": "Request Rate",
        "targets": [
          {
            "expr": "sum(rate(http_requests_total[5m])) by (method, status)",
            "legendFormat": "{{method}} {{status}}"
          }
        ]
      },
      {
        "title": "Response Time",
        "targets": [
          {
            "expr": "histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
            "legendFormat": "P99"
          }
        ]
      }
    ]
  }
}
```

### MELHORIA

```
❌ ERRADO: Não configurar monitoramento
# Sem alertas, sem visibilidade

✅ CORRETO: Prometheus + Grafana + AlertManager
- ServiceMonitor para coleta
- PrometheusRule para alertas
- Dashboard para visualização
```

---

## 18. Resource Quotas e LimitRanges

### Resource Quota

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: development
spec:
  hard:
    requests.cpu: "20"
    requests.memory: "40Gi"
    limits.cpu: "40"
    limits.memory: "80Gi"
    pods: "50"
    services: "20"
    persistentvolumeclaims: "10"

---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: object-count-quota
  namespace: development
spec:
  hard:
    configmaps: "20"
    secrets: "20"
    services.loadbalancers: "2"
    services.nodeports: "5"
```

### LimitRange

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: default-limits
  namespace: development
spec:
  limits:
    - default:
        cpu: "500m"
        memory: "512Mi"
      defaultRequest:
        cpu: "100m"
        memory: "128Mi"
      max:
        cpu: "2"
        memory: "4Gi"
      min:
        cpu: "50m"
        memory: "64Mi"
      type: Container

    - max:
        storage: "10Gi"
      type: PersistentVolumeClaim
```

### MELHORIA

```
❌ ERRADO: Sem quotas de recursos
# Pods podem consumir recursos ilimitados
# Um namespace pode dominar o cluster

✅ CORRETO: Definir quotas e limites
apiVersion: v1
kind: ResourceQuota
spec:
  hard:
    requests.cpu: "20"
    limits.cpu: "40"
    pods: "50"
# Controle de consumo por namespace
```

---

## 19. Pod Security Standards

### Pod Security Admission

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

### Security Context

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-app
spec:
  template:
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1001
        runAsGroup: 1001
        fsGroup: 1001
        seccompProfile:
          type: RuntimeDefault

      containers:
        - name: app
          image: myapp:latest
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            capabilities:
              drop:
                - ALL

          volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: app-cache
              mountPath: /app/cache

      volumes:
        - name: tmp
          emptyDir: {}
        - name: app-cache
          emptyDir: {}
```

### Pod Security Policy (Legacy)

```yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restricted
spec:
  privileged: false
  allowPrivilegeEscalation: false
  requiredDropCapabilities:
    - ALL
  volumes:
    - 'emptyDir'
    - 'persistentVolumeClaim'
    - 'secret'
    - 'configMap'
  hostNetwork: false
  hostPorts: []
  hostIPC: false
  hostPID: false
  runAsUser:
    rule: 'MustRunAsNonRoot'
  seLinux:
    rule: 'RunAsAny'
  fsGroup:
    rule: 'MustRunAs'
    ranges:
      - min: 1
        max: 65535
```

### MELHORIA

```
❌ ERRADO: Sem restrições de segurança
spec:
  securityContext: {}
  containers:
    - name: app
      image: myapp
# Container pode rodar como root, com privilégios

✅ CORRETO: Pod Security Standards
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1001
    seccompProfile:
      type: RuntimeDefault
  containers:
    - name: app
      securityContext:
        allowPrivilegeEscalation: false
        readOnlyRootFilesystem: true
```

---

## 20. Troubleshooting e Debugging

### Diagnóstico de Pods

```bash
# Verificar status do pod
kubectl get pod mypod -o wide

# Verificar eventos
kubectl describe pod mypod

# Ver logs
kubectl logs mypod
kubectl logs mypod --previous  # logs do crash anterior

# Executar shell
kubectl exec -it mypod -- /bin/sh

# Debug com container temporário
kubectl debug mypod -it --image=busybox

# Debug com ephemeral container
kubectl debug mypod -it --target=app

# Verificar resource usage
kubectl top pods
kubectl top nodes
```

### Diagnóstico de Services

```bash
# Verificar endpoints
kubectl get endpoints my-service

# Verificar DNS
kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup my-service

# Verificar conectividade
kubectl run -it --rm debug --image=busybox --restart=Never -- wget -qO- http://my-service:80

# Verificar network policies
kubectl get networkpolicies -n production
```

### Diagnóstico de Nodes

```bash
# Verificar status dos nodes
kubectl get nodes -o wide

# Verificar condições do node
kubectl describe node worker-1

# Verificar pods no node
kubectl get pods --field-selector spec.nodeName=worker-1

# Debug no node
kubectl debug node/worker-1 -it --image=busybox

# Verificar eventos do cluster
kubectl get events --sort-by='.lastTimestamp'
```

### Logs e Métricas

```bash
# Ver logs de todos pods de um deployment
kubectl logs -l app=api --all-containers=true

# Ver logs com timestamp
kubectl logs mypod --timestamps=true

# Filtrar logs
kubectl logs mypod | grep ERROR

# Ver métricas do Prometheus
kubectl port-forward svc/prometheus 9090:9090

# Ver dashboards do Grafana
kubectl port-forward svc/grafana 3000:3000
```

### MELHORIA

```
❌ ERRADO: Deletar e recriar pod para debug
kubectl delete pod myapp
kubectl run myapp --image=myapp
# Perde estado, logs, contexto do problema

✅ CORRETO: Debug in-loco
kubectl exec -it myapp -- /bin/sh
kubectl logs myapp --previous
kubectl describe pod myapp
# Entende o problema antes de agir
```

---

## 📚 Referências

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [kubectl Reference](https://kubernetes.io/docs/reference/kubectl/)
- [Helm Documentation](https://helm.sh/docs/)
- [Kustomize Documentation](https://kustomize.io/)
- [Prometheus Operator](https://prometheus-operator.dev/)
- [Kubernetes Best Practices](https://kubernetes.io/docs/setup/best-practices/)
- [CNCF Projects](https://www.cncf.io/projects/)

---

> **Total de Skills:** 20 categorias avançadas
> **Nível:** Intermediário a Avançado
> **Última atualização:** 2026
