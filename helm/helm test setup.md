
# Setup Helm for test

### Create a helm chart template 
```sh 
mkdir /var/lib/jenkins/helm
helm create /var/lib/jenkins/helm/Ced_testops_Webapp-test
```

by default, it contains 
- values.yaml
- templates
- Charts.yaml
- charts

delete all file in /templates folder:
```sh
cd /var/lib/jenkins/helm/Ced_testops_Webapp-test/templates
rm -rf *
```

### Add the manifest files in the templates folders and then package the chart
List of manifest file in this repo:
- [deployment.yaml](https://github.com/Cedric-Hj/testOps-CICD-WebApp/blob/test/deployment.yaml)
- [namespace.yaml](https://github.com/Cedric-Hj/testOps-CICD-WebApp/blob/test/namespace.yaml)
- [service.yaml](https://github.com/Cedric-Hj/testOps-CICD-WebApp/blob/test/service.yaml)

```sh
touch /var/lib/jenkins/helm/Ced_testops_Webapp-test/templates/deployment.yaml
touch /var/lib/jenkins/helm/Ced_testops_Webapp-test/templates/namespace.yaml
touch /var/lib/jenkins/helm/Ced_testops_Webapp-test/templates/service.yaml
```
then:
```sh
cd /var/lib/jenkins/helm
helm package Ced_testops_Webapp-test
```

### Add Labels and Annotations

create the namespace:
``` sh
kubectl create namespace ced-testops-cicd-test
```

### Run the following commands to add the required labels and annotations to the namespace:

Add the label for Helm management
``` sh
kubectl label namespace ced-testops-cicd-test app.kubernetes.io/managed-by=Helm
```

Add the annotations for Helm release tracking
``` sh
kubectl annotate namespace ced-testops-cicd-test meta.helm.sh/release-name=ced-testops-webapp-test
kubectl annotate namespace ced-testops-cicd-test meta.helm.sh/release-namespace=ced-testops-cicd-test
```


### Install de deployment 
```sh 
helm install ced-testops-webapp-test Ced_testops_Webapp-test-0.1.0.tgz --namespace ced-testops-cicd-test
```

### To list installed helm deployments
```sh 
helm list -a
```
