If you have only a few applications and one domain controller, you might want to fail over the entire site together. In this case, we recommend using Site Recovery to replicate the domain controller to the target site (either in Azure or in a secondary on-premises datacenter). You can use the same replicated domain controller or DNS virtual machine for test failover.

If you have many applications and more than one domain controller in your environment, or if you plan to fail over a few applications at a time, in addition to replicating the domain controller virtual machine with Site Recovery, we recommended that you set up an extra domain controller in the target site (either in Azure or in a secondary on-premises datacenter). For test failover, you can use a domain controller that's replicated by Site Recovery. For failover, you can use the extra domain controller on the target site.

You can use Site Recovery to protect the virtual machine that hosts the domain controller or DNS.

## Protect the virtual machine

The domain controller that's replicated by using Site Recovery is used for test failover. Ensure that it meets the following requirements:

- The domain controller is a global catalog server.
- The domain controller should be the FSMO role owner for roles that are needed during a test failover. Otherwise, these roles will need to be seized after the failover.

### Configure virtual machine network settings

For the virtual machine that hosts the domain controller or DNS, in Site Recovery, configure network settings under the Compute and Network settings of the replicated virtual machine. This ensures that the virtual machine is attached to the correct network after failover.

## Protect Active Directory

### Site-to-Azure protection

First, create a domain controller in an Azure virtual network. When you promote the server to a domain controller role, specify the same domain name that's used on the primary site. Then, reconfigure the DNS server for the virtual network to use the DNS server in Azure.

### Azure-to-Azure protection

First, create a domain controller in an Azure virtual network. When you promote the server to a domain controller role, specify the same domain name that's used on the primary site. Then, reconfigure the DNS server for the virtual network to use the DNS server in Azure.

## Test failover considerations

To avoid impact on production workloads, test failover occurs in a network that's isolated from the production network. Most applications require the presence of a domain controller or a DNS server. Therefore, before the application fails over, you must create a domain controller in the isolated network to be used for test failover. The easiest way to do this is to use Site Recovery to replicate a virtual machine that hosts a domain controller or DNS. Then, run a test failover of the domain controller virtual machine before you run a test failover of the recovery plan for the application. Here's how you do that:

1. Use Site Recovery to replicate the virtual machine that hosts the domain controller or DNS.
2. Create an isolated network. Any virtual network that you create in Azure is isolated from other networks by default. We recommend that you use the same IP address range for this network that you use in your production network. Don't enable site-to-site connectivity on this network.
3. Provide a DNS IP address in the isolated network. Use the IP address that you expect the DNS virtual machine to get. If you're replicating to Azure, provide the IP address for the virtual machine that's used on failover. To enter the IP address, in the replicated virtual machine, in the Compute and Network settings, select the Target IP settings.

Site Recovery attempts to create test virtual machines in a subnet of the same name and by using the same IP address that's provided in the Compute and Network settings of the virtual machine. If a subnet of the same name isn't available in the Azure virtual network that's provided for test failover, the test virtual machine is created in the alphabetically first subnet.

If the target IP address is part of the selected subnet, Site Recovery tries to create the test failover virtual machine by using the target IP address. If the target IP isn't part of the selected subnet, the test failover virtual machine is created by using the next available IP in the selected subnet.

### Test failover to a secondary site

Do a test failover of the domain controller virtual machine that runs in the isolated network. Use the latest available application-consistent recovery point of the domain controller virtual machine to do the test failover. Run a test failover for the recovery plan that contains virtual machines that the application runs on. When testing is complete, clean up the test failover on the domain controller virtual machine. This step deletes the domain controller that was created for test failover.

### Remove references to other domain controllers

When you initiate a test failover, don't include all the domain controllers in the test network. To remove references to other domain controllers that exist in your production environment, you might need to seize FSMO Active Directory roles and do metadata cleanup for missing domain controllers.

## Issues caused by virtualization safeguards

> [!IMPORTANT]
> Some of the configurations described in this section aren't standard or default domain controller configurations. If you don't want to make these changes to a production domain controller, you can create a domain controller that's dedicated to Site Recovery to use for test failover. Make these changes only to that domain controller.

Beginning with Windows Server 2012, extra safeguards are built into Active Directory Domain Services (AD DS). These safeguards help protect virtualized domain controllers against USN rollbacks if the underlying hypervisor platform supports virtual machine-GenerationID. Azure supports virtual machine-GenerationID. Because of this, domain controllers that run Windows Server 2012 or later on Azure Virtual Machines have these extra safeguards.

When virtual machine-GenerationID is reset, the InvocationID value of the AD DS database is also reset. In addition, the RID pool is discarded, and sysvol folder is marked as non-authoritative. Failing over to Azure might cause virtual machine-GenerationID to reset. Resetting virtual machine-GenerationID triggers extra safeguards when the domain controller virtual machine starts in Azure. This might result in a significant delay in being able to sign in to the domain controller virtual machine.

Because this domain controller is used only in a test failover, virtualization safeguards aren't necessary. To ensure that the virtual machine-GenerationID value for the domain controller virtual machine doesn't change, you can change the value following DWORD to 4 in the on-premises domain controller:

```bash
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gencounter\Start
```

### Symptoms of virtualization safeguards

If virtualization safeguards are triggered after a test failover, you might see one or more of following symptoms:

- The GenerationID value changes.
- The InvocationID value changes.
- Sysvol folder and NETLOGON shares aren't available.
- DFSR databases are deleted.

## DNS and domain controller on different machines

If you're running the domain controller and DNs on the same virtual machine, you can skip this procedure. If DNS isn't on the same virtual machine as the domain controller, you need to create a DNS virtual machine for the test failover. You can use a fresh DNS server, and create all the required zones. For example, if your Active Directory domain is contoso.com, you can create a DNS zone with the name contoso.com. The entries that correspond to Active Directory must be updated in DNS as follows:

1. Ensure that these settings are in place before any other virtual machine in the recovery plan starts:

     - The zone must be named after the forest root name.
     - The zone must be file-backed.
     - The zone must be enabled for secure and nonsecure updates.
     - The resolver of the virtual machine that hosts the domain controller should point to the IP address of the DNS virtual machine.
2. Run the following command on the virtual machine that hosts the domain controller:

    ```bash
    nltest /dsregdns
    ```

3. Run the following commands to add a zone on the DNS server, allow nonsecure updates, and add an entry for the zone to DNS:

    ```bash
    dnscmd /zoneadd contoso.com /Primary
    
    dnscmd /recordadd contoso.com contoso.com. SOA %computername%.contoso.com. hostmaster. 1 15 10 1 1
    
    dnscmd /recordadd contoso.com %computername% A <IP_OF_DNS_VM>
    
    dnscmd /config contoso.com /allowupdate 1
    ```
