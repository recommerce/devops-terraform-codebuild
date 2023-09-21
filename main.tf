resource "aws_codebuild_project" "this" {
  name          = "${var.name}-${var.env}"
  description   = coalesce(var.description, var.name)
  build_timeout = var.build_timeout

  service_role   = var.create_service_role ? module.codebuild_service_role.iam_role_arn : var.service_role_arn
  encryption_key = var.encryption_key_arn

  artifacts {
    type     = var.artifacts.type
    name     = var.artifacts.name
    location = var.artifacts.location
  }

  cache {
    type     = var.cache.type
    modes    = var.cache.modes
    location = var.cache.location
  }

  environment {
    compute_type                = var.build_compute_type
    image                       = var.build_image
    image_pull_credentials_type = var.build_image_pull_credentials_type
    type                        = var.build_type
    privileged_mode             = var.privileged_mode

    dynamic "environment_variable" {
      for_each = var.environment_variables

      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = environment_variable.value.type
      }
    }
  }

  source {
    buildspec           = var.buildspec
    type                = var.source_type
    location            = var.source_location
    report_build_status = var.report_build_status
  }
}
