## Setup Helm

### Download Helm
```  sh
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
```
### Add executable permissions
``` sh
chmod 700 get_helm.sh
```

### Execute installation script
``` sh
./get_helm.sh
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm search repo <helm-chart>
helm search repo stable
```


### Create a helm chart template 
```sh 
helm create Ced_Devops_Webapp
```

by default, it contains 
- values.yaml
- templates
- Charts.yaml
- charts

delete all file in /templates folder:
```sh
cd /root/Ced_Devops_Webapp/templates
rm -rf *
```

### Add the manifest files in the templates folders and then package the chart
List of manifest file in this repo:
- [deployment.yamls](/deployment.yaml)
- [namespace.yaml](/namespace.yaml)
- [service.yaml](/service.yaml)
- [secret.yaml](/secret.yaml) (Not used in this project)

```sh
helm package Ced_Devops_Webapp
```

### Add Labels and Annotations

create the namespace:
``` sh
kubectl create namespace ced-devops-cicd
```

### Run the following commands to add the required labels and annotations to the namespace:

Add the label for Helm management
``` sh
kubectl label namespace ced-devops-cicd app.kubernetes.io/managed-by=Helm
```

Add the annotations for Helm release tracking
``` sh
kubectl annotate namespace ced-devops-cicd meta.helm.sh/release-name=ced-devops-webapp
kubectl annotate namespace ced-devops-cicd meta.helm.sh/release-namespace=ced-devops-cicd
```


### Install de deployment 
```sh 
helm install ced-devops-webapp Ced_Devops_Webapp-0.1.0.tgz --namespace ced-devops-cicd
```

### Create a jenkins job for the deployment 
   ```sh 
   stage(" Deploy ") {
          steps {
            script {
               echo '<--------------- Helm Deploy Started --------------->'
               sh 'helm install ttrend ttrend-0.1.0.tgz'
               echo '<--------------- Helm deploy Ends --------------->'
            }
          }
        }
   ```

### To list installed helm deployments
```sh 
helm list -a
```

Other useful commands

to change the default namespace to valaxy
```sh
kubectl config set-context --current --namespace=valaxy
```


## Setup Prometheus

Prometheus run on :9090 and alert manager on :9093

1. Create a dedicated namespace for prometheus 
   ```sh
   kubectl create namespace monitoring
   ```

2. Add Prometheus helm chart repository
   ```sh
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 
   ```

3. Update the helm chart repository
   ```sh
   helm repo update
   helm repo list
   ```

4. Install the prometheus

   ```sh
    helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring
   ```

5. Above helm create all services as ClusterIP. To access Prometheus out side of the cluster, we should change the service type load balancer
   ```sh 
   kubectl edit svc prometheus-kube-prometheus-prometheus -n monitoring
   
   ```
6. Loginto Prometheus dashboard to monitor application
   https://ELB:9090

7. Check for node_load15 executor to check cluster monitoring 

8. We check similar graphs in the Grafana dashboard itself. for that, we should change the service type of Grafana to LoadBalancer
   ```sh 
   kubectl edit svc prometheus-grafana
   ```

9.  To login to Grafana account, use the below username and password 
    ```sh
    username: admin
    password: prom-operator
    ```
10. Here we should check for "Node Exporter/USE method/Node" and "Node Exporter/USE method/Cluster"
    USE - Utilization, Saturation, Errors
   
11. Even we can check the behavior of each pod, node, and cluster 
