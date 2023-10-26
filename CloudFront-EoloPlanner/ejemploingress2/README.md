# Introduction

The scripts will create resources in: us-east-1

# How to run it
# export AWS_PROFILE=user1 # The name of the profile you want to use
- ./create-vpc-stack.sh
- ./create-eks-stack.sh

# How to clean up
- ./delete-eks-stack.sh
- ./delete-vpc-stack.sh

# Tips

## Update Kubeconfig
aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster

## Install an ingress controller
https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

testing
kubectl get service ingress-nginx-controller --namespace=ingress-nginx

## Verify ingress controller
kubectl get service ingress-nginx-controller --namespace=ingress-nginx



kubectl apply -f k8s/

kubectl get ing

curl a13efc445342d4816b73517d70305b6a-1084696550.us-east-1.elb.amazonaws.com
curl a13efc445342d4816b73517d70305b6a-1084696550.us-east-1.elb.amazonaws.com/api