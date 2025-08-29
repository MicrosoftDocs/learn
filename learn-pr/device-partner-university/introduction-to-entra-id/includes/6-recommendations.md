Technology and business environments are continuously evolving. As work becomes more distributed and mobile, cloud solutions have become a standard component of modern IT infrastructure.

Organizations aren't required to replace all existing devices immediately. However, they're encouraged to begin integrating those devices with cloud services to take advantage of cloud-based capabilities.

As a transitional step toward full cloud enablement, existing devices can be enrolled in co-management and connected to cloud identities using Entra hybrid join.

Entra hybrid joined devices are simultaneously connected to an on-premises Active Directory (AD) and registered with Microsoft Entra ID. This configuration allows organizations to use selected cloud features while maintaining compatibility with existing infrastructure.

When organizations are ready to upgrade hardware, they can transition to new or refurbished cloud-native devices.

These devices are provisioned using Windows Autopilot, joined directly to Entra ID (without relying on on-premises AD), and automatically enrolled in Microsoft Intune. This setup enables full cloud-based management and access to modern security and productivity features.

>[!NOTE]
>
>Organizations can continue using their on-premises Active Directory if it remains necessary for specific operational requirements.
>
>The recommended approach is to integrate devices with Microsoft Entra ID and manage them using cloud-based tools. This enables organizations to optimize resource management, improve operational efficiency, and maintain competitiveness.

## User scenarios

Use Entra join when you're:

- Transitioning to cloud-based infrastructure using Microsoft Entra ID and Microsoft Intune.
- Managing mobile devices such as tablets and smartphones where on-premises domain join isn't feasible.
- Providing access for users who primarily utilize Microsoft 365 or other SaaS applications integrated with Entra ID.
- Managing user groups directly in Entra ID rather than Active Directory (AD), which is beneficial for roles such as seasonal workers, contractors, or students.
- Enabling device join capabilities for remote or home-based workers with limited access to on-premises infrastructure.
- Provisioning new or reset devices using Windows Autopilot, supporting scenarios such as drop-shipping, self-service setup, and accelerated deployment timelines.

Use Entra hybrid join when you:

- Require continued use of Group Policy for device configuration management.
- Intend to maintain existing imaging-based deployment processes.
- Have legacy Win32 applications that rely on AD-based machine authentication.

| Feature / aspect                 | Entra Join (Azure AD Join)                              | Entra Hybrid Join (Hybrid Azure AD Join)                  |
|----------------------------------|----------------------------------------------------------|------------------------------------------------------------|
| Target devices                   | Devices owned by the organization, typically cloud-first | Domain-joined devices managed on-premises                  |
| Primary use case                 | Cloud-native environments                                | Organizations with existing on-premises Active Directory       |
| Device ownership                 | Organization-owned or BYOD                               | Organization-owned                                         |
| Directory dependency             | Microsoft Entra ID only                                  | Requires both on-premises AD and Microsoft Entra ID            |
| Join process                     | Joined directly to Entra ID during setup                 | Joined to on-premises AD first, then registered with Entra ID  |
| Management tools                 | Intune, Endpoint Manager                                 | Group Policy, SCCM, Intune                                 |
| User sign-in experience          | Entra ID credentials                                     | AD credentials (with Entra ID token sync)                  |
| SSO (single sign-on)             | Full SSO to cloud resources                              | SSO to both on-premises and cloud resources                    |
| Conditional access support       | Full support                                             | Full support                                               |
| Windows Autopilot support        | Fully supported                                          | Limited (requires additional configuration)                |
| Best for                         | Cloud-first or cloud-only organizations                  | Hybrid environments transitioning to cloud                 |