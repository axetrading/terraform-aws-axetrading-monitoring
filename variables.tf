### ======== IAM VARIABLES ========###

variable "create_role" {
  type        = bool
  description = "Whether to create or not the IAM Role for the AWS Managed Grafana Workspace"
  default     = true
}

variable "iam_role_arn" {
  description = "Existing IAM role ARN for the workspace. Required if `create_iam_role` is set to `false`"
  type        = string
  default     = null
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = null
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = null
}

variable "role_name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "policy_name_prefix" {
  description = "IAM policy name prefix"
  type        = string
  default     = "grafana-policy-"
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = null
}

variable "role_name" {
  description = "Name of IAM role"
  type        = string
  default     = null
}

variable "role_policy_arns" {
  description = "ARNs of any policies to attach to the IAM role"
  type        = set(string)
  default     = []
}
### ======== GRAFANA VARIABLES ========###

variable "name" {
  type        = string
  description = "The name of the AWS Managed Grafana Workspace"
}

variable "create_grafana_workspace" {
  type        = bool
  description = "Whether to create or not the AWS Managed Grafana Workspace"
  default     = true
}

variable "description" {
  type        = string
  description = "The description of the AWS Managed Grafana Workspace"
  default     = "AWS Managed Grafana Workspace"
}

variable "account_access_type" {
  type        = string
  description = "Specifies whether the workspace can access resources in all accounts in the organization, or only in its own account."
  default     = "CURRENT_ACCOUNT"
  validation {
    condition     = can(regex("^(CURRENT_ACCOUNT|ORGANIZATION)$", var.account_access_type))
    error_message = "account_access_type must be CURRENT_ACCOUNT or ORGANIZATION"
  }
}

variable "permission_type" {
  type        = string
  default     = "CUSTOMER_MANAGED"
  description = <<EOF
  The permission type of the workspace.
  If SERVICE_MANAGED is specified, the IAM roles and IAM policy attachments are generated automatically. 
  If CUSTOMER_MANAGED is specified, the IAM roles and IAM policy attachments will not be created.
  EOF
  validation {
    condition     = can(regex("^(CUSTOMER_MANAGED|SERVICE_MANAGED)$", var.permission_type))
    error_message = "permission_type must be CUSTOMER_MANAGED or SERVICE_MANAGED."
  }
}

variable "authentication_providers" {
  type        = list(string)
  description = <<EOF
  Specifies whether this workspace uses SAML 2.0, Amazon Web Services SSO, 
  or both to authenticate users for using the Grafana console within a workspace.
  EOF
  default     = ["AWS_SSO"]
}

variable "configuration" {
  description = "The configuration string for the workspace that you create. For more information about the format and configuration options available, see Working in your Grafana workspace"
  type        = string
  default     = null
}

variable "grafana_data_sources" {
  description = "A list of data sources that should be configured in AWS Managed Grafana Workspace"
  type        = list(string)
  default     = []
}

variable "grafana_version" {
  type        = string
  description = "The version of Grafana to use"
  default     = "9.4"
}

variable "organization_role_name" {
  description = "The role name that the workspace uses to access resources through Amazon Organizations."
  type        = string
  default     = null
}

variable "organizational_units" {
  description = "The Amazon Organizations organizational units that the workspace is authorized to use data sources from"
  type        = list(string)
  default     = []
}


variable "notification_destinations" {
  description = "The notification destinations. If a data source is specified here, Amazon Managed Grafana will create IAM roles and permissions needed to use these destinations. Must be set to `SNS`"
  type        = list(string)
  default     = []
}

variable "role_associations" {
  description = "Provides an Amazon Managed Grafana workspace role association resource."
  type        = any
  default     = {}
}


variable "vpc_configuration" {
  description = "The configuration settings for an Amazon VPC that contains data sources for your Grafana workspace to connect to"
  type        = any
  default     = {}
}

variable "workspace_api_keys" {
  description = "Provides an Amazon Managed Grafana workspace API Key resource."
  type        = any
  default     = {}
}

variable "stack_set_name" {
  type = string
  description = "The name of the stack set to create"
  default = null
}


### ======== SECURITY GROUP VARIABLES ========###

variable "security_group_name" {
  type        = string
  description = "AWS Managed Grafana Security Group Name"
  default     = ""
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group ids that should be attached to AWS Managed Grafana Workspace"
  default     = null
}

variable "create_security_group" {
  type        = bool
  description = "Whether to create a security group for Grafana"
  default     = true
}

variable "security_group_rules" {
  description = "Security Group rules that will be added to the security group created"
  type        = map(any)
  default     = {}
}

### ======== PROMETHEUS VARIABLES ========###

variable "prometheus_workspaces" {
  description = "A list of Prometheus workspaces"
  type        = list(string)
  default     = null
}

variable "enable_logging" {
  description = "Enable logging"
  type        = bool
  default     = false
}

variable "retention_in_days" {
  description = "Specifies the number of days you want to retain log events"
  type        = number
  default     = 14
}


### ======== GENERAL VARIABLES ========###

variable "enabled" {
  type        = bool
  description = "Whether to enable or not the module"
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add the the IAM role"
  type        = map(any)
  default     = {}
}


