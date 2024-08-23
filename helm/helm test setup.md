
# Setup Helm for dev

### Create a helm chart template 
```sh 
mkdir /var/lib/jenkins/helm
helm create /var/lib/jenkins/helm/Ced_Devops_Webapp-test
```

by default, it contains 
- values.yaml
- templates
- Charts.yaml
- charts

delete all file in /templates folder:
```sh
cd /var/lib/jenkins/helm/Ced_Devops_Webapp-test/templates
rm -rf *
```

### Add the manifest files in the templates folders and then package the chart
List of manifest file in this repo:
- [deployment.yaml](https://github.com/Cedric-Hj/DevOps-CICD-WebApp/blob/test/deployment.yaml)
- [namespace.yaml](https://github.com/Cedric-Hj/DevOps-CICD-WebApp/blob/test/namespace.yaml)
- [service.yaml](https://github.com/Cedric-Hj/DevOps-CICD-WebApp/blob/test/service.yaml)

```sh
touch /var/lib/jenkins/helm/Ced_Devops_Webapp-test/templates/deployment.yaml
touch /var/lib/jenkins/helm/Ced_Devops_Webapp-test/templates/namespace.yaml
touch /var/lib/jenkins/helm/Ced_Devops_Webapp-test/templates/service.yaml
```
then:
```sh
cd /var/lib/jenkins/helm
helm package Ced_Devops_Webapp-test
```

### Add Labels and Annotations

create the namespace:
``` sh
kubectl create namespace ced-devops-cicd-test
```

### Run the following commands to add the required labels and annotations to the namespace:

Add the label for Helm management
``` sh
kubectl label namespace ced-devops-cicd-test app.kubernetes.io/managed-by=Helm
```

Add the annotations for Helm release tracking
``` sh
kubectl annotate namespace ced-devops-cicd-test meta.helm.sh/release-name=ced-devops-webapp-test
kubectl annotate namespace ced-devops-cicd-test meta.helm.sh/release-namespace=ced-devops-cicd-test
```


### Install de deployment 
```sh 
helm install ced-devops-webapp-test Ced_Devops_Webapp-test-0.1.0.tgz --namespace ced-devops-cicd-test
```

### To list installed helm deployments
```sh 
helm list -a
```
