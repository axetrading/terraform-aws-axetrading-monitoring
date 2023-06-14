data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "prometheus" {
  count = contains(var.grafana_data_sources, "PROMETHEUS") ? 1 : 0

  statement {
    sid    = "Prometheus"
    effect = "Allow"
    actions = [
      "aps:ListWorkspaces",
      "aps:DescribeWorkspace",
      "aps:QueryMetrics",
      "aps:GetLabels",
      "aps:GetSeries",
      "aps:GetMetricMetadata",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudwatch_logs" {
  count = contains(var.grafana_data_sources, "CLOUDWATCH") ? 1 : 0

  statement {
    sid    = "CloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups",
      "logs:GetLogGroupFields",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:GetQueryResults",
      "logs:GetLogEvents",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudwatch_metrics" {
  count = contains(var.grafana_data_sources, "CLOUDWATCH") ? 1 : 0

  statement {
    sid    = "CloudWatchMetrics"
    effect = "Allow"
    actions = [
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:GetMetricData",
    ]
    resources = ["*"]
  }

}

data "aws_iam_policy_document" "ec2" {
  count = contains(var.grafana_data_sources, "CLOUDWATCH") ? 1 : 0

  statement {
    sid    = "EC2"
    effect = "Allow"
    actions = [
      "ec2:DescribeTags",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "tags" {
  count = contains(var.grafana_data_sources, "CLOUDWATCH") ? 1 : 0

  statement {
    sid    = "Tags"
    effect = "Allow"
    actions = [
      "tag:GetResources",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "sns" {
  count = contains(var.notification_destinations, "SNS") ? 1 : 0

  statement {
    sid    = "SNS"
    effect = "Allow"
    actions = [
      "sns:Publish",
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:sns:*:${data.aws_caller_identity.current.account_id}:grafana*"
    ]
  }
}

data "aws_iam_policy_document" "cross_account" {
  count = var.cross_account_enabled ? 1 : 0

  statement {
    sid    = "CrossAccount"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      "arn:aws:iam::*:role/amp-iamproxy-ingest-role*",
    ]

    dynamic "condition" {
      for_each = var.org_id != null ? [1] : []
      content {
        test     = "StringEquals"
        variable = "aws:PrincipalOrgID"
        values   = [var.org_id]
      }
    }
  }
}