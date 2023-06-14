The ```terraform-aws-axetrading-monitoring``` module is a Terraform module that provisions a managed Grafana instance on AWS. It sets up an IAM role and policy for Grafana to access CloudWatch metrics, creates a security group for the Grafana instance, and deploys the Grafana instance itself. This module is designed to be used as a building block for monitoring infrastructure on AWS, allowing you to easily add a Grafana dashboard to your stack.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_short-name"></a> [short-name](#module\_short-name) | axetrading/short-name/null | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_grafana_role_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_role_association) | resource |
| [aws_grafana_workspace.grafana](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_workspace) | resource |
| [aws_grafana_workspace_api_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_workspace_api_key) | resource |
| [aws_iam_policy.cloudwatch_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cloudwatch_metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cloudwatch_tags](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.grafana](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_tags](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prometheus_remote_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_prometheus_workspace.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/prometheus_workspace) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.grafana_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.prometheus_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.tags](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_access_type"></a> [account\_access\_type](#input\_account\_access\_type) | Specifies whether the workspace can access resources in all accounts in the organization, or only in its own account. | `string` | `"CURRENT_ACCOUNT"` | no |
| <a name="input_authentication_providers"></a> [authentication\_providers](#input\_authentication\_providers) | Specifies whether this workspace uses SAML 2.0, Amazon Web Services SSO, <br>  or both to authenticate users for using the Grafana console within a workspace. | `list(string)` | <pre>[<br>  "AWS_SSO"<br>]</pre> | no |
| <a name="input_configuration"></a> [configuration](#input\_configuration) | The configuration string for the workspace that you create. For more information about the format and configuration options available, see Working in your Grafana workspace | `string` | `null` | no |
| <a name="input_create_grafana_workspace"></a> [create\_grafana\_workspace](#input\_create\_grafana\_workspace) | Whether to create or not the AWS Managed Grafana Workspace | `bool` | `true` | no |
| <a name="input_create_prometheus_role"></a> [create\_prometheus\_role](#input\_create\_prometheus\_role) | Whether to create or not the IAM role that grants permissions to the Prometheus workspace | `bool` | `true` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create or not the IAM Role for the AWS Managed Grafana Workspace | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a security group for Grafana | `bool` | `true` | no |
| <a name="input_cross_account_enabled"></a> [cross\_account\_enabled](#input\_cross\_account\_enabled) | Whether to enable cross account CloudWatch ingestion or not | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the AWS Managed Grafana Workspace | `string` | `"AWS Managed Grafana Workspace"` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Enable logging | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to enable or not the module | `bool` | `true` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `true` | no |
| <a name="input_grafana_data_sources"></a> [grafana\_data\_sources](#input\_grafana\_data\_sources) | A list of data sources that should be configured in AWS Managed Grafana Workspace | `list(string)` | `[]` | no |
| <a name="input_grafana_version"></a> [grafana\_version](#input\_grafana\_version) | The version of Grafana to use | `string` | `"9.4"` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | Existing IAM role ARN for the workspace. Required if `create_iam_role` is set to `false` | `string` | `null` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the AWS Managed Grafana Workspace | `string` | n/a | yes |
| <a name="input_notification_destinations"></a> [notification\_destinations](#input\_notification\_destinations) | The notification destinations. If a data source is specified here, Amazon Managed Grafana will create IAM roles and permissions needed to use these destinations. Must be set to `SNS` | `list(string)` | `[]` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the AWS Organization | `string` | `null` | no |
| <a name="input_organization_role_name"></a> [organization\_role\_name](#input\_organization\_role\_name) | The role name that the workspace uses to access resources through Amazon Organizations. | `string` | `null` | no |
| <a name="input_organizational_units"></a> [organizational\_units](#input\_organizational\_units) | The Amazon Organizations organizational units that the workspace is authorized to use data sources from | `list(string)` | `[]` | no |
| <a name="input_permission_type"></a> [permission\_type](#input\_permission\_type) | The permission type of the workspace.<br>  If SERVICE\_MANAGED is specified, the IAM roles and IAM policy attachments are generated automatically. <br>  If CUSTOMER\_MANAGED is specified, the IAM roles and IAM policy attachments will not be created. | `string` | `"CUSTOMER_MANAGED"` | no |
| <a name="input_policy_name_prefix"></a> [policy\_name\_prefix](#input\_policy\_name\_prefix) | IAM policy name prefix | `string` | `"grafana-policy-"` | no |
| <a name="input_prometheus_role_name"></a> [prometheus\_role\_name](#input\_prometheus\_role\_name) | The name of the IAM role that grants permissions to the Prometheus workspace | `string` | `null` | no |
| <a name="input_prometheus_workspaces"></a> [prometheus\_workspaces](#input\_prometheus\_workspaces) | A list of Prometheus workspaces | `list(string)` | `null` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Specifies the number of days you want to retain log events | `number` | `14` | no |
| <a name="input_role_associations"></a> [role\_associations](#input\_role\_associations) | Provides an Amazon Managed Grafana workspace role association resource. | `any` | `{}` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role | `string` | `null` | no |
| <a name="input_role_name_prefix"></a> [role\_name\_prefix](#input\_role\_name\_prefix) | IAM role name prefix | `string` | `null` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_role_permissions_boundary_arn"></a> [role\_permissions\_boundary\_arn](#input\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `null` | no |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | ARNs of any policies to attach to the IAM role | `set(string)` | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of security group ids that should be attached to AWS Managed Grafana Workspace | `list(string)` | `null` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | AWS Managed Grafana Security Group Name | `string` | `""` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | Security Group rules that will be added to the security group created | `map(any)` | `{}` | no |
| <a name="input_stack_set_name"></a> [stack\_set\_name](#input\_stack\_set\_name) | The name of the stack set to create | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add the the IAM role | `map(any)` | `{}` | no |
| <a name="input_vpc_configuration"></a> [vpc\_configuration](#input\_vpc\_configuration) | The configuration settings for an Amazon VPC that contains data sources for your Grafana workspace to connect to | `any` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | `null` | no |
| <a name="input_workspace_api_keys"></a> [workspace\_api\_keys](#input\_workspace\_api\_keys) | Provides an Amazon Managed Grafana workspace API Key resource. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#output\_cloudwatch\_log\_groups) | CloudWatch Log Groups details |
| <a name="output_grafana_arn"></a> [grafana\_arn](#output\_grafana\_arn) | The ARN of the Grafana Workspace |
| <a name="output_grafana_endpoint"></a> [grafana\_endpoint](#output\_grafana\_endpoint) | The endpoint of the Grafana Workspace |
| <a name="output_grafana_iam_role_arn"></a> [grafana\_iam\_role\_arn](#output\_grafana\_iam\_role\_arn) | The ARN of the IAM role |
| <a name="output_grafana_iam_role_name"></a> [grafana\_iam\_role\_name](#output\_grafana\_iam\_role\_name) | The name of the IAM role |
| <a name="output_grafana_version"></a> [grafana\_version](#output\_grafana\_version) | The version of the Grafana Workspace |
| <a name="output_prometheus_iam_role_arn"></a> [prometheus\_iam\_role\_arn](#output\_prometheus\_iam\_role\_arn) | The ARN of the IAM role |
| <a name="output_prometheus_iam_role_name"></a> [prometheus\_iam\_role\_name](#output\_prometheus\_iam\_role\_name) | The name of the IAM role |
| <a name="output_prometheus_workspaces"></a> [prometheus\_workspaces](#output\_prometheus\_workspaces) | Prometheus Workspaces details |
<!-- END_TF_DOCS -->