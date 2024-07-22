# CI/CD Pipeline with Jenkins, Maven, SonarQube, Docker, Kubernetes, Helm, Prometheus, and Grafana

![CI/CD Pipeline](https://miro.medium.com/max/1400/1*F9gQvs4vGM0vRA_e5x8Eww.gif)

## Overview

This repository contains the configuration for a robust CI/CD pipeline utilizing the following technologies:

- **Jenkins**
- **Maven**
- **SonarQube**
- **Docker**
- **Kubernetes (K8s)**
- **Helm**
- **Prometheus**
- **Grafana**

### Pipeline Workflow

1. **Code Modification**
   - A modification in the source code is made.
2. **Webhook Trigger**
   - This triggers a webhook that activates the Jenkins pipeline.
3. **Build and Test**
   - The code is built and tested using Maven.
4. **Code Analysis**
   - The code is analyzed by SonarQube. If it passes the quality gate, a Docker image is created.
5. **Deployment**
   - Helm updates the version of the image and the Kubernetes manifest file to deploy the new version.
6. **Monitoring**
   - Prometheus and Grafana are installed using Helm. They run in K8s pods and monitor the cluster.

## Tools and Technologies

### Jenkins
![Jenkins Logo](https://www.jenkins.io/images/logos/jenkins/jenkins.svg)

Jenkins is an open-source automation server that orchestrates the CI/CD pipeline.

### Maven
![Maven Logo](https://maven.apache.org/images/maven-logo-black-on-white.png)

Maven is a build automation tool used for Java projects. It handles project building, dependency management, and more.

### SonarQube
![SonarQube Logo](https://www.sonarqube.org/logos/index/sonarqube-logo.png)

SonarQube is a code quality tool that performs static code analysis to detect bugs, vulnerabilities, and code smells.

### Docker
![Docker Logo](https://www.docker.com/sites/default/files/d8/2019-07/vertical-logo-monochromatic.png)

Docker is a platform that enables developers to automate the deployment of applications inside lightweight, portable containers.

### Kubernetes
![Kubernetes Logo](https://kubernetes.io/images/kubernetes-horizontal-color.png)

Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications.

### Helm
![Helm Logo](https://helm.sh/img/helm.svg)

Helm is a package manager for Kubernetes, simplifying the deployment and management of applications within K8s.

### Prometheus
![Prometheus Logo](https://prometheus.io/assets/prometheus_logo_grey.svg)

Prometheus is an open-source systems monitoring and alerting toolkit, designed for reliability and scalability.

### Grafana
![Grafana Logo](https://grafana.com/static/img/press/grafana_logo_transparent_400x192.png)

Grafana is an open-source platform for monitoring and observability, providing rich visualizations for time-series data.

## Pipeline Details

### 1. Code Modification
When a developer pushes code changes to the repository, it triggers the pipeline via a webhook.

### 2. Jenkins Pipeline Activation
![Jenkins Pipeline](https://www.jenkins.io/images/pipeline/pipeline_flow.png)
The webhook triggers Jenkins to start the pipeline.

### 3. Maven Build and Test
Jenkins executes the Maven build lifecycle to compile the code, run tests, and package the application.

### 4. SonarQube Analysis
The code is analyzed by SonarQube for code quality. If it passes the quality gate, the pipeline proceeds to the next step.

### 5. Docker Image Creation
![Docker Build](https://www.docker.com/sites/default/files/d8/styles/large/s3/2018-11/whale-in-container.jpg)
A Docker image is built and tagged with the new application version.

### 6. Helm Deployment
Helm updates the version of the Docker image and the Kubernetes manifest file. Kubernetes then deploys the new version of the application.

### 7. Monitoring with Prometheus and Grafana
Prometheus and Grafana are deployed as Helm charts in K8s. They monitor the cluster, providing real-time metrics and visualizations.

## Installation and Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-repo/ci-cd-pipeline.git
   cd ci-cd-pipeline

