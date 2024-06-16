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

9 Configure GitHub <-> Jenkins conection

    Generate an SSH Key on the Jenkins Machine:
First, you'll need to generate an SSH key on your Jenkins machine.

sh

ssh-keygen -t ed25519 -C "your_email@example.com"

Save the key in the default location (usually ~/.ssh/id_ed25519 or ~/.ssh/id_rsa).

Copy the Public Key to the Clipboard:

sh

cat ~/.ssh/id_ed25519.pub  # or ~/.ssh/id_rsa.pub if using RSA
Add the SSH Key to Your GitHub Account:

Go to GitHub and log in to your account.
In the upper-right corner of any page, click your profile photo, then click Settings.
In the user settings sidebar, click SSH and GPG keys.
Click New SSH key or Add SSH key.
In the "Title" field, add a descriptive label for the new key. For example, "Jenkins Server".
Paste the public key into the "Key" field.
Click Add SSH key.
If prompted, confirm your GitHub password.
Configure SSH Key in Jenkins:

Ensure that the SSH key has the correct permissions. The private key should be readable only by the user running Jenkins.
sh

chmod 600 ~/.ssh/id_ed25519
Make sure the Jenkins server can connect to GitHub. You can test this by logging into the Jenkins server and running:
sh

ssh -T git@github.com
Ensure that your Jenkins instance is configured correctly with the right plugins and permissions.

Go to your Jenkins dashboard.
Click on Manage Jenkins in the sidebar.
Click on Manage Credentials (or Manage Jenkins -> Credentials if you don't see it directly).
Select the appropriate domain (e.g., global).
Click Add Credentials on the left sidebar.
Select SSH Username with private key from the kind dropdown.
In the Username field, enter a username (typically git for GitHub).
Under Private Key, select Enter directly and paste the contents of your private key (~/.ssh/id_ed25519 or ~/.ssh/id_rsa).
Optionally, provide an ID and a description.
Click OK.

Make sure to change the settings in  'Manage Jenkins' -> 'Security' -> 'Git Host Key Verification Configuration' and configure host key verification to -> Accept first connection.


Create/Configure Your Jenkins Job:

Create a new Multibranch pipeline 

Instal the pluggin: Multibranch Scan Webhook Trigger

Add webhook, token name: Ced_Token

Webhook: http://52.90.143.81:8080/multibranch-webhook-trigger/invoke?token=Ced_Token





