variable "name" {
  type = string
}

# Common State Fields
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

variable "time_metric" {
  type    = string
  default = "Seconds"

  validation {
    condition     = can(contains(["Seconds", "TimeStamp", "SecondsPath", "TimeStampPath"], var.time_metric))
    error_message = "Var time_metric must be one of Seconds, TimeStamp, SecondsPath, TimeStampPath."
  }
}

variable "time_value" {
  default = null
}
