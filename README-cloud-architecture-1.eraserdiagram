cloud-architecture-diagram

direction down

CLOUD PROVIDER API [icon: cloud]
{
  CONTROL PLANE {
    cloud-control-manager [icon: k8s-c-c-m]
    etcd [icon: k8s-etcd]
    kube-api-server [icon: k8s-api]
    scheduler [icon: k8s-sched]
    Controller Manager [icon: k8s-c-m]
  }
  Node 1 {
    kubelet1 [icon: k8s-kubelet, label: "kubelet"]
    kube-proxy1 [icon: k8s-k-proxy, label: "kube-proxy"]
    CRI1 [label: "CRI"] {
      pod1 [icon: k8s-pod, label: "pod"]
      pod2 [icon: k8s-pod, label: "pod"]
      pod3 [icon: k8s-pod, label: "pod"]
    }
  }
  Node 2 {
    kubelet2 [icon: k8s-kubelet, label: "kubelet"]
    kube-proxy2 [icon: k8s-k-proxy, label: "kube-proxy"]
    CRI2 [icon: k8s-pod, label: "CRI"] {
      pod4 [icon: k8s-pod, label: "pod"]
    }
  }
}

kube-api-server <> cloud-control-manager
etcd > kube-api-server
scheduler > kube-api-server
Controller Manager > kube-api-server
kubelet1 > kube-api-server
kube-proxy1 --> kube-api-server
kubelet1 > CRI1
kube-proxy1 > CRI1
kubelet2 > kube-api-server
kube-proxy2 --> kube-api-server
kubelet2 > CRI2
kube-proxy2 > CRI2
cloud-control-manager --> CLOUD PROVIDER API
