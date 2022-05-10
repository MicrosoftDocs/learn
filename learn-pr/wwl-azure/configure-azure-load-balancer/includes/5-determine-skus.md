When you create an Azure Load Balancer, you select the type (Internal or Public) of load balancer. You also select the SKU. The load balancer supports both Basic and Standard SKUs, each differing in scenario scale, features, and pricing. The Standard Load Balancer is the newer Load Balancer product with an expanded and more granular feature set over Basic Load Balancer. It is a superset of Basic Load Balancer.

:::image type="content" source="../media/load-balancer-types-a4c0eceb.png" alt-text="Screenshot of the Load Balancer instance page. The type is Internal, the SKU is basic, and VNet is associated.":::


## Capabilities

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
    Backend pools
  :::column-end:::
  :::column:::
    Up to 300 instances
  :::column-end:::
  :::column:::
    Up to 1000 instances
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Health probes
  :::column-end:::
  :::column:::
    HTTP, TCP
  :::column-end:::
  :::column:::
    HTTPS, HTTP, TCP
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Availability zones
  :::column-end:::
  :::column:::
    Not available
  :::column-end:::
  :::column:::
    Zone-redundant and zonal frontends for inbound and outbound traffic.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Multiple front ends
  :::column-end:::
  :::column:::
    Inbound only
  :::column-end:::
  :::column:::
    Inbound and outbound
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Secure by default
  :::column-end:::
  :::column:::
    Open by default. NSG optional.
  :::column-end:::
  :::column:::
    Closed to inbound flows unless allowed by an NSG. Internal traffic from the virtual network to the internal load balancer is allowed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SLA
  :::column-end:::
  :::column:::
    Not available
  :::column-end:::
  :::column:::
    99.99%
  :::column-end:::
:::row-end:::


> [!NOTE]
> The Basic SKU can be upgraded to the Standard SKU. But, new designs and architectures should use the Standard Load Balancer.
