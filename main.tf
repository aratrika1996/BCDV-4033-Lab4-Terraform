terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Create MySQL container
resource "docker_container" "mysql" {
  name    = "mysql"
  image   = "container-registry.oracle.com/mysql/community-server:latest"
  restart = "always"
}

# Create Nginx container
resource "docker_container" "nginx" {
  name    = "nginx"
  image   = "nginx:latest"
  restart = "always"
  ports {
    internal = "80"
    external = "8082"  #changed port to 8082 from 8081
  }
}

# Create WordPress container
resource "docker_container" "wordpress" {
  name    = "wordpress"
  image   = "wordpress:latest"
  restart = "always"
  ports {
    internal = "80"
    external = "8080"
  }
  
  depends_on = [docker_container.nginx]
}
