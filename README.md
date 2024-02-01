# k8s-cluster-coreos
installation and configuration scripts to build a multi-node kubernetes cluster using coreos nodes and a centos9 management client


create 1 host in virtualbox using centos9

* `ssh-keygen -t rsa`
copy contents of ~/.ssh/id_rsa.pub and update the butane config file

`
passwd:
  users:
    - name: core
      ssh_authorized_keys:
        - COPY-YOUR-KEY-HERE
`

convert the butate file to ignition file:
* `sudo yum install butane`
`./convert.sh k8s-setup.bu k8s-setup.ign`

upload the k8s-setup.ign to a url that the nodes can reach

===

create 3 hosts in virtualbox
* memory: 4096 mb 
* cpu: 2
* disk: 50gb

boot the hosts with the coreos live cd and install
`coreos-installer install /dev/sda --igntion-url https://your-website-here/k8s-setup.ign`

===
ansible

update the /etc/hosts file with the names and ips of your nodes

`
192.168.0.101 node1
192.168.0.102 node2
192.168.0.103 node3
`
update the ansible/kubernetes.ini inventory file with your nodes
NOTE: we're using *node1* as our control plane server

install ansible
* `sudo dnf install ansible-core`

start the install
`ansible-playbook kubernetes.yml -i kubernetes.ini`

NODE ROLES (fedora coreos):
* coreos
 ** coreos does not have python installed by default
 ** installs python
 ** reboots after install
* common
 ** sets the hostname of the node based on the inventory name
 ** reboots if changed
* kubernetes
 ** copies yum repository
 ** installs required packages
 ** reboots if anything installed
 ** starts necessary services
* controlplane
 ** copies cluster config
 ** inits cluster from config file
 ** copies config to ~/.kube
 ** copies router config
 ** inits router from config file

CLIENT ROLES (centos9):
* kubectl
 ** copies yum repository
 ** installs kubectl package





