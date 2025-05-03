# Deployment Anleitung

## Voraussetzungen
- Kubernetes Cluster (Cloud Provider)
- Helm installiert
- ArgoCD installiert
- KUBECONFIG gesetzt

## Schritte

### 1. Namespaces erstellen
```bash
kubectl create ns aaa-ns
kubectl create ns bbb-ns
kubectl create ns ddd-ns
kubectl create ns eee-ns
```

### 2. Helm Chart testen
```bash
helm install ostk-app ./charts/ostk-app --dry-run --debug
```

### 3. Helm Chart in Git Repository pushen
- Commit und Push in dein Git Repository

### 4. ArgoCD Application deployen
```bash
kubectl apply -f argocd/application.yaml
```

### 5. DNS konfigurieren
- Bei Namecheap DNS-Eintrag für `www.ostk.cloud` auf die IP-Adresse des Cloud Load Balancers setzen.

### 6. Zugriff testen
- Öffne im Browser:
  - http://www.ostk.cloud/
  - http://www.ostk.cloud/k2
  - http://www.ostk.cloud/k3
  - http://www.ostk.cloud/k4
