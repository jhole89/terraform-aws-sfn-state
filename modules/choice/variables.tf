variable "name" {
  type = string
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

variable "choices" {
  type = list(object({
    operator = string
    next     = string
    rules = list(object({
      variable = string
      rule     = string
      value    = any
    }))
  }))
}

variable "default" {
  type = string
}