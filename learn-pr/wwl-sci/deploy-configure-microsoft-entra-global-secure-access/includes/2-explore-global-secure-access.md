:::image type="content" source="../media/global-secure-access-diagram.png" alt-text="Diagram of the high level process flow for Global Secure Access in Microsoft Entra. Microsoft Entra Private Access and Internet Access are the gateways to resources.":::

## Microsoft Security Service Edge (SSE) solution
Microsoft Entra Internet Access and Microsoft Entra Private Access are a solution that merges network, identity, and endpoint access controls so you can securely access any app or resource, from anywhere. You can enable access orchestration for employees, business partners, and digital workloads. With existing functionality in Microsoft Entra, continuously monitor and adjust user access in real time if permissions or risk level changes. The Global Secure Access uses a unified portal to streamline the roll-out and management of the access control capabilities. Access is delivered from the Microsoft Wide Area Network, spanning 140+ regions and 190+ network edge locations. This private network enables organizations to connect users and devices to public and private resources seamlessly and securely.

## Microsoft Entra Internet Access
Microsoft Entra Internet Access secures access to Microsoft services, SaaS, and public internet apps while protecting users, devices, and data against internet threats. Secure access to public internet apps through the identity-centric, device-aware, cloud-delivered Secure Web Gateway (SWG) of Microsoft Entra Internet Access.

### Key features:
 - Prevent stolen tokens replays with the compliant network check-in Conditional Access.
 - Apply universal tenant restrictions to prevent data exfiltration.
 - Enriched logs with network and device signals.
 - Improve the precision of risk assessments on users, locations, and devices.
 - Acquire network traffic from the desktop client or from a remote network.
 - Dedicated public internet traffic forwarding profile.
 - Protect user access to the public internet while using Microsoft secure web gateway.
 - Regulate access to websites based on their content categories and domain names.
 - Apply universal Conditional Access policies for all internet destinations.

## Microsoft Entra Private Access
Microsoft Entra Private Access provides your users secure access to your private, corporate resources. Microsoft Entra Private Access builds on the capabilities of Microsoft Entra application proxy and extends access to any private resource, port, and protocol. Remote users connect to private apps across hybrid and multicloud environments, private networks, and data centers from any device and network without requiring a VPN. The service offers per-app adaptive access based on Conditional Access policies.

### Key features:
 - Zero Trust based access to a range of IP addresses and/or Fully Qualified Domain Names (FQDNs) without requiring a legacy VPN.
 - Modernize legacy app authentication with Conditional Access.
 - Provide a seamless end-user experience by deploying side-by-side with your existing non-Microsoft SSE solutions.

## Before you begin

Licensing:
 - Microsoft Entra P1 or P2 license
 - Microsoft Entra Internet Access license and / or Microsoft Entra Private Access license

Roles:
 - Global Secure Access Administrator role assigned to at least one administrator

It's recommended that you visit the [Zero Trust Guidance Center](/security/zero-trust/) to plan out your implementation. Additionally, you make all configuration changes in the Microsoft Entra Admin Center at [https://entra.microsoft.com](https://entra.microsoft.com).

