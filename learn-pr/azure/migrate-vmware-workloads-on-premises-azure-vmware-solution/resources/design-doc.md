# Title

- Migrate VMware workloads on-premises to Azure VMware Solution

## Role(s)

- Administrator
- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure VMware Solution
- Hybrid Cloud Exchange
- Azure Virtual Networking

## Prerequisites

- Experience managing VMware infrastructure, such as vSphere, vCenter, NSX-T, and HCX.
- Basic knowledge of network concepts, such as classless inter-domain routing (CIDR) and subnets.

## Summary

First, you'll learn how to plan for the HCX deployment on-premises. From there, you'll learn how to deploy HCX on-premises and connect it to Azure VMware Solution. Additionally, you'll learn about the steps required to ensure the service is configured correctly. After HCX is deployed, you'll learn how to migrate VMware workloads on-premises to AVS. Learning all these steps will help out your business by quickly migrating VMware workloads into Azure VMware Solution.

## Learning objectives

1. Configure Hybrid Cloud Exchange (HCX) to support on-premises VMware migrations.
1. Migrate VMware workloads on-premises to Azure VMware Solution.

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Unit Task   | Conceptual unit title | Practice unit title |
| :---------- | :-------------------- | :------------------ |
| 1. Scenario | Introduction          | N/A                 |
| 2. Plan | Plan HCX deployment | N/A |
| 3. Deploy | VMware HCX deployment and installation | N/A |
| 4. Connect | Configure VMware HCX | N/A |
| 5. Migrate | Migrate VMware workloads on-premises into Azure VMware Solution | N/A
| 6. Module Knowledge Check | Azure VMware Solution migration knowledge check | N/A
| 7. Summary  | Summary | N/A |

## Outline the units

1. **Introduction**

    Imagine you work for a healthcare company that runs production workloads on a VMware platform.  Your company has decided to migrate existing VMware workloads to Azure VMware Solution (AVS). By using AVS, your company doesn't have to change virtualization platforms or alter existing operational patterns. You've planned for and deployed AVS. Now you need to migrate VM workloads on-premises to Azure. In this module, you'll learn how to migrate existing VMware workloads on-premises into Azure VMware Solution.

1. **Plan HCX deployment**

    - Plan HCX deployment
        - Discuss HCX version deployed with AVS and compatibility with on-premises environments.
        - Network and ports required for ExpressRoute Global Reach + all required ports for communication.
        - IP addresses (management network, vMotion network, uplink network, replication network).
        - VMware HCX migration types: bulk, cold, vMotion

    **Knowledge Check**

    - At a minimum, how many IPs do you need to identify on-premises for a network segment to use with VMware HCX?

        - 3 IPs - false
        - 10 IPs - false
        - 2 IPs - true
    
    - What version of vSphere on-premises is compatible with HCX 4.0, without needing another configuration?

        - vSphere 6.0 - true
        - vSphere 5.5 - false
        - vSphere 5.1 - false

    - How many site connections does HCX Advanced support?

        - 4 - false
        - 8 - false
        - 3 - true

1. **VMware HCX deployment and installation**

    - Log into HCX in AVS.
    - Use cloudadmin@vsphere.local account for HCX access.
    - Request download link and download OVA file for deployment.
    - Once OVA file is downloaded, deploy OVF template in on-premises vCenter.
    - Fill in all required fields for template deployment.
    - Activate VMware HCX: log into HCX, enter key in licensing field, configure SSO/PSC, restart HCX appliance.

    - Which account is used to access Azure VMware Solution HCX Manager?

        - Global Administrator - false
        - admin - false
        - cloudadmin@vsphere.local - true

    - If you can't activate your HCX Advanced Key, what might be the issue?

        - You didn't deploy the HCX appliance correctly. - false
        - A NAT rule isn't configured. - false
        - The environment doesn't have open internet access or a proxy configured. - true

1. **Configure networking and compute profiles for VMware HCX**
    - Add site pairing.
    - Enter settings to connect to remote site over port 443.
    - Use the same account (cloudadmin@vsphere.local) to sign in and connect the sites.
    - Create network profiles inside HCX:
        - Management
        - vMotion
        - Replication
        - Uplink
    - Create a compute profile in HCX:
        - Select clusters, datastores, management network profile, uplink network profile, vMotion network profile, vSphere replication network profile, and distributed switches for network extensions.
        - Review all connection rules and select continue and then select finish to create the compute profile.

1. **Create service mesh for VMware HCX**
    - Create a service mesh:
        - Review pre-populated sites, select source compute profile, remote compute profile, review services that will be enabled, then select continue.
        - In Advanced Configuration - Override Uplink Network profiles, select continue (uplink network profiles connect to the network through which the remote site's appliances can be reached).
        - In Advanced Configuration - Network Extension Appliance Scale Out, review and select continue.
        - In Advanced Configuration - Traffic Engineering, review and make necessary modifications and select continue. Review topology preview and select continue. Enter a user-friendly name for the service mesh and select finish to complete. Select view tasks to monitor deployment tasks. The service will show up as green when the deployment successfully finishes. Verify service mesh health.
    - Optional - create a network extension:
        - Select each of the networks AVS extends to, select Next.
        - Enter the on-premises gateway IP for each of the networks being extended.
        - When the extension finishes, it will say Extension complete.

1. **Migrate virtual machine workloads into AVS**

    - From HCX dashboard, select services > migration.
    - Select Migrate Virtual Machines
    - Select Remote Site Connection and select VMs from the list of machines available to migrate.
    - Set the transfer and placement, switchover, and extended options.
    - Select the destination network.
    - Select finish.

1. **Module Knowledge Check**

    - Let's say you have vSphere 5.5 deployed within your environment. What would you have to do to deploy HCX within your environment?

        - You can't deploy HCX to conduct any migrations into Azure VMware Solution. - false
        - Deploy and downgrade the HCX connector appliance on-premises to get support for the migration. - true
        - Deploy Azure VMware Solution in a different region. - false

    - You find you can't successfully establish an HCX site pairing. What might be the issue?

        - You'll need to redownload the HCX Connector OVA file. - false
        - You'll need to redeploy the HCX Connector OVA file on-premises. - false
        - Your VMware HCX Connector can't route to your HCX Cloud Manager IP over port 443. - true

    - If the VM you're trying to migrate is powered off, which migration is set by default?

        - Cold - true
        - Live - false
        - Bulk - false

    - In order for VMware HCX Connector to route to the HCX Cloud Manager environment, which port needs to be open?

        - 3389 - false
        - 443 - true
        - 53 - false

    -  You can't create a service mesh within HCX. What might be the issue?

        - Check permissions on the subscription and resource group. - false
        - Ports UDP 500/4500 are not open between your on-premises 'uplink' network profile the Azure VMware Solution 'uplink' network profile. - true
        - Redeploy HCX on-premises to connect to Azure VMware Solution. - false

1. **Summary**

    In this module, you learned how to deploy and configure Hybrid Cloud Exchange (HCX). First, you learned about all necessary pre-planning steps required to deploy HCX. From there, you learned about how to deploy HCX. You then learned how to configure and connect the HCX to your on-premises VMware environment. Finally, you learned how to migrate existing VMware workloads on-premises to Azure VMware Solution. Knowing how to successfully deploy and configure HCX will help out your company out with all server migrations.

## Notes

[Azure VMware Solution documentation](/azure/azure-vmware/)

[Azure VMware Solution VMware documentation](https://cloud.vmware.com/azure-vmware-solution)

[VMware HCX documentation](https://docs.vmware.com/en/VMware-HCX/index.html)

[VMware software version requirements for HCX](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-54E5293B-8707-4D29-BFE8-EE63539CC49B.html)

[VMware ports and protocols for HCX](https://ports.vmware.com/home/VMware-HCX)

Placeholder: Azure VMware Solution Learn path URL
