# disco
Kubernetes cluster (master + 2 workers) built with Vagrant and Ansible running on Ubuntu 20.04.


Based on https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/ with updates to Ubuntu 20.04 and systemd driver.

Run the system with `vagrant up`and tear down with `vagrant destroy -f`.

The script creates k8s-master (192.168.10.50) and two worker nodes (.51 and .52).

Current errors at k8s-master `kubeadm init` phase. Errors:
vagrant@k8s-master:~$ systemctl status kubelet
`
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /etc/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Tue 2021-02-02 17:52:25 UTC; 11min ago
       Docs: https://kubernetes.io/docs/home/
   Main PID: 41536 (kubelet)
      Tasks: 13 (limit: 2281)
     Memory: 33.5M
     CGroup: /system.slice/kubelet.service
             └─41536 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime=remote --container-runtime-endpoint=unix:///var/run/crio/crio.sock --node-ip=>

Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.012584   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.112750   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.161725   41536 event.go:273] Unable to write event: '&v1.Event{TypeMeta:v1.TypeMeta{Kind:"", APIVersion:""}, ObjectMeta:v1.ObjectMeta{Name:"k8s-master.165fffb7d03b5c3a", GenerateName:"", Namespace:"default", SelfLink:"">
Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.212895   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.313073   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.413519   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.514608   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.614979   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.715214   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:04:05 k8s-master kubelet[41536]: E0202 18:04:05.815392   41536 kubelet.go:2243] node "k8s-master" not found
`

`
journalctl -xeu kubelet
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.552365   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.592753   41536 remote_runtime.go:116] RunPodSandbox from runtime service failed: rpc error: code = Unknown desc = cri-o configured with systemd cgroup manager, but did not receive slice as parent: /kubepods/burstable/po>
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.592791   41536 kuberuntime_sandbox.go:70] CreatePodSandbox for pod "kube-scheduler-k8s-master_kube-system(69cd289b4ed80ced4f95a59ff60fa102)" failed: rpc error: code = Unknown desc = cri-o configured with systemd cgroup >
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.592804   41536 kuberuntime_manager.go:755] createPodSandbox for pod "kube-scheduler-k8s-master_kube-system(69cd289b4ed80ced4f95a59ff60fa102)" failed: rpc error: code = Unknown desc = cri-o configured with systemd cgroup>
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.592839   41536 pod_workers.go:191] Error syncing pod 69cd289b4ed80ced4f95a59ff60fa102 ("kube-scheduler-k8s-master_kube-system(69cd289b4ed80ced4f95a59ff60fa102)"), skipping: failed to "CreatePodSandbox" for "kube-schedul>
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.596169   41536 remote_runtime.go:116] RunPodSandbox from runtime service failed: rpc error: code = Unknown desc = cri-o configured with systemd cgroup manager, but did not receive slice as parent: /kubepods/burstable/po>
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.596212   41536 kuberuntime_sandbox.go:70] CreatePodSandbox for pod "kube-controller-manager-k8s-master_kube-system(c4e6a57135a16a79635900cad171b65d)" failed: rpc error: code = Unknown desc = cri-o configured with system>
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.596223   41536 kuberuntime_manager.go:755] createPodSandbox for pod "kube-controller-manager-k8s-master_kube-system(c4e6a57135a16a79635900cad171b65d)" failed: rpc error: code = Unknown desc = cri-o configured with syste>
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.596259   41536 pod_workers.go:191] Error syncing pod c4e6a57135a16a79635900cad171b65d ("kube-controller-manager-k8s-master_kube-system(c4e6a57135a16a79635900cad171b65d)"), skipping: failed to "CreatePodSandbox" for "kub>
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.652580   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.753625   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.854453   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:46 k8s-master kubelet[41536]: E0202 18:06:46.955445   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.055739   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.167230   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.270927   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.271021   41536 eviction_manager.go:260] eviction manager: failed to get summary stats: failed to get node info: node "k8s-master" not found
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.401762   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.512713   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.554446   41536 remote_runtime.go:116] RunPodSandbox from runtime service failed: rpc error: code = Unknown desc = cri-o configured with systemd cgroup manager, but did not receive slice as parent: /kubepods/burstable/po>
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.554480   41536 kuberuntime_sandbox.go:70] CreatePodSandbox for pod "kube-apiserver-k8s-master_kube-system(9fd4d7d9e57e9819eaccaf52dae09a7f)" failed: rpc error: code = Unknown desc = cri-o configured with systemd cgroup >
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.554547   41536 kuberuntime_manager.go:755] createPodSandbox for pod "kube-apiserver-k8s-master_kube-system(9fd4d7d9e57e9819eaccaf52dae09a7f)" failed: rpc error: code = Unknown desc = cri-o configured with systemd cgroup>
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.554606   41536 pod_workers.go:191] Error syncing pod 9fd4d7d9e57e9819eaccaf52dae09a7f ("kube-apiserver-k8s-master_kube-system(9fd4d7d9e57e9819eaccaf52dae09a7f)"), skipping: failed to "CreatePodSandbox" for "kube-apiserv>
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.616224   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:47 k8s-master kubelet[41536]: E0202 18:06:47.716352   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:48 k8s-master kubelet[41536]: E0202 18:06:48.675100   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:48 k8s-master kubelet[41536]: E0202 18:06:48.675570   41536 reflector.go:138] k8s.io/kubernetes/pkg/kubelet/kubelet.go:438: Failed to watch *v1.Node: failed to list *v1.Node: Get "https://192.168.50.10:6443/api/v1/nodes?fieldSelector=metadata.name%3Dk8s-master&lim>
Feb 02 18:06:48 k8s-master kubelet[41536]: E0202 18:06:48.775624   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:49 k8s-master kubelet[41536]: E0202 18:06:49.956866   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.040621   41536 controller.go:144] failed to ensure lease exists, will retry in 7s, error: Get "https://192.168.50.10:6443/apis/coordination.k8s.io/v1/namespaces/kube-node-lease/leases/k8s-master?timeout=10s": dial tcp 1>
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.057064   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.157279   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.262058   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.362335   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.381892   41536 event.go:273] Unable to write event: '&v1.Event{TypeMeta:v1.TypeMeta{Kind:"", APIVersion:""}, ObjectMeta:v1.ObjectMeta{Name:"k8s-master.165fffb7d03b6d9d", GenerateName:"", Namespace:"default", SelfLink:"">
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.382089   41536 event.go:218] Unable to write event '&v1.Event{TypeMeta:v1.TypeMeta{Kind:"", APIVersion:""}, ObjectMeta:v1.ObjectMeta{Name:"k8s-master.165fffb7d2fe3794", GenerateName:"", Namespace:"default", SelfLink:"",>
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.382436   41536 event.go:273] Unable to write event: '&v1.Event{TypeMeta:v1.TypeMeta{Kind:"", APIVersion:""}, ObjectMeta:v1.ObjectMeta{Name:"k8s-master.165fffb7d03b44b0", GenerateName:"", Namespace:"default", SelfLink:"">
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.449393   41536 certificate_manager.go:437] Failed while requesting a signed certificate from the master: cannot create certificate signing request: Post "https://192.168.50.10:6443/apis/certificates.k8s.io/v1/certificat>
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.463001   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.563766   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.665230   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.766638   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.868105   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.968225   41536 kubelet.go:2243] node "k8s-master" not found
Feb 02 18:06:50 k8s-master kubelet[41536]: I0202 18:06:50.987725   41536 kubelet_node_status.go:71] Attempting to register node k8s-master
Feb 02 18:06:50 k8s-master kubelet[41536]: E0202 18:06:50.987921   41536 kubelet_node_status.go:93] Unable to register node "k8s-master" with API server: Post "https://192.168.50.10:6443/api/v1/nodes": dial tcp 192.168.50.10:6443: connect: connection refused`
