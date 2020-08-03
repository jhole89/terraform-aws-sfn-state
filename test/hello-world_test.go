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
		`"Choices":[{"BooleanEquals":false,"Next":"No","Variable":"$.IsHelloWorldExample"},{"Next":"Yes","Not":{"BooleanEquals":false,"Variable":"$.IsHelloWorldExample"}}],` +
		`"Comment":"A Choice state adds branching logic to a state machine. Choice rules can implement 16 different comparison operators, and can be combined using And, Or, and Not",` +
		`"Default":"No",` +
		`"InputPath":"$",` +
		`"OutputPath":"$",` +
		`"Type":"Choice"` +
		`},` +
		`"No":{"Cause":"Not Hello World","Comment":"","Error":null,"Type":"Fail"},` +
		`"Parallel State":{` +
		`"Branches":[` +
		`{"StartAt":"hello","States":{"hello":{"Comment":"","End":true,"InputPath":"$","OutputPath":"$","Parameters":null,"Result":null,"ResultPath":"$","Type":"Pass"}}},` +
		`{"StartAt":"world","States":{"world":{"Comment":"","End":true,"InputPath":"$","OutputPath":"$","Parameters":null,"Result":null,"ResultPath":"$","Type":"Pass"}}}` +
		`],` +
		`"Catch":[],` +
		`"Comment":"A Parallel state can be used to create parallel branches of execution in your state machine.",` +
		`"InputPath":"$",` +
		`"Next":"helloworld",` +
		`"OutputPath":"$",` +
		`"Parameters":null,` +
		`"ResultPath":"$",` +
		`"Retry":[],"Type":"Parallel"` +
		`},` +
		`"Pass":{` +
		`"Comment":"A Pass state passes its input to its output, without performing work. Pass states are useful when constructing and debugging state machines.",` +
		`"InputPath":"$",` +
		`"Next":"Hello World example?",` +
		`"OutputPath":"$",` +
		`"Parameters":null,` +
		`"Result":null,` +
		`"ResultPath":"$",` +
		`"Type":"Pass"` +
		`},` +
		`"Wait 3 sec":{` +
		`"Comment":"A Wait state delays the state machine from continuing for a specified time.",` +
		`"InputPath":"$",` +
		`"Next":"Parallel State",` +
		`"OutputPath":"$",` +
		`"Seconds":3,"Type":"Wait"` +
		`},` +
		`"Yes":{` +
		`"Comment":"",` +
		`"InputPath":"$",` +
		`"Next":"Wait 3 sec",` +
		`"OutputPath":"$",` +
		`"Parameters":null,` +
		`"Result":null,` +
		`"ResultPath":"$",` +
		`"Type":"Pass"` +
		`},` +
		`"helloworld":{` +
		`"Comment":"",` +
		`"End":true,` +
		`"InputPath":"$",` +
		`"OutputPath":"$",` +
		`"Parameters":null,` +
		`"Result":null,` +
		`"ResultPath":"$",` +
		`"Type":"Pass"` +
		`}` +
		`}}`
	assert.Equal(t, expected, json)

}
