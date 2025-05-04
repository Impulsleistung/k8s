#!/bin/bash

# Create namespace
kubectl apply -f ../manifests/namespace.yaml

# Deploy website
kubectl apply -f ../manifests/website/
echo "Checking website deployment..."
kubectl wait --namespace aaa-bbb-ns \
    --for=condition=ready pod \
    --selector=app=website \
    --timeout=90s

# Deploy gradio
kubectl apply -f ../manifests/gradio/
echo "Checking gradio deployment..."
kubectl wait --namespace aaa-bbb-ns \
    --for=condition=ready pod \
    --selector=app=gradio \
    --timeout=90s

# Deploy ingress
kubectl apply -f ../manifests/ingress.yaml

echo "Deployment complete. Services should be available shortly."
