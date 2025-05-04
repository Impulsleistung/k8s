#!/bin/bash

# Set the namespace
NAMESPACE="aaa-bbb-ns"

# Create the namespace
kubectl apply -f aaa-bbb-ns/namespace.yaml
echo "Namespace created."

# Deploy the static website
kubectl apply -f aaa-bbb-ns/static-website-deployment.yaml
kubectl apply -f aaa-bbb-ns/static-website-service.yaml
echo "Static website deployed."

# Deploy the Gradio Text Converter
kubectl apply -f aaa-bbb-ns/gradio-text-converter-deployment.yaml
kubectl apply -f aaa-bbb-ns/gradio-text-converter-service.yaml
echo "Gradio Text Converter deployed."

# Deploy the Ingress
kubectl apply -f ingress.yaml
echo "Ingress deployed."

# Wait for deployments to be ready
echo "Waiting for deployments to be ready..."
kubectl rollout status deployment/static-website -n $NAMESPACE --timeout=60s
kubectl rollout status deployment/gradio-text-converter -n $NAMESPACE --timeout=60s

# Get the Ingress status and print the address
echo "Getting Ingress status..."
INGRESS_ADDRESS=$(kubectl get ingress main-ingress -n $NAMESPACE -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

if [ -z "$INGRESS_ADDRESS" ]; then
    echo "Ingress address not available yet. Please check again later."
else
    echo "Applications deployed successfully!"
    echo "Static Website: http://$INGRESS_ADDRESS/"
    echo "Gradio Text Converter: http://$INGRESS_ADDRESS/g1"
fi
