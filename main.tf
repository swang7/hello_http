provider "docker" {}

resource "docker_image" "ubuntu_dev" {
  name = "ubuntu_dev"
  build {
    context = "."
  }
}

provider "aws" {
  region = var.region
}

resource "terraform_data" "upload" {
  provisioner "local-exec" {
    command = <<-EOT
      aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${var.ecr_repo}
      docker tag ${docker_image.ubuntu_dev.image_id} ${var.ecr_repo}:${var.container_tag}
      docker push ${var.ecr_repo}:${var.container_tag}
    EOT
  }
}
