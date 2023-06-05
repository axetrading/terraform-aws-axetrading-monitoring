resource "aws_grafana_workspace" "grafana" {
  count = var.enabled && var.create_grafana_workspace ? 1 : 0

  name        = var.name
  description = var.description

  account_access_type      = var.account_access_type
  authentication_providers = var.authentication_providers
  permission_type          = var.permission_type

  grafana_version           = var.grafana_version
  configuration             = var.configuration
  data_sources              = var.grafana_data_sources
  notification_destinations = var.notification_destinations
  organization_role_name    = var.organization_role_name
  organizational_units      = var.organizational_units
  role_arn                  = var.create_role ? aws_iam_role.grafana[0].arn : null
  stack_set_name            = var.name

  dynamic "vpc_configuration" {
    for_each = length(var.vpc_configuration) > 0 ? [var.vpc_configuration] : []

    content {
      security_group_ids = var.create_security_group ? flatten(concat([aws_security_group.this[0].id], try(vpc_configuration.value.security_group_ids, []))) : vpc_configuration.value.security_group_ids
      subnet_ids         = vpc_configuration.value.subnet_ids
    }
  }

  tags = var.tags
}

resource "aws_grafana_role_association" "this" {
  for_each = { for k, v in var.role_associations : k => v if var.enabled }

  role         = try(each.value.role, each.key)
  group_ids    = try(each.value.group_ids, null)
  user_ids     = try(each.value.user_ids, null)
  workspace_id = aws_grafana_workspace.grafana[0].id
}

resource "aws_grafana_workspace_api_key" "this" {
  for_each = { for k, v in var.workspace_api_keys : k => v if var.enabled }

  key_name        = try(each.value.key_name, each.key)
  key_role        = each.value.key_role
  seconds_to_live = each.value.seconds_to_live
  workspace_id    = aws_grafana_workspace.grafana[0].id
}
