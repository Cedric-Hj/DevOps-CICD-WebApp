# Jenkins Setup
Skip to [After the install](#After-the-install) in case provisioning was used

### Install Java
Java is needed for Jenkins to work. Make sure the java version is compatible with the newer jenkins version

```  sh
sudo apt update
sudo apt install openjdk-21-jdk -y
```

### Install Jenkins
```  sh
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
```

### Start Jenkins Service
``` sh
sudo systemctl start jenkins
sudo systemctl enable jenkins
```
### Configure Firewall (if applicable)
```  sh
sudo ufw allow 8080
sudo ufw status
```

## After the install
### Inbound rule for Jenkins
By default, jenkins will run on the port 8080. In this case we will change the port to :8081, configure the router (or security group) to allow traffic to access the machine ip and port 8081 (inbound rules)
to change IP
```  sh
edit jenkins --full
```

### Jenkins setup Wizard
in the browser, go the <IP_Address:8081> to start the jenkins setup wizard

- Get the security code located in the Jenkins instance:

```  sh
cat /var/lib/jenkins/secrets/initialAdminPassword
```
- Insert the security code into the Jenkins setup wizard.

- Insert the user and password values to create your admin account.

- Install the default plugins recommended by Jenkins.
- Jenkins Default URL Step set to <IP_Address:8081>

## Configure GitHub <-> Jenkins Connection
For better security, the connection will be made using ssh.

### Generate an SSH Key on the Jenkins Machine:

```  sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```
Save the key in the default location (usually ~/.ssh/id_ed25519 or ~/.ssh/id_rsa).

Copy the Public Key to the Clipboard:

```  sh
cat ~/.ssh/id_ed25519.pub  # or ~/.ssh/id_rsa.pub if using RSA
```

### Add the SSH Key to GitHub Account:

Go to GitHub and log in ther account.
- In the upper-right corner, click your profile photo, then click Settings.
- In the user settings sidebar, click SSH and GPG keys.
- Click New SSH key or Add SSH key.
- In the "Title" field, add a descriptive label for the new key (e.g., "Jenkins Server").
- Paste the public key into the "Key" field.
- Click Add SSH key.
- If prompted, confirm your GitHub password.

## Configure SSH Key in Jenkins:
Ensure that the SSH key has the correct permissions:

```sh
chmod 600 ~/.ssh/id_ed25519
```

### Test the connection from Jenkins server to GitHub:

```sh
ssh -T git@github.com
```

### Add the SSH Key in Jenkins Credentials:
Go to: Dashboard -> Manage Jenkins -> Credentials -> System -> Global credentials -> Add credentials

Configure as follows:
- Kind: SSH Username with private key
- Username: git (for GitHub)
- Private Key: Enter directly and paste the contents of the jenkins machine private key (~/.ssh/id_ed25519 or ~/.ssh/id_rsa)
- Optionally, provide an ID and a description

Click OK

###  Update Git Host Key Verification Configuration:
Go to: Manage Jenkins -> Security -> Git Host Key Verification Configuration

Configure host key verification to Accept first connection.

### Create/Configure Jenkins Job
- Create a new Multibranch Pipeline
- Install the plugin: Multibranch Scan Webhook Trigger
- Add webhook with a token name: <NameOfTheToken>

In Git:
- Webhook URL: http://<IP_Address:8080>/multibranch-webhook-trigger/invoke?token=<NameOfTheToken>

Note: Disable the webhook while developing the entire CI/CD pipeline to avoid excessive data transfer if using another setup like AWS.

## Set jenkins as a Sudoer:
```sh
sudo visudo
jenkins ALL=(ALL) NOPASSWD: ALL
```

# Setup a slave (optional)
For this solution, the jenkins VM only need to have jenkins intalled in it, the slave will have all other software needed
The slave must have installed in it:
- Maven
- Docker
- kubectl
- Helm
Follow the step above to create an ssh key in another machine that will be the jenkins slave.

in the slave machine, paste the content of the Jenkins machine ssh public key into the known hosts and vice versa

test the connection
```  sh
ssh root@<Salve_IP>
```

### Add Credentials
Go to: Dashboard -> Manage Jenkins -> Credentials -> System -> Global Credentials -> Add Credentials
Configure as follows:
- Kind: SSH Username with private key
- ID: maven-server-cred
- Description: maven server credentials
- Username: root
- Private Key: Enter directly and paste the contents of of the jenkins machine private key (~/.ssh/id_ed25519 or ~/.ssh/id_rsa)

Click Create

### to Setup a Slave >Maven Machine (Optional)

Go to: Dashboard -> Manage Jenkins -> Nodes -> New Node
 
Configure the Node: 
- Node name: maven-slave
- Type: Permanent Agent

Click Create

Configure the slave:
- Number of executors: 3
- Remote root directory: /home/ubuntu/jenkins
- Labels: maven
- Usage: Use this node as much as possible
- Launch method: Launch agents via SSH
- Host: <Private_IP_of_Slave>
- Credentials: <Jenkins_Slave_Credentials>
- Host Key Verification Strategy: Non verifying Verification Strategy
- Availability: Keep this agent online as much as possible

Apply and save
