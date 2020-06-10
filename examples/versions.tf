terraform {
  required_version = "~> 0.13.0"

  required_providers {
    local = "~> 1.2"
  }

  experiments = [variable_validation]
}