terraform {
  backend "consul" {
    address = "34.248.11.152:8500"
    path    = "hackathon/tf"
  }
}
