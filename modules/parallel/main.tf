module "base" {
  source      = "../../modules/base"
  comment     = var.comment
  input_path  = var.input_path
  output_path = var.output_path
}

locals {

  default_retry = {
    interval_seconds = 1
    max_attempts     = 3
    backoff_rate     = 2.0
  }

  retries = [
    for retry in var.retry : {
      error_equals     = retry.error_equals
      interval_seconds = coalesce(retry.interval_seconds, local.default_retry.interval_seconds)
      max_attempts     = coalesce(retry.max_attempts, local.default_retry.max_attempts)
      backoff_rate     = coalesce(retry.backoff_rate, local.default_retry.backoff_rate)
    }
  ]

  catches = [for catch in var.catch : merge({ result_path = null }, catch)]

  local_defn = {
    Type                              = "Parallel"
    var.next != null ? "Next" : "End" = try(tobool(var.next) == null, var.next)
    Parameters                        = var.parameters
    ResultPath                        = var.result_path
    Retry = [
      for try in local.retries : {
        ErrorEquals     = try.error_equals
        IntervalSeconds = try.interval_seconds
        MaxAttempts     = try.max_attempts
        BackoffRate     = try.backoff_rate
      }
    ]
    Catch = [
      for catch in local.catches : {
        ErrorEquals = catch.error_equals
        Next        = catch.next
        ResultsPath = catch.result_path
      }
    ]
    Branches = [for branch in var.branches : {
      StartAt = branch.start_at
      States  = merge([for state in branch.states : state]...)
    }]
  }

  state_defn = { (var.name) = merge(local.local_defn, module.base.defn) }
  json       = jsonencode(local.state_defn)
}