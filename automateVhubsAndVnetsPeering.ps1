<#
    .SYNOPSIS
    This script creates peering connection from virtual hubs to virtual networks based on location.

    .DESCRIPTION
    This script collects virtual hubs and virtual networks existing in each subscription, then checks their locations and creates the corresponding peering connections.

    .PARAMETER resourceGroupName
    Specifies the existing resource group name whete virtual wan has been deployed. This parameter is mandatory and should not be empty

    .NOTES
        Author          : Nika Todua.

#>

[CmdLetBinding()]
param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [System.String] $resourceGroupName
)

$resourceGroup = Get-AzResourceGroup -ResourceGroupName $resourceGroupName
$virtualHubs = Get-AzVirtualHub -ResourceGroupName $resourceGroup.ResourceGroupName

if ($virtualHubs -ne 0) {

    foreach ($virtualHub in $virtualHubs) {

        $subscriptions = Get-AzSubscription

        foreach ($subscription in $subscriptions) {
            Select-AzSubscription -SubscriptionName $subscription.Name

            $virtualNetworks = Get-AzVirtualNetwork

            if ($virtualNetworks.Count -ne 0) {

                foreach ($virtualNetwork in $virtualNetworks) {
                    $virtualNetworkConnectionName = $subscription.Name + '-' + $virtualNetwork.ResourceGroupName + '-' + $virtualNetwork.Name

                    if ($virtualNetwork.Location -eq $virtualHub.Location) {

                        New-AzVirtualHubVnetConnection -ResourceGroupName $resourceGroup.ResourceGroupName -VirtualHubName $virtualHub.Name -Name $virtualNetworkConnectionName -RemoteVirtualNetwork $virtualNetwork
                    }
                    
                }

            }
                
        }
        
    }

}
else {
    Write-Information -MessageData "Virtual Hubs have not been found."
}
