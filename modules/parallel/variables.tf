variable "name" {
  type = string
}

variable "next" {
  type    = string
  default = null
}

variable "comment" {
  type    = string
  default = ""
}

variable "input_path" {
  type    = string
  default = "$"
}

variable "output_path" {
  type    = string
  default = "$"
}

variable "result" {
  default = null
}

variable "result_path" {
  type    = string
  default = "$"
}

variable "parameters" {
  default = null
}

variable "retry" {
  type = list(object({
    error_equals     = list(string)
    interval_seconds = number
    max_attempts     = number
    backoff_rate     = number
  }))
  default = []
}

variable "catch" {
  type = list(object({
    error_equals = list(string)
    next         = string
  }))
  default = []
}

variable "branches" {
  description = <<EOF
    To avoid a go panic of inconsistent map elements a dynamic type must be used, but we aim to follow the below type defn

      type = list(object({
        start_at = string
        states = list(object({
          name = string
          state_defn = any
        }))
      }))
  EOF
}
