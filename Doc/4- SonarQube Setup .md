## SonarQube Setup

### Setup an account
https://www.sonarsource.com/products/sonarcloud/

Signup using github and free option

### Generate auth token
- My account -> security -> generate token
- Token name: Ced_Sonarcloud_Token
- token in another folder for security reasons and is not available in the repo

### Instal sonarQube plugging in jenkins
instal the plugging sonarqube scanner

then, Go to credencial and add a secret text credencial with sonarcloud token

### Configure sonarqube server:
Manage jenkins -> System -> sonarqube server
- Add sonarqube server
- Name: sonar-server
- server url: https://sonarcloud.io/
- server auth: secret text credencials

### Configure sonarqube scaner
Manage jenkins -> Global tools -> sonarqube Scanner installations
- add sonarqube scanner
- Sonarqube scanner name: sonar-scanner
- instal automatically

### Create a project in sonarcloud to then create the property file
go to My Account -> Organisation and create an organisation if not already
- Org. Name: Cedric-Hj
- Key: cedric-hj

Go to My project -> analyse new project
- select the github repo -> setup
- select option Previous version -> create project


- Project name is the same as the name of the github repo: DevOps-CICD-WebApp
- Project key name: Cedric-Hj_DevOps-CICD-WebApp

### Create the file sonar-project.properties
In the root directory of the GitHub repo, create the file [sonar-project.properties](/sonar-project.properties) using the neccessary sonarqube credencials

Note: if using cloud services like AWS, to cost as less as possible, Sonarcloud can be used in a browser with a auth token, the AWS security group need to allow all ip to the port 8080 (Jenkins)
It is possible to create an ec2 instance just for sonarqube and in the security group allow the communication between the two, it is more secure, but it also require one more EC2 instance.
