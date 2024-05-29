Multifactor authentication is a process in which a user is prompted for additional forms of identification during a sign-in event. For example, the prompt could be to enter a code on their cellphone or to provide a fingerprint scan. When you require a second form of identification, security is increased because this additional factor isn't easy for an attacker to obtain or duplicate.

Microsoft Entra multifactor authentication and Conditional Access policies give you the flexibility to require MFA from users for specific sign-in events.

## Prerequisites

To complete this tutorial, you need the following resources and privileges:

 -  A working Microsoft Entra tenant with Microsoft Entra ID P1 or trial licenses enabled.
 -  An account with Conditional Access Administrator, Security Administrator, or Global Administrator privileges. Some MFA settings can also be managed by an Authentication Policy Administrator.
 -  A non-administrator account with a password that you know. For this example, we created such an account, named testuser. In this example, we test the end-user experience of configuring and using Microsoft Entra multifactor authentication.
 -  A group that the non-administrator user is a member of. For this example, we created such a group, named *MFA-Test-Group*. In this example, we enable Microsoft Entra multifactor authentication for this group.

## Create a Conditional Access policy

The recommended way to enable and use Microsoft Entra multifactor authentication is with Conditional Access policies. Conditional Access lets you create and define policies that react to sign-in events and that request additional actions before a user is granted access to an application or service.

:::image type="content" source="../media/conditional-access-overview-f9fc328c.png" alt-text="Diagram showing an example of multifactor authentication and conditional access.":::


In this example, we create a basic Conditional Access policy to prompt for MFA when a user signs in.

First, create a Conditional Access policy and assign your test group of users as follows:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Conditional Access Administrator](/entra/identity/role-based-access-control/permissions-reference#conditional-access-administrator).

2. Browse to **Protection** &gt; **Conditional Access**, select **+ New policy**, and then select **Create new policy**.

    :::image type="content" source="../media/conditional-access-policy-configuration-51511a83.png" alt-text="Screenshot showing an example of the conditional access new policy creation page.":::


3. Enter a name for the policy, such as *MFA Pilot*.

4. Under **Assignments**, select the current value under **Users or workload identities**.<br>

    :::image type="content" source="../media/conditional-access-assignments-60a93961.png" alt-text="Screenshot showing an example of the conditional access assignments page.":::


5. Under **What does this policy apply to?**, verify that **Users and groups** is selected.

6. Under **Include**, choose **Select users and groups**, and then select **Users and groups**.

    :::image type="content" source="../media/conditional-access-policy-new-assignment-842ad63f.png" alt-text="Screenshot showing an example of how to control access for users and groups.":::


> [!NOTE]
> Since no one is assigned yet, the list of users and groups (shown in the next step) opens automatically.

7. Browse for and select your Microsoft Entra group, such as *MFA-Test-Group*, then choose **Select**.

    :::image type="content" source="../media/conditional-access-select-users-groups-2b5dc66a.png" alt-text="Screenshot showing an example of how to apply control access to users or groups.":::


> [!NOTE]
> We've selected the group to apply the policy to. In the next section, we configure the conditions under which to apply the policy.

## Configure the conditions for multifactor authentication

Now that the Conditional Access policy is created and a test group of users is assigned, define the cloud apps or actions that trigger the policy. These cloud apps or actions are the scenarios that you decide require additional processing, such as prompting for multifactor authentication. For example, you could decide that access to a financial application or use of management tools require an additional prompt for authentication.

### Configure which apps require multifactor authentication<br>

For this example, configure the Conditional Access policy to require multifactor authentication when a user signs in.

1. Select the current value under **Cloud apps or actions**, and then under **Select what this policy applies to**, verify that **Cloud apps** is selected.<br>

2. Under **Include**, choose **Select apps**.<br>

> [!NOTE]
> Since no apps are yet selected, the list of apps (shown in the next step) opens automatically.

> [!TIP]
> You can choose to apply the Conditional Access policy to **All cloud apps** or **Select apps**. To provide flexibility, you can also exclude certain apps from the policy.

3. Browse the list of available sign-in events that can be used. For this example, select **Windows Azure Service Management API** so that the policy applies to sign-in events. Then choose **Select**.

    :::image type="content" source="../media/multifactor-credentials-e4680656.png" alt-text="Screenshot showing an example of how to configure the conditional access policy to require multifactor authentication.":::


### Configure multifactor authentication for access

Next, we configure access controls. Access controls let you define the requirements for a user to be granted access. They might be required to use an approved client app or a device that's hybrid joined to Microsoft Entra ID.

In this example, configure the access controls to require multifactor authentication during a sign-in event.

1. Under **Access controls**, select the current value under **Grant**, and then select **Grant access**.

    :::image type="content" source="../media/multifactor-grant-access-95b7f0f3.png" alt-text="Screenshot showing an example of how to block or grant access.":::


2. Select **Require multifactor authentication**, and then choose **Select**.

    :::image type="content" source="../media/multifactor-control-access-b8b5eade.png" alt-text="Screenshot showing an example of how to grant access and require multifactor authentication.":::


### Activate the policy

Conditional Access policies can be set to **Report-only** if you want to see how the configuration would affect users, or **Off** if you don't want to the use policy right now. Because a test group of users is targeted for this tutorial, let's enable the policy, and then test Microsoft Entra multifactor authentication.

1. Under **Enable policy**, select **On**.

:::image type="content" source="../media/multifactor-enable-policy-control-89c8b9c0.png" alt-text="Screenshot showing an example of how to enable the report only policy.":::


2. To apply the Conditional Access policy, select **Create**.

## Test Microsoft Entra multifactor authentication

Let's see your Conditional Access policy and Microsoft Entra multifactor authentication in action.

First, sign in to a resource that doesn't require MFA:

1. Open a new browser window in InPrivate or incognito mode and browse to [https://account.activedirectory.windowsazure.com](https://account.activedirectory.windowsazure.com/). Using a private mode for your browser prevents any existing credentials from affecting this sign-in event.

2. Sign in with your non-administrator test user, such as *testuser*. Be sure to include @ and the domain name for the user account. If this is the first instance of signing in with this account, you're prompted to change the password. However, there's no prompt for you to configure or use multifactor authentication.

3. Close the browser window.

You configured the Conditional Access policy to require additional authentication for sign in. Because of that configuration, you're prompted to use Microsoft Entra multifactor authentication or to configure a method if you haven't yet done so.

Test this new requirement by signing in to the Microsoft Entra admin center:

1. Open a new browser window in InPrivate or incognito mode and sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).

2. Sign in with your non-administrator test user, such as *testuser*. Be sure to include @ and the domain name for the user account. You're required to register for and use Microsoft Entra multifactor authentication.

:::image type="content" source="../media/microsoft-entra-multifactor-authentication-2b9ff13f.png" alt-text="Screenshot showing the more information required notification.":::


3. Select **Next** to begin the process.

You can choose to configure an authentication phone, an office phone, or a mobile app for authentication. *Authentication phone* supports text messages and phone calls, *office phone* supports calls to numbers that have an extension, and *mobile app* supports using a mobile app to receive notifications for authentication or to generate authentication codes.

4. Complete the instructions on the screen to configure the method of multifactor authentication that you've selected.

5. Close the browser window, and sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) again to test the authentication method that you configured. For example, if you configured a mobile app for authentication, you should see a prompt like the following.

:::image type="content" source="../media/approve-sign-in-request-ab44e1f6.png" alt-text="Screenshot showing the approve sign in request notification.":::


6. Close the browser window.

## Configure Microsoft Entra multifactor authentication settings

To customize the end-user experience for Microsoft Entra multifactor authentication, you can configure options for settings like account lockout thresholds or fraud alerts and notifications.

The following Microsoft Entra multifactor authentication settings are available in the Azure portal:

| **Feature**                                                                                                                                          | **Description**                                                                                                                                                                                                                                                                       |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Account lockout (MFA Server only)](/entra/identity/authentication/howto-mfa-mfasettings#account-lockout-mfa-server-only) | Temporarily lock accounts from using Microsoft Entra multifactor authentication if there are too many denied authentication attempts in a row. This feature applies only to users who use MFA Server to enter a PIN to authenticate.                                                  |
| [Block/unblock users](/entra/identity/authentication/howto-mfa-mfasettings#block-and-unblock-users)                       | Block specific users from being able to receive Microsoft Entra multifactor authentication requests. Any authentication attempts for blocked users are automatically denied. Users remain blocked for 90 days from the time that they're blocked or until they're manually unblocked. |
| [Fraud alert](/entra/identity/authentication/howto-mfa-mfasettings#fraud-alert)                                           | Configure settings that allow users to report fraudulent verification requests.                                                                                                                                                                                                       |
| [Report suspicious activity](/entra/identity/authentication/howto-mfa-mfasettings#report-suspicious-activity)             | Configure settings that allow users to report fraudulent verification requests.                                                                                                                                                                                                       |
| [Notifications](/entra/identity/authentication/howto-mfa-mfasettings#notifications)                                       | Enable notifications of events from MFA Server.                                                                                                                                                                                                                                       |
| [OATH tokens](/entra/identity/authentication/concept-authentication-oath-tokens)                                          | Used in cloud-based Microsoft Entra multifactor authentication environments to manage OATH tokens for users.                                                                                                                                                                          |
| [Phone call settings](/entra/identity/authentication/howto-mfa-mfasettings#phone-call-settings)                           | Configure settings related to phone calls and greetings for cloud and on-premises environments.                                                                                                                                                                                       |
| Providers                                                                                                                                            | This will show any existing authentication providers that you've associated with your account. Adding new providers is disabled as of September 1, 2018.                                                                                                                              |

## Account lockout (Microsoft Entra multifactor authentication Server only)

> [!NOTE]
> Account lockout only affects users who sign in by using MFA Server on-premises.

To prevent repeated multifactor authentication attempts as part of an attack, the account lockout settings let you specify how many failed attempts to allow before the account becomes locked out for a period of time. The account lockout settings are applied only when a PIN code is entered for the multifactor authentication prompt.

The following settings are available:

 -  Number of multifactor authentication denials that trigger an account lockout
 -  Minutes until the account lockout counter is reset
 -  Minutes until the account is automatically unblocked

To configure account lockout settings, complete these steps:

1.  Sign in to the Azure portal as an **administrator**.
2.  Go to **Microsoft Entra ID**, **Security**, **Multifactor authentication**, **Account lockout**.
3.  Enter the values for your environment, and then **select Save**.

## Block and unblock users

If a user's device is lost or stolen, you can block Microsoft Entra multifactor authentication attempts for the associated account. Any Microsoft Entra multifactor authentication attempts for blocked users are automatically denied. Users **remain blocked for 90 days from the time that they're blocked**.

**Block a user**

To block a user, complete the following steps.

1.  Browse to **Microsoft Entra ID**, **Security**, **Multifactor authentication**, **Block and unblock users**.<br>
2.  Select Add to block a user.
3.  Enter the user name for the blocked user in the format username@domain.com, and then provide a comment in the Reason box.
4.  Select OK to block the user.

**Unblock a user**

To unblock a user, complete the following steps:

1.  Go to **Microsoft Entra ID, Security**, **Multifactor authentication, Block and unblock users**.<br>
2.  In the Action column next to the user, **select Unblock**.
3.  Enter a comment in the Reason for the unblocking box.
4.  Select **OK** to unblock the user.

## Report suspicious activity

A preview of Report Suspicious Activity, the updated **Multifactor authentication Fraud Alert feature**, is now available. When an unknown and suspicious multifactor authentication prompt is received, users can report the fraud attempt using Microsoft Authenticator or phone. These alerts are integrated with Identity Protection for more comprehensive coverage and capability.

Users who report a multifactor authentication prompt as suspicious are set to High User Risk. Administrators can use risk-based policies to limit access for these users or enable **self-service password reset (SSPR)** for users to remediate problems on their own. If you previously used the Fraud Alert automatic blocking feature and don't have an **Microsoft Entra ID** P2 license for risk-based policies, you can use risk detection events to identify and disable impacted users and automatically prevent their sign-in. For more information about using risk-based policies, see Risk-based access policies.<br>

To enable Report Suspicious Activity from the Authentication Methods Settings:<br>

1.  In the Azure portal, click **Microsoft Entra ID**, **Security**, **Authentication Methods**, **Settings**.<br>
2.  Set Report Suspicious Activity to Enabled.
3.  Select All users or a specific group.

## **View suspicious activity events**

When a user reports a multifactor authentication prompt as suspicious, the event shows up in the Sign-ins report (**as a sign-in that was rejected by the user**), in the **Audit logs**, and in the **Risk detections** report.

Select Azure **Microsoft Entra ID**, **Security, Identity Protection, Risk detection** to view the risk detection report. The risk event is part of the standard Risk Detections report and will appear as Detection Type User Reported Suspicious Activity, Risk level High, Source End user reported.<br>

Select **Microsoft Entra ID**, **Sign-in logs**, **Authentication Details** to view fraud reports in the Sign-in report. The fraud report is part of the standard Microsoft Entra ID Sign-ins report and appears in the Result Detail as MFA denied, Fraud Code Entered.<br>

To view fraud reports in the Audit logs, select **Microsoft Entra ID**, **Audit logs**. The fraud report appears under Activity type Fraud reported - user is blocked for multifactor authentication, or Fraud reported - no action taken based on the tenant-level settings for a fraud report.<br>

## Manage suspicious activity events

Once a user has reported a prompt as suspicious, the risk should be investigated and remediated with Identity Protection.

**Report suspicious activity and fraud alert**

**Report Suspicious Activity** and the legacy **Fraud Alert** implementation can operate in parallel. You can keep your tenant-wide Fraud Alert functionality in place while you start to use **Report Suspicious Activity** with a targeted test group.

If Fraud Alert is enabled with Automatic Blocking and Report Suspicious Activity is enabled, the user will be added to the blocklist and set as high-risk and in-scope for any other policies configured. These users will need to be removed from the blocklist and have their risk remediated to enable them to sign in with MFA.<br>

## **Notifications**

You can configure Microsoft Entra ID to send email notifications when users report fraud alerts. These notifications are typically sent to identity administrators because the user's account credentials are likely compromised. The following example shows what a fraud alert notification email looks like:

:::image type="content" source="../media/multifactor-authentication-fraud-alert-email-d6d50c09.png" alt-text="Screenshot showing an example of a Microsoft Entra ID fraud alert email notification.":::


## OATH tokens

Microsoft Entra ID supports the use of **OATH TOTP (Time-based One Time Password)** SHA-1 tokens that refresh codes every **30** or **60** seconds. You can purchase these tokens from the vendor of your choice.

OATH TOTP hardware tokens typically come with a secret key, or seed, pre-programmed in the token. You need to input these keys into Microsoft Entra ID as described in the following steps. Secret keys are limited to 128 characters, which might not be compatible with all tokens. The secret key can contain only the characters a-z or A-Z and digits 1-7. It must be encoded in Base32.<br>

Programmable OATH TOTP hardware tokens that can be reseeded can also be set up with Microsoft Entra ID in the software token setup flow.<br>

OATH hardware tokens are supported as part of a public preview.

After you acquire tokens, you need to upload them in a comma-separated values (CSV) file format. Include the **User Principal Name (UPN)**, **serial number**, **secret key**, **time interval**, **manufacturer**, and **model**.

```
upn,serial number,secret key,time interval,manufacturer,model
Helga@contoso.com,1234567,2234567abcdef2234567abcdef,60,Contoso,HardwareKey
```

> [!NOTE]
> Make sure to include the header row in your CSV file.

An administrator can sign in to the Azure portal, go to **Microsoft Entra ID, Security**, **Multifactor authentication**, **OATH tokens**, and **upload the CSV file**.<br>

Depending on the CSV file size, it might take a few minutes to process. Select Refresh to get the status. If there are any errors in the file, you can download a CSV file that lists them. The field names in the downloaded CSV file are different from those in the uploaded version.<br>

After any errors are addressed, the administrator can activate each key by selecting Activate for the token and entering the **one-time passwords (OTPs)** displayed in the token.<br>

Users can have a combination of up to five OATH hardware tokens or authenticator applications, such as the Microsoft Authenticator app, configured for use at any time.
