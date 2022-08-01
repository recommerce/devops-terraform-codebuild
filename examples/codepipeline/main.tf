locals {
    repository_branch = "main"
    repository_owner = "SPHTech-Platform"
    repository_name = "terraform-aws-codebuild"
    codestar_arn = "arn:aws:codestar-connections:us-east-1:123456789012:connection/aEXAMPLE-8aad-4d5d-8878-dfcab0bc441f"

    codebuild_name = "test-build-project"
    codebuild_output_artifact_name = "build_artifact"
    artifact_bucket_name = "test-project-artifact"
    

    codepipeline_name = "test-build-pipeline"
    kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/1234aaaa-bbbb-cccc-dddd-abcdabcdab"
}

resource "aws_iam_role" "codepipeline" {
  name               = "${local.codepipeline_name}-role"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_role.json

  inline_policy {
    name   = local.codepipeline_name
    policy = data.aws_iam_policy_document.codepipeline_inline_policy.json
  }
}


resource "aws_codepipeline" "this" {
  name     = local.codepipeline_name
  role_arn = aws_iam_role.codepipeline.arn
  encryption_key = local.kms_key_arn
  artifact_store {
    location = local.artifact_bucket_name
    type     = "S3"

    encryption_key {
      id   =  local.kms_key_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      category         = "Source"
      name             = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_artifact"]

      configuration = {
        BranchName       = local.repository_branch
        FullRepositoryId = "${local.repository_owner}/${local.repository_name}"
        ConnectionArn    = local.codebuild_name
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_artifact"]
      output_artifacts = [local.codebuild_output_artifact_name]

      configuration = {
        "ProjectName" = local.codebuild_name
      }
    }
  }

}

module "codebuild" {
    source = "../../"

    name = "build-project"
    description = "codebuild for test project"
    build_image = "aws/codebuild/standard:5.0"
    buildspec = "./buildspec.yml"
    artifacts_bucket_name = local.artifact_bucket_name

    artifacts = {
        type = "CODEPIPELINE"
    }

    environment_variables = [
        {
            name = "ENV"
            value = "sandbox"
        }
    ]
}

