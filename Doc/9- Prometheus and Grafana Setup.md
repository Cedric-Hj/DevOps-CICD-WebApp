# Setup Prometheus

Prometheus run on :9090 and alert manager on :9093 and or forwarded on pod specific pods

### Create a dedicated namespace for prometheus 
   ```sh
   kubectl create namespace monitoring
   ```

### Add Prometheus helm chart repository
   ```sh
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 
   ```

### Update the helm chart repository
   ```sh
   helm repo update
   helm repo list
   ```

### Install Prometheus with Graphana

   ```sh
    helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring
   ```

### Open external access to Prometheus and Graphana
Helm will create all services as ClusterIP. 
To access Prometheus outside of the cluster, change the service type from ClusterIP to LoadBalancer:
   ```sh 
   kubectl edit svc prometheus-kube-prometheus-prometheus -n monitoring
   # change type: ClusterIP to type: LoadBalancer
   ```

  To access Graphana outside of the cluster, also change the service type from ClusterIP to LoadBalancer:
   ```sh 
   kubectl edit svc prometheus-grafana --namespace monitoring
   # change type: ClusterIP to type: LoadBalancer
   ```
 
Check the port forwarded for the pods
   - service/prometheus-kube-prometheus-prometheus for Prometheus
   - service/prometheus-grafana for Graphana
 
 using the command: 
   ``` ssh
   kubectl get all --namespace monitoring
   ```

### Log into Prometheus and Graphana
 In a browser go to 192.168.0.101:Port for Prometheus and Grafana


Graphana credencials
- username: admin
- password: prom-operator

