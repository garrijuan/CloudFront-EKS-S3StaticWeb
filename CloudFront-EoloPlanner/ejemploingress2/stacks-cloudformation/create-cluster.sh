#!/bin/bash

STACK_VPC="my-eks-vpc"
STACK_EKS="my-eks-cluster"

# Ejecutar script para crear el stack de la VPC
./create-vpc-stack.sh

# Esperar hasta que el estado del stack de VPC sea CREATE_COMPLETE
while true; do
    STACK_STATUS=$(aws cloudformation describe-stacks --stack-name $STACK_VPC --query "Stacks[0].StackStatus" --output text)
    if [ "$STACK_STATUS" = "CREATE_COMPLETE" ]; then
        echo "Starting $STACK_EKS stack"
        # Ejecutar script para crear el stack de EKS una vez que el stack de la VPC esté completo
        ./create-eks-stack.sh
        break
    else
        echo "Waiting $STACK_VPC stack. Current status: $STACK_VPC"
        sleep 30  # Esperar 30 segundos antes de verificar nuevamente
    fi
done

# Esperar hasta que el estado del stack de EKS sea CREATE_COMPLETE
while true; do
    STACK_STATUS=$(aws cloudformation describe-stacks --stack-name $STACK_EKS --query "Stacks[0].StackStatus" --output text)
    if [ "$STACK_STATUS" = "CREATE_COMPLETE" ]; then
        echo "Binding kubectl with eks and  $STACK_EKS stack"

        ##Binding kubectl with eks
        aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster

        ##deploy a nginx ingress in my cluster
        kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

        break
    else
        echo "Waiting $STACK_EKS stack. Current status: $STACK_EKS"
        sleep 30  # Esperar 30 segundos antes de verificar nuevamente
    fi
done
