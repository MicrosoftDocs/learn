
Compliance policies define the rules and settings that should be configured on a device for it to be considered compliant. After you configure and deploy a compliance policy, you can monitor device compliance status, and individual devices that are configured in an expected way.

Before you can apply a compliance policy to a device, it must first be enrolled to Intune. After the enrollment, the device can be automatically added to a device group. If you assigned a compliance policy to that group, the policy will be evaluated on the device, and its compliance status will be automatically reported to Intune and shown in the portal.

Device compliance policies outline the required settings for:

 -  Passwords
 -  Encryption
 -  Jail-broken or rooted devices
 -  The minimum operating-system version
 -  The maximum operating-system version
 -  The maximum Mobile Threat Defense level

When a device enrolls in Intune, information about the device, including its compliance status, is added to Azure Active Directory (Azure AD). Compliance policies are deployed based on the user, not on the device. Conditional access policies use the Azure AD information to block or allow access to email and other organizational data. You don't have to use compliance policies with conditional access. You can use compliance policies simply for reporting purposes.

Intune compliance policies are created in the Devices section of the Endpoint Manager admin center. The device compliance dashboard for monitoring can be found under Reports.

By default, when Intune detects a device that isn't compliant, it immediately marks the device as noncompliant. In each compliance policy you can configure actions for noncompliant devices, which provide you with extra flexibility in deciding what to do. For example, in a typical scenario, organizations will block access to company resources from a non-compliant device. However, you can configure a compliance policy that instead allows a non-compliant device to access company resources as long as the device is made compliant within a specified grace period. If compliance isn't achieved by that time, the device will no longer be able to access company resources.

There are two types of noncompliant actions:

 -  **Notify end users via email**. You can customize an email notification before sending it to the end user. You can customize the recipients, subject, and message body, including company logo, and contact information. Intune includes details about the noncompliant device in the email notification.
 -  **Mark device noncompliant**. You can specify the number of days after which the device is marked as noncompliant. This can be immediately after the device is flagged as noncompliant, or you can give the user a grace period in which he or she can update the device to make it compliant. If the device is still not compliant after the specified number of days, it will be marked as noncompliant.

Device compliance policies can be used in the following manner:

 -  **With conditional access**. For devices that comply with policy rules, you can allow those devices to access email and other company resources. If the devices don't comply with policy rules, then they don't get access to company resources.
 -  **Without conditional access**. You can also use device compliance policies without any conditional access. When you use compliance policies without conditional access, there are no access restrictions to company resources.

### Use Azure AD device groups for policies

It's recommended that you use Azure AD groups for users and devices to apply any type of policies implemented with Intune. You can create a group in Azure AD with dynamic membership by specifying a rule to determine membership based on user or device properties. When the attributes of a user or device changes, Azure AD evaluates all dynamic groups in a directory to see if the change would trigger any group adds or removes. If a user or device satisfies a rule on a group, they're added as a member of that group. If they no longer satisfy the rule, they're removed from the group.

A group membership rule is used to automatically populate a group with users or devices. This is a binary expression that results in a True or False outcome. The three parts of a simple group membership rule include:

 -  **Property**. Specifies the object attribute; for example, you can use **user.department** to reference the Department attribute of a user object, or **device.displayName** to reference the **displayName** attribute of a device object.
 -  **Operator**. Can be one of many supported operators, such as Equals (-eq), Starts With (-startsWith), Contains (-contains), or Match (-match).
 -  **Value**. The value against which you want to evaluate the property by using the operator.

For example, you would use the following group membership rule to include all devices that were manufactured by Microsoft:

```
device.deviceManufacturer -eq "Microsoft

```
