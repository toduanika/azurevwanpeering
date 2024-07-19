# Azure Virtual WAN - Automate peering from Virtual Hubs to Virtual Networks

Networking is super important in Azure because it allows different parts of your system to talk to each other. Azure gives you several ways to plan your network infrastructure, including where to place your components and workloads, which is known as topology.

One handy resource Azure offers is the Azure Virtual WAN. This helps you set up a managed hub-and-spoke network. In this setup, Azure takes care of the main connection point, called the virtual hub, in each region. This hub connects different virtual networks for various projects or workloads within that region using peering connections. While you can connect networks globally with Azure's VNet peering, it's best to connect networks within the same region whenever possible.

![Virtual Hub to Virtual Network](/media/vhub-regional-peering.drawio.png)

This script is designed to make your life easier when managing virtual networks in Azure. It automatically finds all the virtual hubs in your existing Virtual WAN (vWAN) resource and retrieves all the virtual networks. Then, it compares their locations. If the locations match, it sets up peering connections between them. This way, you don't have to create peering connections one by one for a large number of virtual networks.
