module "base" {
  source      = "../../modules/base"
  comment     = var.comment
  input_path  = var.input_path
  output_path = var.output_path
}

locals {

  local_defn = {
    Type                              = "Wait"
    var.next != null ? "Next" : "End" = try(tobool(var.next) == null, var.next)
    (var.time_metric)                 = var.time_value
  }

  state_defn = { (var.name) = merge(local.local_defn, module.base.defn) }
  json       = jsonencode(local.state_defn)
}
