For organizations that use Microsoft Intune, the most efficient way to evaluate device readiness for Windows 11 is through [Microsoft Intune's Endpoint Analytics](/intune/analytics/?pivots=intune).  

This tool provides centralized reporting helping IT administrators quickly identify which devices meet hardware requirements and which may need upgrades or replacement.

## The role of Intune Endpoint Analytics in upgrade planning

Intune Endpoint Analytics turns device readiness data into actionable intelligence. It highlights specific blockers—such as outdated processors, missing Trusted Platform Module (TPM) 2.0, or insufficient memory—so administrators can address issues before rollout begins. This allows IT teams to prioritize upgrades, communicate timelines to leadership, and coordinate replacement cycles efficiently.

By incorporating Endpoint Analytics into the upgrade strategy, organizations move from guesswork to data-driven decision-making. Instead of reactive troubleshooting, IT professionals can proactively manage their post-Windows 10 environment—ensuring that every device in their ecosystem is secure, compliant, and prepared for Windows 11.

## Use the Windows 11 Hardware Readiness report

The **Windows 11 Hardware Readiness** report in Endpoint Analytics shows which devices meet Windows 11 requirements and flags those that don’t.  
It includes readiness insights for devices that are:

- Enrolled in **Intune**  
- Managed through **co-management** with Configuration Manager  
- Attached through **tenant attach** (version 2107 or later)

> [!NOTE]
> To use this feature, your organization must have an active **Microsoft Intune subscription**, and the devices you want to assess must be running **Windows 10 version 1903 or later**.

## Access the readiness report

For centrally managed environments, the **Windows 11 Hardware Readiness report** in **Endpoint Analytics** provides IT professionals with a comprehensive overview of device eligibility across the organization.  
Rather than manually checking each system, Endpoint Analytics automatically evaluates enrolled devices against Windows 11’s hardware requirements and displays readiness insights in a single, centralized dashboard.

This report consolidates data from devices managed through **Microsoft Intune**, **co-management**, or **Configuration Manager (version 2107 or later)** with tenant attach enabled.  
By analyzing these insights, administrators can quickly determine which systems are ready for upgrade, which require hardware updates, and which are no longer viable for deployment.

## Understanding report categories

Each device in the report is grouped into one of four readiness categories:

| Category | Description |
|-----------|-------------|
| **Upgraded** | The device is already running Windows 11. |
| **Capable** | The device meets Windows 11 requirements and can be upgraded immediately. |
| **Not capable** | The device doesn’t meet minimum hardware requirements and can’t be upgraded. |
| **Unknown** | The system’s status couldn’t be determined, often due to inactivity or missing telemetry. |

These categories help IT teams quickly identify where to focus their attention and resources. For example, "Capable" devices can move directly into the upgrade phase, while "Not capable" systems can be reviewed for potential hardware refresh or retirement.

## Assessing the environment and planning next steps

The readiness report helps IT teams identify devices that can be upgraded and those that can't.  
Once noneligible devices are identified, administrators have two choices:

- **Upgrade hardware:** Address specific blockers when possible—such as enabling TPM 2.0, Secure Boot, or adding more memory. These targeted fixes can help extend hardware value while maintaining compliance.  

- **Replace devices:** For systems that can't be upgraded, plan for a phased hardware refresh. Early planning helps avoid disruption and ensures your organization remains productive during the transition.

> [!NOTE]
> If many devices appear as **Unknown**, check the **Last check-in time** in Intune.  
> You may need to adjust device cleanup rules or target only active devices for reporting.

By combining this insight with Endpoint Analytics data, IT professionals can move from reactive fixes to structured lifecycle management, reducing surprises later in deployment.

Using Endpoint Analytics in Microsoft Intune, IT professionals can efficiently assess the readiness of managed devices and make informed decisions about hardware upgrades or replacements.

Next, you apply what you’ve learned in a guided exercise using Microsoft Intune's Endpoint Analytics.