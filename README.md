# Azure Virtual WAN - Automate peering from Virtual Hubs to Virtual Networks

Networking is one of the most critical aspects of Azure: without it, different components and workloads cannot interconnect. Azure offers several ways to plan your network infrastructure. This planning involves deciding on the geographical location of different components/workloads, which in networking terms is referred to as topology.

Azure provides a resource called Azure Virtual WAN for a managed hub/spoke topology. In this setup, the main connectivity point or virtual hub within each region is managed by Azure (although technically, it remains a virtual network). This regional virtual hub is used to connect the virtual networks of different projects or workloads within the corresponding virtual hub using peering connections. While Azure does make global VNet peering possible, ideally, networks in the same region should connect with each other.

![Virtual Hub to Virtual Network](/media/vhub-regional-peering.drawio.png)
