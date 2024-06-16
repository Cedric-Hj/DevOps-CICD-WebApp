Note: to cost as less as possible, Sonarcloud is going to be used in the browser with a auth token, the AWS security group need to allow all ip to the port 8080 (Jenkins)
It is possible to create an ec2 instance just for sonarqube and in the security group allow the communication between the two, it would be more secure, but it also require one more EC2 instance. To avoid cost since it is a self learning project, it was chosen to go this way.

1 - Setup an account
    https://www.sonarsource.com/products/sonarcloud/

    Signup using github and free option

2 - Generate auth token
My account -> security -> generate token
Token name: Ced_Sonarcloud_Token
token in another folder for security reasons and is not available in the repo

3 - Instal sonarQube plugging in jenkins -> sonarqube scanner

4 - Go to credencial and add a secret text credencial with sonarcloud token

5 - configure sonarqube server:
Manage jenkins -> Configure system -> sonarqube server
Add sonarqube server
Name: sonar-server
server url: https://sonarcloud.io/
server auth: secret text credencials

6 - Configure sonarqube scaner
Manage jenkins -> Global tools -> sonarqube Scanner installations
add sonarqube scanner
Sonarqube scanner name: sonar-scanner
instal automatically

7 - Create a project in sonarcloud to then create the property file
    go to My Account -> Organisation and create an organisation if not already
    Org. Name: Cedric-Hj
    Key: cedric-hj

My project -> analyse new project
select the github repo -> setup
select option Previous version -> create project

Project name: DevOps-FullStack-CICD
Project key name: Cedric-Hj_DevOps-FullStack-CICD