If you're using an existing cloud-based mobile device management provider, you should consider moving your existing endpoints and workloads to Microsoft Intune to achieve modern endpoint management. For cloud-based device management scenario, endpoint management can be accomplished for desktops and devices in the same way.

> [!NOTE]
> Devices should only have one Mobile Device Management (MDM) provider.

As previously mentioned in this module, Microsoft Intune is available within Microsoft Endpoint Manager. It's a modern cloud-based mobile device management (MDM) and mobile application management (MAM) provider for your devices and apps. It lets you protect your organization by controlling features and settings on Android, Android Enterprise, iOS/iPadOS, macOS, and Windows 10 devices. It integrates closely with Azure Active Directory (Azure AD) for identity and access control, as well as Azure Information Protection for data protection.

## Benefits of using Intune

By moving your additional endpoint to Intune to manage your organization's endpoints, you gain the following benefits:
- No need to set up and operate your own management infrastructure.
- Native integration with cloud-powered security controls and risk-based conditional access for apps and data.
- Flexible support for diverse corporate and bring-your-own-device (BYOD) scenarios, while increasing productivity and collaboration.
- Maximize your investment and accelerate time to value with fast rollout of services and devices with end-to-end integration across familiar Microsoft stack.

To move from your current cloud-based MDM to Intune, you must first unenroll your organization's devices from your existing MDM provider. Different MDM providers handle removing devices differently. For example, authentication certificates may not get removed by unenrolling devices. So, you should consider contacting your MDM provider for guidance on making sure everything is removed. Once you have unenrolled your organization's devices from the previous cloud-based MDM, you can use conditional access from Intune to ensure the temporarily unprotected devices are block from accessing corporate data until you enroll the devices in Intune. For more information about unenrolling, see [Unenroll from existing MDM](https://docs.microsoft.com/mem/intune/fundamentals/deployment-guide-enrollment?azure-portal=true#unenroll-from-existing-mdm-and-factory-reset).

## Next steps

For detailed steps when you currently are using an existing endpoint management provider, but want to move your endpoints to Microsoft Intune, see the [Currently use a third party MDM provider](https://docs.microsoft.com/mem/intune/fundamentals/deployment-guide-intune-setup?azure-portal=true#currently-use-a-third-party-mdm-provider).
