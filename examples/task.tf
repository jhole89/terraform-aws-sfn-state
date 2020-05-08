module "task" {
  source            = "../task"
  comment           = "An example task state"
  next              = "NextState"
  resource          = "arn:aws:states:us-east-1:123456789012:task:HelloWorld"
  timeout_seconds   = 300
  heartbeat_seconds = 60
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
}

output "task" {
  value = module.task.json
}