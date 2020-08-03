package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestChoiceState(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/choice",
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
		`{"ChoiceStateX":{"Choices":[{"Next":"Private","StringEquals":"Private","Variable":"$.type"},{"Next":"Public","Not":{"StringEquals":"Private","Variable":"$.type"}},{"And":[{"NumericGreaterThanEquals":20,"Variable":"$.value"},{"NumericLessThan":30,"Variable":"$.value"}],"Next":"ValueInTwenties"}],"Comment":"An example choice state","Default":"DefaultState","InputPath":null,"OutputPath":null,"Type":"Choice"}}`,
		json,
	)

}
