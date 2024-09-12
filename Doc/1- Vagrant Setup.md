# Vagrant Setup for Jenkins and Kubernetes VMs

This guide explain how to set up three Ubuntu VMs using Vagrant and VirtualBox. The Vagrantfile provided will also configure the Jenkins VM with Jenkins, Maven, Docker, kubectl, Helm, and Ansible installed.

The K8's VM will be provisioned later with Ansible

## Step 1: Install Prerequisites

1. **Install VirtualBox**:
   - **Windows/Mac**: Download and install from the [VirtualBox website](https://www.virtualbox.org/wiki/Downloads).
   - **Linux**: Use the package manager, e.g., `sudo apt install virtualbox` for Debian-based systems.

2. **Install Vagrant**:
   - Download and install from the [Vagrant website](https://www.vagrantup.com/downloads).

3. **Install Git (if not already installed)**:
   - **Windows/Mac**: Download and install from the [Git website](https://git-scm.com/downloads).
   - **Linux**: Use your package manager, e.g., `sudo apt install git` for Debian-based systems.

## Step 2: Set Up the Project Directory

1. **Create a New Directory**:
   - Open a terminal or command prompt.
   - Create a directory for your Vagrant project and navigate into it:
     ```bash
     mkdir vagrant-setup
     cd vagrant-setup
     ```

2. **Create the Vagrantfile**:
   - Create a file named `Vagrantfile` in this directory.
   ```bash
     touch Vagrantfile
     ```
   - Copy and paste the content of the [Vagrantfile](https://github.com/Cedric-Hj/DevOps-CICD-WebApp/blob/main/Vagrant/VagrantFile) into this file and save it.

## Step 3: Initialize Vagrant

1. **Initialize Vagrant**:
   - This command will set up the initial Vagrant environment in your directory:
     ```bash
     vagrant init
     ```
   - Note: If you already have a `Vagrantfile` in your directory (which you just created), you can skip this step.

## Step 4: Configure the Vagrantfile

1. **Edit Vagrantfile**:
   - Ensure the Vagrantfile content is correct as per the Vagrantfile provided above.

## Step 5: Start and Provision the VMs

1. **Run Vagrant**:
   - Execute the following command to start and provision all VMs as defined in the Vagrantfile:
     ```bash
     vagrant up
     ```
   - This command will:
     - Download the specified Ubuntu box if not already present.
     - Create the virtual machines using VirtualBox.
     - Apply the provisioning script to install Jenkins, Maven, Docker, kubectl, Helm, and Ansible on the Jenkins VM.

2. **Monitor the Output**:
   - Watch the terminal for output messages. It will show the progress of VM creation and provisioning. If everything is set up correctly, you should see messages indicating that the VMs are being created and configured.

## Step 6: Access Your VMs

1. **SSH Access**:
   - To access the Jenkins VM, use:
     ```bash
     vagrant ssh jenkins
     ```
   - Replace `jenkins` with `k8s-control` or `k8s-1` to access the other VMs.

2. **Check Installed Software**:
   - Once logged into the Jenkins VM, you can verify the installation of Jenkins, Maven, Docker, kubectl, Helm, and Ansible using the following commands:
     ```bash
     java -version
     mvn -version
     docker --version
     kubectl version --client
     helm version
     ansible --version
     ```

## Step 7: Manage and Destroy VMs

1. **Suspend or Halt VMs**:
   - To suspend the VMs (save their state):
     ```bash
     vagrant suspend
     ```
   - To halt the VMs (shutdown them):
     ```bash
     vagrant halt
     ```

2. **Destroy VMs**:
   - To destroy all VMs and delete their disk files:
     ```bash
     vagrant destroy
     ```
3. Save delete and restore snapshots
   - To save a snapshot of the entire infrastructure
   ```bash
   vagrant snapshot save <snapshot_name>
    ```
   - To restore a snapshot of the entire infrastructure
   ```bash
   vagrant restore  <snapshot_name>
    ```
   - To delete a snapshot of the entire infrastructure
   ```bash
   vagrant delete  <snapshot_name>
    ```


