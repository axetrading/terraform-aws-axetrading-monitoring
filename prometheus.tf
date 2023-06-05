

resource "aws_prometheus_workspace" "prometheus" {
  for_each = { for workspace in var.prometheus_workspaces : workspace => workspace }
  alias    = each.value

  dynamic "logging_configuration" {
    for_each = var.enable_logging ? [1] : []
    content {
      log_group_arn = "${aws_cloudwatch_log_group.prometheus[each.key].arn}:*"
    }
  }

  tags = merge({ "workspace_name" = each.value }, var.tags)
}

resource "aws_cloudwatch_log_group" "prometheus" {
  for_each = var.enable_logging ? { for workspace in var.prometheus_workspaces : workspace => workspace } : {}

  name              = "prometheus-logging-${each.key}"
  retention_in_days = var.retention_in_days

  tags = merge({ "LogGroupName" = each.value }, var.tags)
}
