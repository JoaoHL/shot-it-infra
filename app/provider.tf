terraform {
  cloud {
    organization = "postech-fiap-alura"
    workspaces {
      name = "shot-it"
    }
  }
}