A public IP address resource can be associated with virtual machine network interfaces, internet-facing load balancers, VPN gateways, and application gateways.

:::row:::
  :::column:::
    **Public IP addresses**
  :::column-end:::
  :::column:::
    **IP address association**
  :::column-end:::
  :::column:::
    **Dynamic**
  :::column-end:::
  :::column:::
    **Static**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Virtual Machine
  :::column-end:::
  :::column:::
    NIC
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Load Balancer
  :::column-end:::
  :::column:::
    Front-end configuration
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    VPN Gateway
  :::column-end:::
  :::column:::
    Gateway IP configuration
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes\*
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Application Gateway
  :::column-end:::
  :::column:::
    Front-end configuration
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes\*
  :::column-end:::
:::row-end:::


 -  Static IP addresses only available on certain SKUs.

## Address SKUs

When you create a public IP address, you are given a SKU choice of either **Basic** or **Standard**. Your SKU choice affects the IP assignment method, security, available resources, and redundancy. This table summarizes the differences.

:::row:::
  :::column:::
    **Feature**
  :::column-end:::
  :::column:::
    **Basic SKU**
  :::column-end:::
  :::column:::
    **Standard SKU**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IP assignment
  :::column-end:::
  :::column:::
    Static or dynamic
  :::column-end:::
  :::column:::
    Static
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Security
  :::column-end:::
  :::column:::
    Open by default
  :::column-end:::
  :::column:::
    Are secure by default and closed to inbound traffic
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resources
  :::column-end:::
  :::column:::
    Network interfaces, VPN Gateways, Application Gateways, and Internet-facing load balancers
  :::column-end:::
  :::column:::
    Network interfaces or public standard load balancers
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Redundancy
  :::column-end:::
  :::column:::
    Not zone redundant
  :::column-end:::
  :::column:::
    Zone redundant by default
  :::column-end:::
:::row-end:::
