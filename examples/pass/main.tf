module "pass" {
  source  = "../../modules/pass"
  name    = "No-op"
  comment = "An example pass state"
  next    = "End"
  result = {
    "x-datum" : 0.381018,
    "y-datum" : 622.2269926397355
  }
  result_path = "$.coords"
}

output "json" {
  value = module.pass.json
}
