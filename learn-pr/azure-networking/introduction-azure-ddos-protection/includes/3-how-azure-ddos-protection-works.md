
In evaluating, whether Contoso should upgrade to DDoS Protection Standard, you need to understand how the service works.

In this unit, you’ll learn how Azure DDoS Protection Standard works.

## Features Azure standard DDoS Protection

As outlined in the previous unit, Azure DDoS Protection Standard provides additional capabilities compared to Basic tier. When enabling Azure DDoS Protection Standard, the first step is to create a DDoS Protection Plan and associating Virtual Networks to that plan. Only services with a public IP address on the Virtual Networks are protected. For example, the public IP of an Azure Web Application Firewall (WAF), available in Azure Application Gateway, deployed for layer 7 protections, is protected. Any systems using Non-Routeable IP address on the protected Virtual Network, are not included in the Protection Plan. This is a customer benefit since these systems are not Internet facing, there is no charge for their protection.

To simplify deployment, you can configure one DDoS protection plan for your organization and link virtual networks from multiple subscriptions to the same plan.

Now that the DDoS Protection Plan is created, the next step is to assign a scope to the plan. Selecting which services get DDoS Protection Standard can be based on Resource Group, Management Group, or Subscription.

DDoS Policy is generated from the DDoS Protection Plan. It is auto configured and optimized by applying machine learning algorithms and optimized by specific network traffic monitoring.

DDoS Protection Standard monitors network traffic and constantly compares it against the limits defined in the DDoS Policy.

When the traffic upper limit is exceeded, DDoS mitigation is initiated automatically.  During the mitigation, packets sent to a protected resource are rerouted by the DDoS protection service. Several checks are performed on this traffic, to ensure packets conform to internet specifications and are not malformed. Valid IP traffic is forwarded to the intended service. DDoS Protection Standard applies three autotuned mitigation policies (TCP SYN, TCP & UDP) for each public IP address associated with a protected resource.

When traffic returns below the thresholds, the mitigation is suspended. This protection does not apply to App Service Environments.

The following diagram shows the data flow through the DDoS Protection Standard.

:::image type="content" source="../media/3-ddos-policy-traffic-flow.png" alt-text=" data flow through the DDoS Protection Standard.":::

### Azure DDoS Protection Adaptive Tuning

Each Azure application has a unique traffic pattern like the uniqueness of a human fingerprint. In DDoS protection, the process is to detection the attack, and then stop the attack. In DDoS Protection Standard, a proprietary machine learning (ML) algorithm, is used. This ML seeks to identify the traffic pattern (fingerprint) for your application. Based on that, an application traffic profile is built.

For example, the algorithm learns, that at nine o'clock Monday mornings the data traffic, on your business-critical application, is different from data traffic at nine o'clock Sunday mornings. It learns how the traffic pattern changes every minute, how it shifts every hour of a day, every week, every month of the year.

In the event this application starts receiving traffic outside the standard range DDoS standard mitigation policy upper limit will be increased to support what might be a seasonal surge.

If someone is trying to DDoS your application, the traffic would continue to grow. At that point alerts will be triggered since something seems anomalous with the traffic. The incoming traffic to the application will be inspected in real time to test for valid packets.

Invalid packets will be dropped so they do not impact the availability and performance of your application.

### Azure DDoS Protection Standard metrics

In the example above, shortly after the detection of an attack, notifications are sent using Azure Monitor metrics. Any DDoS protection metrics are used to generate alerts. Data logged during an attack, should be used for analysis of the attack. Azure Sentinel, partner SIEM tools, Azure Monitor logs, and other diagnostic services can be used. The logged data is retained for 30 days.

### Test your DDoS Protection

Testing and validating are crucial to understand how a system will perform during a DDoS attack. An attack simulator for testing how well your protected services will perform during a DDoS attack is available for Azure customers. The simulator can be used to:

- Validate your key services are protected during a DDoS attack.

- Practice your incident respond for a DDoS attack.

- Help train your security personnel.

Information on this service can be found in **Future Learning Links** at the end of this course.
