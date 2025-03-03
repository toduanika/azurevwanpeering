# Azure Virtual WAN - Automate peering from Virtual Hubs to Virtual Networks

Networking is crucial in Azure because it allows different parts of your system to talk to each other. Azure gives you several ways to plan your network infrastructure, including where to place your components and workloads, which is known as topology.

One handy resource Azure offers is the Azure Virtual WAN. This helps you set up a managed hub-and-spoke network. In this setup, Azure takes care of the main connection point, called the virtual hub, in each region. This hub connects different virtual networks for various projects or workloads within that region using peering connections. While you can connect networks globally with Azure's VNet peering, it's best to connect networks within the same region whenever possible.

![Virtual Hub to Virtual Network](/media/vhub-regional-peering.drawio.png)

This script simplifies virtual network management in Azure by automating the peering process. It retrieves all virtual hubs within your existing Virtual WAN (vWAN) resource and collects all virtual networks. Then, it compares their locations and, if they match, automatically establishes peering connections between them. This eliminates the need to manually create peering connections for a large number of virtual networks, saving time and effort.
