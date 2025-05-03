# Deployment Guide

## Voraussetzungen
- Kubernetes Cluster ist eingerichtet
- KUBECONFIG ist als Umgebungsvariable gesetzt
- kubectl ist installiert
- Ingress-Controller ist installiert

## Deployment-Schritte

1. Clone das Repository:
```bash
git clone https://github.com/Impulsleistung/k8s.git
cd k8s
```

2. Deployments und Services erstellen:
```bash
kubectl apply -f manifests/aaa-deployment.yaml
kubectl apply -f manifests/bbb-deployment.yaml
kubectl apply -f manifests/ddd-deployment.yaml
kubectl apply -f manifests/eee-deployment.yaml
```

3. Ingress erstellen:
```bash
kubectl apply -f manifests/ingress.yaml
```

## Testen der Anwendungen

Alle Anwendungen sind über Port 80 erreichbar:

- Standard Website: http://74.220.28.127/
- Gradio Text Converter: http://74.220.28.127/k2
- Ubuntu Firefox: http://74.220.28.127/k3
- Sonar App: http://74.220.28.127/k4

## Status überprüfen

```bash
kubectl get pods --all-namespaces
kubectl get ingress
kubectl get services --all-namespaces
```

## Wichtiger Hinweis
Alle Container sind für den Betrieb auf Port 80 konfiguriert. Stellen Sie sicher, dass Ihre Container-Images entsprechend konfiguriert sind.
