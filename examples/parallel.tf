module "pass_state" {
  source  = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/pass"
  comment = "branch-pass-state"
}

module "succeed_state" {
  source  = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/succeed"
  comment = "branch-succeed-state"
}

module "task_state" {
  source   = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/task"
  resource = "some:resource::arn"
  comment  = "branch-task-state"
}

module "parallel" {
  source  = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/parallel"
  comment = "An example parallel state"
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
      start_at = "PassState"
      states = [
        {
          name       = "PassState"
          state_defn = module.pass_state.defn
        },
        {
          name       = "SucceedState"
          state_defn = module.succeed_state.defn
        }
      ]
    },
    {
      start_at = "TaskState"
      states = [
        {
          name       = "TaskState"
          state_defn = module.task_state.defn
        }
      ]
    }
  ]
}

output "parallel" {
  value = module.parallel.json
}