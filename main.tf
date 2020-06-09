locals {
  local_defn = {
    Comment = var.comment
    StartAt = var.start_at
    States = merge(flatten([var.states])...)
  }

  json = jsonencode(local.local_defn)
}
