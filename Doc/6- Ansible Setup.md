

# Setup Ansible
Skip to [After the install](#After-the-install) in case provisioning was used
## Install Ansibe

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
Copy the content of [Host_VM](/Ansible/Host_VM) into the hosts file
  ```sh
   vim /opt/hosts
   ```

### Test the connection 
Do the first ssh connection to the machines before hand
   ```sh
   ansible -i hosts all -m ping 
   ```

### Create the Ansible Playbooks
Create a playbook for K8 control and worker nodes at opt and paste the content of 
 [K8_control_Setup.yaml](/Ansible/k8s_control_Setup.yaml) and [K8_worker_Setup.yaml](/Ansible/K8_worker_Setup.yaml) in it
   ```sh
  touch /opt/k8s_control_Setup.yaml
  touch /opt/k8_worker_Setup.yaml
   vim /opt/k8s_control_Setup.yaml
   vim /opt/k8_worker_Setup.yaml
   ```

### Do a dry run of the playbook
this is just a check to see if the playbook start installing, there will be an error
   ```sh
   ansible-playbook -i /opt/hosts k8s_control_Setup.yaml --check 
   ansible-playbook -i /opt/hosts k8_worker_Setup.yaml --check
   ```

### Run the playbook:
  ```sh
   ansible-playbook -i /opt/hosts k8s_control_Setup.yaml
   ansible-playbook -i /opt/hosts k8_worker_Setup.yaml
  ```
