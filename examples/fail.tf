module "fail" {
  source  = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/fail"
  comment = "An example fail state"
}

output "fail" {
  value = module.fail.json
}