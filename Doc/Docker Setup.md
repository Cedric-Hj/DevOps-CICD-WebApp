# Install Docker
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
