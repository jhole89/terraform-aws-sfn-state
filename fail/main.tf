locals {
  state_defn = {
    Type    = "Fail"
    Comment = var.comment
  }

  json = jsonencode(local.state_defn)
}