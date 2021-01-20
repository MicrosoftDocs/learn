# Title

- Deploy Azure VMware Solution to connect to an existing VMware environment on-premises

## Role(s)

- Administrator
- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure VMware Solution
- Azure Virtual Networking

## Prerequisites

- Experience managing VMware infrastructure, such as vSphere, vCenter, NSX-T, and vSAN.
- Basic knowledge of network concepts, such as classless inter-domain routing (CIDR), border gate protocol (BGP) routing, dynamic host configuration protocol (DHCP), and subnets.

## Summary

First, you'll learn how to plan for the Azure VMware Solution deployment. From there, you'll learn how to deploy an Azure VMware Solution resource. Additionally, you'll learn about the steps required to ensure the service is configured correctly. After Azure VMware Solution is deployed, you'll learn how to configure ExpressRoute Global Reach. ExpressRoute Global Reach allows you to connect your on-premises VMware vSphere environment directly to Azure VMware Solution. Learning all these steps will prepare your company to meet the migration demands for your business.

## Learning objectives

1. Plan a successful Azure VMware Solution deployment.
1. Connect to an on-premises VMware environment.

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Unit Task   | Conceptual unit title | Practice unit title |
| :---------- | :-------------------- | :------------------ |
| 1. Scenario | Introduction          | N/A                 |
| 2. Plan | Plan Azure VMware Solution Deployment | N/A |
| 3. Deploy | Deploy Azure VMware Solution | N/A |
| 4. Connect | Connect to on-premises VMware vSphere environment | N/A |
| 5. Module Knowledge Check | Azure VMware Solution Deployment Knowledge Check | N/A
| 6. Summary  | Summary               | N/A                 |

## Outline the units

1. **Introduction**

    Imagine you work for a healthcare company who runs production workloads on a VMware platform. IT operations are spread between different offices. There are a few trends that have surfaced in recent months. Some locations have equipment nearing end of life, so hardware refresh decisions need to be made soon. Additionally, your company isn't able to get new infrastructure quickly enough to meet requests for hardware refreshes and new applications. The requisition process, approvals, and logistics can take at least 4 to 6 months, if not longer. One avenue your company has decided to move forward with involves migrating existing VMware workloads to Azure VMware Solution. By using Azure VMware Solution, your company doesn't have to change virtualization platforms or alter existing operational patterns. In this module, you'll learn how to plan, deploy, and connect Azure VMware Solution to your existing VMware infrastructure on-premises.

1. **Plan Azure VMware Solution Deployment**

    - Plan deployment
        - Azure components: subscription, resource group, number of nodes, vCenter/NSX-T admin passwords
        - Eligibility criteria: EA, CSP, register provider
        - Migration assessment: Azure Migrate
        - Network planning: VNet/ExpressRoute considerations, routing/subnet configurations, required ports, DHCP/DNS resolution considerations
        - Solution components: software versions, nodes, private clouds, clusters, host maintenance, and lifecycle management

    **Knowledge check**

    - Which planning step is not required to deploy Azure VMware Solution in the Azure portal?
    
        - Create a new support request if you're an Enterprise Agreement customer - false
        - Register the Microsoft.AVS resource provider - false
        - A service principal - true

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
    - Possible video: https://www.youtube.com/embed/gng7JjxgayI
    - Possible demo: https://bjd52q.axshare.com/#id=q3ewtk&p=dashboard&g=1

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

        - Virtual Private Network - false
        - ExpressRoute Global Reach - true
        - Load Balancer - false

    - Which resource is required to peer the Azure VMware Solution private cloud to on-premises?

        - Customer provided ExpressRoute - true
        - Application Gateway - false
        - Network Virtual Appliance - false

1. **Module Knowledge Check**

    - When you try to deploy Azure VMware Solution, you receive an error stating "NoRegisteredProviderFound." What should you try next?

        - Try to redeploy and see if the same error message displays. - false
        - Register Microsoft.AVS resource provider for the subscription. - true
        - Try deploying Azure VMware Solution in a different region. - false
     
    - If you can't connect to your Azure VMware Solution environment from on-premises, what would be a good configuration step to take or inspect?
    
        - Check to see if path prepends or local path preferences have been configured. - true
        - Delete Azure VMware Solution deployment and redeploy service. - false
        - Check permissions on the subscription and resource group. - false

    -  When you try to deploy Azure VMware Solution, you receive an error message highlighting there are steps to take before node deployment. How do you resolve the error so you can continue with the deployment?

        - Check permissions on the subscription and resource group. - false
        - Use a different region. - false
        - Open up a new support ticket to have hosts allocated. - true

1. **Summary**

    In this module, you learned how to deploy and connect Azure VMware Solution to an on-premises VMware environment. First, you learned about all necessary planning to deploy Azure VMware Solution. From there, you learned about how to deploy Azure VMware Solution in Azure. Lastly, you learned how to connect the Azure VMware Solution private cloud to your on-premises VMware environment. Knowing how to successfully build and configure Azure VMware Solution will help out your company with future server migrations.

## Notes

[Azure VMware Solution](https://azure.microsoft.com/services/azure-vmware/)

[Azure VMware Solution documentation](https://docs.microsoft.com/azure/azure-vmware/)

[Azure VMware Solution - VMware documentation](https://cloud.vmware.com/azure-vmware-solution)

Placeholder: Azure VMware Solution Learn path URL