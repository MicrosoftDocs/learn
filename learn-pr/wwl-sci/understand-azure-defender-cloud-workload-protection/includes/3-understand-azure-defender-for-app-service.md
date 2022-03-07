Azure App Service is a fully managed platform for building and hosting your web apps and APIs without worrying about having to manage the infrastructure. It provides management, monitoring, and operational insights to meet enterprise-grade performance, security, and compliance requirements. For more information, see [Azure App Service](/azure/app-service/overview?azure-portal=true).

Microsoft Defender for App Service uses the scale of the cloud to identify attacks targeting applications running over App Service. Attackers probe web applications to find and exploit weaknesses. Before being routed to specific environments, requests to applications running in Azure go through several gateways, where they're inspected and logged. This data is then used to identify exploits and attackers and learn new patterns that will be used later.

By using the visibility that Azure has as a cloud provider, Defender for Cloud analyzes App Service internal logs to identify attack methodology on multiple targets. For example, methodology includes widespread scanning and distributed attacks. This type of attack typically comes from a small subset of IPs and shows patterns of crawling to similar endpoints on multiple hosts. The attacks are searching for a vulnerable page or plugin and can't be identified from the standpoint of a single host.

## What does Microsoft Defender for App Service protect?

With the App Service plan enabled, Defender for Cloud assesses the resources covered by your App Service plan and generates security recommendations based on its findings. Defender for Cloud protects the VM instance in which your App Service is running and the management interface. It also monitors requests and responses sent to and from your apps running in App Service.

If you're running a Windows-based App Service plan, Defender for Cloud also has access to the underlying sandboxes and VMs. Together with the log data mentioned above, the infrastructure can tell the story, from a new attack circulating in the wild to compromises in customer machines. Therefore, even if Defender for Cloud is deployed after a web app has been exploited, it might be able to detect ongoing attacks.

## Protect your Azure App Service web apps and APIs

To protect your Azure App Service plan with Microsoft Defender for App Service:

- Ensure you have a supported App Service plan that is associated with dedicated machines. Supported plans are listed [here](/azure/app-service/overview-hosting-plans?azure-portal=true).

- Enable Defender for Cloud on your subscription (you can optionally enable only the Defender for App Service plan).

Defender for Cloud is natively integrated with App Service, eliminating the need for deployment and onboarding - the integration is transparent.
