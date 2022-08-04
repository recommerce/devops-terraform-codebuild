
module "codebuild" {
  source = "../../"

  name        = "standalone-build"
  description = "codebuild for standalone-project"

  artifacts = {
    type = "S3"
  }

  environment_variables = [
    {
      name  = "ENV"
      value = "sandbox"
    }
  ]
}
