module "pass" {
  source  = "../../modules/pass"
  name    = "my_pass_state"
  comment = "An example pass state"
  next    = "NextState"
  result = {
    "x-datum" : 0.381018,
    "y-datum" : 622.2269926397355
  }
  result_path = "$.coords"
}
