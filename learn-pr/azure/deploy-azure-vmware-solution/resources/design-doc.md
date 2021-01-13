# Title

- Onboard Azure VMware Solution and connect to an existing VMware vSphere environment on-premises

## Role(s)

- Administrator
- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure VMware Solution
- Azure Virtual Networking

## Prerequisites

- Experience managing VMware infrastructure.
- Basic knowledge of network concepts.

## Summary

First, you'll learn about all the pre-requisites that need to be factored in for the Azure VMware Solution deployment. From there, you'll learn how to deploy an Azure VMware Solution resource plus all steps required to ensure the service is configured correctly. Once the Azure VMware Solution is ready and properly configured, you'll learn how to configure ExpressRoute Global Reach to connect your on-premises VMware vSphere environment directly to Azure VMware Solution. Learning all these steps will prepare your company to meet the demands of the business.

## Learning objectives

1. Plan for an Azure VMware Solution deployment
1. Deploy Azure VMware Solution
1. Connect Azure VMware Solution to an on-premises network

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Unit Task   | Conceptual unit title | Practice unit title |
| :---------- | :-------------------- | :------------------ |
| 1. Scenario | Introduction          | N/A                 |
| 2. Plan | Plan Azure VMware Solution Deployment | N/A |
| 3. Deploy | Deploy Azure VMware Solution | N/A |
| 4. Connect | Connect to on-premises VMware vSphere environment | N/A |
| 5. Summary  | Summary               | N/A                 |

## Outline the units

1. **Introduction**

    Imagine you work for a healthcare company who runs many of their production workloads on a VMware platform. IT operations are spread between many different offices. There are a few trends that have surfaced in recent months. Some locations have equipment nearing end of life, so hardware refresh decisions need to be made in short order. Additionally, your company isn't able to get new infrastructure quickly enough to meet requests for hardware refreshes and new applications. The requisition process, approvals, and logistics can take at least 4 to 6 months, if not longer. One avenue your company is interested in exploring involves migrating VMware workloads to the cloud without changing virtualization platforms or altering existing operational patterns. In this module, you'll learn how to plan, deploy, and connect Azure VMware Solution to your existing VMware infrastructure on-premises.

1. **Plan Azure VMware Solution Deployment**

    - Plan deployment
        - Azure components: subscription, resource group, number of nodes, vCenter/NSX-T admin passwords
        - Eligibility criteria: EA, CSP, register provider
        - Migration assessment: Azure Migrate
        - Network planning: VNet/ExpressRoute considerations, routing/subnet configurations, required ports, DHCP/DNS resolution considerations
        - Solution components: software versions, nodes, private clouds, clusters, host maintenance, and lifecycle management

    **Knowledge check**

    - At a minimum, which CIDR block does Azure VMware Solution private clouds require?

        - /22 - true
        - /30 - false
        - /31 - false
        
    - What is the minimum number of nodes that can be deployed for Azure VMware Solution?

        - 4 - false
        - 8 - false
        - 3 - true

1. **Deploy Azure VMware Solution**

    - Deploy AVS resource
    - Create Bastion or a jump host
    - Connect to VNet with ExpressRoute
    - Verify network routes are advertised
    - Connect and sign into vCenter and NSX-T from the Bastion host
    - Confirm NSX-T configurations: advertised NSX-T segment, DHCP services to NSX-T segment(optional), add VM on NSX-T segment, verify connectivity
    - Placeholder: video/demo showing the creation of AVS and methods to ensure all settings are configured correctly.

    **Knowledge check**

    - At a minimum, which role is required at the subscription level to deploy Azure VMware Solution?

        - Virtual Machine Contributor - false
        - Owner - false
        - Contributor - true

    - If DHCP on your NSX-T segments is required, what is one of the ways to configure within your environment?

        - Create a DHCP server and relay traffic to that server - true
        - Create a NAT rule - false
        - Set a static MAC address on a virtual machine - false

1. **Connect to on-premises VMware vSphere environment**
    - Establish ExpressRoute Global Reach connection
    - Create an ExpressRoute authorization key for the AVS private cloud
    - Peer private cloud to on-premises using authorization key
    - Verify on-premises network connectivity
    - Placeholder: video/demo showing the configurations required to connect AVS in Azure to an on-premises environment.

    **Knowledge check**

    - In order for on-premises network traffic to reach Azure VMware Solution, which component is required?

        - VPN - false
        - ExpressRoute Global Reach - true
        - Load Balancer - false

    - Which resource is required to peer the Azure VMware Solution private cloud to on-premises?

        - Customer provided ExpressRoute - true
        - Application Gateway - false
        - Network Virtual Appliance - false

1. **Summary**

    In this module, you learned how to effectively onboard Azure VMware Solution and connect the Azure deployment to an on-premises VMware vSphere environment. First, you examined all pre-requisites to deploy Azure VMware Solution. From there, you learned about all the steps involved with deploying Azure VMware Solution in Azure. Lastly, you learned how to connect the Azure VMware Solution private cloud to your on-premises VMware vSphere environment. Knowing how to successfully build and configure Azure VMware Solution will help your company out

## Notes

[Azure VMware Solution](https://azure.microsoft.com/services/azure-vmware/)

[Azure VMware Solution documentation](https://docs.microsoft.com/azure/azure-vmware/)

[Azure VMware Solution - VMware documentation] (https://cloud.vmware.com/azure-vmware-solution)

Placeholder: Azure VMware Solution Learn path URL