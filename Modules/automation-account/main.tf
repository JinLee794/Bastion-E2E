resource "azurerm_automation_account" "bastion_automation" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Basic"
  tags                = var.tags
}

# Link automation account to a Log Analytics Workspace.
# Only deployed if enable_update_management and/or enable_change_tracking are/is set to true
resource "azurerm_log_analytics_linked_service" "law_link" {
  count               = var.enable_update_management || var.enable_change_tracking ? 1 : 0
  resource_group_name = var.resource_group_name
  workspace_id        = var.az_law_id
  #linked_service_name = "automation"
  read_access_id = azurerm_automation_account.bastion_automation.id
}


# Add Updates workspace solution to log analytics if enable_update_management is set to true.
# Adding this solution to the log analytics workspace, combined with above linked service resource enables update management for the automation account.
resource "azurerm_log_analytics_solution" "law_solution_updates" {
  count               = var.enable_update_management
  resource_group_name = var.resource_group_name
  location            = var.location

  solution_name         = "Updates"
  workspace_resource_id = var.az_law_id
  workspace_name        = element(split("/", var.az_law_id), length(split("/", var.az_law_id)) - 1)

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Updates"
  }
}


# Add Updates workspace solution to log analytics if enable_change_tracking is set to true.
# Adding this solution to the log analytics workspace, combined with above linked service resource enables Change Tracking and Inventory for the automation account.
resource "azurerm_log_analytics_solution" "law_solution_change_tracking" {
  count               = var.enable_change_tracking
  resource_group_name = var.resource_group_name
  location            = var.location

  solution_name         = "ChangeTracking"
  workspace_resource_id = var.az_law_id
  workspace_name        = element(split("/", var.az_law_id), length(split("/", var.az_law_id)) - 1)

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ChangeTracking"
  }
}


# Send logs to Log Analytics
# Required for automation account with update management and/or change tracking enabled.
# Optional on automation accounts used of other purposes.
#resource "azurerm_monitor_diagnostic_setting" "aa_diags_logs" {
#  count                      = var.enable_logs_collection || var.enable_update_management || var.enable_change_tracking ? 1 : 0
#  name                       = "LogsToLogAnalytics"
#  target_resource_id         = azurerm_automation_account.bastion_automation.id
#  log_analytics_workspace_id = var.az_law_id
#
#  log {
#    category = "JobLogs"
#    enabled  = true
#
#   retention_policy {
#      enabled = false
#    }
#  }
#
#  log {
#    category = "JobStreams"
#    enabled  = true
#
#    retention_policy {
#      enabled = false
#    }
#  }
#
#  log {
#    category = "DscNodeStatus"
#    enabled  = true
#
#    retention_policy {
#      enabled = false
#    }
#  }
#
#  metric {
#    category = "AllMetrics"
#    enabled  = false
#
#    retention_policy {
#      enabled = false
#    }
#  }
#}


# Send metrics to Log Analytics
#resource "azurerm_monitor_diagnostic_setting" "aa_diags_metrics" {
#  count                      = var.enable_metrics_collection || var.enable_update_management || var.enable_change_tracking ? 1 : 0
#  name                       = "MetricsToLogAnalytics"
#  target_resource_id         = azurerm_automation_account.bastion_automation.id
#  log_analytics_workspace_id = var.az_law_id

#  log {
#    category = "JobLogs"
#    enabled  = false

#    retention_policy {
#      enabled = false
#    }
#  }

#  log {
#    category = "JobStreams"
#    enabled  = false

#    retention_policy {
#      enabled = false
#    }
#  }

#  log {
#    category = "DscNodeStatus"
#    enabled  = false

#    retention_policy {
#      enabled = false
#    }
#  }

#  metric {
#    category = "AllMetrics"
#    enabled  = true

#    retention_policy {
#      enabled = false
#    }
#  }
#}