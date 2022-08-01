# Terraform Modules Template

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.24 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_codebuild_service_role"></a> [codebuild\_service\_role](#module\_codebuild\_service\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> 5.2.0 |
| <a name="module_codebuild_service_role_policy"></a> [codebuild\_service\_role\_policy](#module\_codebuild\_service\_role\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | ~> 5.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_policy_arns"></a> [additional\_policy\_arns](#input\_additional\_policy\_arns) | Additional policies to be added to the IAM role. | `list(string)` | `[]` | no |
| <a name="input_artifacts"></a> [artifacts](#input\_artifacts) | Artifacts configuration block. | <pre>object({<br>    type     = string # Valid values are CODEPIPELINE, NO_ARTIFACTS, S3<br>    name     = optional(string)<br>    location = optional(string)<br>  })</pre> | <pre>{<br>  "type": "NO_ARTIFACTS"<br>}</pre> | no |
| <a name="input_artifacts_bucket_name"></a> [artifacts\_bucket\_name](#input\_artifacts\_bucket\_name) | Name of the artifacts bucket | `string` | `""` | no |
| <a name="input_build_compute_type"></a> [build\_compute\_type](#input\_build\_compute\_type) | Compute resources the build project will use. | `string` | `"BUILD_GENERAL1_MEDIUM"` | no |
| <a name="input_build_image"></a> [build\_image](#input\_build\_image) | Docker image to use for this build project. | `string` | `"aws/codebuild/standard:6.0"` | no |
| <a name="input_build_image_pull_credentials_type"></a> [build\_image\_pull\_credentials\_type](#input\_build\_image\_pull\_credentials\_type) | Type of credentials AWS CodeBuild uses to pull images in your build. | `string` | `"CODEBUILD"` | no |
| <a name="input_build_timeout"></a> [build\_timeout](#input\_build\_timeout) | Number of minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. | `number` | `60` | no |
| <a name="input_build_type"></a> [build\_type](#input\_build\_type) | Type of build environment to use for related builds. | `string` | `"LINUX_CONTAINER"` | no |
| <a name="input_buildspec"></a> [buildspec](#input\_buildspec) | The build spec declaration to use for this build project's related builds. | `string` | `""` | no |
| <a name="input_cache"></a> [cache](#input\_cache) | Cache configuration block. | <pre>object({<br>    type     = optional(string)       # Valid values: NO_CACHE, LOCAL, S3. Defaults to NO_CACHE.<br>    modes    = optional(list(string)) # Required when cache type is LOCAL<br>    location = optional(string)       # Required when cache type is S3<br>  })</pre> | `{}` | no |
| <a name="input_codestar_arn"></a> [codestar\_arn](#input\_codestar\_arn) | Codestar ARN for connecting to Github. | `string` | n/a | yes |
| <a name="input_create_service_role"></a> [create\_service\_role](#input\_create\_service\_role) | Create new IAM service role and policy if `true`. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Short description of the project. | `string` | n/a | yes |
| <a name="input_encryption_key_arn"></a> [encryption\_key\_arn](#input\_encryption\_key\_arn) | AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts. | `string` | `null` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment Variables for CodeBuild Project. | <pre>list(object({<br>    name  = string<br>    value = string<br>    type  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | CodeBuild Project's name. | `string` | n/a | yes |
| <a name="input_privileged_mode"></a> [privileged\_mode](#input\_privileged\_mode) | Whether to enable running the Docker daemon inside a Docker container. | `bool` | `false` | no |
| <a name="input_report_build_status"></a> [report\_build\_status](#input\_report\_build\_status) | Whether to report the status of a build's start and finish to your source provider. This option is only valid when the source\_type is BITBUCKET or GITHUB. | `bool` | `false` | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | Existing CodeBuild service role arn. | `string` | `null` | no |
| <a name="input_service_role_name"></a> [service\_role\_name](#input\_service\_role\_name) | Service Role Name. | `string` | `""` | no |
| <a name="input_source_location"></a> [source\_location](#input\_source\_location) | Location of the source code from git or s3. | `string` | `""` | no |
| <a name="input_source_type"></a> [source\_type](#input\_source\_type) | Type of repository that contains the source code to be built. | `string` | `"CODEPIPELINE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | CodeBuild ARN. |
| <a name="output_id"></a> [id](#output\_id) | CodeBuild Id. |
| <a name="output_service_role_arn"></a> [service\_role\_arn](#output\_service\_role\_arn) | CodeBuild service role ARN. |
<!-- END_TF_DOCS -->
