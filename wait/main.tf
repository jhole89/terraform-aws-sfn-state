module "base" {
  source      = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/base"
  comment     = var.comment
  input_path  = var.input_path
  output_path = var.output_path
}

locals {

  local_defn = {
    Type                              = "Wait"
    var.next != null ? "Next" : "End" = var.next != null ? var.next : true
    (var.time_metric)                 = var.time_value
  }

  state_defn = merge(local.local_defn, module.base.defn)
  json       = jsonencode(local.state_defn)
}
