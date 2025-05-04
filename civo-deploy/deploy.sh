#!/bin/bash
set -e

echo "Deploy AAA Namespace..."
kubectl apply -f aaa-namespace.yaml

echo "Deploy BBB Namespace..."
kubectl apply -f bbb-namespace.yaml

echo "Deploy AAA App..."
kubectl apply -f aaa-deployment.yaml

echo "Deploy BBB App..."
kubectl apply -f bbb-deployment.yaml

echo "Deploy Ingress (in aaa-ns)..."
kubectl apply -f ingress.yaml

echo "Warte auf Deployments..."
kubectl -n aaa-ns rollout status deployment/aaa-deployment
kubectl -n aaa-ns rollout status deployment/bbb-deployment

echo "Prüfe Services:"
kubectl -n aaa-ns get svc aaa-service
kubectl -n aaa-ns get svc bbb-service

echo "Prüfe Ingress:"
kubectl -n aaa-ns get ingress imp-ingress

echo "Deployment abgeschlossen."
