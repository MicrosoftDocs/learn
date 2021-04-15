<!--
management
migration
security
redundancy

Ways that the Azure VMware Solution is different than running VMware on-premises
billing and licensing
support and responsibility matrix
service components
network connectivity

-->
## Managing Azure VMware Solutions

The Azure portal is used for deployment and several management operations. vCenter and NSX Manager are used to manage vSphere and NSX-T resources.  

Microsoft is responsible for the lifecycle management of VMware software (ESXi, vCenter, PSC, and NXS) in the Azure VMware Solution private cloud. 

The AVS software is upgraded on a schedule that tracks the software bundle's release from VMware. The upgrades do not require downtime. 
The upgrade keeps the software within one version of the most recent software bundle release. The versions may differ from the most recent versions of the individual software components (ESXi, NSX-T, vCenter, vSAN).

Software updates include:

Patches - Security patches or bug fixes released by VMware
Updates - Minor version change of a VMware stack component
Upgrades - Major version change of a VMware stack component
Microsoft tests a critical security patch as soon as it becomes available from VMware.


##  Migration into Azure VMware Solutions


## Securing Azure VMware Solutions
Azure VMware Solution private clouds use vSphere role-based access control for acesss and security. You can integrate vSphere SSO LDAP capabilities with Azure Active Directory. 

In Azure VMware Solution, vCenter has a built-in local user called cloudadmin and assigned to the CloudAdmin role.  The CloudAdmin role has vCenter privileges that differ from other VMware cloud solutions.

- The local cloudadmin user is used to set up users in Active Directory (AD).

- In an Azure VMware Solution deployment, the administrator doesn't have access to the administrator user account. They are, however, assign AD users and groups to the CloudAdmin role on vCenter.

- The private cloud user doesn't have access to and can't configure specific management components supported and managed by Microsoft. For example, clusters, hosts, datastores, and distributed virtual switches.

vSan storage datastore security is provided by data-at-rest encryption that is turned on by default. The encryption is KMS-based and supports vCenter operations for key management. Keys are stored encrypted, wrapped by an Azure Key Vault master key. When a host is removed from a cluster, data on SSDs is invalidated immediately.
