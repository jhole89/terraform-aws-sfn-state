module "wait_until_s" {
  source      = "../../../modules/wait"
  name        = "wait_until"
  comment     = "An example wait with seconds path"
  time_metric = "SecondsPath"
  time_value  = "$.seconds"
  next        = "NextState"
}

output "json" {
  value = module.wait_until_s.json
}
