
# SITE: https://metallb.universe.tf/installation/


kubectl edit configmap -n kube-system kube-proxy

SET THE FOLLOWING:
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: "ipvs"
ipvs:
  strictARP: true




# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.3/config/manifests/metallb-native.yaml

# USE VERSION v0.14 instead /config/manifests/metallb-native.yaml













========================================================
DIFFERENT INSTRUCTIONS
========================================================





# https://docs.k0sproject.io/v1.23.6+k0s.2/examples/metallb-loadbalancer/


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml


Create a YAML file accordingly, and deploy it: kubectl apply -f metallb-configmap.yaml

apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - <ip-address-range-start>-<ip-address-range-stop>




Deploy an example application (web server) with a load balancer

apiVersion: v1
kind: Namespace
metadata:
  name: web
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-server
  namespace: web
spec:
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: httpd
        image: httpd:2.4.48-alpine3.14
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: web-server-service
  namespace: web
spec:
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
