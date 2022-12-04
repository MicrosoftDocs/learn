A site in a private mobile network represents a physical enterprise location containing an Azure Stack Edge (ASE) device that hosts a packet core instance. The packet core instance provides the 4G and 5G network functions for the network and is responsible for managing the site. An Azure Private 5G Core private mobile network can have one or more physically dispersed sites.

Once a site is deployed and in operation, you'll need to manage it on a daily basis. For example, you may need to provision new SIMs for newly attached UEs or reconfigure SIM policies due to application changes.

## Network slices and multiple data networks

Azure Private 5G Core allows you divide a site into multiple network slices. Each slice is a logical end-to-end network within the site. To support different requirements of different UE applications in the network, you can configure unique SIM policies for each slice, and then add the UEs to relevant network slices.

Additionally, Azure Private 5G Core allows you to connect a site to multiple data networks (DNs). You can use different DNs for different applications. Each UE can connect to multiple DNs simultaneously.

Take the UEs in an enterprise as an example. One type of UEs might require low latency, while another type might require high bandwidth. The enterprise can separate the UEs into different network slices, and configure different quality of service (QoS) polices for each slice. The UEs in each slice can connect to different DNs.

## Modify a site

Basic process for site mgmt

Slices

data networks

## Decommission a site

## Azure Stack Edge related tasks

power recycle & ASE replacement