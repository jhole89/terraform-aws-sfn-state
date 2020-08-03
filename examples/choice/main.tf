module "choice" {
  source  = "../../modules/choice"
  comment = "An example choice state"
  name    = "ChoiceStateX"
  default = "DefaultState"
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
          value    = 20
          }, {
          variable = "$.value",
          rule     = "NumericLessThan"
          value    = 30
        }
      ]
    }
  ]
}

output "json" {
  value = module.choice.json
}
