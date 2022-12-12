## How does Permissions Management work? ##

Permissions Management allows you to address three key use cases in securing and managing identity permissions in cloud environments: *discover*, *remediate*, and *monitor*.

:::image type="content" source="../media/discover-remediate-monitor.png" alt-text="Image of the Discover, Remediate, and Monitor workflow of Entra Permisssions Management."lightbox="../media/discover-remediate-monitor.png":::

### Discover & Assess ###
Permissions Management gives you visibility to discover and assess permissions risk by evaluating the gap between permissions granted verses permissions used in the Permissions Management UI.

- Cross-cloud permissions discovery delivers granular and normalized metrics for key cloud platforms: AWS, Azure, and GCP.
- Permissions Creep Index (PCI) allows you to easily assess risk by evaluating the gap between permisssions granted and permissions used. PCI is an aggregated metric that regularly evaluates the level of risk associated with the number of unused or excessive permissions across identities and resources. It measures how much damage identities might cause based on the level of permissions they have. 
- Permissions usage analytics provide a multi-dimensional view of permissions risk for all identities, actions, and resources.


### Remediate & Manage ###
Permissions Management evaluates and creates right-size permissions based on usage, grants new permissions on-demand, and automates just-in-time access for cloud resources.
- Simplify permissions right-sizing and least privilege role creation across any cloud platform; AWS, Azure, or GCP.
- Automated deletion provides efficiency of security with automatic removal of permissions that have been unused for the past 90 days. 
- Grant identity permissions on-demand for a limited time period or an as-needed basis. 


### Monitor & Alert ###
Detect anomalous activities with machine language-powered (ML-powered) alerts and generate detailed forensic reports. 
- ML-powered anomaly detections provide increased efficiency in detecting unexpected shifts in activity.
- Context-rich forensic reports show information on identities, actions, and resources to support rapid investigation and remediation.
- Integration of the Defender for Cloud dashboard empowers you to manage the security of all cloud resources in one interface.

### Permissions Management for Zero Trust ###
Permissions Management strengthens zero trust security strategies by augmenting the least privilege access principle. 
- Get comprehensive visiblity to discover which identity is doing what, where, and when. 
- Automate least privilege access and use access analytics to ensure identities have the right permissions, at the right time.
- Unify access policies across infrastructure as a service (IaaS) platforms to implement consistent security policies across your cloud infrastructure. 

By adopting Entra Permissions Management for cloud security, you're implementing a solution for discovery, remediation, and monitoring that establishes your organization with a core pillar of a modern zero trust security strategy.

## What sets Entra Permissions Management apart? ##
The increase in the adoption of multicloud creates new access management challenges. Inconsistent methods to manage assets in multicloud platforms can cause security teams to struggle with lack of visibility and control in complex IT environments. The recent exponential growth of identities, machines, functions, and scripts operating in cloud infrastructures means that unmanaged permissions can expand your area of attack. 

Today...
- More than 90 percent of identities are using less than 5 percent of the permissions that they are granted.
- More than 50 percent of permissions are high-risk and can cause catastrophic damage.

Entra Permissions Management provides a unified platform to manage permissions for all identities, users and workflows across all major cloud infrastructures. So how does it compare to other permissions management solutions? See below for key differentiators of Entra Permissions Management. 

:::image type="content" source="../media/entra-permissions-management-key-differentiators.png" alt-text="Screen with Entra Permissions Management key differentiators."lightbox="../media/entra-permissions-management-key-differentiators.png":::

### Permissions Management Architecture ###
The Permissions Management architecture is comprised of data processing and analytics and data collection that create a SaaS structure. 

:::image type="content" source="../media/epm_architecture.png" alt-text="Screen with Entra Permissions Management architecture."lightbox="../media/epm_architecture.png":::

#### SaaS Service ####
- Responsible for processing the raw entitlement and activity data over a 90-day window and making it available for the application to query.
- Receives raw files from the Collector Service containing entitlement and activity data.
- Data processing and analytics are done on these raw files to generate the usage metrics and reports that you see in the product.
- Cloud Object Storage stores the raw data files that the collector service uploaded.
- Data Lake is used to help with data analytics related to alerting (know whether an activity triggered an alert through a data lake).
- Cloud database serves all of our pages/tabs in Entra Permissions Management.
- Data Collector configures the collector service with the appropriate credentials to access the cloud service providers. This service collects data every hour. 

#### Key Terminology ####

Below are some key terms used within the Permissions Management framework.

:::image type="content" source="../media/epm-architecture-terminology.png" alt-text="Screen with Entra Permissions Management Architecture key terminology."lightbox="../media/epm-architecture-terminology.png":::

## Minimize permission risks with Permissions Management ###
Now see some of these concepts and features of Permissions Management in action. 

This interactive video will help you to become more familiar with what securing permissions in your multicloud environment will look like with Entra Permissions Management. Learn how, with Permissions Management, you can get granular cross-cloud visibility, enforce principle of least privilege, and continuously monitor permissions.


> [!VIDEO https://mslearn.cloudguides.com/guides/Minimize%20permission%20risks%20with%20Microsoft%20Entra%20Permissions%20Management]

