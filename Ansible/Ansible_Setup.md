
# Setup Ansible

## Install Ansibe
Skip to [After the install](#After-the-install) in case provisioning was used
   ```sh 
   sudo apt update
   sudo apt install software-properties-common
   sudo add-apt-repository --yes --update ppa:ansible/ansible
   sudo apt install ansible
   ```

## After the install 
### Add the hosts File 
Create the hosts file 
in this case, we are using /opt as our working directory for Ansible. 
   ```sh
   sudo su
   cd /opt
   touch hosts
```
Copy the content of [Host_VM](main/Ansible/Host_VM)
   vim /opt/hosts
   ```

 Paste the following (one ip at the time, do check and add the other)and change the private ip's before saving
   ```
   [Jenkins]
   10.0.1.169
   [Jenkins:vars]
   ansible_user=ubuntu
   ansible_ssh_private_key_file=/opt/Devops_Project_Key_1.pem
   [Maven]
   10.0.1.123
   [Maven:vars]
   ansible_user=ubuntu
   ansible_ssh_private_key_file=/opt/Devops_Project_Key_1.pem
   ```

4. Test the connection 
   ```sh
   ansible -i hosts all -m ping 
   ```
5. Create the Jenkins master playbook at opt and paste the Jenkins master playbook in it
   ```sh
   touch /opt/jenkins-setup.yaml
   touch /opt/maven-setup.yaml 
   vim /opt/jenkins-setup.yaml
   vim /opt/maven-setup.yaml
   ```

6. Do a dry run of the playbook
   ```sh
   ansible-playbook -i /opt/hosts jenkins-setup.yaml --check 
   ansible-playbook -i /opt/hosts Maven-setup.yaml --check
   ```
   thre will be an error because no package where found to install jenkins, it is normal, since it is a dry run, the package was not downloaded.
   Run the playbook:
      ```sh
   ansible-playbook -i /opt/hosts jenkins-setup.yaml
   ansible-playbook -i /opt/hosts maven-setup.yaml
   ```
