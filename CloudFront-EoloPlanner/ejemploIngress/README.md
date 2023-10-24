kubectl apply -f ns-and-sa.yml

kubectl apply -f ingress/

kubectl get ns
kubectl -n nginx-ingress get all

kubectl apply -f app/

kubectl get all

kubectl describe service/hello-v1-svc
kubectl describe service/hello-v2-svc

kubectl get ing

añadir hosts en local /etc/hosts
sudo nano /etc/hosts
cat /etc/hosts
192.168.49.2 v1.peladonerd.local
192.168.49.2 v2.peladonerd.local



curl v1.peladonerd.local:30000
curl v2.peladonerd.local:30000

kubectl describe ing ingress


-------via 2 -----working
 minikube start
 minikube addons enable ingress
 kubectl apply -f app/
 kubectl get all
 cat /etc/hosts
 minikube ip
 kubectl get ing
 curl v1.peladonerd.local

