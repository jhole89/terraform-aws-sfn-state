module "wait_timestamp" {
  source      = "../../../modules/wait"
  name        = "wait_until"
  comment     = "An example wait with timestamp"
  time_metric = "TimeStamp"
  time_value  = "2016-03-14T01:59:00Z"
  next        = "NextState"
}

output "json" {
  value = module.wait_timestamp.json
}
