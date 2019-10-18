Your organization wants to add another layer of device-level security. You want to understand what is meant by device identity. You also want to know how to build up details of any device added to your network.

Azure's device identity is a mechanism that allows you to control what devices can be added to your organization's active directory, and what data, resources, and assets they can access.

In this unit, you'll learn what is meant by device identity, what registration options are available, and how they apply to various devices. You'll see how you can apply condition access to bring about better access control with your devices. Finally, you'll look at the merits and considerations of using device identity in Azure.

## What is device identity

Today's work environment extends beyond the defined and controllable boundaries of your on-premises workspace. Today, your staff can expect to work in different locations, not only here but abroad. Your users have access to a broader range of technologies. Some are owned by your organization, others that aren't.

The challenge faced by IT staff is a difficult one. You want to support your users, enabling them to be productive wherever they're working, and on whatever device they're using. But you still need to keep your organization's resources and assets safe.

Finding a balance between protecting assets and allowing users greater flexibility in the devices they use is at the heart of device identity. Every device you want to connect to your network must be known. Tools, such as Microsoft Intune, can enhance what is known about a device by ensuring compliance with organization requirements.

Device identity management provides a framework for implementing device-based Conditional Access. Using a device-based conditional access policy, you can limit access to your organization's assets and resources to managed and known devices.

When combined with Azure Active Directory, through single sign-on, your users can access their services and apps through any device. Which meets both your organization's need to protect its resources and assets and provides the users with the flexibility to work as they need.

## Device registration options

There are three options for adding a device to your Azure Active Directory (AD). Azure registered, AD joined, and hybrid.

- Azure AD registered devices fall into the Bring Your Own Device (BYOD) category. They're privately owned and use a personal or local Microsoft account. This method of device registration is the most promiscuous as it supports devices running Windows 10, iOS, iPadOS, Android, and MacOS. Device security is typically provided from password, PIN, pattern, or Windows Hello.
- Azure AD joined devices are owned by your organization. They access your cloud-based Azure AD thought their work account. This option is only available to Windows 10 devices, typically laptops, tablets, etc. Security for this option uses either a password or Microsoft Hello.
- Hybrid Azure AD joined, is similar to AD joined. The devices are owned by the organization, and access is through the same organizations Azure Active directory. The hybrid option is better suited to organizations that need on-premises access including the cloud. This option supports Windows 7, 8.1 and 10, and Windows Server 2008 or better.

## Conditional Access

Conditional Access is a feature of the Azure Active Directory that uses data from different sources (known as Signals), validates them against a user-definable rules base, and chooses the best outcome to enforce your organization's security policies. Conditional Access enables device identity management. While Conditional Access policies can be complex, they can be thought of, at their simplest, as if-then statements. If a device wants access to a resource, then it must fulfill the condition to complete the request.

![Image showing conditional access overview](../media/2-conditional-access.png)

Conditional Access policies are applied after a user has successfully completed first-factor authentication, typically username, and password. These policies aren't a substitute for first-factor authentication. They're used to access factors like device, location, application, and assess the risk in real time.

### Common signal types

There are many common signal types that Conditional Access uses to make a decision on which outcome to recommend.

![Image showing the various signal types consumed by Conditional Access](../media/2-conditional-access-signals.png)

- User or group membership, which provides fine-grained access to resources
- IP location information, using allow-list of trusted IP addresses, and deny-list of blocked or banned IP addresses
- The device allows you to specify the type of device and that state of the device
- Application, lets you control access to a given application for a specific device
- Real-time and calculated risk detection, which allows Azure AD to identify behaviors not only during sign-in but throughout the user's session
- Microsoft Cloud App Security (MCAS) provides real-time monitoring of the user's session and application access. It can also provide you control over your cloud environment

### Common decisions

Conditional Access evaluates the signals and will, at a granular level, provide a decision:

- Block access, which is the most restrictive
- Grant access, which is the least restrictive, but may require additional criteria before allowing access. These other criteria can be one or more of:

  - Multi-factor authentication
  - The device marked as compliant
  - That the device is Hybrid Azure AD joined.
  - An approved application
  - Needs an app protection policy.

## Benefits of device identity management

Some of the benefits of using device identity combined with Conditional Access in your Azure AD are:

- Simplifies the procedure for adding and managing devices in Azure AD
- Reduces the friction for users when switching between different devices
- Azure AD supports Mobile Device Management (MDM) tools, for instance, Microsoft Intune
- You can use Single Sign-on (SSO) with any registered or joined device
- Conditional Access is included with your Microsoft 365 Business license

## Considerations when using device identity management

When evaluating device identity, the following factors should be considered:

- Using Azure AD Join or Hybrid AD joined options limits you to using Windows or Windows Server-based operating system on the device
- Conditional Access requires an Azure AD Premium P1 license
