<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u02_data_centers\_u02_m03_software_stack\x-oli-workbook_page\_u02_m03_4_orchestration.xml -->

Cloud Orchestration is the process by which all of the provisioning, middleware and other complex systems in a cloud can be automatically arranged and coordinated. Today, cloud orchestration supports the specification and management of the following resources including but not limited to: 
- Compute Servers (In the form of virtual machines) 
- Auto Scaling 
- Load Balancers 
- Databases 
- Block Storage 
- DNS and Virtual Network (VLANs) 
- Software configuration and setup (typically in the form of bootstrapping scripts) 

##  Benefits of Orchestration

Cloud orchestration is a method to fully realize the dynamic potential of cloud infrastructure, by allowing users to specify and configure a complete application encompassing multiple resource types. One of the most important aspects of the cloud is the rapid service delivery which is made possible by cloud orchestration. It also saves cost by eliminating manual intervention and management of IT services. Benefits of cloud orchestration can be summarized as follows: 
- Integration, automation and optimization of service deployment across heterogeneous environments. 
- Self-service portals for selection of cloud services, including storage and networking, from a predefined menu of offerings. 
- Reduces the need for manual intervention which lowers the ratio of administrators to physical and virtual servers. 
- Automates high-scale provisioning and de-provisioning of resources with policy-based tools to manage virtual machine sprawl by reclaiming resources automatically. 
- Ability to integrate workflows and approval chains across technology silos to improve collaboration and reduce delays. 
- Real-time monitoring of physical and virtual cloud resources, as well as usage and accounting chargeback capabilities to track and optimize system usage. 
- Making adoption of best practices easy by prepackaging automation templates and workflows for the most common resource types.

##  Orchestrator Tools

There are variety of tools which provides orchestration, Puppet and Chef are popular examples. 
###  Puppet

Puppet is a tool that can be used to issue service commands to multiple client machines from a master machine. This allows developers and systems administrators to manage client machines from a single master machine, providing commands to individual clients based on code which describes the configuration actions that are to be performed on each machine: 
![Figure 2.26: Puppet](../media/puppet.png)

_Figure 2.26: Puppet_


Puppet is typically (but not always) used in a client/server formation, with all of the clients talking to one or more central servers. Each client contacts the server periodically (every half hour, by default), downloads the latest configuration, and makes sure it is in sync with that configuration. Once done, the client can send a report back to the server indicating if anything needs to change. Puppet’s functionality is built as a stack of separate layers, each responsible for a fixed aspect of the system, with tight controls on how information passes between layers.
###  Chef

Chef uses the same concepts as Puppet, but differs in deployment. Chef operates using user-specified recipes, which describe the state of the resources in the system, such as the packages (and versions) to install, start up daemons or services to execute, or an data to be downloaded/created. This ensures an identical operating environment with the same resources and configurations across all systems. Using Chef, it is possible to automate the creation of a complex distributed system, stitching together various components and workflows. 