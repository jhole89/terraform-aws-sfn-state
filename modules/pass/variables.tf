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
