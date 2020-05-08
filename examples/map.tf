module "validate_task" {
  source = "../task"
  resource = "arn:aws:lambda:us-east-1:123456789012:function:ship-val"
  comment = "An example task state"
}

module "map" {
  source  = "../map"
  comment = "An example map state"
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

output "map" {
  value = module.map.json
}