locals {
  grafana_role_name   = var.role_name != null ? format("%s-%s", var.role_name, "grafana") : null
  grafana_role_prefix = var.role_name_prefix != null && var.permission_type == "CUSTOMER_MANAGED" ? format("%s-%s", var.role_name_prefix, "grafana") : null
  create_policies     = var.permission_type == "CUSTOMER_MANAGED" && var.account_access_type == "CURRENT_ACCOUNT"
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

resource "aws_iam_policy" "cloudwatch_metrics" {
  count       = contains(var.grafana_data_sources, "CLOUDWATCH") && local.create_policies ? 1 : 0
  name_prefix = "grafana-cloudwatch-metrics-"
  path        = var.role_path
  policy      = data.aws_iam_policy_document.cloudwatch_metrics[0].json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "cloudwatch_metrics" {
  count      = contains(var.grafana_data_sources, "CLOUDWATCH") && local.create_policies ? 1 : 0
  role       = aws_iam_role.grafana[0].name
  policy_arn = aws_iam_policy.cloudwatch_metrics[0].arn
}

resource "aws_iam_policy" "cloudwatch_logs" {
  count       = contains(var.grafana_data_sources, "CLOUDWATCH") && local.create_policies ? 1 : 0
  name_prefix = "grafana-cloudwatch-logs-"
  path        = var.role_path
  policy      = data.aws_iam_policy_document.cloudwatch_logs[0].json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  count      = contains(var.grafana_data_sources, "CLOUDWATCH") && local.create_policies ? 1 : 0
  role       = aws_iam_role.grafana[0].name
  policy_arn = aws_iam_policy.cloudwatch_logs[0].arn
}

resource "aws_iam_policy" "prometheus" {
  count       = contains(var.grafana_data_sources, "PROMETHEUS") && local.create_policies ? 1 : 0
  name_prefix = "grafana-prometheus-"
  path        = var.role_path
  policy      = data.aws_iam_policy_document.prometheus[0].json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "prometheus" {
  count      = contains(var.grafana_data_sources, "PROMETHEUS") && local.create_policies ? 1 : 0
  role       = aws_iam_role.grafana[0].name
  policy_arn = aws_iam_policy.prometheus[0].arn
}

resource "aws_iam_policy" "cloudwatch_ec2" {
  count       = contains(var.grafana_data_sources, "CLOUDWATCH") && local.create_policies ? 1 : 0
  name_prefix = "grafana-cloudwatch-ec2-"
  path        = var.role_path
  policy      = data.aws_iam_policy_document.ec2[0].json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "cloudwatch_ec2" {
  count      = contains(var.grafana_data_sources, "CLOUDWATCH") && local.create_policies ? 1 : 0
  role       = aws_iam_role.grafana[0].name
  policy_arn = aws_iam_policy.cloudwatch_ec2[0].arn
}

resource "aws_iam_policy" "cloudwatch_tags" {
  count       = contains(var.grafana_data_sources, "CLOUDWATCH") && local.create_policies ? 1 : 0
  name_prefix = "grafana-cloudwatch-tags-"
  path        = var.role_path
  policy      = data.aws_iam_policy_document.tags[0].json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_tags" {
  count      = contains(var.grafana_data_sources, "CLOUDWATCH") && local.create_policies ? 1 : 0
  role       = aws_iam_role.grafana[0].name
  policy_arn = aws_iam_policy.cloudwatch_tags[0].arn
}

resource "aws_iam_policy" "sns" {
  count       = contains(var.notification_destinations, "SNS") && local.create_policies ? 1 : 0
  name_prefix = "grafana-sns-"
  path        = var.role_path
  policy      = data.aws_iam_policy_document.sns[0].json
}

resource "aws_iam_role_policy_attachment" "sns" {
  count      = contains(var.notification_destinations, "SNS") && local.create_policies ? 1 : 0
  role       = aws_iam_role.grafana[0].name
  policy_arn = aws_iam_policy.sns[0].arn
}



module "short-name" {
  count      = local.grafana_role_prefix != null ? 1 : 0
  source     = "axetrading/short-name/null"
  version    = "1.0.0"
  max_length = 38
  value      = local.grafana_role_prefix
}
