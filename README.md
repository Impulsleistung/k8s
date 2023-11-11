# Kubernetes Introduction

![Alt text](drawing/containerCloud.png)

Here's a concise cheat sheet for `kubectl`, the command-line tool for Kubernetes:

### General Syntax
- `kubectl [command] [TYPE] [NAME] [flags]`

### Getting Started
- `kubectl version`: Display the Kubernetes version.
- `kubectl cluster-info`: Show cluster info.
- `kubectl config view`: Display merged kubeconfig settings.

### Working with Namespaces
- `kubectl get namespaces`: List all namespaces.
- `kubectl create namespace [name]`: Create a new namespace.
- `kubectl config set-context --current --namespace=[name]`: Set the default namespace for subsequent commands.

### Managing Resources
- `kubectl get [resource]`: List resources (pods, services, deployments, etc.).
- `kubectl describe [resource] [name]`: Show detailed info about a resource.
- `kubectl create -f [file.yaml]`: Create a resource from a YAML file.
- `kubectl apply -f [file.yaml]`: Apply a configuration to a resource from a YAML file.
- `kubectl delete [resource] [name]`: Delete a resource.

### Pods and Containers
- `kubectl get pods`: List all pods in the namespace.
- `kubectl logs [pod-name]`: Get logs for a pod.
- `kubectl exec [pod-name] -- [command]`: Execute a command in a container.

### Deployments and Replication
- `kubectl rollout status deployment/[name]`: Get the rollout status of a deployment.
- `kubectl rollout undo deployment/[name]`: Rollback to the previous deployment.
- `kubectl scale deployment/[name] --replicas=[number]`: Scale a deployment to a specified number of replicas.

### Services
- `kubectl get services`: List all services in the namespace.
- `kubectl expose deployment/[name] --port=[port] --type=[type]`: Expose a deployment as a new Kubernetes Service.

### Advanced Commands
- `kubectl set image deployment/[deployment-name] [container-name]=[new-image]`: Update the image of a deployment.
- `kubectl attach [pod-name] -i`: Attach to a running container.
- `kubectl port-forward [pod-name] [local-port]:[container-port]`: Forward one or more local ports to a pod.

### Configuration and Context
- `kubectl config current-context`: Display the current context.
- `kubectl config use-context [context-name]`: Switch to another context.

### Debugging and Troubleshooting
- `kubectl get events`: Get events for the current namespace.
- `kubectl run -i --tty [pod-name] --image=[image] --restart=Never -- [command]`: Run a temporary pod and execute a command.

Remember, this is just a basic guide. `kubectl` has many more commands and options available. For more detailed information, you can always refer to the official Kubernetes documentation or use `kubectl help`.

## Resolve some issues
### Windows and Git
The bash in the container use Double Slashes. Another workaround specific to Git Bash is to use double slashes at the beginning of the Unix path:
 can `kubectl exec -it my-first-pod -- //bin/bash`

### Finding a file with a specific text
The command `grep -r "Welcome to Kevins Kubernetes" . 2>/dev/null` searches recursively for the string in all files within a specified directory, suppressing error messages by redirecting them to `/dev/null`, a location where they are effectively discarded.

## Excute a remote file 
### Variant A (curl it)
Use the -k or --insecure Option with curl
If updating the CA certificates doesn't solve the problem or if you're in a controlled environment where you trust the source, you can bypass the certificate verification by using the -k or --insecure option with curl. This is not recommended for untrusted sources as it could expose you to security risks.

`curl -k -o replicaset-demo.yml -L https://github.com/stacksimplify/azure-aks-kubernetes-masterclass/raw/master/03-Kubernetes-Fundamentals-with-kubectl/03-02-ReplicaSets-with-kubectl/replicaset-demo.yml`

Then apply it with kubectl:
`kubectl apply -f replicaset-demo.yml`

### Variant B (direct execute)
Directly Input the URL in kubectl. Some versions of kubectl might allow you to directly specify a URL with the -f flag, like this:
`kubectl apply -f https://github.com/stacksimplify/azure-aks-kubernetes-masterclass/raw/master/03-Kubernetes-Fundamentals-with-kubectl/03-02-ReplicaSets-with-kubectl/replicaset-demo.yml`

