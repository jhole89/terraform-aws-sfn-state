package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestMapState(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/map",
		Upgrade:      true,
	}

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Teardown
	defer terraform.Destroy(t, terraformOptions)

	// Test
	json := terraform.Output(t, terraformOptions, "json")
	assert.Equal(t, `{"mymap":{"Catch":[{"ErrorEquals":["States.ALL"],"Next":"Z","ResultsPath":null}],"Comment":"An example map state","End":true,"InputPath":null,"ItemsPath":"$","Iterator":{"StartAt":"Validate","States":[{"Validate":{"mylambdatask":{"Catch":[],"Comment":"An example task state","End":true,"HeartbeatSeconds":1,"InputPath":null,"OutputPath":null,"Parameters":null,"Resource":"arn:aws:lambda:us-east-1:123456789012:function:ship-val","ResultPath":null,"Retry":[],"TimeoutSeconds":60,"Type":"Task"}}},{"Validate2":{"mylambdatask":{"Catch":[],"Comment":"An example task state","End":true,"HeartbeatSeconds":1,"InputPath":null,"OutputPath":null,"Parameters":null,"Resource":"arn:aws:lambda:us-east-1:123456789012:function:ship-val","ResultPath":null,"Retry":[],"TimeoutSeconds":60,"Type":"Task"}}}]},"MaxConcurrency":0,"OutputPath":null,"Parameters":null,"ResultPath":null,"Retry":[{"BackoffRate":1.5,"ErrorEquals":["States.Timeout"],"IntervalSeconds":3,"MaxAttempts":2},{"BackoffRate":2,"ErrorEquals":["States.ALL"],"IntervalSeconds":1,"MaxAttempts":3}],"Type":"Map"}}`, json)

}
