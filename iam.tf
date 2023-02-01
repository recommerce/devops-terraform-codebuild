module "codebuild_service_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.2.0"

  create_role = var.create_service_role

  trusted_role_services = [
    "codebuild.amazonaws.com",
  ]

  role_name = coalesce(var.service_role_name, "${var.name}-iam-role")

  role_requires_mfa = false
  custom_role_policy_arns = concat([
    module.codebuild_service_role_policy.arn,
  ], var.additional_policy_arns)
}

module "codebuild_service_role_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.2.0"

  create_policy = var.create_service_role

  name        = "${var.name}-iam-policy"
  path        = "/"
  description = "${var.name} IAM Policy"
  policy      = data.aws_iam_policy_document.codebuild_inline_policy.json
}

data "aws_iam_policy_document" "codebuild_inline_policy" {
  source_policy_documents = concat([
    data.aws_iam_policy_document.codebuild.json,
  ], var.codebuild_additional_iam)
}

data "aws_iam_policy_document" "codebuild" {
  statement {
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.name}:log-stream:*",
    ]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }

  dynamic "statement" {
    for_each = var.artifacts_bucket_name != "" ? [1] : []

    content {
      resources = [
        "arn:aws:s3:::${var.artifacts_bucket_name}/*",
      ]

      actions = [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:PutObject",
      ]
    }
  }
}
