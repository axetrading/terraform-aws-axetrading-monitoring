data "aws_iam_policy_document" "prometheus_assume_role" {
  statement {
    sid    = "AllowAssumeRole"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::*:role/amp-iamproxy-ingest-role*"]
    }
    actions = ["sts:AssumeRole"]

    dynamic "condition" {
      for_each = var.org_id != null ? [var.org_id] : []
      content {
        test     = "StringEquals"
        variable = "aws:PrincipalOrgID"
        values   = [condition.value]
      }
    }
  }
}

resource "aws_iam_role" "prometheus" {
  count       = var.create_prometheus_role ? 1 : 0
  name        = var.prometheus_role_name
  path        = var.role_path
  description = var.role_description

  assume_role_policy    = data.aws_iam_policy_document.prometheus_assume_role[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.role_permissions_boundary_arn
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "prometheus_remote_write" {
  count      = var.create_prometheus_role ? 1 : 0
  role       = aws_iam_role.prometheus[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess"
}
