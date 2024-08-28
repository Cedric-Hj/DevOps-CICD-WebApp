# Setup Helm

Skip to [Create a helm chart template](#Create-a-helm-chart-template) if provisioning was used

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
mkdir /var/lib/jenkins/helm
helm create /var/lib/jenkins/helm/Ced_Devops_Webapp
```

by default, it contains 
- values.yaml
- templates
- Charts.yaml
- charts

delete all file in /templates folder:
```sh
cd /var/lib/jenkins/helm/Ced_Devops_Webapp/templates
rm -rf *
```

### Add the manifest files in the templates folders and then package the chart
List of manifest file in this repo:
- [deployment.yaml](/deployment.yaml)
- [namespace.yaml](/namespace.yaml)
- [service.yaml](/service.yaml)
- [secret.yaml](/secret.yaml) (Not used in this project)

```sh
touch /var/lib/jenkins/helm/Ced_Devops_Webapp/templates/deployment.yaml
touch /var/lib/jenkins/helm/Ced_Devops_Webapp/templates/namespace.yaml
touch /var/lib/jenkins/helm/Ced_Devops_Webapp/templates/service.yaml
```
Optional, package the application:
```sh
cd /var/lib/jenkins/helm
helm package Ced_Devops_Webapp
```

### Add Labels and Annotations

create the namespace:
``` sh
kubectl create namespace ced-devops-cicd
```

Add the label for Helm management
``` sh
kubectl label namespace ced-devops-cicd app.kubernetes.io/managed-by=Helm
```

Add the annotations for Helm release tracking
``` sh
kubectl annotate namespace ced-devops-cicd meta.helm.sh/release-name=ced-devops-webapp
kubectl annotate namespace ced-devops-cicd meta.helm.sh/release-namespace=ced-devops-cicd
```


### Manually Install de packaged deployment 
```sh 
helm install ced-devops-webapp Ced_Devops_Webapp-0.1.0.tgz --namespace ced-devops-cicd
```

### List of usefull heml commands
```sh 
helm list -a

helm list --namespace <namespace>

helm uninstall <release_name> --namespace <namespace>

helm rollback <release_name> <revision> --namespace <namespace>

helm get values <release_name> --namespace <namespace> [--all]

helm history <release_name> --namespace <namespace>


```

