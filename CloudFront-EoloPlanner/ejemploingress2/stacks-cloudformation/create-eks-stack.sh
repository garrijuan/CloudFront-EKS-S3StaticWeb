aws cloudformation create-stack \
  --region us-east-1 \
  --stack-name my-eks-cluster \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file:///home/juanangel/Escritorio/TFM/CloudFront-EKS-S3StaticWeb/CloudFront-EoloPlanner/ejemploingress2/stacks-cloudformation/eks-stack.yaml 