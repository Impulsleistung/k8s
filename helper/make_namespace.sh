#!/bin/bash

NAMESPACE=$1

kubectl create namespace "$NAMESPACE"

if [[ $? -eq 0 ]]; then
  echo "Namespace created successfully."
  kubectl config set-context --current --namespace="$NAMESPACE"
  echo "$NAMESPACE is now the default namespace."
else
  echo "Failed to create namespace. Please check for errors."
fi

kubectl config view --minify | grep -E 'cluster:|namespace:|user:'

echo "To create a namespace named 'my-new-namespace', you would run the following command:"
echo "./make_namespace.sh my-new-namespace"
echo "This will create the namespace 'my-new-namespace' and set it as the default namespace for the current context."
