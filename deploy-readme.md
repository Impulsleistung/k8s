# Deployment Guide

## Voraussetzungen
- Kubernetes Cluster auf Civo.com
- kubectl konfiguriert mit korrektem KUBECONFIG
- Ingress-Controller bereits installiert

## Deployment Schritte

1. Ins Projektverzeichnis wechseln:
   ```bash
   cd scripts
   ```

2. Deployment-Skript ausführen:
   ```bash
   chmod +x deploy.sh
   ./deploy.sh
   ```

## Überprüfung der Deployment-Status

Überprüfen Sie die Pods:
```bash
kubectl get pods -n aaa-bbb-ns
```

Überprüfen Sie die Services:
```bash
kubectl get services -n aaa-bbb-ns
```

Überprüfen Sie den Ingress:
```bash
kubectl get ingress -n aaa-bbb-ns
```

## Testen der Anwendungen

Die Anwendungen sind über folgende URLs erreichbar:

- Website: http://74.220.29.142/
- Gradio Converter: http://74.220.29.142/g1/

Wichtig: Für Gradio muss der URL mit einem Schrägstrich enden ("/g1/")

## Kubernetes Dashboard

1. Öffnen Sie das Kubernetes Dashboard
2. Wählen Sie den Namespace "aaa-bbb-ns"
3. Überprüfen Sie:
   - Deployments
   - Pods
   - Services
   - Ingress

## Fehlerbehebung

Bei Problemen überprüfen Sie:
```bash
kubectl describe pods -n aaa-bbb-ns
kubectl logs -n aaa-bbb-ns [pod-name]
kubectl describe ingress -n aaa-bbb-ns
```

### Bekannte Probleme

#### Schwarzer Bildschirm bei Gradio

Wenn der Gradio Text Converter einen schwarzen Bildschirm zeigt:

1. Überprüfen Sie die Pod-Logs:
```bash
kubectl logs -n aaa-bbb-ns -l app=gradio
```

2. Prüfen Sie, ob beide Ingress-Ressourcen korrekt konfiguriert sind:
```bash
kubectl get ingress -n aaa-bbb-ns
```

3. Überprüfen Sie die Pod-Verbindungen:
```bash
kubectl exec -n aaa-bbb-ns $(kubectl get pod -n aaa-bbb-ns -l app=gradio -o name | head -n 1) -- netstat -an
```

4. Neustart der Pods wenn nötig:
```bash
kubectl rollout restart deployment/gradio -n aaa-bbb-ns
```

Die Anwendung sollte nun unter http://74.220.29.142/g1 erreichbar sein.
Nach Änderungen an der Ingress-Konfiguration kann es einige Minuten dauern, bis diese vollständig übernommen wurden.
