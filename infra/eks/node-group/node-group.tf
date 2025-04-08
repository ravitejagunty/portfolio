resource "aws_eks_node_group" "mfe-node-group" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.node-group-role.arn

  # Node group configuration
  subnet_ids     = var.subnet_ids
  capacity_type  = "ON_DEMAND"
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  launch_template {
    name    = "mfe-template-with-key"
    version = "$Latest"
  }
  
  tags = var.tags
}

resource "aws_iam_role" "node-group-role" {
  name = "mfe-node-group-role"
  tags = var.tags
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

# resource "aws_iam_policy" "node-group-policy" {
#   name = "mfe-node-group-policy"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:DescribeInstances",
#           "ec2:DescribeSubnets",
#           "ec2:DescribeSecurityGroups",
#           "ec2:DescribeVpcs",
#           "ec2:CreateTags",
#           "ec2:DeleteTags",
#           "ec2:DescribeRouteTables",
#           "ec2:DescribeInternetGateways",
#           "ec2:DescribeNatGateways",
#           "ec2:DescribeVpcPeeringConnections",
#           "ec2:DescribeVpcEndpoints",
#           "ec2:DescribeVpcEndpointServices",
#           "ec2:DescribeVpcEndpointServiceConfigurations",
#           "ec2:DescribeVpcEndpointServicePermissions",
#           "ec2:DescribeVpcEndpointConnections",
#           "ec2:DescribeVpcEndpointConnectionNotifications",
#         ]
#         Resource = "*"
#         Effect = "Allow"
#       }
#     ]
#   })
# }

# EKS required managed policies
resource "aws_iam_role_policy_attachment" "eks_worker_node" {
  role       = aws_iam_role.node-group-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
  role       = aws_iam_role.node-group-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.node-group-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
