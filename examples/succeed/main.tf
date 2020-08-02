module "succeed" {
  source  = "../../modules/succeed"
  name    = "SuccessState"
  comment = "An example succeed state"
}

output "json" {
  value = module.succeed.json
}