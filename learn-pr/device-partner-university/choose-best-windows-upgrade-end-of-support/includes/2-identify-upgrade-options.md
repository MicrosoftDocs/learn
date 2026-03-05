Now that Windows 10 has reached end of support on **October 14, 2025**, organizations must decide how to move forward with a secure and supported Windows environment. There's no single upgrade path that fits every organization—timelines, infrastructure, and business priorities all influence the right approach.

Operating post Windows 10 end of support also impacts more than endpoint security. It affects how organizations approach device lifecycle planning, identity protection, cloud strategy, and long-term platform sustainability. Without active support and security updates, Windows 10 devices become progressively more difficult (and expensive) to secure, manage, and certify for compliance.

For IT teams, this transition introduces a balancing act between risk reduction, budget management, user productivity, and future readiness. Some organizations are prepared to modernize immediately with new devices, while others require transitional strategies to maintain stability during multi-phase upgrade efforts. Understanding how each upgrade path fits into these broader goals is essential before making any deployment decisions.

## Finding the right path for you

Choosing the right upgrade path affects far more than just the operating system—it shapes security posture, device strategy, user experience, and long-term IT investment. The decisions—and actions not taken—during this transition can either enable smooth modernization or introduce technical debt and expose the organization to unnecessary risk.

For IT professionals, understanding when to move forward with Windows 11 on new devices, when ESU is appropriate as a short-term bridge, and when to use Windows 365 is critical to guiding a secure and sustainable path forward

Decisions made during this phase often set the direction for several years of device and platform strategy. A short-term choice made to reduce immediate cost or disruption can introduce longer-term operational challenges, while a well-timed modernization effort can simplify management, improve user satisfaction, and strengthen the overall security posture.

For many IT organizations, the post-Windows 10 end of support transition also becomes a coordination point across teams—including security, procurement, networking, and compliance. Aligning these groups early helps avoid fragmented upgrades, overlapping tools, and unnecessary technical debt later in the lifecycle.

Three primary paths are available post-Windows 10 end of support:

## Upgrade paths overview

| Option                     | Best for                          | Key benefit                        |
|----------------------------|------------------------------------|------------------------------------|
| **Windows 11**             | New hardware deployments          | Modern security and performance    |
| **Windows 10 ESU**         | Short-term migration grace period | Temporary security coverage        |
| **Windows 365 Cloud PC**   | Remote/hybrid workforces          | Cloud-based flexibility            |

Each option supports different needs, from long-term modernization to short-term risk mitigation.

> [!NOTE]
> The following terms appear throughout this module and are important to understand when evaluating upgrade options after Windows 10 end of support.
>
> **Trusted Platform Module (TPM) 2.0**  
> TPM 2.0 is a hardware-based security feature that helps protect sensitive data such as encryption keys, credentials, and certificates. Windows 11 requires TPM 2.0 to support modern security features like device encryption and secure identity protection.
>
> **Secure Boot**  
> Secure Boot is a security standard that helps ensure a device boots using only software trusted by the manufacturer. It helps prevent malicious software from loading during the startup process and is a requirement for Windows 11.
>
> **Cloud PC**  
> A Cloud PC is a full Windows desktop hosted in the Microsoft cloud and delivered to users over the internet. With Windows 365, the Cloud PC experience remains persistent and personalized across sessions.
>
> **Extended Security Updates (ESU)**  
> Extended Security Updates provide critical security updates for eligible Windows 10 devices after end of support. ESU is intended as a temporary option to help organizations maintain security while planning a full upgrade.
>
> **Hardware eligibility**  
> Hardware eligibility refers to whether a device meets the minimum system requirements to run Windows 11, including support for features like TPM 2.0, Secure Boot, and supported processors.

## Windows 11

Windows 11 is the modern Windows operating system designed with security, productivity, and performance at its core. While in-place upgrades may be possible in certain cases, the **recommended approach—when possible—is deployment on new, hardware-eligible devices** to take full advantage of Windows 11 capabilities.

### Key features

- Built-in security requirements such as **TPM 2.0** and **Secure Boot**
- Modern user experience built for productivity
- Broad compatibility with existing Windows 10 applications

### Ideal for

- Organizations planning a **hardware refresh**
- Businesses focused on **long-term platform stability**
- Environments that require **modern, hardware-based security**

### Why new devices matter

Deploying Windows 11 on new, supported hardware helps ensure:

- Full compliance with Windows 11 hardware requirements  
- Access to the latest security protections  
- A more reliable and consistent user experience  

### Operational considerations

Deploying Windows 11 on new devices often aligns with standard hardware refresh cycles, which many organizations already plan for every three to five years. Coordinating Windows 11 adoption with these refresh timelines can help reduce disruption and avoid large-scale mid-cycle replacements.

From an operations standpoint, moving to new hardware also allows IT teams to standardize device models, simplify driver management, and reduce long-term support complexity. While the upfront investment is higher, the long-term benefits often include improved device reliability, fewer break-fix incidents, and more predictable lifecycle management.

## Windows 10 Extended Security Updates (ESU)

[Extended Security Updates (ESU)](/windows/whats-new/extended-security-updates) provide **critical security updates only** for eligible Windows 10 devices after end of support. This option is intended as a **temporary risk mitigation measure**, not a replacement for modernization.

ESU can help maintain security coverage while upgrade planning and device refresh strategies are finalized.

### Key features

- Delivers **security updates only** (no new features)
- Available for **eligible** Windows 10 editions
- Offered through a **subscription-based model**

### Ideal for

- Organizations with **legacy application dependencies**
- Environments with **hardware that cannot yet be replaced**
- Businesses that **need additional time** to complete migration planning

> [!IMPORTANT]
> **Extended Security Updates (ESU) limitations**
>
> Windows 10 ESU provides **security updates only** and does **not** include:
> - New features  
> - Customer-requested nonsecurity updates  
> - Design change requests  
>
> In addition, **general product support is not provided for Windows versions past the end of support date**. Windows 10 ESU includes support only for:
> - ESU license activation  
> - ESU installation  
> - Potential regressions related to the ESU itself  
>
> To receive technical assistance for ESU-related issues, organizations must have an active [support plan](https://www.microsoft.com/microsoft-unified) in place.

### Operational considerations

Using ESU post-Windows 10 end of support generally indicates that parts of the environment are constrained by legacy hardware, software dependencies, or long procurement timelines. While ESU reduces immediate security risk, it doesn't remove the operational burden of maintaining unsupported platforms.

Over time, maintaining mixed environments that include ESU-protected devices may increase help desk complexity, vulnerability management overhead, and compliance reporting efforts. For most organizations, ESU works best when paired with a clearly defined exit plan.

## Windows 365 Cloud PC

Windows 365 provides a full Windows desktop streamed securely from the Microsoft cloud to nearly any device. The experience remains persistent and personalized, giving users access to their full desktop wherever they work.

This model works especially well when device refresh timelines are uncertain or when supporting remote and hybrid teams.

### Key features

- Persistent Cloud PC accessible from almost any device
- Predictable **per-user monthly pricing**
- Scales for temporary, seasonal, or distributed workers

### Ideal for

- Remote and hybrid teams  
- Contractors or temporary workers  
- Organizations reducing dependence on physical device refresh cycles  

### Key benefits

- Secure access without relying on high-spec local hardware  
- Consistent desktop experience across locations  
- Supports flexible workforce models  

### Operational considerations

Windows 365 shifts much of the desktop delivery model away from physical device dependency and toward identity, access, and network performance. This can simplify provisioning for new users, contractors, or seasonal workers, since desktops can be assigned and decommissioned without shipping hardware.

However, this model also places increased importance on identity management, network resiliency, and cloud governance. IT teams adopting Windows 365 should consider how user access, conditional access policies, and endpoint security tooling align with a cloud-first desktop experience.