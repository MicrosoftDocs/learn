A site in a private mobile network represents a physical enterprise location containing an Azure Stack Edge (ASE) device that hosts a packet core instance. The packet core instance provides the 4G and 5G network functions for the network and is responsible for managing the site. An Azure Private 5G Core private mobile network can have one or more physically dispersed sites.

Each site can have multiple network slices. Each slice is a logical end-to-end network within the site. For different UE applications in the network, you can configure unique SIM policies for each slice, and then add the UEs to relevant network slices. Additionally, Azure Private 5G Core allows you to connect a site to multiple data networks (DNs). Each UE can connect to multiple DNs simultaneously.

Once a site is deployed and in operation, you'll need to manage it on a daily basis. For example, you may need to attach a new DN for a new UE application.

## Modify a site

The *Mobile Network Site* resource in the Azure portal represents a packet core instance deployed at the enterprise edge. Through this resource, you can modify the configuration of the relevant packet core instance and its connected DNs.



### Packet core configuration

### Network access interfaces

### Data network configuration

### Network slices

site configuration: tech type - Can't be changed, ASE connected, Arc location
access network: N2 & N3
DN: Add; modify (virtual network, IP ool prefixes, port range)



Basic process for site mgmt

Slices

data networks

Take the UEs in an enterprise as an example. One type of UEs might require low latency, while another type might require high bandwidth. The enterprise can separate the UEs into different network slices, and configure different quality of service (QoS) polices for each slice. The UEs in each slice can connect to different DNs.

## Decommission a site

## Azure Stack Edge related tasks

power recycle & ASE replacement