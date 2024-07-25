
The Microsoft Entra admin center now includes a new set of capabilities grouped under the heading Global Secure Access. Global Secure Access is the unifying term used for both Microsoft Entra Internet Access and Microsoft Entra Private Access. 

Microsoft Entra Internet Access and Microsoft Entra Private Access, coupled with Microsoft Defender for Cloud Apps, our SaaS-security focused Cloud Access Security Broker (CASB), come together as a solution that converges network, identity, and endpoint access controls so that you can secure access to any app or resource, from any location, device, or identity.  This is Microsoft's Security Service Edge (SSE) solution.



Security Service Edge brings together zero trust identity and access controls with zero trust network controls to provide more advanced protections.  These protections are context-aware and made possible by deep integration with conditional access policies and risks assessed in real time, across identity, device, location, and applications to protect any app or resource.



:::image type="content" source="../media/global-secure-access-v3.png" alt-text="Image showing components that make up Global Secure Access.":::



### Microsoft Entra Internet Access

A Secure Web Gateway (SWG) is a cybersecurity solution that protects users from web-based threats by filtering internet traffic and enforcing security policies.

Microsoft Entra Internet Access provides an identity-centric Secure Web Gateway (SWG) solution for Software as a Service (SaaS) applications and other Internet traffic. It protects users, devices, and data from the Internet's wide threat landscape with best-in-class security controls and visibility through Traffic Logs.

Some of the key features of include:
- Protection against user identity or token theft by using Conditional Access policies to perform a compliant network check for access to resources.
- Tenant restrictions to prevent data exfiltration to other tenants or personal accounts including anonymous access.
- Internet Access traffic forwarding profile policies to control which internet sites can be accessed to ensure remote workers connect to the internet in a controlled and secure way.
- Web content filtering to regulate access to websites based on their content categories and domain names.
- and many more...

### Microsoft Entra Private Access

Microsoft Entra Private Access provides your users - whether in an office or working remotely - secured access to your private, corporate resources.

Microsoft Entra Private Access unlocks the ability to specify the fully qualified domain names (FQDNs) and IP addresses that you consider private or internal, so you can manage how your organization accesses them. Remote workers don't need to use a VPN to access these resources if they have the Global Secure Access Client installed. The client quietly and seamlessly connects them to the resources they need.

Microsoft Entra Private Access has two ways in which it can  be setup to secure access to your private resources.

- Quick Access which includes the group of fully qualified domain names (FQDNs) and IP addresses that you always want to access through the Global Secure Access service. Refer to figure 1.
- Per-app access, also referred to as Global Secure Access Apps, which provides a more granular approach. For example, you may have private resources for which you want to set to different access policies for different users based on how they are accessing the resource or for a specific time frame.  Refer to figure 2.



