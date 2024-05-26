
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

3. Add Jenkins master and slave as hosts 
Add jenkins master and slave private IPs in the inventory file 
in this case, we are using /opt as our working directory for Ansible. 
File name hosts
   ```sh
   sudo su
   cd /opt
   touch hosts
   vim /opt/hosts
   ```

 Paste the following and change the private ip's before saving
   ```
   [Jenkins_Master]
   10.0.1.176
   [Jenkins_Master:vars]
   ansible_user=ubuntu
   ansible_ssh_private_key_file=/opt/Devops_Project_Key_1.pem
   [Jenkins_Slave]
   10.0.1.190
   [Jenkins_Slave:vars]
   ansible_user=ubuntu
   ansible_ssh_private_key_file=/opt/Devops_Project_Key_1.pem
   ```

4. Test the connection  
   ```sh
   ansible -i hosts all -m ping 
   ```
