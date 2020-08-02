module "wait_seconds" {
  source      = "../../../modules/wait"
  name        = "wait_ten_seconds"
  comment     = "An example wait with seconds"
  time_metric = "Seconds"
  time_value  = 10
  next        = "NextState"
}

output "json" {
  value = module.wait_seconds.json
}
