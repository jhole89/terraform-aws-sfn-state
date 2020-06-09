module "succeed" {
  source  = "../../modules/succeed"
  name = "my_succeed_state"
  comment = "An example succeed state"
}

output "succeed" {
  value = module.succeed.json
}