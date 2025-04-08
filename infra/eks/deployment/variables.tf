
variable "desired_size" {
  type = number
  default = 2
}

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

variable "tags" {
  type    = map(string)
  default = {}
}