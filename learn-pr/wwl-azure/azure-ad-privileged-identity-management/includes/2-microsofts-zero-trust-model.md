Cloud-based services and mobile computing have changed the technology landscape for the modern enterprise. Today’s workforce often requires access to applications and resources outside traditional corporate network boundaries, rendering security architectures that rely on firewalls and virtual private networks (VPNs) insufficient. Changes brought about by cloud migration and a more mobile workforce has led to the development of an access architecture called Zero Trust.

## The Zero Trust model

Based on the principle of “never trust, always verify,” Zero Trust helps secure corporate resources by eliminating unknown and unmanaged devices and limiting lateral movement. Implementing a true Zero Trust model requires that all components—user identity, device, network, and applications—be validated and proven trustworthy. Zero Trust verifies identity and device health prior to granting access to corporate resources. When access is granted, applying the principle of least privilege limits user access to only those resources that are explicitly authorized for each user, thus reducing the risk of lateral movement within the environment. In an ideal Zero Trust environment, the following four elements are necessary:

 -  Strong identity authentication everywhere (user verification via authentication)
 -  Devices are enrolled in device management, and their health is validated
 -  Least-privilege user rights (access is limited to only what is needed)
 -  The health of services is verified (future goal)

For Microsoft, Zero Trust establishes a strict boundary around corporate and customer data. For end users, Zero Trust delivers a simplified user experience that allows them to easily manage and find their content. And for customers, Zero Trust creates a unified access platform that they can use to enhance the overall security of their entire ecosystem.

## Zero Trust architecture

A Zero Trust approach extends throughout the entire digital estate and serves as an integrated security philosophy and end-to-end strategy.

The illustration below provides a representation of the primary elements that contribute to Zero Trust.

:::image type="content" source="../media/zero-architecture-example-1a-4d3e0059.png" alt-text="The illustration below provides a representation of the primary elements that contribute to Zero Trust.":::


In the illustration above:

Security policy enforcement is at the center of a Zero Trust architecture. This includes Multi-Factor authentication with conditional access that takes into account user account risk, device status, and other criteria and policies that you set.

Identities, devices (also called endpoints), data, applications, network, and other infrastructure components are all configured with appropriate security. Policies that are configured for each of these components are coordinated with your overall Zero Trust strategy. For example, device policies determine the criteria for healthy devices and conditional access policies require healthy devices for access to specific apps and data.

Threat protection and intelligence monitors the environment, surfaces current risks, and takes automated action to remediate attacks.

## Guiding principles of Zero Trust

Today, organizations need a new security model that effectively adapts to the complexity of the modern environment, embraces the mobile workforce, and protects people, devices, applications, and data wherever they are located.

To address this new world of computing, Microsoft highly recommends the Zero Trust security model, which is based on these guiding principles:

 -  **Verify explicitly** \- Always authenticate and authorize based on all available data points.
 -  **Use least privilege access** \- Limit user access with Just-In-Time and Just-Enough-Access (JIT/JEA), risk-based adaptive policies, and data protection.
 -  **Assume breach** \- Minimize blast radius and segment access. Verify end-to-end encryption and use analytics to get visibility, drive threat detection, and improve defenses.

## Microsoft's Zero Trust architecture<br>

Below is a simplified reference architecture for our approach to implementing Zero Trust. The primary components of this process are Intune for device management and device security policy configuration, Azure AD conditional access for device health validation, and Azure AD for user and device inventory.

The system works with Intune, pushing device configuration requirements to the managed devices. The device then generates a statement of health, which is stored in Azure AD. When the device user requests access to a resource, the device health state is verified as part of the authentication exchange with Azure AD.

:::image type="content" source="../media/az500-zero-trust-architecture-d7277787.png" alt-text="MFA is used to ensure conditions are met before accessing resources.":::


> [!IMPORTANT]
> The National Institute of Standards and Technology has a Zero Trust Architecture, NIST 800-207, publication.
