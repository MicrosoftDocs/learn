
Microsoft Defender for Cloud is a unified infrastructure security management system that strengthens the security posture of your data centers, and provides advanced threat protection across your hybrid workloads in the cloud - whether they're in Azure or not - as well as on premises.

Keeping your resources safe is a joint effort between your cloud provider, Azure, and you, the customer. You have to make sure your workloads are secure as you move to the cloud, and at the same time, when you move to IaaS (infrastructure as a service) there is more customer responsibility than there was in PaaS (platform as a service), and SaaS (software as a service). Microsoft Defender for Cloud provides you the tools needed to harden your network, secure your services and make sure you're on top of your security posture.

Microsoft Defender for Cloud addresses the three most urgent security challenges:
* **Rapidly changing workloads** – It's both a strength and a challenge of the cloud. On the one hand, end users are empowered to do more. On the other, how do you make sure that the ever-changing services people are using and creating are up to your security standards and follow security best practices?
* **Increasingly sophisticated attacks** - Wherever you run your workloads, the attacks keep getting more sophisticated. You have to secure your public cloud workloads, which are, in effect, an Internet facing workload that can leave you even more vulnerable if you don't follow security best practices.
* **Security skills are in short supply** - The number of security alerts and alerting systems far outnumbers the number of administrators with the necessary background and experience to make sure your environments are protected. Staying up-to-date with the latest attacks is a constant challenge, making it impossible to stay in place while the world of security is an ever-changing front.

To help you protect yourself against these challenges, Defender for Cloud provides you with the tools to:
* **Strengthen security posture**: Defender for Cloud assesses your environment and enables you to understand the status of your resources, and whether they are secure.
* **Protect against threats**: Defender for Cloud assesses your workloads and raises threat prevention recommendations and security alerts.
* **Get secure faster**: In Defender for Cloud, everything is done in cloud speed. Because it is natively integrated, deployment of Defender for Cloud is easy, providing you with autoprovisioning and protection with Azure services.

### Architecture
Because Defender for Cloud is natively part of Azure, PaaS services in Azure - including Service Fabric, SQL databases, and storage accounts - are monitored and protected by Defender for Cloud without necessitating any deployment.

In addition, Defender for Cloud protects non-Azure servers and virtual machines in the cloud or on premises, for both Windows and Linux servers, by installing the Log Analytics agent on them. Azure virtual machines are auto-provisioned in Defender for Cloud.

The events collected from the agents and from Azure are correlated in the security analytics engine to provide you tailored recommendations (hardening tasks), that you should follow to make sure your workloads are secure, and security alerts. You should investigate such alerts as soon as possible to make sure malicious attacks aren't taking place on your workloads.

When you enable Defender for Cloud, the security policy built-in to Defender for Cloud is reflected in Azure Policy as a built in initiative under Defender for Cloud category. The built-in initiative is automatically assigned to all Defender for Cloud registered subscriptions (Free or Standard tiers). The built-in initiative contains only Audit policies.

Defender for Cloud makes mitigating your security alerts one step easier, by adding a Secure Score. The Secure Scores are now associated with each recommendation you receive to help you understand how important each recommendation is to your overall security posture. This is crucial in enabling you to prioritize your security work.

> [!div class="mx-imgBorder"]
> ![Screenshot of Defender for Cloud showing the secure score value.  Score is a 656 out of 1000 with several recommendations on how to increase it.](../media/az500-azure-security-center.png)

### Microsoft Defender for Cloud recommendations

The heart of Microsoft Defender for Cloud's value lies in its recommendations. The recommendations are tailored to the particular security concerns found on your workloads, and Defender for Cloud does the security admin work for you, by not only finding your vulnerabilities, but providing you with specific instructions for how to get rid of them.
In this way, Defender for Cloud enables you not just to set security policies, but to apply secure configuration standards across your resources.

The recommendations help you to reduce the attack surface across each of your resources. That includes Azure virtual machines, non-Azure servers, and Azure PaaS services such as SQL and Storage accounts and more - where each type of resource is assessed differently and has its own standards.

### Scan container images in Azure Container Registry for vulnerabilities

Microsoft Defender for Cloud can scan container images in Azure Container Registry (ACR) for vulnerabilities.

The image scanning works by parsing through the packages or other dependencies defined in the container image file, then checking to determine whether there are any known vulnerabilities in those packages or dependencies (powered by a Qualys vulnerability assessment database).

The scan is automatically triggered when pushing new container images to Azure Container Registry. Found vulnerabilities will surface as Defender for Cloud recommendations and be included in the Secure Score together with information on how to patch them to reduce the attack surface they allowed.
Defender for Cloud shows scanning status to reflect the progress of the scan (**Unscanned, Scan in progress, Scan error, and Completed**).

### Protect PaaS
Defender for Cloud helps you detect threats across Azure PaaS services. You can detect threats targeting Azure services including Azure App Service, Azure SQL, Azure Storage Account, and more data services. You can also take advantage of the native integration with the Microsoft Defender for Cloud Apps User and Entity Behavioral Analytics (UEBA) to perform anomaly detection on your Azure activity logs.

### Licensing 
* **Defender for Cloud's free pricing tier** is enabled on all your current Azure subscriptions once you visit the workload protection dashboard in the Azure portal for the first time, or if enabled programmatically via API. 
* **Standard tier** To take advantage of advanced security management and threat detection capabilities, you must upgrade to the standard pricing tier. 
The standard tier can be tried for free for 30 days. 
