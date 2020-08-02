module "wait_until_t" {
  source      = "../../../modules/wait"
  name        = "wait_until"
  comment     = "An example wait with timestamp path"
  time_metric = "TimeStampPath"
  time_value  = "$.expirydate"
}

output "json" {
  value = module.wait_until_t.json
}
