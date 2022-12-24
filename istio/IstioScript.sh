# /bin/sh
# minikube start --memory=4000mb --cpus=4 --kubernetes-version=v1.20.2
# A ouvrir dans istio-1.16.1
# gnome-terminal --window-with-profile=SCRIPT minikube start --memory=4000mb --cpus=4 --kubernetes-version=v1.20.2 & minikube kubectl get pods -A
minikube config set driver kvm2
minikube delete
minikube start --memory=4000mb --cpus=4 --kubernetes-version=v1.20.2
minikube kubectl -- get pods -A
gnome-terminal --window-with-profile=SCRIPT -- minikube tunnel --cleanup
export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y
kubectl label namespace default istio-injction=enabled
cd ..
cd ..
cd k8s
kubectl apply -f .
sleep 2m
kubectl get pods
cd ..
cd istio/istio-1.16.1 
istioctl analyze
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo "http://$GATEWAY_URL"
minikube service web

