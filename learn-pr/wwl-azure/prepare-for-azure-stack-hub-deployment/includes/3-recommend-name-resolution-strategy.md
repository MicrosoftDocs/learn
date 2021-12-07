To be able to access Azure Stack Hub endpoints from outside Azure Stack Hub, you need to integrate the Azure Stack Hub DNS services with the DNS servers that host the DNS zones you want to use in Azure Stack Hub.

## Azure Stack Hub DNS namespace

You're required to provide some important information related to DNS when you deploy Azure Stack Hub.

:::row:::
  :::column:::
    **Field**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Example**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Region
  :::column-end:::
  :::column:::
    The geographic location of your Azure Stack Hub deployment.
  :::column-end:::
  :::column:::
    `east`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    External Domain Name
  :::column-end:::
  :::column:::
    The name of the zone you want to use for your Azure Stack Hub deployment.
  :::column-end:::
  :::column:::
    `cloud.fabrikam.com`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Internal Domain Name
  :::column-end:::
  :::column:::
    The name of the internal zone that's used for infrastructure services in Azure Stack Hub. It's Directory Service-integrated and private (not reachable from outside the Azure Stack Hub deployment).
  :::column-end:::
  :::column:::
    `azurestack.local`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    DNS Forwarders
  :::column-end:::
  :::column:::
    DNS servers that are used to forward DNS queries, DNS zones, and records that are hosted outside Azure Stack Hub, either on the corporate intranet or public internet. You can edit the DNS Forwarder value with the Set-AzSDnsForwarder cmdlet after deployment.
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Naming Prefix (Optional)
  :::column-end:::
  :::column:::
    The naming prefix you want your Azure Stack Hub infrastructure role instance machine names to have. If not provided, the default is `azs`.
  :::column-end:::
  :::column:::
    `azs`
  :::column-end:::
:::row-end:::


The fully qualified domain name (FQDN) of your Azure Stack Hub deployment and endpoints is the combination of the Region parameter and the External Domain Name parameter. Using the values from the examples in the previous table, the FQDN for this Azure Stack Hub deployment would be the following name:

`east.cloud.fabrikam.com`

As such, examples of some of the endpoints for this deployment would look like the following URLs:

`https://portal.east.cloud.fabrikam.com`

`https://adminportal.east.cloud.fabrikam.com`

To use this example DNS namespace for an Azure Stack Hub deployment, the following conditions are required:

 -  The zone fabrikam.com is registered either with a domain registrar, an internal corporate DNS server, or both, depending on your name resolution requirements.
 -  The child domain cloud.fabrikam.com exists under the zone fabrikam.com.
 -  The DNS servers that host the zones fabrikam.com and cloud.fabrikam.com can be reached from the Azure Stack Hub deployment.

To be able to resolve DNS names for Azure Stack Hub endpoints and instances from outside Azure Stack Hub, you need to integrate the DNS servers that host the external DNS zone for Azure Stack Hub with the DNS servers that host the parent zone you want to use.

### DNS name labels

Azure Stack Hub supports adding a DNS name label to a public IP address to allow name resolution for public IP addresses. DNS labels are a convenient way for users to reach apps and services hosted in Azure Stack Hub by name. The DNS name label uses a slightly different namespace than the infrastructure endpoints. Following the previous example namespace, the namespace for DNS name labels appears as follows:

`*.east.cloudapp.cloud.fabrikam.com`

Therefore, if a tenant indicates a value **Myapp** in the DNS name label field of a public IP address resource, it creates an A record for **myapp** in the zone **east.cloudapp.cloud.fabrikam.com** on the Azure Stack Hub external DNS server. The resulting fully qualified domain name appears as follows:

`myapp.east.cloudapp.cloud.fabrikam.com`

Integrate the DNS servers that host the external DNS zone for Azure Stack Hub with the DNS servers that host the parent zone you want to use. This is a different namespace than the namespace for the Azure Stack Hub service endpoints, so you must create another delegation or conditional forwarding rule.

## Resolution and delegation

There are two types of DNS servers:

 -  **An authoritative DNS server hosts DNS zones**. It answers DNS queries for records in those zones only.
 -  **A recursive DNS server doesn't host DNS zones**. It answers all DNS queries by calling authoritative DNS servers to gather the data it needs.

Azure Stack Hub includes both authoritative and recursive DNS servers. The recursive servers are used to resolve names of everything except for the internal private zone and the external public DNS zone for that Azure Stack Hub deployment.

:::image type="content" source="../media/Recommend-name-resolution-1-5751a42a.png" alt-text="Image showing normalized relational tables.":::


## Resolving external DNS names from Azure Stack Hub

To resolve DNS names for endpoints outside Azure Stack Hub, you need to provide DNS servers that Azure Stack Hub can use to forward DNS requests for which Azure Stack Hub isn't authoritative. For deployment, DNS servers that Azure Stack Hub forwards requests to are required in the Deployment Worksheet (in the DNS Forwarder field). Provide at least two servers in this field for fault tolerance. Without these values, Azure Stack Hub deployment fails.

### Configure conditional DNS forwarding

This procedure only applies to an AD FS deployment.

To enable name resolution with your existing DNS infrastructure, configure conditional forwarding.

To add a conditional forwarder, you must use the privileged endpoint.

For this procedure, use a computer in your datacenter network that can communicate with the privileged endpoint in Azure Stack Hub.

1.  Open an elevated Windows PowerShell session (run as administrator) and connect to the IP address of the privileged endpoint. Use the credentials for CloudAdmin authentication.
    
    ```
    $cred=Get-Credential
    Enter-PSSession -ComputerName <IP Address of ERCS> -ConfigurationName PrivilegedEndpoint -Credential $cred
    
    ```

2.  After you connect to the privileged endpoint, run the following PowerShell command. Substitute the sample values provided with your domain name and IP addresses of the DNS servers you want to use.
    
    ```
    Register-CustomDnsServer -CustomDomainName "contoso.com" -CustomDnsIPAddresses "192.168.1.1","192.168.1.2"
    
    ```

## Resolving Azure Stack Hub DNS names from outside Azure Stack Hub

The authoritative servers are the ones that hold the external DNS zone information, and any user-created zones. Integrate with these servers to enable zone delegation or conditional forwarding to resolve Azure Stack Hub DNS names from outside Azure Stack Hub.

## Get DNS Server external endpoint information

To integrate your Azure Stack Hub deployment with your DNS infrastructure, you need the following information:

 -  DNS server FQDNs
 -  DNS server IP addresses

The FQDNs for the Azure Stack Hub DNS servers have the following format:

`<NAMINGPREFIX>-ns01.<REGION>.<EXTERNALDOMAINNAME>`

`<NAMINGPREFIX>-ns02.<REGION>.<EXTERNALDOMAINNAME>`

Using the sample values, the FQDNs for the DNS servers are:

`azs-ns01.east.cloud.fabrikam.com`

`azs-ns02.east.cloud.fabrikam.com`

This information is also created at the end of all Azure Stack Hub deployments in a file named `AzureStackStampInformation.json`. This file is located in the `C:\CloudDeployment\logs` folder of the Deployment virtual machine. If you're not sure what values were used for your Azure Stack Hub deployment, you can get the values from here.
