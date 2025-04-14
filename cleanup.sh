#!/bin/bash

# 🔁 Update these two values based on your environment
CLUSTER_NAME="mfe-eks-cluster"
VPC_NAME_TAG="mfe-vpc"

echo "Getting VPC ID for tag Name=$VPC_NAME_TAG"
VPC_ID=$(aws ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=$VPC_NAME_TAG" \
  --query 'Vpcs[0].VpcId' --output text)

echo "Found VPC: $VPC_ID"

# 1. Delete Node Groups
echo "Deleting Node Groups in cluster: $CLUSTER_NAME"
NODEGROUPS=$(aws eks list-nodegroups --cluster-name $CLUSTER_NAME --query "nodegroups[]" --output text)
for NG in $NODEGROUPS; do
  echo "Deleting Node Group: $NG"
  aws eks delete-nodegroup --cluster-name $CLUSTER_NAME --nodegroup-name $NG
done

# Wait for node group deletion
echo "Waiting for node groups to be deleted..."
sleep 30

# 2. Delete EKS Cluster
echo "Deleting EKS Cluster: $CLUSTER_NAME"
aws eks delete-cluster --name $CLUSTER_NAME

# 3. Delete Internet Gateway
IGW_ID=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$VPC_ID" \
  --query 'InternetGateways[0].InternetGatewayId' --output text)

if [[ $IGW_ID != "None" ]]; then
  echo "Detaching and deleting Internet Gateway: $IGW_ID"
  aws ec2 detach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
  aws ec2 delete-internet-gateway --internet-gateway-id $IGW_ID
fi

# 4. Delete subnets
SUBNETS=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" --query "Subnets[].SubnetId" --output text)
for SUBNET_ID in $SUBNETS; do
  echo "Deleting Subnet: $SUBNET_ID"
  aws ec2 delete-subnet --subnet-id $SUBNET_ID
done

# 5. Delete route tables (excluding the main one)
ROUTE_TABLES=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VPC_ID" \
  --query "RouteTables[?Associations[?Main!=\`true\`]].RouteTableId" --output text)
for RT_ID in $ROUTE_TABLES; do
  echo "Deleting Route Table: $RT_ID"
  aws ec2 delete-route-table --route-table-id $RT_ID
done

# 6. Delete security groups (excluding default)
SG_IDS=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" \
  --query "SecurityGroups[?GroupName!='default'].GroupId" --output text)
for SG in $SG_IDS; do
  echo "Deleting Security Group: $SG"
  aws ec2 delete-security-group --group-id $SG
done

# 7. Delete NAT Gateway (if any)
NGW_IDS=$(aws ec2 describe-nat-gateways --filter "Name=vpc-id,Values=$VPC_ID" \
  --query "NatGateways[].NatGatewayId" --output text)
for NGW_ID in $NGW_IDS; do
  echo "Deleting NAT Gateway: $NGW_ID"
  aws ec2 delete-nat-gateway --nat-gateway-id $NGW_ID
done

# 8. Release Elastic IPs (if any)
ALLOC_IDS=$(aws ec2 describe-addresses --query "Addresses[].AllocationId" --output text)
for ALLOC_ID in $ALLOC_IDS; do
  echo "Releasing Elastic IP: $ALLOC_ID"
  aws ec2 release-address --allocation-id $ALLOC_ID
done

# 9. Finally, delete the VPC
echo "Deleting VPC: $VPC_ID"
aws ec2 delete-vpc --vpc-id $VPC_ID

echo "All resources deleted successfully!"