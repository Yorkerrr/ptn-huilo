$resourceGroup = "${local_name}"

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

$vmss = Get-AzVmssVM -ResourceGroupName $resourceGroup -VMScaleSetName ${local_name}

$vmids = [System.Collections.ArrayList]::new()

foreach($item in $vmss.id){
  $ID = $item.Split("/")[-1]
  $vmids.Add($ID)
  Write-Output "VM ID: $ID"
}

Write-Output "VM IDs array: $vmids"
Remove-AzVmss -Force -ResourceGroupName $resourceGroup -VMScaleSetName ${local_name} -InstanceId $vmids;
