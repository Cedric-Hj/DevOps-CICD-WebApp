
# Setup Ansible
1. Install ansibe on Ubuntu 22.04 
   ```sh 
   sudo apt update
   sudo apt install software-properties-common
   sudo add-apt-repository --yes --update ppa:ansible/ansible
   sudo apt install ansible
   ```

2. Add the key.pm file in personal folders to /opt using Moba extern
Due to limitations, copy to /home/ubuntu and then using the terminal
   ```sh
   mv /home/ubuntu/Devops_Project_Key_1.pem /opt/
   chmod 400 /opt/Devops_Project_Key_1.pem
   ```

3. Add Jenkins as hosts 
Add jenkins master and slave private IPs in the inventory file 
in this case, we are using /opt as our working directory for Ansible. 
File name hosts
   ```sh
   sudo su
   cd /opt
   touch hosts
   vim /opt/hosts
   ```

 Paste the following (one ip at the time, do check and add the other)and change the private ip's before saving
   ```
   [Jenkins]
   10.0.1.198
   [Jenkins:vars]
   ansible_user=ubuntu
   ansible_ssh_private_key_file=/opt/Devops_Project_Key_1.pem
   [Maven]
   10.0.1.198
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