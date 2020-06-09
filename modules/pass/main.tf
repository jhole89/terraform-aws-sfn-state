module "base" {
  source      = "../../modules/base"
  comment     = var.comment
  input_path  = var.input_path
  output_path = var.output_path
}

locals {
  local_defn = {
    Type                              = "Pass"
    var.next != null ? "Next" : "End" = var.next != null ? var.next : true
    Parameters                        = var.parameters
    Result                            = var.result
    ResultPath                        = var.result_path
  }

  state_defn = { (var.name) = merge(local.local_defn, module.base.defn) }
  json       = jsonencode(local.state_defn)
}