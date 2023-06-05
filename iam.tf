locals {
  grafana_role_name   = var.role_name != null ? format("%s-%s", var.role_name, "grafana") : null
  grafana_role_prefix = var.role_name_prefix != null ? format("%s-%s", var.role_name_prefix, "grafana") : null
}



resource "aws_iam_role" "grafana" {
  count       = var.create_role ? 1 : 0
  name        = local.grafana_role_name
  name_prefix = module.short-name[0].result
  path        = var.role_path
  description = var.role_description

  assume_role_policy    = data.aws_iam_policy_document.grafana_assume_role[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.role_permissions_boundary_arn
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "grafana_cloudwatch" {
  count      = contains(var.grafana_data_sources, "CLOUDWATCH") ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonGrafanaCloudWatchAccess"
  role       = aws_iam_role.grafana[0].name
}



module "short-name" {
  count      = local.grafana_role_prefix != null ? 1 : 0
  source     = "axetrading/short-name/null"
  version    = "1.0.0"
  max_length = 38
  value      = local.grafana_role_prefix
}
