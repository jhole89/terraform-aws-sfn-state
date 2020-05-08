module "base" {
  source      = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/base"
  comment     = var.comment
  input_path  = var.input_path
  output_path = var.output_path
}

locals {

  states = [for state in var.iterator.states : {
    (state.name) = 1
  }]

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

  default_catch = {
    result_path = null
  }
  catches = [for catch in var.catch : merge(local.default_catch, catch)]

  local_defn = {
    Type = "Map"
    var.next != null ? "Next" : "End" = var.next != null ? var.next : true
    Parameters = var.parameters
    ResultPath = var.result_path
    MaxConcurrency = var.max_concurrency
    ItemsPath = var.items_path

    Retry = [
    for retry in local.retries : {
      ErrorEquals = retry.error_equals
      IntervalSeconds = retry.interval_seconds
      MaxAttempts = retry.max_attempts
      BackoffRate = retry.backoff_rate
    }
    ]
    Catch = [
    for catch in local.catches : {
      ErrorEquals = catch.error_equals
      Next = catch.next
      ResultsPath = catch.result_path
    }
    ]

    Iterator = {
      StartAt = var.iterator.start_at
      //      States = local.states
      //    }
      States = [for state in var.iterator.states: {
        (state.name) = state.state_defn
      }]
    }
  }

  state_defn = merge(local.local_defn, module.base.defn)
  json       = jsonencode(local.state_defn)
}