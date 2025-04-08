variable "cluster_name" {
  type = string
  default = "mfe-eks-cluster"
}

variable "admin_iam_user_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}