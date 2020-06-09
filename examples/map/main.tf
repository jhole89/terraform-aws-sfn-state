module "validate_task" {
  source = "../../modules/task"
  name = "mylambdatask"
  resource = "arn:aws:lambda:us-east-1:123456789012:function:ship-val"
  comment = "An example task state"
}

module "map" {
  source  = "../../modules/map"
  comment = "An example map state"
  name = "mymap"
  retry = [
    {
      error_equals     = ["States.Timeout"]
      interval_seconds = 3
      max_attempts     = 2
      backoff_rate     = 1.5
    },
    {
      error_equals     = ["States.ALL"]
      interval_seconds = null
      max_attempts     = null
      backoff_rate     = null
    }
  ]
  catch = [
    {
      error_equals = ["States.ALL"]
      next         = "Z"
    }
  ]
  iterator = {
    start_at = "Validate"
    states = [
      {
        name       = "Validate"
        state_defn = module.validate_task.defn
      },
      {
        name       = "Validate2"
        state_defn = module.validate_task.defn
      }
    ]
  }
}
