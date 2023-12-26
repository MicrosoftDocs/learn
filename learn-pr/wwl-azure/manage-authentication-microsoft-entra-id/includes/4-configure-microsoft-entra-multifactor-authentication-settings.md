To customize the end-user experience for Microsoft Entra multifactor authentication, you can configure options for settings like account lockout thresholds or fraud alerts and notifications.<br>

The following Microsoft Entra multifactor authentication settings are available in the Azure portal:

| **Feature**                      | **Description**                                                                                                                                                                                                                                                                       |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Account lockout                  | Temporarily lock accounts from using Microsoft Entra multifactor authentication if there are too many denied authentication attempts in a row. This feature applies only to users who enter a PIN to authenticate. (MFA Server only)                                                  |
| Block/unblock users              | Block specific users from being able to receive Microsoft Entra multifactor authentication requests. Any authentication attempts for blocked users are automatically denied. Users remain blocked for 90 days from the time that they're blocked or until they're manually unblocked. |
| Report suspicious activity       | Configure settings that allow users to report fraudulent verification requests.                                                                                                                                                                                                       |
| Notifications                    | Enable notifications of events from MFA Server.                                                                                                                                                                                                                                       |
| Open Authorization (OATH) tokens | Used in cloud-based Microsoft Entra multifactor authentication environments to manage OATH tokens for users.                                                                                                                                                                          |
| Phone call settings              | Configure settings related to phone calls and greetings for cloud and on-premises environments.                                                                                                                                                                                       |
| Providers                        | This will show any existing authentication providers that you've associated with your account. Adding new providers is disabled as of September 1, 2018.                                                                                                                              |

:::image type="content" source="../media/new-multifactor-authentication-settings-portal-00fc7718.png" alt-text="Screenshot showing the multifactor authentication settings portal.":::


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

:::image type="content" source="../media/account-lockout-settings-fd2ee95a.png" alt-text="Screenshot showing a Multi-Authentication Account lockout example.":::


## Block and unblock users

If a user's device is lost or stolen, you can block Microsoft Entra multifactor authentication attempts for the associated account. Any Microsoft Entra multifactor authentication attempts for blocked users are automatically denied. Users **remain blocked for 90 days from the time that they're blocked**.

**Block a user**<br>

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

You can configureMicrosoft Entra IDto send email notifications when users report fraud alerts. These notifications are typically sent to identity administrators because the user's account credentials are likely compromised. The following example shows what a fraud alert notification email looks like:

:::image type="content" source="../media/multifactor-authentication-fraud-alert-email-a2197419.png" alt-text="Screenshot showing a multifactor authentication fraud alert example.":::


## OATH tokens

Microsoft Entra ID supports the use of **OATH TOTP (Time-based One Time Password)** SHA-1 tokens that refresh codes every **30** or **60** seconds. You can purchase these tokens from the vendor of your choice.

OATH TOTP hardware tokens typically come with a secret key, or seed, pre-programmed in the token. You need to input these keys into Microsoft Entra ID as described in the following steps. Secret keys are limited to 128 characters, which might not be compatible with all tokens. The secret key can contain only the characters a-z or A-Z and digits 1-7. It must be encoded in Base32.<br>

Programmable OATH TOTP hardware tokens that can be reseeded can also be set up with Microsoft Entra ID in the software token setup flow.<br>

OATH hardware tokens are supported as part of a public preview.<br>

:::image type="content" source="../media/multifactor-authentication-oath-tokens-6b5b9523.png" alt-text="Screenshot showing the multifactor authentication Oath tokens page.":::


After you acquire tokens, you need to upload them in a comma-separated values (CSV) file format. Include the **User Principal Name (UPN)**, **serial number**, **secret key**, **time interval**, **manufacturer**, and **model**.

> [!NOTE]
> Be sure to include the header row in your CSV file.

An administrator can sign in to the Azure portal, go to **Microsoft Entra ID, Security**, **Multifactor authentication**, **OATH tokens**, and **upload the CSV file**.<br>

Depending on the CSV file size, it might take a few minutes to process. Select Refresh to get the status. If there are any errors in the file, you can download a CSV file that lists them. The field names in the downloaded CSV file are different from those in the uploaded version.<br>

After any errors are addressed, the administrator can activate each key by selecting Activate for the token and entering the **one-time passwords (OTPs)** displayed in the token.<br>

Users can have a combination of up to five OATH hardware tokens or authenticator applications, such as the Microsoft Authenticator app, configured for use at any time.
