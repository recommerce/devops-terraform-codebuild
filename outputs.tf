output "arn" {
  description = "CodeBuild ARN."
  value       = aws_codebuild_project.this.arn
}

output "id" {
  description = "CodeBuild Id."
  value       = aws_codebuild_project.this.id
}

output "service_role_arn" {
  description = "CodeBuild service role ARN."
  value       = var.create_service_role ? module.codebuild_service_role.iam_role_arn : null
}

output "name" {
  description = "CodeBuild name."
  value       = aws_codebuild_project.this.name
}
