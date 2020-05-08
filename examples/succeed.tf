module "succeed" {
  source  = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/succeed"
  comment = "An example succeed state"
}

output "succeed" {
  value = module.succeed.json
}