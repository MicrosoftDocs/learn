
Even though Windows Client and Windows Server are designed to be secure out-of-the-box, many organizations still want more granular control over their security configurations. To navigate the large number of controls, organizations often seek guidance on configuring various security features. Microsoft provides this guidance in the form of security baselines.

Security baselines are groups of pre-configured Windows settings that help you apply and enforce granular security settings that are recommended by the relevant security teams. You can also customize each baseline you deploy to enforce only those settings and values you require. When you create a security baseline profile in Intune, you're creating a template that consists of multiple device *configuration* profiles.

We recommend that you implement an industry-standard configuration that is broadly known and well-tested, such as Microsoft security baselines, as opposed to creating a baseline yourself. This helps increase flexibility and reduce costs.

#### What are security baselines?

Every organization faces security threats. However, the types of security threats that are of most concern to one organization can be completely different from another organization. For example, an e-commerce company may focus on protecting its Internet-facing web apps, while a hospital may focus on protecting confidential patient information. The one thing that all organizations have in common is a need to keep their apps and devices secure. These devices must be compliant with the security standards (or security baselines) defined by the organization.

A security baseline is a group of Microsoft-recommended configuration settings that explains their security impact. These settings are based on feedback from Microsoft security engineering teams, product groups, partners, and customers.

Security baselines are an essential benefit to customers because they bring together expert knowledge from Microsoft, partners, and customers.

In modern organizations, the security threat landscape is constantly evolving, and IT pros and policymakers must keep up with security threats and make required changes to security settings to help mitigate these threats. To enable faster deployments and make managing Microsoft products easier, Microsoft provides customers with security baselines that are available in consumable formats, such as Group Policy Objects Backups.

#### Baselines principles

Our recommendations follow a streamlined and efficient approach to baseline definitions. The foundation of that approach is essentially:

-   The baselines are designed for well-managed, security-conscious organizations in which standard end users do not have administrative rights.
-   A baseline enforces a setting only if it mitigates a contemporary security threat and does not cause operational issues that are worse than the risks they mitigate.
-   A baseline enforces a default only if it's otherwise likely to be set to an insecure state by an authorized user:

    -   If a non-administrator can set an insecure state, enforce the default.
    -   If setting an insecure state requires administrative rights, enforce the default only if it's likely that a misinformed administrator will otherwise choose poorly.

#### Selecting the appropriate baseline

The selection of the appropriate security baseline starts with the understanding of which operating system the security baseline needs to be applied to. There are many versions of Windows Client and Windows Servers, and in a heterogeneous environment, you may need to have multiple baselines that address the requirements of each operating system. Once you have an inventory of the operating systems and its versions, you can decide which tool you'll utilize to deploy these baselines.

One option is to utilize the **Security Compliance Toolkit (SCT)**, which is a set of tools that allows enterprise security administrators to download, analyze, test, edit, and store Microsoft-recommended security configuration baselines for Windows and other Microsoft products. The SCT enables administrators to effectively manage their enterprise's Group Policy Objects (GPOs). Using the toolkit, administrators can compare their current GPOs with Microsoft-recommended GPO baselines or other baselines, edit them, store them in GPO backup file format, and apply them broadly through Active Directory or individually through local policy.

Another option available for Servers is to use Azure security baselines to machines through **Azure Security Benchmark (ASB)**. The ASB has guidance for OS hardening which has led to security baseline documents for Windows and Linux.

However, if the focus of your security baseline is to configure endpoint (Windows Client), you can use **Intune** to automate the deployment and configuration. By using Intune capabilities, you can easily deploy Windows security baselines to help you secure and protect your users and devices. You can deploy security baselines to groups of users or devices in Intune, and the settings apply to devices that run Windows 10/11. For example, the MDM Security Baseline automatically enables BitLocker for removable drives, automatically requires a password to unlock a device, automatically disables basic authentication, and more. When a default value doesn't work for your environment, customize the baseline to apply the settings you need.

Separate baseline types can include the same settings but use different default values for those settings. It's important to understand the defaults in the baselines you choose to use, and to then modify each baseline to fit your organizational needs.

Is very important to emphasize that Intune security baselines are not CIS or NIST compliant. While Microsoft security team consults organizations, such as CIS, to compile its recommendations, there's no one-to-one mapping between "CIS-compliant" and Microsoft baselines.

The recommendations in these baselines are from the Microsoft security team's engagement with enterprise customers and external agencies, including the Department of Defense (DoD), National Institute of Standards and Technology (NIST), and more. Microsoft shares recommendations and baselines with these organizations. These organizations also have their own recommendations that closely mirror Microsoft's recommendations. As mobile device management (MDM) continues to grow into the cloud, Microsoft created equivalent MDM recommendations of these group policy baselines. These additional baselines are built into Microsoft Intune, and include compliance reports on users, groups, and devices that follow (or don't follow) the baseline. Security baselines can be found in the Endpoint security configuration as shown below:

![Screenshot of selecting a security baseline to configure.](../media/endpoint-security.png) 
