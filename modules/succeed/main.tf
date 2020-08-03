locals {
  state_defn = {
    (var.name) = {
      Type    = "Succeed"
      Comment = var.comment
    }
  }

  json = jsonencode(local.state_defn)
}