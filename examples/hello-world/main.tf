module "pass" {
  source  = "../../modules/pass"
  name    = "Pass"
  comment = "A Pass state passes its input to its output, without performing work. Pass states are useful when constructing and debugging state machines."
  next    = module.choice.name
}

module "choice" {
  source  = "../../modules/choice"
  name    = "Hello World example?"
  comment = "A Choice state adds branching logic to a state machine. Choice rules can implement 16 different comparison operators, and can be combined using And, Or, and Not"
  choices = [{
    operator = "Not"
    next     = module.yes.name
    rules = [
      {
        variable = "$.IsHelloWorldExample"
        rule     = "BooleanEquals"
        value    = false
      }
    ]
    }, {
    operator = null
    next     = module.no.name
    rules = [
      {
        variable = "$.IsHelloWorldExample"
        rule     = "BooleanEquals"
        value    = false
      }
    ]
  }]
  default = module.no.name
}

module "yes" {
  source = "../../modules/pass"
  name   = "Yes"
  next   = module.wait3sec.name
}

module "no" {
  source = "../../modules/fail"
  name   = "No"
  cause  = "Not Hello World"
}

module "wait3sec" {
  source      = "../../modules/wait"
  name        = "Wait 3 sec"
  comment     = "A Wait state delays the state machine from continuing for a specified time."
  time_metric = "Seconds"
  time_value  = 3
  next        = module.parallel.name
}

module "hello" {
  source = "../../modules/pass"
  name   = "hello"
}

module "world" {
  source = "../../modules/pass"
  name   = "world"
}

module "helloworld" {
  source = "../../modules/pass"
  name   = "helloworld"
}

module "parallel" {
  source  = "../../modules/parallel"
  name    = "Parallel State"
  comment = "A Parallel state can be used to create parallel branches of execution in your state machine."
  next    = module.helloworld.name
  branches = [
    {
      start_at = module.hello.name
      states = [
        module.hello.defn,
      ]
    },
    {
      start_at = module.world.name
      states = [
        module.world.defn,
      ]
    }
  ]
}

module "stepfn" {
  source   = "../../"
  comment  = "A Hello World example demonstrating various state types of the Amazon States Language"
  start_at = module.pass.name
  states = [
    module.pass.defn,
    module.choice.defn,
    module.yes.defn,
    module.no.defn,
    module.wait3sec.defn,
    module.parallel.defn,
    module.helloworld.defn,
  ]
}

output "json" {
  value = module.stepfn.json
}

output "raw" {
  value = module.stepfn.raw
}