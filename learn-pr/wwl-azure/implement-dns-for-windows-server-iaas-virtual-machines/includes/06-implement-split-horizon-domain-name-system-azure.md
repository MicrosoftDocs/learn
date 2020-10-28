

Contoso uses internet-facing DNS servers in its perimeter network to resolve DNS queries for external clients. Internal DNS servers resolve queries for internal clients. The IT team needs a way to resolve the same names for both internal and external clients in Azure. You suggest split-horizon DNS.

## What is split-horizon DNS?

*Split-horizon DNS* (also sometimes called *split-brain DNS*) uses the same DNS domain name for both internet and internal resources. But having a matching internal and external DNS namespace can pose certain problems. However, split-horizon DNS can provide a solution to these problems. 

Split-horizon DNS is a configuration in which your resources have two primary DNS zones for the same domain that contain domain-name registration information. Your internal network hosts are directed to one zone, whereas external hosts are directed to another for name resolution. 

For example, in a non-split DNS configuration for the domain `contoso.com`, you might have a DNS zone similar to the example in the following table.

|Host|Record type|IP address|
|----------|-----------|-------------|
|www|A|131.107.1.200|
|Relay|A|131.107.1.201|
|Webserver1|A|192.168.1.200|
|Exchange1|A|192.168.0.201|

When a client computer on the internet wants to access the SMTP relay by using the published name of `relay.contoso.com`, it queries the DNS server that returns the result 131.107.1.201. The client then establishes a connection over SMTP to that IP address.

However, the client computers on the organization’s intranet also use the published name of `relay.contoso.com`. The DNS server returns the same result: a public IP address of 131.107.1.201. The client now attempts to establish a connection to the returned IP address by using the external interface of the publishing computer. Depending on the client configuration, this might not be successful.

## Implement split-horizon DNS in Azure

By configuring two zones for the same domain name, you can avoid this problem. To implement split-horizon DNS in Azure, you must create the following two Azure DNS zones:

- A public DNS zone named `contoso.com`. You must register the public IP addresses for appropriate VMs as DNS records within this zone.
- A private DNS zone also named `contoso.com`. You must link an appropriate VNet to this zone as the Registration VNet. Azure automatically registers the VMs on that VNet as host (A) records into your private zone, pointing to their private IP addresses.

The private zone for `Contoso.com` would contain the information in the following table.

|Host|Record type|IP address|
|----------|-----------|----------------------|
|www|CNAME|`Webserver1.contoso.com`|
|Relay|CNAME|`Exchange1.contoso.com`|
|Webserver1|A|192.168.1.200|
|Exchange1|A|192.168.1.201|

The public zone for `Contoso.com` would contain the information in the following table.

|Host|Record type|IP address|
|-----|-----------|-----------------|
|www|A|131.107.1.200|
|Relay|A|131.107.1.201|
||MX|`Relay.contoso.com`|

Now client computers in the internal and external networks can resolve the name `relay.contoso.com` to the appropriate internal or external IP address.

> [!NOTE] 
> In Windows Server DNS, split-horizon DNS is achieved using DNS policies.
