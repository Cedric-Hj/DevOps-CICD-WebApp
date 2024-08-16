# Install Docker

## Install optional if not using VagrantFile for provisioning
Skip to [Integrate Docker with Jenkins](#Integrate-Docker-with-Jenkins) if provisioning was used

### Update Package Information

```sh
sudo apt update
```
### Install Necessary Packages

```sh
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

### Add Docker’s Official GPG Key

```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

### Set Up the Stable Repository

```sh
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### Install Docker Engine

```sh
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
```

### Verify Docker Installation

```sh
sudo docker --version
```

### Configure Docker to Run Without sudo
Add Your User to the Docker Group

```sh
sudo usermod -aG docker ${USER}
```

### Apply the New Group Membership

```sh
su - ${USER}
```

### Verify Docker Without sudo
```sh
docker run hello-world
```

## Integrate Docker with Jenkins

### Install Docker Plugins in Jenkins

Open Jenkins in your browser.

Go to Manage Jenkins > Manage Plugins.

Search for the "Docker" and "Docker Pipeline" plugins and install them.

### Configure Jenkins user to access Docker
On the terminal, as root user, insert the command:
```sh
usermod -aG docker jenkins
```
This will allow jenkins to use docker commands
Restart jenkins to make the modification active:
```sh
sudo systemctl restart jenkins
```

