package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestWaitStateSeconds(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/wait/seconds",
		Upgrade:      true,
	}

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Teardown
	defer terraform.Destroy(t, terraformOptions)

	// Test
	json := terraform.Output(t, terraformOptions, "json")
	assert.Equal(t, `{"wait_ten_seconds":{"Comment":"An example wait with seconds","InputPath":"$","Next":"NextState","OutputPath":"$","Seconds":10,"Type":"Wait"}}`, json)

}

func TestWaitStateSecondsPath(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/wait/seconds_path",
		Upgrade:      true,
	}

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Teardown
	defer terraform.Destroy(t, terraformOptions)

	// Test
	json := terraform.Output(t, terraformOptions, "json")
	assert.Equal(t, `{"wait_until":{"Comment":"An example wait with seconds path","End":true,"InputPath":"$","OutputPath":"$","SecondsPath":"$.seconds","Type":"Wait"}}`, json)

}

func TestWaitStateTimestamp(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/wait/timestamp",
		Upgrade:      true,
	}

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Teardown
	defer terraform.Destroy(t, terraformOptions)

	// Test
	json := terraform.Output(t, terraformOptions, "json")
	assert.Equal(t, `{"wait_until":{"Comment":"An example wait with timestamp","InputPath":"$","Next":"NextState","OutputPath":"$","Timestamp":"2016-03-14T01:59:00Z","Type":"Wait"}}`, json)

}

func TestWaitStateTimestampPath(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/wait/timestamp_path",
		Upgrade:      true,
	}

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Teardown
	defer terraform.Destroy(t, terraformOptions)

	// Test
	json := terraform.Output(t, terraformOptions, "json")
	assert.Equal(t, `{"wait_until":{"Comment":"An example wait with timestamp path","InputPath":"$","Next":"NextState","OutputPath":"$","TimestampPath":"$.expirydate","Type":"Wait"}}`, json)

}
