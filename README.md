# Vagrant + Ansible + Kubernetes + containerd + Kata Containers cluster with a single master node

## Versions
Ubuntu 20.04, Docker CLI 19.03.14, Kubernetes 1.20.2, Containerd 1.3.3, Kata Containers 2.0.1

## Prerequisites
VirtualBox, Vagrant, and Ansible installed on the host. By default, VM's are created with 3GB of memory, which can be changed in the Vagrantfile. No less than 2GB is recommended.

## Cluster setup
The script creates the master node (k8s-master / 10.0.10.50). Username and password for SSH is vagrant:vagrant.

## Get started
Run the system with `vagrant up`and tear down with `vagrant destroy -f`. Ansible playbook can be rerun by `vagrant provision` wiithout destroying the node first.

The playbooks setup the node with containerd as CRI and installs Kata Containers to the system.

## Issues
Virtio-fs not installed on guest.

## References
https://pkg.go.dev/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta1  
https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/  
https://github.com/cri-o/cri-o/issues/1284  
https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/  
https://medium.com/cloudlego/using-cri-o-as-container-runtime-for-kubernetes-b8ddf8326d38  
https://medium.com/@ramaswin121994/kubernetes-installation-with-containerd-721fe0c40b6e  
https://github.com/kata-containers/kata-containers/blob/main/docs/how-to/containerd-kata.md  
