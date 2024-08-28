# List of usefull command to use in the cluster
this list contains usefull commands for kubectl and helm

Kubectl
- [Basic Operations](#Basic-Operations)
- [Managing Resources](#Managing-Resources)
- [Troubleshooting](#Troubleshooting)
- [Advanced Operations](#Advanced-Operations)
- [Namespace Management](#Namespace-Management)

Helm
- [Listing Helm Releases](#Listing-Helm-Releases)
- [Managing Helm Releases](#Managing-Helm-Releases)
- [Retrieving Release Information](#Retrieving-Release-Information)

### Basic Operations

- View the details of the current Kubernetes cluster.

   ```bash
   kubectl cluster-info
   ```

- List all the nodes in the cluster.

   ```bash
   kubectl get nodes
   ```

- List all pods in a specific namespace or all namespaces.

   ```bash
   kubectl get pods --namespace <namespace>
   ```

- List pods in all namespaces:

   ```bash
   kubectl get pods --all-namespaces
   ```

- List all services in a specific namespace.

   ```bash
   kubectl get svc --namespace <namespace>
   ```

- List all deployments in a specific namespace.

   ```bash
   kubectl get deployments --namespace <namespace>
   ```

- Get detailed information about a resource (e.g., pod, service, deployment).

   ```bash
   kubectl describe <resource_type> <resource_name> --namespace <namespace>
   ```


- View logs for a specific pod.

   ```bash
   kubectl logs <pod_name> --namespace <namespace>
   ```

   - To follow logs in real-time:

   ```bash
   kubectl logs -f <pod_name> --namespace <namespace>
   ```

- Run a command inside a specific pod.

   ```bash
   kubectl exec -it <pod_name> --namespace <namespace> -- <command>
   ```


### Managing Resources

- Apply a configuration file to a resource. This can be used to create or update resources.

   ```bash
   kubectl apply -f <file.yaml>
   ```

- Delete a specific resource.

    ```bash
    kubectl delete <resource_type> <resource_name> --namespace <namespace>
    ```


- Delete all resources of a type in a namespace:

    ```bash
    kubectl delete <resource_type> --all --namespace <namespace>
    ```

- Scale a deployment to a specific number of replicas.

    ```bash
    kubectl scale deployment <deployment_name> --replicas=<number_of_replicas> --namespace <namespace>
    ```


- Create resources like pods, services, deployments, etc., from a configuration file.

    ```bash
    kubectl create -f <file.yaml>
    ```

- Create a service to expose a deployment.

    ```bash
    kubectl expose deployment <deployment_name> --type=<service_type> --port=<port> --target-port=<target_port> --namespace <namespace>
    ```


### Troubleshooting

- Forward a local port to a port on a pod.

    ```bash
    kubectl port-forward <pod_name> <local_port>:<pod_port> --namespace <namespace>
    ```


- View recent events in the cluster, which is useful for debugging.

    ```bash
    kubectl get events --namespace <namespace>
    ```

- Get resource usage (CPU/Memory) for nodes or pods (requires `metrics-server` to be installed).

    ```bash
    kubectl top nodes
    ```

- Get resource usage for pods:

    ```bash
    kubectl top pods --namespace <namespace>
    ```

- View the current context and configurations in use by `kubectl`.

    ```bash
    kubectl config view
    ```

- Preview the result of a command without actually applying it.

    ```bash
    kubectl apply -f <file.yaml> --dry-run=client
    ```

- Create a temporary pod for debugging with a specific image.

    ```bash
    kubectl run -it --rm debug-pod --image=<image_name> -- /bin/bash
    ```

### Advanced Operations

- Check the status of a deployment rollout.

    ```bash
    kubectl rollout status deployment/<deployment_name> --namespace <namespace>
    ```

- View the history of rollouts for a deployment.

    ```bash
    kubectl rollout history deployment/<deployment_name> --namespace <namespace>
    ```

- Roll back to a previous revision of a deployment.

    ```bash
    kubectl rollout undo deployment/<deployment_name> --namespace <namespace>
    ```

- Edit a resource configuration directly in your default editor.

    ```bash
    kubectl edit <resource_type> <resource_name> --namespace <namespace>
    ```

- Apply a partial update to a resource.

    ```bash
    kubectl patch <resource_type> <resource_name> --patch '<json_patch>' --namespace <namespace>
    ```


### Namespace Management

- List all namespaces in the cluster.

    ```bash
    kubectl get namespaces
    ```

- Create a new namespace.

    ```bash
    kubectl create namespace <namespace_name>
    ```

- Delete a namespace and all resources in it.

    ```bash
    kubectl delete namespace <namespace_name>
    ```


### Listing Helm Releases

- List all Helm releases across all namespaces
    ```sh
    helm list -a
    ```

- List Helm releases in a specific namespace
  ```sh
  helm list --namespace <namespace>
  ```

### Managing Helm Releases
- Uninstall a specific Helm release from a namespace
  ```sh
  helm uninstall <release_name> --namespace <namespace>
  ```

- Roll back a Helm release to a specific revision in a namespace
  ```sh
  helm rollback <release_name> <revision> --namespace <namespace>
  ```

### Retrieving Release Information
- Get the values of a specific Helm release in a namespace
 Use --all to show all values, including those not set by the user
  ```sh
  helm get values <release_name> --namespace <namespace> [--all]
  ```

- Show the history of a specific Helm release in a namespace
  ```sh
  helm history <release_name> --namespace <namespace>
  ```
