package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"os"
	"testing"
	"github.com/gruntwork-io/terratest/modules/logger"
)

// TestExamplesComplete tests a typical deployment of this module
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples/complete",
		BackendConfig: map[string]interface{}{
			"bucket": os.Getenv("TF_STATE_BUCKET"),
			"key":    os.Getenv("TF_VAR_git"),
		},
		EnvVars: map[string]string{},
		Vars:    map[string]interface{}{},
	}
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)
	logger.Log(t, "Creating AWS Session")

}
