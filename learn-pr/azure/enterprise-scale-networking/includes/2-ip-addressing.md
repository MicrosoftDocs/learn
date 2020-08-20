# IP Addressing

   ***Considerations***
        -Do not use overlapping IP address spaces across on-prem and Azure as this will cause routing problems
        -VNet address space can be extended but only when no peerings exist. This means that adding space could create application downtime as peerings are removed and re-added. 
        -Azure reserves five IP addresses per subnet.
        -Some services require dedicated subnets like Azure Firewall.
     ***Recommendations***
        -Plan the cloud IP schema well in advance, each Azure Region should get its own easily summarized range. For instance 10.1.0.0/16 is West US 2 and 10.2.0.0/16 is North Europe, etc.
        -Use private (RFC 1918) address space to avoid conflicts with other public IPs in use by Azure or on the internet.
        -Don't use overly large (/16) VNets in order to not waste RFC1918 address space.
        -Do not use public IP addresses for VNets unless you own those IPs and have no option to use RFC1918 space. This is to avoid conflicting with other internet services and to not waste IPV4 public IPs.
