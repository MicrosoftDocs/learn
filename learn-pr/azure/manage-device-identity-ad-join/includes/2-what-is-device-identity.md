Device identity in Azure helps you control the devices you add to your organization's active directory, and the data, resources, and assets they can access.

Your organization wants to add another layer of device-level security. You want to understand the meaning of device identity. You also need to know how to build up details of any device that's added to your network.

In this unit, you'll learn about device identity, the registration options, and how they apply to various devices. You'll see how you can apply condition access to improve access control with your devices. Finally, you'll look at the benefits, and the considerations, of using device identity in Azure.

## What is device identity?

Device identity management provides a framework to implement device-based conditional access. You can use a device-based conditional access policy to limit device access to your organization's assets.

Today's work environment extends beyond the controllable boundaries of your on-premises workspace. Your staff can now work in different locations, not only in their home country or region but abroad. Users can access a broader range of technologies. Some are owned by your organization, but others aren't.

The challenge faced by IT staff is how to give users flexibility, while protecting your company's data. You want to support your users, enabling them to be productive wherever they're working, on whatever device they're using. But you still need to keep your organization's resources and assets safe.

Finding a balance between protecting assets and allowing users greater flexibility in the devices they use is at the heart of device identity. Every device you want to connect to your network must be known. Tools such as Microsoft Intune can enhance what's known about a device by ensuring compliance with organizational requirements.

By combining Azure Active Directory (Azure AD) with single sign-on, users can access services and apps through any device. This outcome meets your organization's need to protect its resources and assets, and gives users the flexibility they want.

## Device registration options

You have three device registration options to add a device to your Azure AD: 

- **Azure AD registered** devices fall into the Bring Your Own Device (BYOD) category. These devices are privately owned and use a personal or local Microsoft account. This method of device registration is the least restrictive as it supports devices running Windows 10, iOS, iPadOS, Android, and macOS. Device security is typically provided from a password, PIN, pattern, or Windows Hello.

- **Azure AD joined** devices are owned by your organization. Users access your cloud-based Azure AD through their work account. Device identities only exist in the cloud. This option is only available to Windows 10 devices. Security for this option uses either a password or Microsoft Hello.

- **Hybrid Azure AD joined** is similar to AD joined. The devices are owned by the organization, and are signed in with an Azure AD account that belongs to that organization. Device identities exist in the cloud and on-premises. The hybrid option is better suited to organizations that need on-premises and the cloud access. This option supports Windows 7, 8.1 and 10, and Windows Server 2008 or better.

## Conditional access

Conditional Access in Azure AD uses data from different sources, known as signals, validates them against a user-definable rules base, and chooses the best outcome to enforce your organization's security policies. Conditional Access enables device identity management but Conditional Access policies can be complex. At their simplest, these policies can be thought of as 'if-then' statements. If a device wants access to a resource, it must fulfill the condition to complete the request.

![Illustration that shows conditional signal plus decision to get enforcement.](../media/2-conditional-access.png)

Conditional Access policies are applied after a user has successfully completed first-factor authentication, typically with a username, and password. These policies aren't a substitute for first-factor authentication. They're used to access factors like device, location, application, and to assess the risk in real time.

### Common signal types

There are many common signal types that Conditional Access uses to make a decision on which outcome to recommend.

![Illustration that shows the Conditional Access process flow.](../media/2-conditional-access-signals.png)

Signals include the following types:

- **User or group membership**, to provide fine-grained access to resources.
- **IP location information**, using an allow list of trusted IP addresses, and a deny list of blocked or banned IP addresses.
- **Device** allows you to specify the type of device and its state.
- **Application** lets you control access to a given application for a specific device.
- **Real-time and calculated risk detection**, which allows Azure AD to identify behaviors not only during sign-in but also throughout the user's session.
- **Microsoft Cloud App Security (MCAS)** provides real-time monitoring of the user's session and application access. MCAS also helps you control your cloud environment.

### Common decisions

Conditional Access evaluates the signals and provides a decision:

- Block access, which is the most restrictive.
- Grant access, which is the least restrictive, but may require additional criteria before allowing access.

Those criteria can be one or more of:

- Multi-Factor Authentication
- Device marked as compliant
- Device is Hybrid Azure AD joined
- An approved application
- Needs an app protection policy

If your organization uses MFA, users don't have to do MFA when they're using an MDM compliant, AD joined device. You can choose the option **Require one of the selected controls** with your grant controls selected. If you need extra security for something like a payroll app, choose **Require all the selected controls** to require MFA and a compliant device. 

>[!div class="mx-imgBorder"]
>![Screenshot of the access control grant settings with the options selected: Require MFA, Require device compliant, and Require one of the selected controls.](../media/2-access-controls-grant.png)

### Create Conditional Access policies

To create a Conditional Access policy, go to **Azure Active Directory** > **Security** > **Conditional Access** > **New policy**.

>[!div class="mx-imgBorder"]
>![Screenshot that show a new Conditional Access policy with no assignments or access controls set.](../media/2-conditional-access-policies.png)

## Benefits of device identity management

Some of the benefits of using device identity, combined with Conditional Access in your Azure AD, are:

- Simplifies the procedure for adding and managing devices in Azure AD.
- Reduces the friction for users when switching between different devices.
- Azure AD supports mobile device management tools such as Microsoft Intune.
- You can use single sign-on (SSO) with any registered or joined device.
- Conditional Access is included with your Microsoft 365 Business license.

## Considerations when using device identity management

When evaluating device identity, consider the following factors:

- Using Azure AD join or Hybrid AD joined options limits you to using Windows or Windows Server-based operating system on the device.
- Conditional Access requires an Azure AD Premium P1 license.
