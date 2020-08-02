module "fail" {
  source  = "../../modules/fail"
  comment = "An example fail state"
  name    = "FailState"
  cause   = "Kaiju attack"
  error   = "ErrorA"
}

output "json" {
  value = module.fail.json
}
