# vagrant kubeadm testing
This [Vagrantfile](./Vagrantfile) provisions a 4cpu/4GB Ubuntu 17.10 vm for the purpose of developing on kubeadm.  
Recent packages of kubernetes components will be installed and a compatible Docker daemon is started and running.  
The bashrc is configured by default to use `/etc/kubernetes/admin.conf`.  
An upstream version of kubeadm is installed for reference usage.  

[copy_kubeadm_bin.sh](./copy_kubeadm_bin.sh) takes your built kubeadm binary, prefixes it with an issue
number and copies it into this repo's `./bin`, so that it may be used from `/vagrant/bin` inside the VM for testing.  
This is useful for comparing builds.

## example
#### build two versions of kubeadm:
```shell
cd ~/go/src/k8s.io/kubernetes

git checkout feature/kubeadm_594-etcd_tls
bazel test //cmd/kubeadm/...
make WHAT=cmd/kubeadm KUBE_BUILD_PLATFORMS=linux/amd64
issue=594 ./copy_kubeadm_bin.sh

git checkout feature/kubeadm_710-etcd-ca
bazel test //cmd/kubeadm/...
make WHAT=cmd/kubeadm KUBE_BUILD_PLATFORMS=linux/amd64
issue=710 ./copy_kubeadm_bin.sh
```
#### experiment with the two builds on the vagrant:
```shell
cd ~/Repos/vagrant-kubeadm-testing

vagrant up
vagrant ssh
  sudo /vagrant/bin/594_kubeadm init
  sudo /vagrant/bin/594_kubeadm reset
  sudo /vagrant/bin/710_kubeadm init
```
