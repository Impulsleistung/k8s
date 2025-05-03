# Deployment Instructions

This document outlines the steps to deploy the applications to your Kubernetes cluster.

## Prerequisites

-   A Kubernetes cluster (e.g., Civo)
-   `kubectl` configured to connect to your cluster
-   Sufficient permissions to create namespaces, deployments, services, and ingress resources.

## Steps

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Impulsleistung/k8s.git
    cd k8s
    ```

2.  **Run the deployment script:**

    ```bash
    chmod +x deploy.sh
    ./deploy.sh
    ```

## Testing the Applications

Once the deployment is complete, you can access the applications in your web browser using the following URLs:

-   **Static Website (AAA):** `http://74.220.28.127/`
-   **Gradio Text Converter (BBB):** `http://74.220.28.127/k2`
-   **Docker Firefox (DDD):** `http://74.220.28.127/k3`
-   **Sonar App (EEE):** `http://74.220.28.127/k4`

Replace `74.220.28.127` with the actual DNS name or IP address of your load balancer if it differs.
