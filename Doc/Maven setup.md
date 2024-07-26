# Maven Setup
### Update the package index:
```sh
sudo apt update
```

### Install Dependencies

```sh
sudo apt install fontconfig openjdk-11-jre -y
```

## Step 3: Download Maven
### Define variables:

```sh
MAVEN_VERSION=3.9.7
MAVEN_HOME=/opt/apache-maven-$MAVEN_VERSION
MAVEN_BINARY_URL=https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
```

### Download the Maven binary:

```sh
wget $MAVEN_BINARY_URL -O /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz
```

## Step 4: Extract Maven
### Extract the downloaded Maven archive:
```sh
sudo tar -xzf /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz -C /opt
```

## Step 5: Set Up Environment Variables
### Create a symbolic link (optional but recommended for easier updates):

```sh
sudo ln -s $MAVEN_HOME /opt/maven
```

### Set up environment variables for Maven:

```sh
echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" | sudo tee -a /etc/profile.d/maven.sh
echo "export M2_HOME=/opt/maven" | sudo tee -a /etc/profile.d/maven.sh
echo "export MAVEN_HOME=/opt/maven" | sudo tee -a /etc/profile.d/maven.sh
echo "export PATH=\$M2_HOME/bin:\$PATH" | sudo tee -a /etc/profile.d/maven.sh
```


### Make the script executable and source it:

```sh
sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
```

### Verify Installation

```sh
mvn -version
```
