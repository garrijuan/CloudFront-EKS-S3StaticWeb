1. crear bucket eoloplsnner para almacenar contenido statico
2. crear distribucion
    add origin
        bucket eoloplanner
        loadBalancer del cluster(para redireccionar a los services), cuando lo tenga
    configure behavoir 
3. construir nueva imagen docker del server para poder desplegar, puesto que hemos sacado el contenido estatico
4. desplegar cluster con cloudformation
    /home/juanangel/Escritorio/TFM:
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
    kubectl get service ingress-nginx.controller --namespace=ingress-nginx
```