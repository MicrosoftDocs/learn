
Even with the ability to reset the existing Windows image with Autopilot, sometimes even that isn’t necessary, especially with new devices purchased from an OEM. A new device typically starts with a fresh install of Windows, and what’s typically needed is the correct edition deployed (such as Windows Enterprise or Education), correct configuration and apps. When this is the case, dynamic provisioning can further simplify deployments.

Dynamic provisioning uses a number of transforms to achieve this objective.

| Name                            | Description                                                                                                                                                 |
|---------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Windows Subscription Activation | With Windows Subscription Activation, users of Windows Pro can upgrade to Windows Enterprise without needing to enter a product key, nor perform a restart. |
| Provisioning package configuration | By using Windows Configuration Designer, you can create configuration packages that you can deploy to users’ devices that can be used to configure apps and settings on those devices. |
| Azure AD join with automatic MDM enrollment | Using Azure AD join with automatic MDM enrollment, users enter their work or school account details and their device is automatically joined to Azure AD and enrolled in MDM. The user’s device is then configured per the organization’s MDM policies. |



### Objectives

After completing this module, you will be able to:

 -  Describe how Subscription Activation works.
 -  Describe the benefits of Provisioning Packages.
 -  Explain how Windows Configuration Designer creates Provisioning Packages.
 -  Describe the benefits of using MDM enrollment with Azure AD join.
