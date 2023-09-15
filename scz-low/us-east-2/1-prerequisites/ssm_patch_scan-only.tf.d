resource "aws_ssm_patch_baseline" "example_baseline" {
    name            = "example-baseline"
    description     = "Patch baseline for scan-only operation"
    operating_system = "WINDOWS"

 # approved_patches_compliance_level = "CRITICAL" # Comment this out
  approved_patches_enable_non_security = false

  global_filter {
      key = "CLASSIFICATION"
      values = ["Updates"]
  }

  approval_rule {
    patch_filter {
      key = "PRIORITY"
      values = ["CRITICAL"]
    }
    compliance_level = "UNSPECIFIED"
    enable_non_security = false
  }

  # approval_rule {
  #   patch_rule {
  #     patch_filter_group {
  #       patch_filter {
  #          key = "PRIORITY"
  #         # values = ["CRITICAL", "High", "Medium”, "Low”]
  #          values = ["CRITICAL"]
  #       }
  #     }
#    }
#  }
}
