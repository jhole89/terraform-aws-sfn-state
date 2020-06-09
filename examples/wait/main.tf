module "wait_seconds" {
  source      = "../../modules/wait"
  name        = "my_wait_state"
  comment     = "An example wait with seconds"
  time_metric = "Seconds"
  time_value  = 10
  next        = "NextState"
}

module "wait_until_s" {
  source      = "../../modules/wait"
  name        = "my_wait_state"
  comment     = "An example wait with seconds path"
  time_metric = "SecondsPath"
  time_value  = "$.seconds"
}

module "wait_timestamp" {
  source      = "../../modules/wait"
  name        = "my_wait_state"
  comment     = "An example wait with timestamp"
  time_metric = "TimeStamp"
  time_value  = "2016-03-14T01:59:00Z"
  next        = "NextState"
}

module "wait_until_t" {
  source      = "../../modules/wait"
  name        = "my_wait_state"
  comment     = "An example wait with timestamp path"
  time_metric = "TimeStampPath"
  time_value  = "$.expirydate"
}
