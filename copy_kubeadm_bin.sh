#!/bin/sh

# copy_kubeadm_bin takes your built kubeadm binary, prefixes it with an issue
# number and copies it into this repo's /bin, so that it may be used from
# `/vagrant/bin` inside the VM for testing.
#
#   usage:
#     issue=710 ./copy_kubeadm_bin.sh
#   env_vars:
#     issue (*required)     Issue number(s) or descriptor used for prefixing the binary
#     kube_root | GOPATH    Used for setting the kubernetes source root. (defaults to ~/go)

set -eu
binary=kubeadm
kube_root="${kube_root:-${GOPATH:-${HOME}/go}/src/k8s.io/kubernetes}"
vagrant_root="$(cd "$(dirname "${BASH_SOURCE[0]:-$PWD}")" 2>/dev/null 1>&2 && pwd)"

mkdir -p ${vagrant_root}/bin

set -x
cd "${kube_root}/_output/local/bin/linux/amd64/"
cp ${binary} ${issue}_${binary}
cp ${binary} ${vagrant_root}/bin/${issue}_${binary}
