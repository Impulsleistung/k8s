# Civo Kubernetes Deployment

## Voraussetzungen

- Zugriff auf das Cluster (KUBECONFIG Umgebungsvariable gesetzt)
- kubectl installiert

## Deployment

1. Wechsle ins Verzeichnis `civo-deploy`:
   ```bash
   cd civo-deploy
   ```
2. Führe das Deployment-Skript aus:
   ```bash
   bash deploy.sh
   ```

## Test der Anwendungen

Öffne im Browser:

- **Homepage:**  
  http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/

- **Markdown Converter:**  
  http://29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com/k2

Beide Anwendungen sollten erreichbar sein.

> **Hinweis bei 503-Fehlern:**  
> Das Ingress-Objekt verweist auf Services im Namespace `aaa-ns`.  
> Stelle sicher, dass sowohl `aaa-service` als auch `bbb-service` im Namespace `aaa-ns` existieren.  
> Wenn ein Service im Namespace `bbb-ns` liegt, kann das Ingress im Namespace `aaa-ns` diesen nicht finden.  
> Prüfe, ob die Services und Deployments im richtigen Namespace laufen und Endpoints vorhanden sind:
> ```bash
> kubectl -n aaa-ns get svc
> kubectl -n aaa-ns get endpoints
> kubectl -n bbb-ns get svc
> kubectl -n bbb-ns get endpoints
> ```

## Hinweise

- Die Ingress-URL basiert auf dem Load Balancer DNS-Namen.
- Bei Problemen prüfe die Pods und Logs:
  ```bash
  kubectl -n aaa-ns get pods
  kubectl -n bbb-ns get pods
  kubectl -n aaa-ns logs deployment/aaa-deployment
  kubectl -n bbb-ns logs deployment/bbb-deployment
  ```
