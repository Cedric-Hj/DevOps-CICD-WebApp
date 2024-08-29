<p><a target="_blank" href="https://app.eraser.io/workspace/thllnGtosn8VVMRPxttC" id="edit-in-eraser-github-link"><img alt="Edit in Eraser" src="https://firebasestorage.googleapis.com/v0/b/second-petal-295822.appspot.com/o/images%2Fgithub%2FOpen%20in%20Eraser.svg?alt=media&amp;token=968381c8-a7e7-472a-8ed6-4a6626da5501"></a></p>

# Overview
This repository contains a DevOps project that is designed to manage the deployment lifecycle of an application through a robust CI/CD pipeline. The pipeline ensures continuous integration and deployment across multiple environments -Development, Testing, and Production- leveraging tools such as Vagrant, Ansible, Jenkins, Maven, SonarQube, Docker, Helm, and Kubernetes, Prometheus, and Grafana.

The infrastructure was deliberately designed to enhance learning while efficiently managing resource constraints. By provisioning and utilizing three virtual machines, the project effectively demonstrates Infrastructure as Code (IaC) principles. This setup not only adheres to local resource limitations but also provides a robust platform for exploring CI/CD practices, deployment strategies, and monitoring. It strikes a balance between practical, hands-on experience and efficient use of a constrained development environment.

All setup instructions and documentation for comprehensive guidance on configuring and deploying the project are available in the doc folder.

## Technology Stack Overview
<table>
  <tr>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Ansible.svg" width="40" height="40" alt="Ansible"/><br>
      Ansible
    </td>    
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Jenkins.svg" width="40" height="40" alt="Jenkins"/><br>
      Jenkins
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Apache-Maven.svg" width="40" height="40" alt="Apache Maven"/><br>
      Apache Maven
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/SonarQube.svg" width="40" height="40" alt="SonarQube"/><br>
      SonarQube
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Docker.svg" width="40" height="40" alt="Docker"/><br>
      Docker
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Kubernetes.svg" width="40" height="40" alt="Kubernetes"/><br>
      Kubernetes
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Helm.svg" width="40" height="40" alt="Helm"/><br>
      Helm
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Grafana.svg" width="40" height="40" alt="Grafana"/><br>
      Grafana
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Prometheus.svg" width="40" height="40" alt="Prometheus"/><br>
      Prometheus
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Git.svg" width="40" height="40" alt="Git"/><br>
      Git
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Python.svg" width="40" height="40" alt="Python"/><br>
      Python
    </td>
    <td align="center">
      <img src="https://icon.icepanel.io/Technology/svg/Bash.svg" width="40" height="40" alt="Bash"/><br>
      Bash
    </td>   
    <td align="center">
      <img src="https://static-00.iconduck.com/assets.00/vagrant-icon-1981x2048-m89lsyi5.png" width="40" height="40" alt="Vagrant"/><br>
      Vagrant
    </td>    
  </tr>
</table>


## Pipeline Diagram
![diagram-export-8-29-2024-10_25_04-AM.png](/.eraser/thllnGtosn8VVMRPxttC___3en0Fu49T2aSwTqzDKvcWrfcO6C2___pSncCFug52WX1G1jWLjRL.png "diagram-export-8-29-2024-10_25_04-AM.png")



## Branches
- dev: The primary branch for ongoing development. Changes pushed to this branch will trigger a Jenkins job for initial deployment and testing.
- test: The branch where code is merged after successful deployment in the dev environment. It undergoes additional testing before being promoted to prod.
- main (prod): The branch for stable, production-ready code. Merges into this branch trigger the final deployment to the production environment.
## Infrastructure and Setup
### Virtual Machines:
Three VMs were provisioned to optimize resource usage:

- Jenkins VM: Hosts all services needed beside Kubernetes.
- Kubernetes Control Node (k8s-control): Manages the Kubernetes cluster.
- Kubernetes Worker Node (k8s-1): Executes application workloads within the cluster.
### Provisioning and Configuration:
- Vagrant was used for VM provisioning, ensuring consistent and automated setup of the virtual machines.
- Ansible was employed to configure the control and worker nodes. This automation tool installed and set up all necessary components for a fully functional Kubernetes cluster, adhering to IaC principles.
## CI/CD Pipeline
### Development Workflow
 Jenkins Job:

- Clean Deploy: The application is built using Maven.
- Code Analysis: SonarQube performs code analysis and enforces quality gates.
- Docker Build: An application image is created and pushed to the Docker repository.
- Kubernetes Deployment: The application is deployed to the Development pod in the Kubernetes cluster using Helm.
- Merge to Test: Upon successful deployment and testing in the Development environment, code is automatically merged into the test branch.
### Testing Workflow
Jenkins Job:

- Clean Deploy: The application is rebuilt using Maven.
- Docker Build: The updated image is created and pushed to the Docker repository.
- Kubernetes Deployment: The application is deployed to the Testing pod.
- Testing: A suite of tests is executed to ensure the application functions correctly.
- Multi-Version Testing: A parametrized Jenkins job allows for deploying multiple versions of the application to different pods in the Testing environment. This enables simultaneous testing of different versions.
- Merge to Prod: If tests are successful, code is automatically merged into the prod branch.
### Production Workflow
Jenkins Job:

- Clean Deploy: The application is rebuilt using Maven.
- Code Analysis: SonarQube performs code analysis and enforces quality gates.
- Docker Build: An updated application image is created and pushed to the Docker repository.
- Kubernetes Deployment: The application is deployed to the Production pod in the Kubernetes cluster using Helm.
- End User Access: The application becomes available to end users.
## Rollback Functionality
A parametrized Jenkins job is available to roll back the application to a previous version for each environment. This job retrieves the desired Docker image of a previous version and redeploys it onto the appropriate pod.

### Importance
- Minimizes Downtime: Quickly reverts to a stable version if issues arise.
- Risk Management: Provides a safety net for new deployments.
- User Experience: Ensures minimal disruption and consistent performance.
## Monitoring
Effective monitoring is essential for maintaining the health and performance of an application and infrastructure. Prometheus and Grafana are used for this purpose.

- Prometheus: Collects and stores metrics from the Kubernetes cluster, allowing to track application performance, resource usage, and system health over time.
- Grafana: Integrates with Prometheus to provide customizable dashboards and visualizations. This helps monitor real-time data, identify anomalies, and make informed decisions.
### Importance of Monitoring
- Performance Tracking: Ensures the application performs optimally and scales appropriately.
- Early Detection: Identifies issues before they impact users, allowing for proactive resolution.
- Resource Optimization: Helps in efficient utilization and allocation of resources.
- Incident Response: Provides detailed metrics for rapid diagnosis and resolution of issues.
- Capacity Planning: Supports forecasting and scaling based on historical data.
- Monitoring with Prometheus and Grafana is crucial for maintaining a reliable and high-performing system.




