module "pass" {
  source  = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/pass"
  comment = "An example pass state"
  next    = "NextState"
  result = {
    "x-datum" : 0.381018,
    "y-datum" : 622.2269926397355
  }
  result_path = "$.coords"
}

output "pass" {
  value = module.pass.json
}