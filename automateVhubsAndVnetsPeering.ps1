<#
    .SYNOPSIS
    Creates peering connections from virtual hubs to virtual networks based on their locations.

    .DESCRIPTION
    This script retrieves virtual hubs and virtual networks from each subscription, checks their locations, and establishes the corresponding peering connections.

    .PARAMETER resourceGroupName
    Specifies the name of the existing resource group where the Virtual WAN is deployed. This parameter is mandatory and must not be empty.

    .NOTES
    Author: Nika Todua
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
