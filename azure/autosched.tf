resource "azurerm_automation_account" "glory_to_ukraine" {
  name                = "glory-to-ukraine"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = "Basic"
  identity {
     type = "SystemAssigned"
  }
}

resource "azurerm_automation_schedule" "hourly" {
  name                    = local.name
  resource_group_name     = azurerm_resource_group.main.name
  automation_account_name = azurerm_automation_account.glory_to_ukraine.name
  frequency               = "Hour"
  interval                = 1
  start_time              = timeadd(timestamp(), "10m")
  description             = "Hourly schedule"
}

data "template_file" "init" {
  template = "${file("${path.module}/deleteVMs.tpl")}"
  vars = {
    local_name = "${local.name}"
  }
}

resource "azurerm_automation_runbook" "delVMs" {
  name                    = "delVMs"
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  automation_account_name = azurerm_automation_account.glory_to_ukraine.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "Delete VMs from VMSS runbook"
  runbook_type            = "PowerShell"

  content = data.template_file.init.rendered
}

data "azurerm_subscription" "primary" {
}

resource "azurerm_role_assignment" "main" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id       = azurerm_automation_account.glory_to_ukraine.identity[0].principal_id
}

resource "azurerm_automation_job_schedule" "main" {
  resource_group_name     = azurerm_resource_group.main.name
  automation_account_name = azurerm_automation_account.glory_to_ukraine.name
  schedule_name           = azurerm_automation_schedule.hourly.name
  runbook_name            = azurerm_automation_runbook.delVMs.name
}
