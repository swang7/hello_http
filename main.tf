terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_network" "private_network" {
  name = "my_network"
}

resource "docker_image" "ubuntu_dev" {
  name = "ubuntu_dev"
  build {
    context = "."
  }
}

resource "docker_container" "ubuntu_dev" {
  image = docker_image.ubuntu_dev.image_id
  name = "web"

  ports {
    internal = "8080"
    external = "12344"
    ip = "127.0.0.1"
  }

  networks_advanced {
    name = docker_network.private_network.id
  }
}
