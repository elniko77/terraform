provider "docker" {
    
    host = "unix:///var/run/docker.sock"
}

# Create the network
resource "docker_network" "private_network" {
    name = "wp_network"
}

# create db container
resource "docker_container" "db" {
  name  = "db"
  image = "mysql:5.7"
  env = ["MYSQL_DATABASE=wordpress", "MYSQL_USER=nico", "MYSQL_PASSWORD=nico", "MYSQL_RANDOM_ROOT_PASSWORD=nico"]
  command = ["--default-authentication-plugin=mysql_native_password"]
  network_mode = "bridge"

  networks_advanced {
    name    = "wp_network"
  }
}

# create wordpress container
resource "docker_container" "wordpress" {
  name  = "wordpress"
  image = "wordpress:latest"
  env = ["WORDPRESS_DB_HOST=db", "WORDPRESS_DB_USER=nico", "WORDPRESS_DB_PASSWORD=nico", "WORDPRESS_DB_NAME=wordpress"]
  network_mode = "bridge"

  networks_advanced {
    name    = "wp_network"
  }

  ports {
    internal = 80
    external = 8888
  }
}

