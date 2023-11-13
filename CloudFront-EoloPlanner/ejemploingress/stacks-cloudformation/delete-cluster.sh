#!/bin/bash

STACK_VPC="my-eks-vpc"
STACK_EKS="my-eks-cluster"

#delete load balancer
LB_NAME=$(aws elb describe-load-balancers --query 'LoadBalancerDescriptions[0].LoadBalancerName' --output text)
aws elb delete-load-balancer --load-balancer-name $LB_NAME


# Ejecutar script para borrar el stack de la VPC
./delete-eks-stack.sh

# Esperar hasta que el estado del stack de EKS sea DELETE_COMPLETE
while true; do
    STACK_STATUS=$(aws cloudformation describe-stacks --stack-name $STACK_EKS --query "Stacks[0].StackStatus" --output text)
    if [ "$STACK_STATUS" = "" ]; then
        echo "Starting $STACK_VPC stack"
        # Ejecutar script para borrar el stack de VPC una vez que el stack de la EKS esté completo
        ./delete-vpc-stack.sh
        break
    else
        echo "Waiting $STACK_EKS stack. Current status: $STACK_STATUS"
        sleep 30  # Esperar 30 segundos antes de verificar nuevamente
    fi
done


# Esperar hasta que el estado del stack de VPC sea DELETE_COMPLETE
while true; do
    STACK_STATUS=$(aws cloudformation describe-stacks --stack-name $STACK_VPC --query "Stacks[0].StackStatus" --output text)
    if [ "$STACK_STATUS" = "" ]; then

        echo "Delete all AWS resources completed"
        break
    else
        echo "Waiting $STACK_VPC stack. Current status: $STACK_STATUS"
        sleep 30  # Esperar 30 segundos antes de verificar nuevamente
    fi