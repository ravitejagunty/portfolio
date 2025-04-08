variable "region" {
  type = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "cluster_name" {
  type = string
  default = "mfe-eks-cluster"
}

variable "cluster_version" {
  type = string
  default = "1.28"
}

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

# variable "image_name" {
#   type = string
#   default = "mfe-image"
# }

# variable "container_port" {
#   type = number
#   default = 80
# }

variable "microfrontends" {
    type = map(object({
      image_name = string
      container_port = number 
    }))
    default = {
        "shell" = {
            image_name = "shell"
            container_port = 3000
        }
        "about" = {
            image_name = "about"
            container_port = 3004
        }
        "blogs" = {
            image_name = "blogs"
            container_port = 3003
        }
        "contact" = {
            image_name = "contact"
            container_port = 3005
        }
        "home" = {
            image_name = "home"
            container_port = 3001
        }
        "projects" = {
            image_name = "projects"
            container_port = 3002
        }
    }
}

variable "admin_iam_user_arn" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "dockerhub_username" {
  type = string
}

variable "dockerhub_password" {
  type = string
  sensitive = true
}

variable "dockerhub_email" {
  type = string
}