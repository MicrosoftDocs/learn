Network security is an ever-changing and shifting battleground where a moment's hesitation can allow cybercriminals to compromise your security perimeter and steal valuable assets and resources. Using Azure Security Center gives you infrastructure level security management to protect your data and provides advanced threat protection for both on-premises, cloud, and hybrid workloads in the cloud - whether they're in Azure or not - as well as on premises. Azure Security Center provides you the tools needed to harden your network, secure your services, and make sure you're on top of your security posture.

Azure Security Center addresses the three most urgent security challenges:

- **Rapidly changing workloads**: As organizations empower their users to do more, it creates challenges to ensure that the ever-changing services people are using and creating are up to your security standards and follow security best practices.
- **Increasingly sophisticated attacks**: Wherever you run your work, the attacks keep getting more sophisticated. Securing your public Internet-facing services is essential; otherwise, it will leave you even more vulnerable.
- **Security skills are in short supply**: The number of security alerts and alerting systems far outnumbers the number of administrators with the necessary background and experience to ensure your environments are protected.

To help protect against these challenges, Azure Security Center provides you with the tools to:

- **Strengthen security posture**: Security Center assesses your environment and enables you to understand your resources' status and whether they are secure.

- **Protect against threats**: Security Center assesses your workloads and raises threat prevention recommendations and security alerts.

- **Get secure faster**: In Security Center, everything is done in cloud speed. Because it is natively integrated, deployment of Security Center is easy, providing you with auto-provisioning and protection with Azure services.

Also, Security Center protects non-Azure servers and virtual machines in the cloud or on-premises, for both Windows and Linux servers, by installing the Log Analytics agent on them. Azure virtual machines are auto-provisioned in Security Center.

### Strengthen your security posture

You can improve your security posture using Azure Security Center to identify and perform hardening tasks across your machines, data services, and applications. With Azure Security Center, you can manage and enforce security policies to ensure compliance across your virtual machines, non-Azure servers, and Azure PaaS services.

### Continuous Assessment

Security Center brings continuous assessment of your entire estate, discovering and reporting whether new and existing resources and assets are configured according to your security compliance requirements. You’ll get a prioritized list of recommendations of what needs to be fixed to maintain maximum protection. Security Center groups the recommendations into security controls and adds a secure score value to each control. This is crucial in enabling you to prioritize your security work.

:::image type="content" source="../media/3-security-center-recommendations.png" alt-text="Screenshot showing part of Azure Security Center with recommendations as to what needs to be fixed to maintain maximum protection.":::

### Network map

One of the most powerful tools Security Center provides for continuously monitoring the security status of your network is the Network map. The map enables you to see the topology of your workloads, so you can see if each node is properly configured. You can see how your nodes are connected, which helps you block unwanted connections that could potentially make it easier for an attacker to creep along your network.

:::image type="content" source="../media/3-network-map.png" alt-text="Diagram showing the Security Center network map.":::

### Protect against threats

With Azure Security Center’s threat protection, you can detect and prevent threats on Infrastructure as a Service (IaaS), Non-Azure servers, and Platform as a Service (PaaS). It comes with these features:

- **Integration with Microsoft Defender**: Security Center natively integrates with Microsoft Defender for Endpoint.
- **Protect PaaS**: Security Center helps you detect threats across Azure PaaS services. You can detect threats targeting Azure services, including Azure App Service, Azure SQL, Azure Storage Account, and more data services.
- **Block brute force attacks**: By reducing access to virtual machine ports, using the just-in-time VM access, you can harden your network by preventing unnecessary access.
- **Protect data services**: Get assessments for potential vulnerabilities across Azure SQL and Storage services and recommendations for mitigating them.

Security Center's threat protection automatically correlates alerts in your environment based on cyber kill-chain analysis, to help you better understand the full story of an attack campaign, where it started and what kind of impact it had on your resources.

### Get Secure Faster

With Security Center, organizations can get secure faster through integration with other Microsoft security solutions. Also, integration with Azure and Azure resources means you can pull together a complete security story involving Azure Policy and built-in Security Center policies across all your Azure resources, and make sure that the whole thing is automatically applied to newly discovered resources as you create them in Azure.
