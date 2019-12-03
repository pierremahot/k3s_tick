curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v0.11.0-alpha2 sh -
kubectl create namespace cert-manager
kubectl create namespace tick
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
kubectl apply --force -f cert-manager.yaml
sleep 200
kubectl apply -f le-staging.yaml
kubectl apply -f le-prod.yaml
kubectl apply -f deployment_influxdb.yaml
kubectl apply -f services_influxdb.yaml
kubectl apply -f deployment_kapacitor.yaml
kubectl apply -f services_kapacitor.yaml
kubectl apply -f deployment_chronograf.yaml
kubectl apply -f services_chronograf.yaml
kubectl apply -f deployment_telegraf.yaml
kubectl apply -f ingress.yaml
