# Kubernetes Deployment Anleitung

## Voraussetzungen

- Kubernetes Cluster (Cloud Provider)
- Helm installiert
- ArgoCD installiert
- KUBECONFIG gesetzt

## Schritte zur Bereitstellung

### 1. Repository klonen

```bash
git clone https://github.com/Impulsleistung/k8s.git
cd k8s
```

### 2. Namespaces erstellen

```bash
kubectl create namespace aaa-ns
kubectl create namespace bbb-ns
kubectl create namespace ddd-ns
kubectl create namespace eee-ns
kubectl create namespace ingress-nginx
```

### 3. Ingress Controller installieren (falls noch nicht vorhanden)

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx
```

### 4. ArgoCD ApplicationSet deployen

```bash
kubectl apply -f argocd/applications.yaml
```

### 5. Zugriff testen

Warte, bis alle Pods laufen (`kubectl get pods -A`).

Um die externe IP des Ingress-Controllers bzw. des Load Balancers zu ermitteln, führen Sie folgenden Befehl aus:

```bash
kubectl get svc -n ingress-nginx
```

Suchen Sie in der Ausgabe nach der Spalte EXTERNAL-IP. Diese IP-Adresse verwenden Sie als YOUR_DOMAIN. Öffnen Sie im Browser:
- http://EXTERNAL-IP/ (Static Homepage)
- http://EXTERNAL-IP/k2 (Markdown Converter)
- http://EXTERNAL-IP/k3 (Ubuntu Desktop mit Firefox)
- http://EXTERNAL-IP/k4 (Sonar App)

Ersetze `YOUR_DOMAIN` mit der Domain oder IP-Adresse deines Load Balancers.

## Architekturübersicht

```mermaid
graph LR
    User -->|Accesses URL| LB[Cloud Load Balancer]
    LB --> IngressController[Ingress Controller]
    IngressController --> Ingress[Ingress Resource]
    Ingress -->|Path /| AAA-Service
    Ingress -->|Path /k2| BBB-Service
    Ingress -->|Path /k3| DDD-Service
    Ingress -->|Path /k4| EEE-Service
    subgraph aaa-ns
        AAA-Service --> AAA-Deployment[Deployment: static-website]
    end
    subgraph bbb-ns
        BBB-Service --> BBB-Deployment[Deployment: gradio-converter]
    end
    subgraph ddd-ns
        DDD-Service --> DDD-Deployment[Deployment: ubuntu-firefox]
    end
    subgraph eee-ns
        EEE-Service --> EEE-Deployment[Deployment: sonar-app]
    end
