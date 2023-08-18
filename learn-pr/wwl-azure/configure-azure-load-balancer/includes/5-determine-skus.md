
When you create an Azure load balancer in the Azure portal, you select the type of load balancer to create (internal or public) and the SKU. Azure Load Balancer supports three SKU options: Basic, Standard, and Gateway. Each SKU provides different features, scenario scaling, and pricing.

:::image type="content" source="../media/load-balancer-types-a4c0eceb.png" alt-text="Screenshot that shows how to create an Azure load balancer in the Azure portal.":::

### Things to know about Azure Load Balancer SKUs

Let's review some points to consider when choosing the SKU type for your load balancer.

- Standard Load Balancer is the newest product. It's essentially a superset of Basic Load Balancer.

- The Standard SKU offers an expanded and more granular feature set than the Basic SKU.

- The Basic SKU can be upgraded to the Standard SKU. But, new designs and architectures should use the Standard SKU.

- The Gateway SKU supports high performance and high availability scenarios with third-party network virtual appliances (NVAs).

## Compare Basic and Standard SKU features

The following table provides a brief comparison of how features are implemented in the Standard and Basic SKUs.

| Feature | Basic SKU | Standard SKU |
| --- | --- | --- |
| **Health probes** | HTTP, TCP | HTTPS, HTTP, TCP |
| **Availability zones** | Not available | Zone-redundant and zonal frontends for inbound and outbound traffic |
| **Multiple frontends** | Inbound only | Inbound and outbound |
| **Security** | - Open by default <br> - (Optional) Control through network security groups (NSGs) | - Closed to inbound flows unless allowed by an NSG <br> - Internal traffic from the virtual network to the internal load balancer is allowed |