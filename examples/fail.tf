module "fail" {
  source  = "../fail"
  comment = "An example fail state"
}

output "fail" {
  value = module.fail.json
}