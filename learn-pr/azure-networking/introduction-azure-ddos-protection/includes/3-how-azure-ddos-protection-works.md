To better evaluate whether Contoso should upgrade to DDoS Protection, you need to understand how the service works. In this unit, you’ll learn about the features of DDoS Protection and how it works.

## Features of DDoS Protection

As outlined in the previous unit, Azure DDoS Protection provides more capabilities than infrastructure protection. When enabling DDoS Protection, the first step is to create a DDoS Protection Plan and associate virtual networks to that plan. Only services with a public IP address on the virtual networks are protected. For example, the public IP of an Azure Web Application Firewall that's available in Azure Application Gateway and deployed for layer 7 protections is protected. Any systems using non-routeable IP addresses on the protected virtual network aren’t included in the Protection Plan. This is a customer benefit, because these systems are not internet-facing and there's no charge for their protection.

> [!NOTE]
> To simplify deployment, you can configure one DDoS protection plan for your organization and link virtual networks from multiple subscriptions to the same plan.

After configuring a DDoS protection plan, you need to assign a scope to the plan. You can select the services that will get DDoS Protection by using your user-defined Azure Resource Groups, Management Groups, or Subscriptions.

Your DDoS policy is generated from the DDoS protection plan. It's autoconfigured and optimized by applying machine learning algorithms and using specific network traffic monitoring.

DDoS Network Protection monitors network traffic and constantly compares it to the limits defined in the DDoS policy. When your traffic exceeds the maximum limit, DDoS mitigation is initiated automatically. During the mitigation, packets sent to a protected resource are rerouted by the DDoS protection service. Several checks are performed on this traffic, to help ensure that packets conform to internet specifications and are not malformed. Valid IP traffic is forwarded to the intended service. DDoS Network Protection applies three autotuned mitigation policies&#8212;TCP SYN, TCP, and UDP&#8212;for each public IP address associated with a protected resource.

When traffic decreases to less than the applicable threshold, the mitigation is suspended. This protection doesn't apply to App Service environments.

The following diagram depicts the data flow through the DDoS Protection.

:::image type="content" source="../media/3-ddos-policy-traffic-flow.png" alt-text="A customer subscribing to DDoS Protection, which triggers a DDoS protection policy. Data traffic anomalies activate DDoS Protection for attack mitigation." border="false":::

### Azure DDoS Protection Adaptive Tuning

Each Azure application has its own traffic pattern, which is unique like a human fingerprint. In DDoS protection, the process is to detect the attack and then stop the attack. DDoS Protection uses a proprietary machine learning algorithm, which identifies the traffic pattern (fingerprint) for your application and uses that pattern to build an application traffic profile.

In the event this application starts receiving traffic outside the standard range, your DDoS Protection mitigation policy upper limit will be increased to support what might be a seasonal surge.

If someone is trying to DDoS your application, the traffic would continue to grow. At that point, DDoS Protection triggers alerts, because something seems anomalous with the traffic. The incoming traffic to the application will be inspected in real time to test for valid packets. Invalid packets will be dropped so they do not impact the availability and performance of your application.

### DDoS Protection metrics

In the previous example, shortly after the detection of an attack, DDoS Protection sends notifications by using Azure Monitor metrics and any DDoS protection alerts. You should analyze the attack by using the data that was logged during that attack. You can use Microsoft Sentinel, partner SIEM tools, Azure Monitor logs, and other diagnostic services for this purpose. The logged data is retained for 30 days.

### Test your DDoS protection

Testing and validating are crucial to understanding how a system will perform during a DDoS attack. Azure customers can use an attack simulator for testing the performance of your protected services during a DDoS attack. This simulator is available at the [BreakingPoint Cloud](https://www.keysight.com/us/en/products/network-security/breakingpoint-cloud.html?azure-portal=true) website.

You can use attack simulators to:

- Validate that your key services are protected during a DDoS attack.

- Practice your incident response to a DDoS attack.

- Help train your security personnel.

You can find more information on this service by reviewing the reference links in the summary unit.
