# Vagrant + Ansible + Kubernetes + CRI-O + Kata Containers cluster with a master and two worker nodes

## Versions
Ubuntu 20.04, Docker 19.03.14, Kubernetes/CRI-O 1.20.2, Kata Containers 2.0.1

## Prerequisites
VirtualBox, Vagrant, and Ansible installed on the host. By default, VM's are created with 3GB of memory, which can be changed in the Vagrantfile. No less than 2GB is recommended.

## Cluster setup
The script creates the master node (k8s-master / 10.0.10.50) and two worker nodes (node-1 / 10.0.10.51; node-2 / 10.0.10.52). Username and password for SSH is vagrant:vagrant.

## Get started
Run the system with `vagrant up`and tear down with `vagrant destroy -f`. Ansible playbook can be rerun by `vagrant provision` wiithout destroying the node first. A single node can be constructed/provisioned/destroyed by using `vagrant up k8s-master`, for example.

The playbooks setup the nodes with CRI-O as CRI and install Kata Containers to the system.

## Issues
Kata Containers Shim V2 gets unrecognized flag from kubelet/CRI which currently stalls the runtime.

## References
https://pkg.go.dev/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta1
https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
https://github.com/cri-o/cri-o/issues/1284
https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/
