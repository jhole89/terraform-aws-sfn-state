module "base" {
  source      = "../../modules/base"
  comment     = var.comment
  input_path  = var.input_path
  output_path = var.output_path
}

locals {

  no_op_states = [
    for m in var.choices : (
      m.operator == null ? [{ Next : m.next, Variable : m.rules[0].variable, (m.rules[0].rule) : try(tonumber(m.rules[0].value), tobool(m.rules[0].value), tostring(m.rules[0].value)) }] : []
    )
  ]

  single_op_states = [
    for m in var.choices : (
      m.operator == null ? [] : (
        length(m.rules) > 1 ? [] : [
          {
            (m.operator) : {
              Variable : m.rules[0].variable,
              (m.rules[0].rule) : try(tonumber(m.rules[0].value), tobool(m.rules[0].value), tostring(m.rules[0].value)),
            },
            Next : m.next
          }
        ]
      )
    )
  ]

  multi_op_states = [
    for m in var.choices : (
      m.operator == null ? [] : (
        length(m.rules) > 1 ? [
          {
            (m.operator) : [
              for n in m.rules : {
                Variable : n.variable,
                (n.rule) : try(tonumber(n.value), tobool(n.value), tostring(n.value)),
              }
            ],
            Next : m.next,
          }
        ] : []
      )
    )
  ]

  local_defn = {
    Type    = "Choice"
    Default = var.default
    Choices = concat(flatten(local.no_op_states), flatten(local.single_op_states), flatten(local.multi_op_states))
  }

  state_defn = { (var.name) = merge(local.local_defn, module.base.defn) }
  json       = jsonencode(local.state_defn)
}
