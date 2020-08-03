package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestPassState(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/pass",
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
		`{"No-op":{"Comment":"An example pass state","End":true,"InputPath":null,"OutputPath":null,"Parameters":null,"Result":{"x-datum":0.381018,"y-datum":622.2269926397355},"ResultPath":"$.coords","Type":"Pass"}}`,
		json,
	)

}
