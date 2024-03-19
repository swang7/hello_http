resource "kubernetes_service" "hello-http" {
  metadata {
    name = "hello-http"
  }
  spec {
    selector = {
      App = kubernetes_deployment.hello-http.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
