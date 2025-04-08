resource "kubernetes_secret" "dockerhub" {
  provider = kubernetes
  metadata {
    name = "dockerhub"
  }

  type = "kubernetes.io/dockerconfigjson"

data = {
  ".dockerconfigjson" = jsonencode({
    auths = {
      "https://index.docker.io/v1/" = {
        username = var.dockerhub_username,
        password = var.dockerhub_password,
        email    = var.dockerhub_email,
        auth     = base64encode("${var.dockerhub_username}:${var.dockerhub_password}")
      }
    }
  })
}
}

# base64encode(jsonencode({auths = {"https://index.docker.io/v1/" = {username = "raviteajagunty",password = "Sunday@0404",email= "ravitejagunty@gmail.com",auth= base64encode("ravitejagunty:Sunday@0404")}}}))


resource "kubernetes_deployment" "mfe-deployment" {
  provider = kubernetes
  for_each = var.microfrontends
  metadata {
    name = each.value.image_name
  }

  spec {
    replicas = var.desired_size

    selector {
      match_labels = {
        app = each.value.image_name
      }
    }

    template {
      metadata {
        labels = {
          app = each.value.image_name
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret.dockerhub.metadata[0].name
        }

        container {
          name  = each.value.image_name
          image = "docker.io/ravitejagunty/rg:${each.value.image_name}"

          port {
            container_port = each.value.container_port
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "200m"
              memory = "256Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = each.value.container_port
            }
            initial_delay_seconds = 5
            timeout_seconds       = 2
          }

          readiness_probe {
            http_get {
              path = "/"
              port = each.value.container_port
            }
            initial_delay_seconds = 3
            period_seconds        = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mfe-service" {
  provider = kubernetes
  for_each = var.microfrontends
  metadata {
    name = each.value.image_name
  }

  spec {
    selector = {
      app = each.value.image_name
    }

    port {
      port        = each.value.container_port
      target_port = each.value.container_port
    }

    type = "LoadBalancer"
  }
}
