<p><a target="_blank" href="https://app.eraser.io/workspace/thllnGtosn8VVMRPxttC" id="edit-in-eraser-github-link"><img alt="Edit in Eraser" src="https://firebasestorage.googleapis.com/v0/b/second-petal-295822.appspot.com/o/images%2Fgithub%2FOpen%20in%20Eraser.svg?alt=media&amp;token=968381c8-a7e7-472a-8ed6-4a6626da5501"></a></p>

# DevOps project of a CI/CD Pipeline for a Webpage
This repository contains a DevOps project for a CI/CD pipeline designed for a webpage. This pipeline is designed to automate the process of building, testing, and deploying a web application. It consists of several stages, each with specific tasks to ensure code quality and streamline deployment. The purpose of this project is to learn how to implement such a pipeline and understand the technologies involved. The entire project was set up on multiple VMs in a home lab, making it completely free and without time constraints, allowing for experimentation and learning. All documentation and step-by-step guides are located in the doc folder.

## Technologies and Tools Used
<img src="https://icon.icepanel.io/Technology/svg/Jenkins.svg"  width="50" height="50" alt="Jenkins"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Apache-Maven.svg" width="50" height="50" alt="Apache Maven"/> </a> <img src="https://icon.icepanel.io/Technology/svg/SonarQube.svg" width="50" height="50" alt="SonarQube"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Docker.svg" width="50" height="50" alt="Docker"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Kubernetes.svg" width="50" height="50" alt="Kubernetes"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Helm.svg" width="50" height="50" alt="Helm"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Grafana.svg" width="50" height="50" alt="Grafana"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Prometheus.svg" width="50" height="50" alt="Prometheus"/> </a> <img src="https://icon.icepanel.io/Technology/svg/Git.svg" width="50" height="50" alt="Git"/> 

## Pipeline Diagram
![Diagram](https://github.com/Cedric-Hj/DevOps-CICD-WebApp/blob/main/Doc/Pipeline%20diagram.png "")

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

### 6. Push Docker image
Pushes the Docker image to a registry. 

### 7. Helm Deployment
Helm updates the Kubernetes manifest file. Kubernetes then deploys the new version of the application.

### 8. Monitoring with Prometheus and Grafana
Prometheus and Grafana are deployed as Helm charts in K8s. They monitor the cluster, providing real-time metrics and visualizations.

