###======= GRAFANA OUTPUTS =======###
output "grafana_arn" {
  description = "The ARN of the Grafana Workspace"
  value       = aws_grafana_workspace.grafana[0].arn
}

output "grafana_endpoint" {
  description = "The endpoint of the Grafana Workspace"
  value       = aws_grafana_workspace.grafana[0].endpoint
}

output "grafana_version" {
  description = "The version of the Grafana Workspace"
  value       = aws_grafana_workspace.grafana[0].grafana_version
}

###======= PROMETHEUS OUTPUTS =======###

output "prometheus_workspaces" {
  description = "Prometheus Workspaces details"
  value = { for k, ws in aws_prometheus_workspace.prometheus : k => {
    alias               = ws.arn
    id                  = ws.id
    tags                = ws.tags
    prometheus_endpoint = ws.prometheus_endpoint
  } }
}

output "cloudwatch_log_groups" {
  description = "CloudWatch Log Groups details"
  value = { for k, lg in aws_cloudwatch_log_group.prometheus : k => {
    name = lg.name
    arn  = lg.arn
  } }
}

###======= IAM OUTPUTS =======###

output "grafana_iam_role_name" {
  description = "The name of the IAM role"
  value       = try(aws_iam_role.grafana[0].name, null)
}

output "grafana_iam_role_arn" {
  description = "The ARN of the IAM role"
  value       = try(aws_iam_role.grafana[0].arn, null)
}

output "prometheus_iam_role_name" {
  description = "The name of the IAM role"
  value       = try(aws_iam_role.prometheus[0].name, null)
}

output "prometheus_iam_role_arn" {
  description = "The ARN of the IAM role"
  value       = try(aws_iam_role.prometheus[0].arn, null)
}