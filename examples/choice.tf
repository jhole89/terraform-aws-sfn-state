module "choice" {
  source  = "github.com/jhole89/terraform-aws-sfn-state.git?ref=master/choice"
  comment = "An example choice state"
  choices = [
    {
      operator = null
      next     = "Private"
      rules = [
        {
          variable = "$.type"
          rule     = "StringEquals"
          value    = "Private"
        }
      ]
    },
    {
      operator = "Not"
      next     = "Public"
      rules = [
        {
          variable = "$.type"
          rule     = "StringEquals"
          value    = "Private"
        }
      ]
      }, {
      operator = "And"
      next     = "ValueInTwenties"
      rules = [
        {
          variable = "$.value",
          rule     = "NumericGreaterThanEquals"
          value    = "20"
          }, {
          variable = "$.value",
          rule     = "NumericLessThan"
          value    = "30"
        }
      ]
    }
  ]
}

output "choice" {
  value = module.choice.json
}