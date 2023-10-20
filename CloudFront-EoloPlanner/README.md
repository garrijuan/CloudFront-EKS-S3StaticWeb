1. crear bucket eoloplsnner para almacenar contenido statico
2. crear distribucion
    add origin
        bucket eoloplanner
        loadBalancer del cluster(para redireccionar a los services), cuando lo tenga
    configure behavoir 
3. construir nueva imagen docker del server para poder desplegar, puesto que hemos sacado el contenido estatico
4. desplegar cluster con cloudformation
    /home/juanangel/Escritorio/TFM/CloudFront-EKS-S3StaticWeb:
```sh
    eksctl create cluster -f Cluster.yaml
```
6. (opcional), update config para apuntar al cluster
    
```sh
    eks --region us-east-1 update-kubeconfig --name nombreCluster
```
5. configurar Nginx ingress controller en el cluster
```sh
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml
```
check:
```sh
    kubectl get pods --namespace=ingress-nginx
    kubectl get service  --namespace=ingress-nginx
```

6. deploy
```sh
kubectl apply -f k8s/
```
```sh
kubectl get all
```

[23:27, 17/10/2023] Manuel Lorente: 
Y eso en eks por debajo te genera el ALB
[23:28, 17/10/2023] Manuel Lorente: 
Y en el hostname del ingress se pone el DNS del alb
[23:28, 17/10/2023] Manuel Lorente: 
Y en el cliente js para la conexión ws se pone el DNS del alb
[23:28, 17/10/2023] Manuel Lorente: 
Que lo genera automáticamente eks
[23:28, 17/10/2023] Manuel Lorente: Pero hay que generar un IAM
[23:40, 17/10/2023] Manuel Lorente: 
En pocas palabras, sustituir el ALB por un nginx que usamos en minikube