# Title

Improve sign-in security by registering Microsoft Authenticator for Azure Active Directory (Azure AD) users

## Role(s)

Security engineers
Security Operations Analyst

## Level

- Beginner

## Product(s)

- Azure Active Directory

## Prerequisites

- Azure Active Directory (Azure AD) fundamentals, including multifactor authentication (MFA).
- Your tenant needs to have enabled Azure AD MFA. We recommend using Conditional Access to enable Azure AD MFA.  
- Have a phone that can install Microsoft Authenticator to test user access.

## Summary

Review authentication methods for Azure AD. For better sign-in security, run a campaign to have users set up Microsoft Authenticator and confirm it's their default sign-in method.

## Learning objectives

By the end of this module, you'll be able to:

1. Explain why Microsoft Authenticator provides better security than authentication methods like SMS or voice call. 
1. Enable the policy to help users register Microsoft Authenticator
1. Confirm Microsoft Authenticator is the default sign-in method

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: Exercise or Knowledge check? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Make sure MFA is enabled for the tenant | First | Exercise | Prepare for the registration campaign | Yes |
| Make sure users are enabled for Microsoft Authenticator | First | Exercise | Prepare for the registration campaign | Yes |
| Make sure users Authentication mode is set to **Any** or **Push** | First | Exercise | Prepare for the registration campaign | Yes |
| Create a registration campaign policy | Second | Exercise | Enable the policy | Yes |
| Verification |Third|Exercise | Validate the user experience  | Yes |

## Outline the units

1. Introduction

   You monitor security compliance for an aerospace manufacturer that uses Microsoft 365. In response to recent supply-chain attacks, senior leadership wants to strengthen sign-in security for the company. 

   The company requires MFA, but many employees sign-in with their username and password, and then use either a voice call or an SMS code for additional authentication. With budgets already set for this year, leadership wants a low-cost solution that helps employees switch to better authentication methods and gradually move to passwordless sign-in. 
   
   You need to research available authentication options, including passwordless, and determine a way to help employees switch. Then you'll want to prepare your Microsoft 365 environment and validate the experience for users. 

1. Learning-content unit title

   List the content that will enable the learner to complete the subtask:

   1. Prepare the Microsoft 365 environment:
      - Learn which authentication methods are available
      - Decide which authentication methods to enable
      - Enable users for Microsoft Authenticator
   1. Validate the user experience:
      - Create a test user
      - Perform MFA as a test user 
      - Confirm Microsoft Authenticator is the new default sign-in method 

1. Understand authentication methods 

   
   ## What authentication and verification methods are available in Azure Active Directory?

   As part of the sign-in experience for accounts in Azure Active Directory (Azure AD), users can authenticate themselves in different ways. A username and password is the most common way. With modern authentication and security features in Azure AD, that basic password should be supplemented or replaced with more secure authentication methods.

   ![Diagram of the strengths and preferred authentication methods in Azure AD](media/concept-authentication-methods/authentication-methods.png)

   **Microsoft Authenticator**

   For flexibility and usability, Microsoft recommends that you use the Microsoft Authenticator app. This authentication method provides the best user experience. Users can sign in to any platform or browser by getting a notification to their phone, matching a number displayed on the screen to the one on their phone, and then using their biometric (touch or face) or PIN to confirm.  and multiple modes, such as passwordless, MFA push notifications, and OATH codes. 

   *image*

   **Windows Hello for Business**

   Windows Hello for Business is ideal for information workers that have their own designated Windows PC. The biometric and PIN credentials are directly tied to the user's PC, which prevents access from anyone other than the owner. With public key infrastructure (PKI) integration and built-in support for single sign-on (SSO), Windows Hello for Business provides a convenient method for seamlessly accessing corporate resources on-premises and in the cloud.

   *image*

   **FIDO2 security keys**

   The FIDO (Fast IDentity Online) Alliance helps to promote open authentication standards and reduce the use of passwords as a form of authentication. FIDO2 is the latest standard that incorporates the web authentication (WebAuthn) standard.

   FIDO2 security keys are an unphishable standards-based passwordless authentication method that can come in any form factor. Fast Identity Online (FIDO) is an open standard for passwordless authentication. FIDO allows users and organizations to leverage the standard to sign in to their resources without a username or password using an external security key or a platform key built into a device.

   Users can register and then select a FIDO2 security key at the sign-in interface as their main means of authentication. These FIDO2 security keys are typically USB devices, but could also use Bluetooth or NFC. With a hardware device that handles the authentication, the security of an account is increased as there's no password that could be exposed or guessed.

   FIDO2 security keys can be used to sign in to their Azure AD or hybrid Azure AD joined Windows 10 devices and get single-sign on to their cloud and on-premises resources. Users can also sign in to supported browsers. FIDO2 security keys are a great option for enterprises who are very security sensitive or have scenarios or employees who aren't willing or able to use their phone as a second factor.

   *image*
   
   **OATH tokens**

   OATH TOTP (Time-based One Time Password) is an open standard that specifies how one-time password (OTP) codes are generated. OATH TOTP can be implemented using either software or hardware to generate the codes. 

   Software OATH tokens are typically applications such as Microsoft Authenticator and other authenticator apps. Azure AD generates the secret key, or seed, that's input into the app and used to generate each OTP. Microsoft Authenticator automatically generates codes when set up to do push notifications so a user has a backup even if their device doesn't have connectivity. 

   OATH-TOTP SHA-1 hardware tokens refresh codes every 30 or 60 seconds. Customers can purchase these tokens from the vendor of their choice. OATH TOTP hardware tokens typically come with a secret key, or seed, pre-programmed in the token. These keys must be input into Azure AD.

   **SMS**

   SMS-based sign-in is often used by Frontline workers. With SMS-based sign-in, users don't need to know a username and password to access applications and services. The user instead enters their registered mobile phone number, receives a text message with a verification code, and enters that in the sign-in interface. SMS authentication is less secure than other methods because SMS messages are not encrypted and they can be intercepted.

   **Voice call**

   Users can also verify themselves using a mobile phone as secondary form of authentication. With phone call verification, an automated voice call is made to the phone number registered by the user. To complete the sign-in process, the user is prompted to press # on their keypad. Like SMS, voice calls are less secure than other authentication methods because they not encrypted and can be intercepted. 
  
   ## Authentication method strength and security

   The following table summarizes considerations for Azure AD authentication method. Some users in your environment sign in by using SMS or voice call. Microsoft Authenticator can turn any of their iOS or Android phones into a strong, passwordless credential that is more secure than SMS or voice call. 

   | Authentication method          | Security | Usability | Availability |
   |--------------------------------|:--------:|:---------:|:------------:|
   | Windows Hello for Business     | High     | High      | High         |
   | Microsoft Authenticator app    | High     | High      | High         |
   | FIDO2 security key             | High     | High      | High         |
   | OATH hardware tokens (preview) | Medium   | Medium    | High         |
   | OATH software tokens           | Medium   | Medium    | High         |
   | SMS                            | Medium   | High      | Medium       |
   | Voice                          | Medium   | Medium    | Medium       |
   | Password                       | Low      | High      | High         |

   **Getting started**

   Budget constraints prevent some passwordless options. You can't buy new PCs with Windows Hello for Business or FIDO2 security keys. On the other hand, employees who sign-in with SMS or voice call already have phones that run either Android or iOS. Microsoft Authenticator is a free app that can turn those phones into a strong, passwordless credential that is more secure than SMS or voice call. 

   You decide to promote Microsoft Authenticator push notifications as an easy way to move users from less secure methods. You'll create a *registration campaign* to nudge users to set up Microsoft Authenticator whenever they sign. 

   You want to try out how the registration campaign works for a test user account. After you confirm it works as expected, you plan to run the campaign for the employees who sign in using methods like SMS or Voice call.  

1. Prepare the environment

   Before enabling a registration campaign, make sure prerequisites are complete. Only users who are enabled for Azure AD MFA will be prompted to register Microsoft Authenticator, so check that Azure AD MFA is enabled for the tenant. The users also need to be enabled to use Microsoft Authenticator for authentication, and the Authentication mode must be set to **Any** or **Push**. 

   **Exercise: Verify users are enabled for Microsoft Authenticator**

   1. In the Azure AD portal, click **Security** > **Authentication methods** > **Policies**. 
   1. Click **Microsoft Authenticator**, click **Enabled**, select **All users** or **Select users** to choose specific users or groups.
   1. In the contextual menu, click **Configure**, set **Authentication mode** to **Any** or **Push**, and click **Done**. 
   1. Click **Save**.

1. Prepare the Microsoft 365 environment

   During the process, you'll:
   - Create a test user account
   - Enable authentication methods for the test user 


   You can enable the the registration campaign in the Azure AD portal.

   The registration campaign can apply to only a single group, but it can contain other groups. 

   If you want to nudge users during each MFA attempt, set the snooze to 0.

   **Exercise: Enable the registration campaign using the Azure AD portal**

   We will use portal....

   1. In the Azure AD portal, sign in as either Authentication Policy Administrator or Global Administrator.
   1. Click **Security** > **Authentication methods** > **Registration campaign**.
   1. Under **State**, click **Enabled**, select any users or groups to exclude from the registration campaign, and then click **Save**.

1. **Exercise: Validate the Microsoft Authenticator setup**

   With the registration campaign enabled, let's walk through the user experience to make sure Microsoft Authenticator setup works as expected. We'll create a test user and then sign in from a phone that can install Microsoft Authenticator. 

   **Create a test user account**

   Create a user account for the purposes of testing the Microsoft Authenticator registration campaign.

   1. Sign in to the Azure portal, click **Azure Active Directory** > **Manage** > **Users**.
   1. Select **New user** at the top of the pane.
   1. In the **User name** field, enter the username of the user account. For example, `contosouser1@contoso.com`. Be sure to change `contoso.com` to the name of the tenant domain.
   1. In the **Name** field, enter the name of the user of the account. For example, `contosouser1`.
   1. Leave Auto-generate password selected, and then select **Show password**. Write down the value that's displayed in the **Password** box.
   1. Select **Create**.

   **Enable current authentication methods for the test user**

   Your company is concerned about users who sign in with Voice call or SMS for MFA. Let's enable this test user to sign in with Voice by default as their current method for MFA.  

   1. Choose the test user you created and select **Authentication methods**.
   1. At the top of the window, select **+ Add authentication method**.
   1. Select **Phone number** and enter a number with a valid format such as *+1 4255551234*.
   1. Select **Add**.

   **Enable Microsoft Authenticator**
   
   With the test user configured to sign in using Voice call, now let's enable Microsoft Authenticator as a passwordless sign-in option for the test user. You'll need to set the Authentication mode to Push. If it's set to Passwordless, the will not be nudged to set up Authenticator.  

   1. In Authentication methods, click **Policies**.
   1. Under Microsoft Authenticator, choose the following options:
   
      - Enable - **Yes**
      - Target - Select the test user
      - Browse to **...** > **Configure**.
      - For Authentication mode - **Push**. 
      
   1. To apply the new policy, click **Save**.

   **Sign in as a test user**

   Sign in as the test user from a device that hasn't already set up Microsoft Authenticator. The device must use the phone number that you enabled for authentication.  

   1. Sign in to Azure and perform MFA. 
   1. When prompted, set up the Microsoft Authenticator app to improve their sign-in experience. Only users who are allowed for the Microsoft Authenticator push notifications and do not have it currently set up will see the prompt. 
   1. User taps **Next** and steps through Microsoft Authenticator setup. 
      1. First download the app.  
      1. See how to set up Microsoft Authenticator. 
      1. Scan the QR Code. 
      1. Approve the test notification.
      1. Notification approved.
      1. Microsoft Authenticator is now successfully set up as the user’s default sign-in method.
   1. If you don't want to install Microsoft Authenticator, tap **Not now** to snooze the prompt for up to 14 days. The snooze duration can be set by an admin. 

What types of questions will test the learning objective? [(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)

- Which authentication method is more secure?
- Which authentication methods are passwordless?
- After you enable a registration campaign, how can you confirm Microsoft Authenticator is the default sign-in method?
- What step must a user complete before they can download and set up Microsoft Authenticator?
- How many days can a user snooze the Microsoft Authenticator setup?

1. Summary

   To improve sign-in security, you needed to roll out a low-cost passwordless sign-in strategy to help users move away from signing in with less secure methods like Voice calls or SMS. You chose to create a registration campaign to help users set up Microsoft Authenticator, a free app, and use it as their default method for passwordless sign-in. 

   You made it easy for employees to register Microsoft Authenticator when they sign in using MFA. Now you can target the registration campaign to specific users who sign in using less secure methods, and move them to sign in with Microsoft Authenticator for better security. You helped your company take an important step to prevent security breaches from compromised credentials. 

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.

[How to run a registration campaign to set up Microsoft Authenticator](https://docs.microsoft.com/en-us/azure/active-directory/authentication/how-to-mfa-registration-campaign)
[Authentication methods](https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-authentication-methods)
[Microsoft Authenticator app](https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-authentication-authenticator-app)