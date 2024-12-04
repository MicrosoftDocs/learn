Now we discuss how to determine which Azure Front Door SKU is the best choice for your needs. Your organization wants to provide efficient, reliable, and optimized access to application content that's hosted in Azure. We review the following criteria:

- Scalability
- Security
- Pricing
- Content delivery

It's also important to consider several other Azure products you could use instead of Azure Front Door, including:

- **Azure Traffic Manager**, which provides DNS-based global routing. However, it doesn't provide for Transport Layer Security (TLS) protocol termination, or *SSL offload*, per-HTTP/HTTPS request, or application-layer processing.
- **Azure Application Gateway**, which can load-balance between your servers in a region at the application layer.

## Decision criteria

You can use Azure Front Door to build, operate, and scale out your dynamic web application and static content. Remember, the following tiers are available:

- Azure Front Door Standard, which is content-delivery optimized.
- Azure Front Door Premium, which is security optimized.

The decision you make depends on whether you require the other features that Azure Front Door Standard and Azure Front Door Premium offer.

| **Criteria** | **Analysis**|
| --- | --- |
| **Scalability** | Does your organization scale-out content? Organizations that host scalable content benefits more from using Azure Front Door. |
| **Pricing** | Does your organization prefer a monthly charge for each policy or hourly billing? Do you want to pay extra charges for custom rules? Review the pricing considerations in the *Pricing* section later in this unit. |
| **Content delivery** | Do you require content optimization, without extensive security capabilities? Azure Front Door Standard is a good choice in this case. |
| **Security** | Do you have enhanced security requirements? Azure Front Door Premium is your best option. |

## Apply the criteria

To decide which product has the features you need, review the following criteria and the recommendations about which product meets them.

### Scalability

Organizations that don't host global, scalable web applications might not benefit from implementing Azure Front Door. However, if it builds, operates, and scales out dynamic web applications and static content, it can benefit from the use of the different Azure Front Door tiers.

Consider using Azure Front Door when you want to:

- Define, manage, and monitor your web traffic's global routing.
- Optimize for top-tier, end-user performance and reliability through quick global failover.

### Pricing

Azure Front Door billing is based on outbound data transfers, inbound data transfers, and routing rules. If you implement Azure Web Application Firewall and Azure Content Delivery Network, pricing includes:

- A monthly charge per policy.
- Other charges for custom rules and managed rule sets.

Azure Front Door Standard/Premium billing is based on the following criteria:

- A fixed charge calculated on hourly basis
- Outbound data transfers
- Inbound data transfers
- Requests incoming from client to Azure Front Door points of presence

### Content delivery

Consider using Azure Front Door Standard when you want to:

- Optimize your content delivery.
- Provide for both static and dynamic content acceleration.
- Support global load balancing.
- Implement SSL offload.
- Implement domain and certificate management.
- Benefit from enhanced traffic analytics.
- Benefit from basic security capabilities.

### Security

Consider using Azure Front Door Premium when you need Azure Front Door Standard features and require:

- Extensive security capabilities across Web Application Firewall.
- BOT protection.
- Private Link support.
- Integration with Microsoft Threat Intelligence and security analytics.

> [!NOTE]
> Azure Web Application Firewall pricing is included in Premium tier.
