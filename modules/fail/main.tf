locals {
  state_defn = {
    (var.name) = {
      Type    = "Fail"
      Comment = var.comment
      Cause   = var.cause
      Error   = var.error
    }
  }

  json = jsonencode(local.state_defn)
}
