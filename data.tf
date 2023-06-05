data "aws_partition" "current" {}

data "aws_iam_policy_document" "grafana_assume_role" {
  count = var.create_role ? 1 : 0

  statement {
    sid     = "GrafanaAssume"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["grafana.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

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
  }
}