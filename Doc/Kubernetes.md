Once you have your servers, first access the Master node and update all packages:
```sh
sudo apt-get update && sudo apt-get upgrade
```
We must disable swap in order for the kubelet to work properly.

# Disable swap 
```sh 
swapoff -a
```
# To verify
```sh
 sudo cat /etc/fstab
```
 
Configuring a Container runtime
To run containers in Pods, Kubernetes uses a container runtime.

By default, Kubernetes uses the Container Runtime Interface (CRI) to interface with container runtime.

We will use containerd, so we need to install it on each cluster node.

First, configure prerequisites forwarding IPv4 and letting iptables see bridged traffic:
```sh
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
```
# sysctl params required by setup, params persist across reboots
```sh
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
```
# Apply sysctl params without reboot
```sh
sudo sysctl --system
```
The containerd.io packages in DEB and RPM formats are distributed by Docker, set up the repository:

Install packages to allow apt to use a repository over HTTPS:
```sh
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```
2. Add Docker’s official GPG key:
```sh
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```
3. Use the following command to set up the repository:
```sh
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
4. Update the apt package index and install the containerd.io:
```sh
sudo apt-get update

sudo apt-get install containerd.io
```
5. Download the cni-plugins-linux-amd64-v1.1.1.tgz archive from https://github.com/containernetworking/plugins/releases , verify its sha256sum, and extract it under /opt/cni/bin:
```sh
mkdir -p /opt/cni/bin
  
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
  
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
```
6. Configuring the systemd cgroup driver:
```sh
vim /etc/containerd/config.toml
```
# Enable the cni plugin by commenting out the line below
```sh
   #disabled_plugins = ["cri"]
```
# To use the systemd cgroup driver in /etc/containerd/config.toml with runc, set:
```sh
   [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
   [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
   SystemdCgroup = true
```
7. Restart containerd service:
```sh
sudo systemctl restart contained
```
```sh
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```
```sh
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

Dont install kubectl on worler nodes
```sh
sudo apt update
sudo apt-get install -y kubelet=1.28.4-1.1 kubeadm=1.28.4-1.1 kubectl=1.28.4-1.1
sudo apt-mark hold kubelet kubeadm kubectl
```

IF ON WORKER NODES>
```sh
kubeadm join 192.168.0.29:6443 --token d9oxnf.s3kfj4tbudvz8dcs \
	--discovery-token-ca-cert-hash sha256:ea40c1fde7bd9a5e3ba9dd5105186185507de7c6a01ecde6bed18670e8254bd2
  


```

If master node>
```sh
kubeadm init

sudo kubeadm init --control-plane-endpoint cka-cluster:6443 --pod-network-cidr 10.1.0.0/22
```

7. Alternatively, if you are the root user, you can run:
```sh
export KUBECONFIG=/etc/kubernetes/admin.conf
```

We will install the Addon Weave Net 2.8.1, running the command:
```sh
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
```

```sh
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml
```
```sh
wget https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/custom-resources.yaml
```


8. You can test kubectl with a simple command:
```sh
# Running to get information about the attached nodes in the cluster
kubectl get nodes
```


To see all namespaces in your cluster, run the command:
```sh
kubectl get namespaces
```


