package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestTaskState(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/task",
		Upgrade:      true,
	}

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Teardown
	defer terraform.Destroy(t, terraformOptions)

	// Test
	json := terraform.Output(t, terraformOptions, "json")
	assert.Equal(
		t,
		`{"TaskState":{"Catch":[{"ErrorEquals":["States.ALL"],"Next":"Z","ResultsPath":null}],"Comment":"An example task state","HeartbeatSeconds":60,"InputPath":null,"Next":"NextState","OutputPath":null,"Parameters":null,"Resource":"arn:aws:states:us-east-1:123456789012:task:HelloWorld","ResultPath":null,"Retry":[{"BackoffRate":1.5,"ErrorEquals":["States.Timeout"],"IntervalSeconds":3,"MaxAttempts":2},{"BackoffRate":2,"ErrorEquals":["States.ALL"],"IntervalSeconds":1,"MaxAttempts":3}],"TimeoutSeconds":300,"Type":"Task"}}`,
		json,
	)

}
