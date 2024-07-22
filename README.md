# CI/CD Pipeline for a simple webpage

![CI/CD Pipeline](https://miro.medium.com/max/1400/1*F9gQvs4vGM0vRA_e5x8Eww.gif)

## Technologies and Tools Used
<img src="https://icon.icepanel.io/Technology/svg/Jenkins.svg"  width="50" height="50" alt="Jenkins"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Apache-Maven.svg" width="50" height="50" alt="Apache Maven"/> </a> <img src="https://icon.icepanel.io/Technology/svg/SonarQube.svg" width="50" height="50" alt="SonarQube"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Docker.svg" width="50" height="50" alt="Docker"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Kubernetes.svg" width="50" height="50" alt="Kubernetes"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Helm.svg" width="50" height="50" alt="Helm"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Grafana.svg" width="50" height="50" alt="Grafana"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Prometheus.svg" width="50" height="50" alt="Prometheus"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Git.svg" width="50" height="50" alt="Git"/> 


## Pipeline Details

### 1. Code Modification
When a developer pushes code changes to the repository, it triggers the pipeline via a webhook.

### 2. Jenkins Pipeline Activation
The webhook triggers Jenkins to start the pipeline.

### 3. Maven Build and Test
Jenkins executes the Maven build lifecycle to compile the code, run tests, and package the application.

### 4. SonarQube Analysis
The code is analyzed by SonarQube for code quality. If it passes the quality gate, the pipeline proceeds to the next step.

### 5. Docker Image Creation
A Docker image is built and tagged with the new application version.

### 6. Helm Deployment
Helm updates the Kubernetes manifest file. Kubernetes then deploys the new version of the application.

### 7. Monitoring with Prometheus and Grafana
Prometheus and Grafana are deployed as Helm charts in K8s. They monitor the cluster, providing real-time metrics and visualizations.





