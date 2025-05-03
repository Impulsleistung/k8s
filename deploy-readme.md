# Deployment Anleitung

Diese Anleitung beschreibt, wie die Anwendungen AAA, BBB, DDD und EEE mittels Helm und ArgoCD auf dem K3s-Cluster (imp-k8s) deployed werden.

## Voraussetzungen

- Kubernetes KUBECONFIG-Variable ist gesetzt.
- Zugriff auf das Repository: https://github.com/Impulsleistung/k8s.git
- Zugang zum ArgoCD-Frontend.

## Projektstruktur

```
c:\Users\info\OneDrive\Desktop\k8s
├── argo
│   ├── aaa-app.yaml
│   ├── bbb-app.yaml
│   ├── ddd-app.yaml
│   └── eee-app.yaml
├── deploy-readme.md
└── helm
    ├── aaa-chart
    ├── bbb-chart
    ├── ddd-chart
    └── eee-chart
```

## Deployment mit ArgoCD

1. **ArgoCD einrichten**  
   Falls noch nicht geschehen, installiere ArgoCD im Cluster ([Dokumentation](https://argo-cd.readthedocs.io/en/stable/)).

2. **ArgoCD Applications anlegen**  
   Wende die ArgoCD Application-Manifeste an:

   ```
   kubectl apply -f argo/aaa-app.yaml
   kubectl apply -f argo/bbb-app.yaml
   kubectl apply -f argo/ddd-app.yaml
   kubectl apply -f argo/eee-app.yaml
   ```

3. **Sync abwarten**  
   Überprüfe im ArgoCD-Frontend, ob alle Applications den Sync-Zustand erreicht haben.

## Zugriff auf die Anwendungen

Die Ingress-Routen leiten wie folgt weiter (verwende den Ingress-Host aus den Helm‑Charts, hier: `29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com`):

- AAA (Static Website): [http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/](http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/)
- BBB (Gradio Text Converter): [http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/k2](http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/k2)
- DDD (Ubuntu Firefox): [http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/k3](http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/k3)
- EEE (Sonar App): [http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/k4](http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/k4)

## ArgoCD Frontend

Rufe das ArgoCD-Frontend auf (normalerweise über einen Ingress oder Port-Forward). Beispiel (Port-Forward):

```
kubectl port-forward svc/argo-cd-argocd-server -n argocd 8080:443
```

Falls der Befehl den Fehler "services 'argocd-server' not found" zurückgibt, führe folgenden Befehl aus, um den korrekten Service-Namen zu ermitteln:
```
kubectl get svc -n argocd
```
Verwende anschließend den angezeigten Namen im Port-Forward-Befehl.

Sollte im Browser eine Benutzer-Authentifizierung abgefragt werden, melde dich mit dem Benutzernamen "admin" an und hole das initiale Passwort mit:
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Dann im Browser: [https://localhost:8080](https://localhost:8080)

## Testen

Öffne in Deinem Browser die o. g. URLs, um jede Anwendung zu prüfen.

## Zusammenfassung

- ArgoCD übernimmt das Deployment der Helm-Charts.
- Jede Anwendung ist in einem eigenen Namespace deployed (aaa-ns, bbb-ns, ddd-ns, eee-ns).
- Teste die Applikationen und greife über das ArgoCD-Frontend auf den Sync-/Health-Zustand zu.
