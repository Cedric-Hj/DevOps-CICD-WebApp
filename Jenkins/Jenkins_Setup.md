1 - After the instalation, change in the security group the inbound rule to admit "MyIP"

2 - in the browser, user the public IP + :8080 (default jenkins port)

3 - get the security code located in the jenkins instance:

sh'''
cat /var/lib/jenkins/secrets/initialAdminPassword
'''

4 - insert user and pass value

5 - Install default pluggins

6 - skip the jenkins default url step

7 - Add credencials:
    Dashboard - Manage jenkins - Credentials - System - Global credencial - Add credencial
        Kind: ssh username with private key
        ID: maven-server-cred
        Description: maven server credentials
        username: ubuntu
        Private key -> add -> Copy the ENTIRE content of the .pem file and paste it
        Create

8 - Setup the slave which is the maven machine
    Dashboard - Manage Jenkins - Nodes - New Node
        Node name: maven-slave
        Permanent Agent
        Create
    
    Configure the slave
        Number of executors: 3
        Remote root directory: /home/ubuntu/jenkins
        Labels: maven
        Usage: Use this node as much as possible
        Launch method: Launch agents via SSH
        Host: <Private_IP_of_Slave>
        Credentials: <Jenkins_Slave_Credentials>
        Host Key Verification Strategy: Non verifying Verification Strategy
        Availability: Keep this agent online as much as possible

