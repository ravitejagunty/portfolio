variable "node_group_name" {
  type = string
  default = "mfe-node-group"
}

variable "instance_type" {
  type = string
  default = "t3.medium"
}

variable "desired_size" {
  type = number
  default = 2
}

variable "max_size" {
  type = number
  default = 5
}

variable "min_size" {
  type = number
  default = 1
}

variable "cluster_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}