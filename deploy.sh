#!/bin/bash

#set -e

# Function to check if a namespace exists
namespace_exists() {
    kubectl get namespace "$1" >/dev/null 2>&1
    return $?
}

# Function to check if a service exists in a namespace
service_exists() {
    kubectl get service "$1" -n "$2" >/dev/null 2>&1
    return $?
}

# Function to check if endpoints exist for a service in a namespace
endpoints_exist() {
    kubectl get endpoints "$1" -n "$2" | grep -q "Endpoints.*<none>"
    return $((1 - $?)) # Invert the exit code: 0 if endpoints exist, 1 if not
}

# Create Namespaces
kubectl apply -f namespaces/aaa-ns.yaml
kubectl apply -f namespaces/bbb-ns.yaml
kubectl apply -f namespaces/ddd-ns.yaml
kubectl apply -f namespaces/eee-ns.yaml

# Deploy Applications
if namespace_exists "aaa-ns"; then
    kubectl apply -f deployments/aaa-deployment.yaml -n aaa-ns
else
    echo "Namespace aaa-ns does not exist. Aborting."
    exit 1
fi

if namespace_exists "bbb-ns"; then
    kubectl apply -f deployments/bbb-deployment.yaml -n bbb-ns
else
    echo "Namespace bbb-ns does not exist. Aborting."
    exit 1
fi

if namespace_exists "ddd-ns"; then
    kubectl apply -f deployments/ddd-deployment.yaml -n ddd-ns
else
    echo "Namespace ddd-ns does not exist. Aborting."
    exit 1
fi

if namespace_exists "eee-ns"; then
    kubectl apply -f deployments/eee-deployment.yaml -n eee-ns
else
    echo "Namespace eee-ns does not exist. Aborting."
    exit 1
fi

# Expose Services
if namespace_exists "aaa-ns"; then
    kubectl apply -f services/aaa-service.yaml -n aaa-ns
else
    echo "Namespace aaa-ns does not exist. Aborting."
    exit 1
fi

if namespace_exists "bbb-ns"; then
    kubectl apply -f services/bbb-service.yaml -n bbb-ns
else
    echo "Namespace bbb-ns does not exist. Aborting."
    exit 1
fi

if namespace_exists "ddd-ns"; then
    kubectl apply -f services/ddd-service.yaml -n ddd-ns
else
    echo "Namespace ddd-ns does not exist. Aborting."
    exit 1
fi

if namespace_exists "eee-ns"; then
    kubectl apply -f services/eee-service.yaml -n eee-ns
else
    echo "Namespace eee-ns does not exist. Aborting."
    exit 1
fi

# Wait for services to be available
echo "Waiting for services to be available..."
sleep 30 # Wait for 30 seconds. Adjust as needed.

# Check Services and Endpoints
SERVICES=(
    "aaa-service:aaa-ns"
    "bbb-service:bbb-ns"
    "ddd-service:ddd-ns"
    "eee-service:eee-ns"
)

for SERVICE in "${SERVICES[@]}"; do
    SVC_NAME=$(echo "$SERVICE" | cut -d':' -f1)
    SVC_NS=$(echo "$SERVICE" | cut -d':' -f2)

    if ! service_exists "$SVC_NAME" "$SVC_NS"; then
        echo "Service $SVC_NAME in namespace $SVC_NS does not exist. Aborting."
        exit 1
    fi

    if ! endpoints_exist "$SVC_NAME" "$SVC_NS"; then
        echo "Endpoints for service $SVC_NAME in namespace $SVC_NS do not exist. Aborting."
        exit 1
    fi

    echo "Service $SVC_NAME in namespace $SVC_NS is reachable."
done

# Configure Ingress
kubectl apply -f ingress/ingress.yaml

echo "Deployment completed!"
