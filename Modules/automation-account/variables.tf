variable "name" {
  description = "The name of the automation account."
}

variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location to deploy resources to."
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "enable_update_management" {
  description = "Trigger to enable update management."
  default     = "1"
}

variable "enable_change_tracking" {
  description = "Trigger to enable change tracking."
  default     = "1"
}

variable "enable_logs_collection" {
  description = "Trigger to enable collecting of logs."
  default     = true
}

variable "enable_metrics_collection" {
  description = "Trigger to enable collecting of metrics."
  default     = true
}

variable "log_analytics_workspace_id" {
  description = "ID of log analytics workspace for logging"
}

variable "metrics_log_analytics_workspace_id" {
  description = "ID of log analytics workspace for metrics"
}

variable "az_law_id" {
  description = "resource ID of log analytics workspace"
}
