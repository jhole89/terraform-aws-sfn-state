package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestHelloWorldState(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/hello-world",
		Upgrade:      true,
	}

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Teardown
	defer terraform.Destroy(t, terraformOptions)

	// Test
	json := terraform.Output(t, terraformOptions, "json")
	expected := `{` +
		`"Comment":"A Hello World example demonstrating various state types of the Amazon States Language",` +
		`"StartAt":"Pass",` +
		`"States":{` +
		  `"Hello World example?":{` +
		    `"Choices":[{"BooleanEquals":"false","Next":"No","Variable":"$.IsHelloWorldExample"},{"Next":"Yes","Not":{"BooleanEquals":"false","Variable":"$.IsHelloWorldExample"}}],` +
		    `"Comment":"A Choice state adds branching logic to a state machine. Choice rules can implement 16 different comparison operators, and can be combined using And, Or, and Not",` +
		    `"Default":"No",` +
		    `"InputPath":null,` +
		    `"OutputPath":null,` +
		    `"Type":"Choice"` +
		  `},` +
		  `"No":{"Cause":"Not Hello World","Comment":null,"Error":null,"Type":"Fail"},` +
		  `"Parallel State":{` +
		  `"Branches":[` +
		    `{"StartAt":"hello","States":{"hello":{"Comment":null,"End":"true","InputPath":null,"OutputPath":null,"Parameters":null,"Result":null,"ResultPath":null,"Type":"Pass"}}},` +
		    `{"StartAt":"world","States":{"world":{"Comment":null,"End":"true","InputPath":null,"OutputPath":null,"Parameters":null,"Result":null,"ResultPath":null,"Type":"Pass"}}}` +
		  `],` +
		  `"Catch":[],` +
		  `"Comment":"A Parallel state can be used to create parallel branches of execution in your state machine.",` +
		  `"InputPath":null,` +
		  `"Next":"helloworld",` +
		  `"OutputPath":null,` +
		  `"Parameters":null,` +
		  `"ResultPath":null,` +
		  `"Retry":[],"Type":"Parallel"` +
		`},` +
		`"Pass":{` +
		  `"Comment":"A Pass state passes its input to its output, without performing work. Pass states are useful when constructing and debugging state machines.",` +
          `"InputPath":null,` +
		  `"Next":"Hello World example?",` +
		  `"OutputPath":null,` +
		  `"Parameters":null,` +
		  `"Result":null,` +
		  `"ResultPath":null,` +
		  `"Type":"Pass"` +
		`},` +
		`"Wait 3 sec":{` +
		  `"Comment":"A Wait state delays the state machine from continuing for a specified time.",` +
		  `"InputPath":null,` +
		  `"Next":"Parallel State",` +
		  `"OutputPath":null,` +
		  `"Seconds":3,"Type":"Wait"`+
		`},` +
		`"Yes":{` +
		  `"Comment":null,` +
		  `"InputPath":null,` +
		  `"Next":"Wait 3 sec",` +
		  `"OutputPath":null,` +
		  `"Parameters":null,` +
		  `"Result":null,` +
		  `"ResultPath":null,` +
		  `"Type":"Pass"` +
		`},` +
		`"helloworld":{` +
		  `"Comment":null,` +
		  `"End":"true",` +
		  `"InputPath":null,` +
		  `"OutputPath":null,` +
		  `"Parameters":null,` +
		  `"Result":null,` +
		  `"ResultPath":null,` +
		  `"Type":"Pass"` +
		`}` +
		`}}`
	assert.Equal(t, expected, json)

}


