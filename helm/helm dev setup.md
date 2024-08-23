
# Setup Helm for dev

### Create a helm chart template 
```sh 
mkdir /var/lib/jenkins/helm
helm create /var/lib/jenkins/helm/Ced_Devops_Webapp-dev
```

by default, it contains 
- values.yaml
- templates
- Charts.yaml
- charts

delete all file in /templates folder:
```sh
cd /var/lib/jenkins/helm/Ced_Devops_Webapp-dev/templates
rm -rf *
```

### Add the manifest files in the templates folders and then package the chart
List of manifest file in this repo:
- [deployment.yaml](https://github.com/Cedric-Hj/DevOps-CICD-WebApp/blob/dev/deployment.yaml)
- [namespace.yaml](https://github.com/Cedric-Hj/DevOps-CICD-WebApp/blob/dev/namespace.yaml)
- [service.yaml](https://github.com/Cedric-Hj/DevOps-CICD-WebApp/blob/dev/service.yaml)

```sh
touch /var/lib/jenkins/helm/Ced_Devops_Webapp-dev/templates/deployment.yaml
touch /var/lib/jenkins/helm/Ced_Devops_Webapp-dev/templates/namespace.yaml
touch /var/lib/jenkins/helm/Ced_Devops_Webapp-dev/templates/service.yaml
```
then:
```sh
cd /var/lib/jenkins/helm
helm package Ced_Devops_Webapp-dev
```

### Add Labels and Annotations

create the namespace:
``` sh
kubectl create namespace ced-devops-cicd-dev
```

### Run the following commands to add the required labels and annotations to the namespace:

Add the label for Helm management
``` sh
kubectl label namespace ced-devops-cicd-dev app.kubernetes.io/managed-by=Helm
```

Add the annotations for Helm release tracking
``` sh
kubectl annotate namespace ced-devops-cicd-dev meta.helm.sh/release-name=ced-devops-webapp-dev
kubectl annotate namespace ced-devops-cicd-dev meta.helm.sh/release-namespace=ced-devops-cicd-dev
```


### Install de deployment 
```sh 
helm install ced-devops-webapp-dev Ced_Devops_Webapp-dev-0.1.0.tgz --namespace ced-devops-cicd-dev
```

### To list installed helm deployments
```sh 
helm list -a
```
