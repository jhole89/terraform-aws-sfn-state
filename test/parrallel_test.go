package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestParallelState(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/parallel",
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
		`{"my_parallel_state":{"Branches":[{"StartAt":"my_pass_state","States":{"my_pass_state":{"Comment":"branch-pass-state","End":"true","InputPath":null,"OutputPath":null,"Parameters":null,"Result":null,"ResultPath":null,"Type":"Pass"},"my_succeed_state":{"Comment":"branch-succeed-state","InputPath":null,"OutputPath":null,"Type":"Succeed"}}},{"StartAt":"my_task_state","States":{"my_task_state":{"Catch":[],"Comment":"branch-task-state","End":"true","HeartbeatSeconds":null,"InputPath":null,"OutputPath":null,"Parameters":null,"Resource":"some:resource::arn","Result":null,"ResultPath":null,"Retry":[],"TimeoutSeconds":60,"Type":"Task"}}}],"Catch":[{"ErrorEquals":["States.ALL"],"Next":"Z","ResultsPath":null}],"Comment":"An example parallel state","InputPath":null,"Next":"NextState","OutputPath":null,"Parameters":null,"ResultPath":null,"Retry":[{"BackoffRate":1.5,"ErrorEquals":["States.Timeout"],"IntervalSeconds":3,"MaxAttempts":2},{"BackoffRate":2,"ErrorEquals":["States.ALL"],"IntervalSeconds":1,"MaxAttempts":3}],"Type":"Parallel"}}`,
		json,
	)

}
