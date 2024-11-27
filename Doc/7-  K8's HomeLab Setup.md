# Step by step guide to setup k8's cluster with Master and Worker nodes on VM'S

Skip to [After install](#After-install) if provisioning was used

### VM'S pre-requesite:
- The VM's must have internet connection and their own IP adress
- 2 vCPU, 4 GB RAM, 20GB Disk for each nodes to run Kubernetes
- NameSpace and static IP
```sh
k8s-control   192.168.0.101
k8-1    192.168.0.102
```
## Do on both k8s-control and k8-1 VM's
### Configuring Hostnames
```sh
printf "\n192.168.0.101 k8s-control\n192.168.0.102 k8s-1\n\n" >> /etc/hosts
```
### Preload Kernel Modules for Containerd with Configuration Commands
```sh
printf "overlay\nbr_netfilter\n" >> /etc/modules-load.d/containerd.conf
```

### Essential Kernel Module and Network Configuration for Kubernetes Setup
```sh
modprobe overlay
modprobe br_netfilter

printf "net.bridge.bridge-nf-call-iptables = 1\nnet.ipv4.ip_forward = 1\nnet.bridge.bridge-nf-call-ip6tables = 1\n" >> /etc/sysctl.d/99-kubernetes-cri.conf

sysctl --system
```

### Install and Configure Containerd for Kubernetes
```sh
wget https://github.com/containerd/containerd/releases/download/v1.7.13/containerd-1.7.13-linux-amd64.tar.gz -P /tmp/
tar Cxzvf /usr/local /tmp/containerd-1.7.13-linux-amd64.tar.gz
wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -P /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now containerd
```

### Install and Set Up runc
```sh
wget https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.amd64 -P /tmp/
install -m 755 /tmp/runc.amd64 /usr/local/sbin/runc
```

### Install CNI Plugins for Kubernetes Networking
```sh
wget https://github.com/containernetworking/plugins/releases/download/v1.4.0/cni-plugins-linux-amd64-v1.4.0.tgz -P /tmp/
mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin /tmp/cni-plugins-linux-amd64-v1.4.0.tgz
```

### Configure Containerd for Kubernetes: Systemd Cgroup Setup
```sh
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml  #manually edit and change SystemdCgroup to true (not systemd_cgroup)
vi /etc/containerd/config.toml
systemctl restart containerd
```

### Install HTTPS and Certificates
```sh
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gpg
```

### Add Kubernetes APT Repository and Keyring Setup
```sh
mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

### Update Package Repositories for System Maintenance and Reboot
```sh
apt-get update

reboot
```
Now is a good time to take a snapshot of the VM in case anything goes wrong after

### Turn Off Swap 
```sh
swapoff -a
```

### Install and Version Lock of Kubernetes Tools
For the worker node, do not instal kubectl=1.29.1-1.1

```sh
apt-get install -y kubelet=1.29.1-1.1 kubeadm=1.29.1-1.1 kubectl=1.29.1-1.1
apt-mark hold kubelet kubeadm kubectl
```


### After install
## ONLY ON CONTROL NODE
The pod network default adress is 192.138.0.0/16 which will overlap with a personal home network and will create routing issue.
to avoid this problem, use another IP, in this case it will be used: 10.96.0.0/16
make sure --node-name is the same name as the one defined in VM'S pre-requesite

### control plane install:
```sh
kubeadm init --pod-network-cidr 10.96.0.0/16 --kubernetes-version 1.29.1 --node-name k8s-control --apiserver-advertise-address 192.168.0.101
```
save the kubeadm join command at the end or use the following command to join a worker node:
```sh
kubeadm token create --print-join-command
```

after do as told on the console:
```sh
export KUBECONFIG=/etc/kubernetes/admin.conf 
```


### Add Calico 3.27.2 CNI: 
```sh
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/tigera-operator.yaml
wget https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/custom-resources.yaml
```
Since a custom IP is used, it is neccessary to edit the filecustom-resources.yaml and change the CIDR to 10.96.0.0/16
```sh
sed -i 's/192\.168\.0\.0\/16/10.96.0.0\/16/g' custom-resources.yaml
```

Apply the changes:
```sh
kubectl apply -f custom-resources.yaml
```

Wait a momment for all pods to be setup and running.
Use the following command to check the pods live:
```sh
watch kubectl get pods -A
```

When everything is running, the status of the control-plane should be Ready:
```sh
kubectl get nodes
```

If everything is running smoothly, take a snapshot of the master node VM while k8's are running. You can turn off the master's VM and turn it on again with the k8's still running by reloading from that snapshot.

For worker node to join the cluster, either save the kubeadm join command or use the following command later on:
```sh
kubeadm token create --print-join-command
```

## ON Worker NODE
Take a snapshot of the worker node VM before joining it to the cluster. You can shut down the node and restore the VM to the snapshot to rejoin it. You can also clone the VM from the snapshot to create another worker node.

Run the command from the output of kubeadm init or from the token created above, it will lokk something like that:
```sh
kubeadm join 192.168.0.101:6443 --token 9n0kiz.9lj3b60r3rbs27j1 --discovery-token-ca-cert-hash sha256:33da70046c2b6972731c6d33dc83036f3f8a50dfa51137743a4cf8f816ad899e 
```


### After worker node has join the cluster

Use get node and get pods command above to see the pods loading until the worker node status is Ready

When ready, Change the role of the node to worker:

```sh
kubectl label node k8s-1 node-role.kubernetes.io/worker=worker
```

## Setup Jenkins access to Kubernetes cluster 
In the control node copy the content of the file /etc/kubernetes/admin.conf
```sh
cat /etc/kubernetes/admin.conf
```
In the jenkins machine, create the directory and file needed:
```sh
mkdir /var/lib/jenkins/.kube
cd /var/lib/jenkins/.kube
touch kubeconfig
vim kubeconfig #paste the content in this file
```
make sure jenkins has the proper authorisation:
```sh
 sudo chown jenkins:jenkins /var/lib/jenkins/.kube/kubeconfig
 sudo chmod 600 /var/lib/jenkins/.kube/kubeconfig
```
then to let the machine have access to the cluster:
```sh
export KUBECONFIG=/var/lib/jenkins/.kube/kubeconfig
```
The jenkins machine can now use kubectl commands, check with:
```sh
kubectl get nodes
kubectl get pods -A
```
### After restoring VM's snapshot
Usually, the cluster is unstable after restoring a snaphot or after suspending the vm's. 
After restoring the vm's, do the following in the k8s-control (kubernetes control node) and execute each command one by one: 
```sh
export KUBECONFIG=/etc/kubernetes/admin.conf 

kubectl delete pods --all --all-namespaces
```
ctrl+C to exit and the:

```sh

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/calico.yaml

wget https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/custom-resources.yaml

sed -i 's/192\.168\.0\.0\/16/10.96.0.0\/16/g' custom-resources.yaml

kubectl apply -f custom-resources.yaml

watch kubectl get pods -A

```
Doc: 
https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart
