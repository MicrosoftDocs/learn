When you use Windows Information Protection, organizational data automatically encrypts when data downloads to or opens on a local device. Encryption protects the file data and associates the data with your enterprise identity.

WIP policies then specify which trusted apps can use and manipulate that data. Enlightened apps such as Word or Microsoft Excel can work with organizational and personal data. When creating WIP policies, you can set four WIP-protection modes, which the following table lists, for managing that access.

| Mode| Description|
|-----|------------|
| Block or Hide overrides | Prevents employees from performing data-sharing actions when blocked by the policy. In some Microsoft documentation, this is referred to as Hide overrides mode.           |
| Allow overrides         | Warns employees when they're performing a potentially risky action, but they can choose to complete the action. The action records to the audit log.                      |
| Silent                  | Works like Allow overrides mode, except that it only records any action that an employee can override to the audit log. Any action that would be blocked is still blocked. |
| Off                     | WIP is turned off and doesn't protect data. |


#### Create a WIP policy in Intune

When you create policies in Intune, you can define which apps are protected, the level of protection provided, and how to find organizational data on your network.

To create a WIP policy in Intune, perform the following steps:

 1. **Sign in to the Microsoft Intune admin center**.
 2. Navigate to **Apps** > **App protection policies**.
 3. In the **App protection policies** pane, select **Add a policy**, and then fill in the following fields:
    -  **Name**. Enter a name for the policy.
    -  **Description**. Enter a description for the policy.
    -  **Platform**. Select the platform for the policy.
    -  **Enrollment state**: Choose Without enrollment for MAM or With enrollment for MDM.
 4. Select **Protected apps** and then select **Add apps**. You can add these types of apps:
    -  **Recommended apps**. These are enlightened apps that work with WIP.
    -  **Store apps**. These are apps that are available from Microsoft Store.
    -  **Desktop apps**. These are signed Windows desktop apps.
Please note that an application might return access denied errors after removing it from the list of protected apps. Rather than remove it from the list, you should uninstall and reinstall the application or exempt it from WIP policy.

#### Allowed and exempt apps

The process for adding an app rule varies slightly depending on the type of rule template that you use. The rule templates are:

 -  **Recommended App**. Recommended apps are enlightened apps that work with WIP.
 -  **Store App**. This is for apps that are available from Microsoft Store.
 -  **Desktop App**. This is for signed Windows desktop apps.

For detailed information about how to add each type of app to the Allowed apps list, refer to the “Add apps to your Allowed apps list” topic in “Create a Windows Information Protection (WIP) policy with MDM using the Endpoint Manager admin center.

After you add the apps that you plan to protect, you'll need to decide on the protection mode that you want to use. When creating and verifying your policies with a group of test users, consider the best practice of using the Silent or Allow overrides mode before using the Block mode. In doing so, you can confirm that these are the correct apps to have on your Allowed apps list.

#### Corporate identity

Your corporate identity identifies organizational data from apps that you protect with WIP. For example, emails coming from your organizational domain would be identified as organizational, and WIP policies would be applied. For this reason, you typically want to add all the domains from which you send emails.

You add your corporate identity by typing your domain name or multiple domain names separated by the pipe character (\|) in the Corporate identity field.

#### Network perimeter

WIP needs to know where the apps can find and access organizational data on your network, also known as the network boundary. There is no default set of locations or automatic way to define these locations. You must add them to your WIP policies, and you can add as many locations as you require.

When you add a network boundary definition, you choose the type of boundary; based on that choice, you provide the definition in a specific format. You can also configure the policy to tell Windows if some boundary lists, such as the lists of proxy servers or IP addresses, are definitive or if searching for other servers or IP addresses on your network is allowed.

The following table describes the different boundary type options.

| Network element        | Description |
| ---------------------- | ----------- |
| Cloud resources        |Specifies URLs for cloud-based resources or applications such as SharePoint Online or Microsoft Visual Studio Codespace that should be treated as containing organizational data. You can make multiple entries by using the format **URL1**\|**URL2**.|
| Protected domains      |Defines DNS suffixes for domains that should be treated as protected. Multiple entries are allowed by using the format domainname1,domainname2; for example, corp.adatum.com,sales.adatum.com.|
| Network domains        |Defines the DNS suffixes that are used within your environment. Multiple entries are allowed by using the format domainname1,domainname2; for example, corp.adatum.com,sales.adatum.com.|
| Proxy servers          |Specifies external-facing proxy server addresses and ports where WIP should protect traffic. For example, proxy.adatum.com:80;proxy2.adatum.com:137.|
| Internal proxy servers |Specifies proxy servers that devices use to reach cloud-based resources. Uses the same format as enterprise proxy servers.|
| IPv4 ranges            |Specifies the range of Internet Protocol version 4 (IPv4) addresses used in your network. Enter by using the format startingaddress-endingaddress, with multiple ranges separated by commas. This network element is required if you don't specify an enterprise Internet Protocol version 6 (IPv6) range.|
| IPv6 ranges            |Specifies the range of IPv6 addresses used in your network. This network element is required if you don't specify enterprise IPv4 ranges, and it uses the same format as IPv4.|
| Neutral resources      |Specifies authentication redirection endpoints for your company, such as Active Directory Federation Services endpoints. Enter by using the format **URL1**\|**URL2**.|

#### Data Recovery Agent (DRA) certificate

As described earlier, WIP will encrypt enterprise data when it’s on local drives. If the encryption key is lost or revoked, you can't recover the data. By adding a DRA certificate, you provide a public key that will encrypt the local data, which will allow you to unencrypt that data later if necessary.

If you don’t already have an Encrypting File System (EFS) DRA certificate, you'll need to create one and upload it to your policy before you can deploy it.

For more information, see [Create and verify an Encrypting File System (EFS) Data Recover Agent (DFA) certificate](https://aka.ms/G7280o).

#### Optional WIP-related settings

You can also configure these other WIP policy settings:

 -  **Revoke encryption keys on unenroll**. Users can't access encrypted organizational data when a device is unenrolled from Intune.
 -  **Show the Windows Information Protection icon overlay**. Determines if the WIP icon overlays files in File Explorer or in the Save As view.
 -  **Use Azure RMS for WIP.** Determines whether Azure RMS encryption will be used for WIP. Must have Azure RMS.
 -  **Use Windows Hello for Business as a method for signing into Windows**. Determines if users can use Windows Hello to sign in to their device and the rules for using Windows Hello.
