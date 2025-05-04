# Deployment Instructions

## Prerequisites

-   kubectl installed and configured to connect to your Civo Kubernetes cluster.
-   KUBECONFIG environment variable set to the path of your kubeconfig file.
-   Bash shell

## Deployment Steps

1.  **Clone this repository.**
2.  **Navigate to the `k8s` directory.**

    ```bash
    cd k8s
    ```
3.  **Run the deployment script:**

    ```bash
    bash deploy.sh
    ```

    This script will:

    -   Create the `aaa-bbb-ns` namespace.
    -   Deploy the static website and Gradio Text Converter deployments and services.
    -   Deploy the ingress to route traffic to the services.
    -   Wait for the deployments to be ready.
    -   Print the URLs for accessing the applications.

## Testing the Applications

Once the deployment is complete, you can access the applications in your web browser using the following URLs:

-   **Static Website:** `http://<ingress-address>/`
-   **Gradio Text Converter:** `http://<ingress-address>/g1`

Replace `<ingress-address>` with the address provided by the deployment script.  It will look something like `29137147-cf8f-4673-a55a-028b2b89af31.lb.civo.com`.

## Checking the Deployment in the Kubernetes Dashboard

1.  **Access the Kubernetes Dashboard:**

    You can access the Kubernetes Dashboard using `kubectl proxy`.  Open a new terminal and run:

    ```bash
    kubectl proxy
    ```

    Then, open your web browser and navigate to `http://localhost:8001/`.

2.  **Navigate to the `aaa-bbb-ns` namespace.**
3.  **Check the status of the deployments and services.**

    -   Verify that the deployments (`static-website` and `gradio-text-converter`) are running and have the desired number of replicas.
    -   Verify that the services (`static-website-service` and `gradio-text-converter-service`) are available.
    -   Check the ingress (`main-ingress`) to ensure that it is configured correctly and has an address assigned.

## Troubleshooting

-   If the applications are not accessible, check the status of the deployments, services, and ingress in the Kubernetes Dashboard.
-   Check the logs of the pods for any errors.
-   Ensure that the Civo load balancer is configured correctly and is routing traffic to the Kubernetes nodes.
