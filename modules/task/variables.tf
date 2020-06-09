variable "name" {
  type = string
}

variable "next" {
  type    = string
  default = null
}

variable "comment" {
  type    = string
  default = null
}

variable "input_path" {
  type    = string
  default = null
}

variable "output_path" {
  type    = string
  default = null
}

variable "result" {
  default = null
}

variable "result_path" {
  type    = string
  default = null
}

variable "parameters" {
  default = null
}

variable "resource" {
  type = string
}

variable "timeout_seconds" {
  type    = number
  default = 60
}

variable "heartbeat_seconds" {
  type    = number
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