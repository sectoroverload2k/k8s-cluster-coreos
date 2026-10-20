alias ap='ansible-playbook'
ap -i inventory.ini clean-k8s.yml 
ap -i inventory.ini controlplane.yml 
ap -i inventory.ini kubernetes.yml 
ap -i inventory.ini join-cluster.yml
ap -i inventory.ini kubectl.yml

cat ~/.kube/config
