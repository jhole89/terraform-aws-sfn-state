module "pass_state" {
  source  = "../../modules/pass"
  name    = "my_pass_state"
  comment = "branch-pass-state"
}

module "succeed_state" {
  source  = "../../modules/succeed"
  name    = "my_succeed_state"
  comment = "branch-succeed-state"
}

module "task_state" {
  source   = "../../modules/task"
  name     = "my_task_state"
  resource = "some:resource::arn"
  comment  = "branch-task-state"
}

module "parallel" {
  source  = "../../modules/parallel"
  comment = "An example parallel state"
  name    = "my_parallel_state"
  next    = "NextState"
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
  branches = [
    {
      start_at = module.pass_state.name
      states = [
        module.pass_state.defn,
        module.succeed_state.defn,
      ]
    },
    {
      start_at = module.task_state.name
      states = [
        module.task_state.defn,
      ]
    }
  ]
}

output "json" {
  value = module.parallel.json
}
