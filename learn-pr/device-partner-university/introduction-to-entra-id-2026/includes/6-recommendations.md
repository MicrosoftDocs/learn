Technology and business environments are continuously evolving. As work becomes more distributed and mobile, cloud solutions have become a standard component of modern IT infrastructure.

Organizations aren't required to replace all existing devices immediately. However, they're encouraged to begin integrating those devices with cloud services to take advantage of cloud-based capabilities.

As a transitional step toward full cloud enablement, existing devices can be enrolled in co-management and connected to cloud identities using Entra hybrid join.

> [!NOTE]
> Co-management is when a device is managed simultaneously by both Microsoft Configuration Manager and Microsoft Intune. This allows organizations to gradually shift device management to the cloud while maintaining existing on-premises controls. Co-management provides flexibility to choose which workloads are managed by Intune versus Configuration Manager, enables pilot testing with select devices, and unlocks cloud-powered capabilities such as Conditional Access and modern provisioning with Windows Autopilot.

Entra hybrid joined devices are simultaneously connected to an on-premises Active Directory (AD) and registered with Microsoft Entra ID. This configuration allows organizations to use selected cloud features while maintaining existing processes and progressing on their cloud journey.

When organizations are ready to upgrade hardware, they can transition to new or refurbished cloud-native devices.

These devices are provisioned using Windows Autopilot, joined directly to Entra ID (without relying on on-premises AD), and automatically enrolled in Microsoft Intune. This setup enables full cloud-based management and access to modern security and productivity features.

>[!NOTE]
>
>Organizations can continue using their on-premises Active Directory if it remains necessary for specific operational requirements.
>
>The recommended approach is to integrate devices with Microsoft Entra ID and manage them using cloud-based tools. This enables organizations to optimize resource management, improve operational efficiency, and maintain competitiveness.

The recommended approach is to integrate devices with Microsoft Entra ID and manage them using cloud-based tools. This enables organizations to optimize resource management, improve operational efficiency, and maintain competitiveness. Entra join doesn't prevent access to on-premises resources, and organizations transitioning to cloud-native Windows can continue to use on-premises Active Directory for applications or services that require it.

## User scenarios

Entra join is the preferred choice for connecting devices to Microsoft Entra ID. It supports cloud-first management, enables modern provisioning with Windows Autopilot, and integrates seamlessly with Microsoft Intune and Microsoft 365 applications.

That said, some devices or environments might require on-premises or hybrid join, such as:

- Air-gapped networks or devices.
- Devices running applications with nonstandard authentication mechanisms that depend on on-premises Active Directory.
- Organizational or regulatory requirements that mandate on-premises management.

Using on-premises or hybrid join for a subset of devices doesn't limit your entire environment. Organizations can mix device join types as needed while keeping Entra join as the default.

| Feature / aspect           | Entra Join (Azure AD Join) | Entra Hybrid Join (Hybrid Azure AD Join)  |
| -------------------------- | -------------------------- | ----------------------------------------- |
| User sign-in experience    | Entra ID credentials       | AD credentials (with Entra ID token sync) |
| Conditional Access support | Full support               | Full support                              |
| Windows Autopilot support  | Fully supported            | Limited (generally **not recommended**)   |