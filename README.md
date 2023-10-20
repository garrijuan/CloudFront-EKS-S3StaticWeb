#create cluster

```sh
eksctl create cluster --name development --dry-run
```

##instrucciona anterior me devuelve yaml base para ajustar

#crear cluster y nodos

```sh
eksctl create cluster -f Cluster.yaml

```

En CloudFormation puedo ver el stack con los avances, debe desplegar dos stack: cluster y nodos(ec2)



#desplegar EoloPlanner en k8s, todos los servicios en el cluster incluido Frontend

```sh
kubectl apply -f EoloPlanner-k8s/
```
```sh
kubectl get all
```
esto va a tener que ser un paso manual, porque no sabemos en que puerto nos va a desplegar el servicio.
añadimos inbound rule con e puerto se server-service a el SG que se creo del cluster
comprobar app working
ec2->instancia->Public IPv4 DNS
copio  y concateno el pueto servido de server-service y con http


--------------------------------
Creancion Manual:
-crear cluster EKS con confi que deseemos
-crear dos roles en IAM:
    -(EKS-cluster):AmazonEKSClusterPolicy
    -(EC2):AmazonEKS_CNI_Policy,AmazonEKSWorkerNodePolicy,AmazonEC2ContainerRegistryReadOnly
- crear workerNodes
    -compute->add node group
    
-binding kubectl con cluster:
```sh
eks --region us-east-1 update-kubeconfig --name nombreCluster
```
-modificar ec2->security-groups y editamos inbound groups, creamos regla para nuestro puerto donde servimos el server-service 

--------------------------------
conectar bucket s3 al cluster