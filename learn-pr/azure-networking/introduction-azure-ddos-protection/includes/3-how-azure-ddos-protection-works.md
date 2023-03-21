
After reviewing the previous chapter, you identified Contoso will benefit from the additional safeguards that the DDoS Protection service provides over the Infrastructure Protection service. In this unit, you’ll learn about the features of DDoS Protection and how it works.

## Features of DDoS Protection

<<<<<<< HEAD
As outlined in the previous unit, Azure DDoS Protection provides more capabilities than Infrastructure Protection.

### DDoS Protection

When enabling DDoS Protection, the first step is to associate virtual networks or IP addresses to  DDoS Protection. Only services with a public IP address on the virtual networks are protected. For example, the public IP of an Azure Web Application Firewall that's available in Azure Application Gateway and deployed for layer 7 protections is protected. Any systems using non-routeable IP addresses on the protected virtual network aren’t included in the Protection Plan. This is a customer benefit, because these systems aren't internet-facing and there's no charge for their protection.
=======
As outlined in the previous unit, Azure DDoS Protection provides more capabilities than infrastructure protection. When enabling DDoS Protection, the first step is to create a DDoS Protection Plan and associate virtual networks to that plan. Only services with a public IP address on the virtual networks are protected. For example, the public IP of an Azure Web Application Firewall that's available in Azure Application Gateway and deployed for layer 7 protections is protected. Any systems using non-routeable IP addresses on the protected virtual network aren’t included in the Protection Plan. This is a customer benefit, because these systems are not internet-facing and there's no charge for their protection.
>>>>>>> feaa85fe1746df0ac388dc207713100fc37ee987

> [!NOTE]
> To simplify deployment, you can configure DDOS Network Protection for your organization and link virtual networks from multiple subscriptions to the same plan.

After configuring DDoS Network Protection, you need to add protected resources. You can select the services that will get DDoS Protection by using your user-defined Azure Resource Groups, Management Groups, or Subscriptions. Alternatively, you can enable DDoS IP protection on a singular IP address. This is useful if you require protection for less than 100 IP addresses or you're testing DDoS Protection in your environment.

Your DDoS policy is generated when you enable DDoS Protection. It's auto-configured and optimized by applying machine learning algorithms and using specific network traffic monitoring.

<<<<<<< HEAD
DDoS Protection monitors network traffic and constantly compares it to the limits defined in the DDoS policy. When your traffic exceeds the maximum limit, DDoS mitigation is initiated automatically. During the mitigation, packets sent to a protected resource are rerouted by the DDoS protection service. Several checks are performed on this traffic, to help ensure that packets conform to internet specifications and aren't malformed. Valid IP traffic is forwarded to the intended service. DDoS Protection applies three auto-tuned mitigation policies&#8212;TCP SYN, TCP, and UDP&#8212;for each public IP address associated with a protected resource.
=======
DDoS Network Protection monitors network traffic and constantly compares it to the limits defined in the DDoS policy. When your traffic exceeds the maximum limit, DDoS mitigation is initiated automatically. During the mitigation, packets sent to a protected resource are rerouted by the DDoS protection service. Several checks are performed on this traffic, to help ensure that packets conform to internet specifications and are not malformed. Valid IP traffic is forwarded to the intended service. DDoS Network Protection applies three autotuned mitigation policies&#8212;TCP SYN, TCP, and UDP&#8212;for each public IP address associated with a protected resource.
>>>>>>> feaa85fe1746df0ac388dc207713100fc37ee987

When traffic decreases to less than the applicable threshold, the mitigation is suspended. This protection doesn't apply to App Service environments.

The following diagram depicts the data flow through the DDoS Protection.

:::image type="content" source="../media/mitigation.png" alt-text="Diagram of a customer subscribing to DDoS Protection, which triggers a DDoS protection policy. " border="false":::

In the following diagram DDoS Network Protection is enabled on the virtual network of the Azure (internet) load balancer that has the public IP associated with it.

:::image type="content" source="../media/ddos-network-protection-vm.png" alt-text="Diagram of data traffic anomalies activate DDoS Protection for attack mitigation. " border="false":::

In the following diagram DDoS IP Protection is enabled on the frontend public IP address of a public load balancer.

:::image type="content" source="../media/ddos-ip-protection-virtual-machine.png" alt-text="Screenshot of data traffic anomalies activate DDoS Protection for attack mitigation. " border="false":::
### Azure DDoS Protection Adaptive Tuning

Each Azure application has its own traffic pattern, which is unique like a human fingerprint. In DDoS protection, the process is to detect the attack and then stop the attack. DDoS Protection uses a proprietary machine learning algorithm, which identifies the traffic pattern (fingerprint) for your application and uses that pattern to build an application traffic profile.

In the event this application starts receiving traffic outside the standard range, your DDoS Protection mitigation policy upper limit will be increased to support what might be a seasonal surge.

If someone is trying to DDoS your application, the traffic would continue to grow. At that point, DDoS Protection triggers alerts, because something seems anomalous with the traffic. The incoming traffic to the application will be inspected in real time to test for valid packets. Invalid packets will be dropped so they don't impact the availability and performance of your application.

### DDoS Protection metrics

In the previous example, shortly after the detection of an attack, DDoS Protection sends notifications by using Azure Monitor metrics and any DDoS protection alerts. You should analyze the attack by using the data that was logged during that attack. You can use Microsoft Sentinel, partner SIEM tools, Azure Monitor logs, and other diagnostic services for this purpose. The logged data is retained for 30 days.

### Test your DDoS protection

Testing and validating are crucial to understanding how a system will perform during a DDoS attack. Azure customers can use our approved testing partners for testing the performance of your protected services during a DDoS attack:

- [BreakingPoint Cloud](https://www.ixiacom.com/products/breakingpoint-cloud): a self-service traffic generator where your customers can generate traffic against DDoS Protection-enabled public endpoints for simulations.
- [Red Button](https://www.red-button.net/): work with a dedicated team of experts to simulate real-world DDoS attack scenarios in a controlled environment.
- [RedWolf](https://www.redwolfsecurity.com/services/#cloud-ddos) a self-service or guided DDoS testing provider with real-time control.

You can use attack simulators to:

- Validate that your key services are protected during a DDoS attack.

- Practice your incident response to a DDoS attack.

- Help train your security personnel.

You can find more information on these services by reviewing the reference links in the summary unit.
