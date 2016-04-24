# kube-demos
Kubernetes demos

To run these demos you need 'pv' and 'tmux' installed.
(NOTE: On mac, use brew to install pv, tmux and coreutils)
  * brew install pv
  * brew install tmux
  * brew install coreutil

To make best use of these demos:

SSH to your kubernetes-master and set the following flags (in this order):
  * kube-apiserver: --runtime-config=extensions/v1beta1/daemonsets=true,extensions/v1beta1/deployments=true
  * kube-controllermanager: --pod-eviction-timeout=10s

