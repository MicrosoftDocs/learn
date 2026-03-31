Now that you understand how to use **Endpoint Analytics** in Microsoft Intune to assess managed devices, it’s time to put that knowledge into practice.  
In this exercise, you simulate reviewing Windows 11 readiness data for your organization and identifying devices that require attention.

> [!IMPORTANT]  
> To complete this exercise, you need access to a Microsoft Intune environment with Endpoint Analytics enabled.  
> The devices you assess should be running **Windows 10 version 1903 or later** and enrolled in Intune, co-management, or tenant attach.

## Access the readiness report

1. Sign in to the Microsoft Intune admin center.

1. In the left-hand pane, navigate to **Reports > Endpoint Analytics**.  

   :::image type="content" border="true" source="../media/access-analytics.png" alt-text="Screenshot showing how to access the reports in Microsoft Intune Endpoint Analytics.":::

1. In the Endpoint Analytics view, select **work from anywhere**.
   1. Select **Windows**. A flyout opens on the Overview page, displaying a chart that highlights the specific hardware requirements most commonly blocking upgrades in your organization.

    :::image type="content" border="true" source="../media/endpoint-analytics-main.png" alt-text="Screenshot showing where to view the Windows 11 readiness reports in Microsoft Intune Endpoint Analytics." lightbox="../media/endpoint-analytics-main-expanded.png":::

1. Review the summary chart to see the overall distribution of device readiness.

   :::image type="content" border="true" source="../media/view-report.png" alt-text="Screenshot showing the Windows 11 Hardware Readiness report in Microsoft Intune Endpoint Analytics." lightbox="../media/view-report-expanded.png":::

> [!NOTE]
> The Hardware readiness report provides insights into each device’s Windows 11 upgrade eligibility, helping IT professionals plan upgrade or replacement strategies efficiently.

## Interpret readiness statuses

Within the report, identify how many devices fall into each readiness category:

| Category | Description |
|-----------|--------------|
| **Upgraded** | Devices already running Windows 11. |
| **Capable** | Devices that meet Windows 11 requirements and are ready for upgrade. |
| **Not capable** | Devices that don’t meet minimum hardware requirements. |
| **Unknown** | Devices that haven’t checked in or where readiness can’t be determined. |

> [!TIP]
> Select a category to filter and view the corresponding list of devices. This helps you quickly identify which systems need configuration changes or replacement.

## Investigate unmet requirements

For devices labeled **Not capable**, review the **Windows 11 readiness reason** column to find out which hardware components are missing or incompatible.

- **Upgrade hardware** – For example, add RAM or enable TPM 2.0 in BIOS.  
- **Replace devices** – For systems that can’t be upgraded, plan a hardware refresh using Windows 11-ready devices.

If devices are marked **Unknown**, verify their **Last check-in time**.  
Inactive or unresponsive devices may need re-enrollment or cleanup from the device inventory.

> [!NOTE]
> If you see a high number of inactive devices, review your organization’s device cleanup rules to ensure accurate reporting.

## Summarize your findings

In your assessment report or worksheet:
- Record the total number of devices in each readiness category.  
- Identify the most common unmet hardware requirements.  
- Document your recommended next steps for each group of devices (for example, “Upgrade BIOS,” “Enable TPM,” or “Replace hardware”).  

> [!TIP]
> These readiness insights can help inform your deployment strategy and hardware procurement plans for the Windows 11 transition.

## Reflect

Consider the following:
- Which hardware requirements are most often preventing upgrades in your environment?  
- How could you use this data to communicate upgrade needs to leadership or procurement?  
- What additional Intune reports might you pair with this analysis to prepare for deployment?

By completing this exercise, you’ve practiced using Endpoint Analytics in Intune to analyze Windows 11 readiness across managed devices—an essential step in ensuring your organization’s upgrade plan is accurate and data-driven.