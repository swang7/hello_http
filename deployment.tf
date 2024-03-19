resource "kubernetes_deployment" "hello-http" {
  metadata {
    name = "hello-webserver"
    labels = {
      App = "hello-http"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "hello-http"
      }
    }
    template {
      metadata {
        labels = {
          App = "hello-http"
        }
      }
      spec {
        container {
          image = "${var.ecr_repo}:${var.container_tag}"
          name  = "hello-webserver"

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
