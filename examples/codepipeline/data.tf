data "aws_iam_policy_document" "codepipeline_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "codepipeline_codestar" {
  statement {
    resources = [local.codestar_arn]
    actions   = ["codestar-connections:UseConnection"]
  }
}

data "aws_iam_policy_document" "codepipeline_codebuild" {
  statement {
    resources = [module.codebuild.arn]

    actions = [
      "codebuild:StartBuild",
      "codebuild:BatchGetBuilds",
    ]
  }
}

data "aws_iam_policy_document" "codepipeline_s3" {
  statement {
    resources = [
      "arn:aws:s3:::${local.artifact_bucket_name}/*",
    ]

    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
  }
}

data "aws_iam_policy_document" "codepipeline_inline_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.codepipeline_codestar.json,
    data.aws_iam_policy_document.codepipeline_codebuild.json,
    data.aws_iam_policy_document.codepipeline_s3.json,
  ]
}
