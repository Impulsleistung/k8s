# Deployment Instructions

## Prerequisites

-   A Civo Kubernetes cluster.
-   Helm installed.
-   ArgoCD installed in the cluster.
-   kubectl configured to connect to your Civo cluster.

## Steps

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Impulsleistung/k8s.git
    cd k8s
    ```

2.  **Install ArgoCD Applications:**

    ```bash
    kubectl create namespace argocd --kubeconfig=$KUBECONFIG
    kubectl apply -n argocd -f argocd/aaa-app.yaml --kubeconfig=$KUBECONFIG
    kubectl apply -n argocd -f argocd/bbb-app.yaml --kubeconfig=$KUBECONFIG
    kubectl apply -n argocd -f argocd/ccc-app.yaml --kubeconfig=$KUBECONFIG
    kubectl apply -n argocd -f argocd/ddd-app.yaml --kubeconfig=$KUBECONFIG
    kubectl apply -n argocd -f argocd/eee-app.yaml --kubeconfig=$KUBECONFIG
    ```

3.  **Deploy Ingress:**

    ```bash
    kubectl apply -f ingress.yaml --kubeconfig=$KUBECONFIG
    ```

4.  **Verify the deployments:**

    Check the ArgoCD UI to ensure that all applications are successfully deployed and synced.

## Testing the applications

1.  **Get the external IP of the Ingress controller:**

    ```bash
    kubectl get ingress main-ingress -o wide --kubeconfig=$KUBECONFIG
    ```

    Note the address under the `ADDRESS` column.  It might take a few minutes for the IP to be assigned. In this case it is `74.220.28.127`

2.  **Access the applications in your web browser:**

    -   AAA: `http://471f6fe0-f767-4ae6-bbdc-dd687bff86d.k8s.civo.com/`
    -   BBB: `http://471f6fe0-f767-4ae6-bbdc-dd687bff86d.k8s.civo.com/k2`
    -   CCC: `http://471f6fe0-f767-4ae6-bbdc-dd687bff86d.k8s.civo.com/k5`
    -   DDD: `http://471f6fe0-f767-4ae6-bbdc-dd687bff86d.k8s.civo.com/k3`
    -   EEE: `http://471f6fe0-f767-4ae6-bbdc-dd687bff86d.k8s.civo.com/k4`

## Troubleshooting

-   If the applications are not accessible, check the status of the deployments and services in each namespace.
-   Verify that the Ingress resource is correctly configured and that the Ingress controller is running.
-   Check the ArgoCD UI for any errors or out-of-sync applications.
