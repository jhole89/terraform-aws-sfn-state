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
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "time_value" {
  default = null
}
