module "base" {
  source      = "../../modules/base"
  comment     = var.comment
  input_path  = var.input_path
  output_path = var.output_path
}

locals {

  local_defn = {
    Type                              = "Wait"
    var.next != null ? "Next" : "End" = var.next != null ? tostring(var.next) : tobool(true)
    (var.time_metric)                 = var.time_value
  }

  state_defn = { (var.name) = merge(local.local_defn, module.base.defn) }
  json       = jsonencode(local.state_defn)
}
