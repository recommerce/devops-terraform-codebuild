variable "name" {
  description = "CodeBuild Project's name."
  type        = string
}

variable "env" {
  description = "Project's env."
  type        = string
}

variable "description" {
  description = "Short description of the project."
  type        = string
}

variable "build_timeout" {
  description = "Number of minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed."
  type        = number
  default     = 60
}

variable "create_service_role" {
  description = "Create new IAM service role and policy if `true`."
  type        = bool
  default     = true
}

variable "service_role_arn" {
  description = "Existing CodeBuild service role arn."
  type        = string
  default     = null
}

variable "service_role_name" {
  description = "Service Role Name."
  type        = string
  default     = ""
}

variable "additional_policy_arns" {
  description = "Additional policies to be added to the IAM role."
  type        = list(string)
  default     = []
}

variable "encryption_key_arn" {
  description = "AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts."
  type        = string
  default     = null
}

variable "artifacts" {
  description = "Artifacts configuration block."
  type = object({
    type     = string # Valid values are CODEPIPELINE, NO_ARTIFACTS, S3
    name     = optional(string)
    location = optional(string)
  })
  default = {
    type = "NO_ARTIFACTS"
  }
}

variable "artifacts_bucket_name" {
  description = "Name of the artifacts bucket"
  type        = string
  default     = ""
}

variable "cache" {
  description = "Cache configuration block."
  type = object({
    type     = optional(string)       # Valid values: NO_CACHE, LOCAL, S3. Defaults to NO_CACHE.
    modes    = optional(list(string)) # Required when cache type is LOCAL
    location = optional(string)       # Required when cache type is S3
  })
  default = {}
}

variable "build_compute_type" {
  description = "Compute resources the build project will use."
  type        = string
  default     = "BUILD_GENERAL1_MEDIUM"
}

variable "build_image" {
  description = "Docker image to use for this build project."
  type        = string
  default     = "aws/codebuild/standard:6.0"
}

variable "build_image_pull_credentials_type" {
  description = "Type of credentials AWS CodeBuild uses to pull images in your build."
  type        = string
  default     = "CODEBUILD"
}

variable "privileged_mode" {
  description = "Whether to enable running the Docker daemon inside a Docker container."
  type        = bool
  default     = false
}

variable "build_type" {
  description = "Type of build environment to use for related builds."
  type        = string
  default     = "LINUX_CONTAINER"
}

variable "environment_variables" {
  description = "Environment Variables for CodeBuild Project."
  type = list(object({
    name  = string
    value = string
    type  = optional(string)
  }))
}

variable "buildspec" {
  description = "The build spec declaration to use for this build project's related builds."
  type        = string
  default     = ""
}

variable "source_type" {
  description = "Type of repository that contains the source code to be built."
  type        = string
  default     = "CODEPIPELINE"
}

variable "source_location" {
  description = "Location of the source code from git or s3."
  type        = string
  default     = ""
}

variable "report_build_status" {
  description = "Whether to report the status of a build's start and finish to your source provider. This option is only valid when the source_type is BITBUCKET or GITHUB."
  type        = bool
  default     = false
}

variable "additional_iam" {
  description = "Additional IAM Policy Document for Codebuild"
  type        = list(any)
  default     = []
}
