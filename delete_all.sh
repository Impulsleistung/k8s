#!/bin/bash

# Optional: Specify a namespace
NAMESPACE="default"

# First, scale all deployments to 0 replicas. This is a safer approach to ensure that no new pods are created
# by the deployments during the deletion process.
kubectl scale deployment --all --replicas=0 --namespace=$NAMESPACE

# Delete all statefulsets in the namespace. StatefulSets are used for stateful applications and should be
# deleted before deleting pods to ensure proper cleanup.
kubectl delete statefulsets --all --namespace=$NAMESPACE

# Delete all daemonsets in the namespace. DaemonSets are used to run a pod on each node and should be
# deleted to free up resources on each node.
kubectl delete daemonsets --all --namespace=$NAMESPACE

# Delete all deployments in the namespace. Deployments are a higher-level management mechanism for pods.
kubectl delete deployments --all --namespace=$NAMESPACE

# Delete all services in the namespace. Services are networking abstractions that should be removed
# to avoid any residual network configuration.
kubectl delete services --all --namespace=$NAMESPACE

# Delete all persistent volume claims (PVCs) in the namespace. PVCs represent storage claims by pods.
kubectl delete persistentvolumeclaims --all --namespace=$NAMESPACE

# Finally, delete all remaining pods in the namespace. Pods are the smallest deployable units and should be
# cleaned up last to ensure that all controlled resources are deleted.
kubectl delete pods --all --namespace=$NAMESPACE

# Echo a message to indicate completion of the script.
echo "All resources deleted in the namespace: $NAMESPACE"
