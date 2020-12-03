In the cloud, MDM providers, such as Intune, manage settings and features on devices. Group policies objects (GPO) aren't used. When managing devices, Intune device configuration profiles replace on-premises GPO. These profiles use settings exposed by Apple, Google, and Microsoft. 

When moving devices from group policy, use Group policy analytics. In Endpoint Manager, you import your GPOs, and see which policies are available (and not available) in Intune.

## Group policy analytics

Group policy objects (GPOs) are used on-premises to configure settings on personal computers, and other on-premises devices. In device management, GPOs help control security and features in the Windows OS, Internet Explorer, Office apps, and more.

Many organizations are looking at cloud solutions to support the growing remote workforce. Group Policy analytics is a tool and feature in Microsoft Endpoint Manager that analyzes your on-premises GPOs. It helps you determine how your GPOs translate in the cloud. The output shows which settings are supported in MDM providers, including Microsoft Intune. It also shows any deprecated settings, or settings not available to MDM providers.

If your organization uses GPOs, and you want to move some workloads to Microsoft Endpoint Manager and Intune, then Group Policy analytics will help.

## Next steps

For detailed steps when you currently use on-premises group policy as your on-premises management solution, see the [Currently use on-premises group policy](https://docs.microsoft.com/mem/intune/fundamentals/deployment-guide-intune-setup#currently-use-on-premises-group-policy?azure-portal=true).