module "succeed" {
  source  = "../succeed"
  comment = "An example succeed state"
}

output "succeed" {
  value = module.succeed.json
}