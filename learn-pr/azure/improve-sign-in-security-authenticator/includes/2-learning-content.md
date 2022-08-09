<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
Azure AD users can satisfy multifactor authentication requirements by using various authentications methods. 

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
Your company wants remote employees to use more secure sign-in methods than SMS and voice call, so you need to what options are available. 

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
Here, you'll review modern authentication methods and security features. Then you'll compare various methods for security, usability, and availability before deciding how to switch remote employees to a more secure sign-in method. 

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
:::image type="content" border="true" source="../media/methods.png" alt-text="Table showing authentication methods.":::


<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## What authentication and verification methods are available in Azure Active Directory?

Users with accounts in Azure Active Directory (Azure AD) have many ways to authenticate themselves when they sign in for services like Microsoft 365 or Azure. While a username and password is one common way, that basic password should be supplemented or replaced with modern authentication and security features in Azure AD. 

Let's take a closer look at each method to better understand their advantages. Knowing the advantages of each method will help you determine a path to move remote employees from less secure methods. 

### Microsoft Authenticator

For flexibility and usability, Microsoft recommends that you use Microsoft Authenticator. This authentication method provides the best user experience. Users can sign in to any platform or browser by getting a notification to their phone, matching a number displayed on the screen to the one on their phone, and then using their biometric (touch or face) or PIN to confirm.  and multiple modes, such as passwordless, MFA push notifications, and OATH codes. 

:::image type="content" border="true" source="../media/phone-sign-in-microsoft-authenticator-app.png" alt-text="Screenshot of Microsoft Authenticator sign-in.":::

### Windows Hello for Business

Windows Hello for Business is ideal for information workers that have their own designated Windows PC. The biometric and PIN credentials are directly tied to the user's PC, which prevents access from anyone other than the owner. With public key infrastructure (PKI) integration and built-in support for single sign-on (SSO), Windows Hello for Business provides a convenient method for seamlessly accessing corporate resources on-premises and in the cloud.

:::image type="content" border="true" source="../media/windows-hello-sign-in.jpeg" alt-text="Screenshot of Windows Hello for Business sign-in.":::

### FIDO2 security keys

The FIDO (Fast IDentity Online) Alliance helps to promote open authentication standards and reduce the use of passwords as a form of authentication. FIDO2 is the latest standard that incorporates the web authentication (WebAuthn) standard.

FIDO2 security keys are an unphishable standards-based passwordless authentication method that can come in any form factor. Fast Identity Online (FIDO) is an open standard for passwordless authentication. FIDO allows users and organizations to leverage the standard to sign in to their resources without a username or password using an external security key or a platform key built into a device.

Users can register and then select a FIDO2 security key at the sign-in interface as their main means of authentication. These FIDO2 security keys are typically USB devices, but could also use Bluetooth or NFC. With a hardware device that handles the authentication, the security of an account is increased as there's no password that could be exposed or guessed.

FIDO2 security keys can be used to sign in to their Azure AD or hybrid Azure AD joined Windows 10 devices and get single-sign on to their cloud and on-premises resources. Users can also sign in to supported browsers. FIDO2 security keys are a great option for enterprises who are very security sensitive or have scenarios or employees who aren't willing or able to use their phone as a second factor.

:::image type="content" border="true" source="../media/security-key.png" alt-text="Screenshot of FIDO2 Security key sign-in.":::
   
### OATH tokens

OATH TOTP (Time-based One Time Password) is an open standard that specifies how one-time password (OTP) codes are generated. OATH TOTP can be implemented using either software or hardware to generate the codes. 

Software OATH tokens are typically applications such as Microsoft Authenticator and other authenticator apps. Azure AD generates the secret key, or seed, that's input into the app and used to generate each OTP. Microsoft Authenticator automatically generates codes when set up to do push notifications so a user has a backup even if their device doesn't have connectivity. 

OATH-TOTP SHA-1 hardware tokens refresh codes every 30 or 60 seconds. Customers can purchase these tokens from the vendor of their choice. OATH TOTP hardware tokens typically come with a secret key, or seed, pre-programmed in the token. These keys must be input into Azure AD.

:::image type="content" border="true" source="../media/oath-tokens.png" alt-text="Screenshot of OATH token upload.":::

### SMS

SMS-based sign-in is often used by Frontline workers. With SMS-based sign-in, users don't need to know a username and password to access applications and services. The user instead enters their registered mobile phone number, receives a text message with a verification code, and enters that in the sign-in interface. SMS authentication is less secure than other methods because SMS messages are not encrypted and they can be intercepted.

### Voice call

Users can also verify themselves using a mobile phone as secondary form of authentication. With phone call verification, an automated voice call is made to the phone number registered by the user. To complete the sign-in process, the user is prompted to press # on their keypad. Like SMS, voice calls are less secure than other authentication methods because they not encrypted and can be intercepted. 
  
## Compare security

The following table summarizes user considerations for each Azure AD authentication method. Usability refers to how easily users can sign-in with that method. For example, OATH tokens can only be used as a secondary form of verification. Availability refers to the number of environments where users can sign-in with that method. Some environments don't allow phones to be used for verification, which makes SMS ans Voice call less available. 

| Authentication method          | Security | Usability | Availability |
|--------------------------------|:--------:|:---------:|:------------:|
| Windows Hello for Business     | High     | High      | High         |
| Microsoft Authenticator app    | High     | High      | High         |
| FIDO2 security key             | High     | High      | High         |
| OATH hardware tokens           | Medium   | Medium    | High         |
| OATH software tokens           | Medium   | Medium    | High         |
| SMS                            | Medium   | High      | Medium       |
| Voice                          | Medium   | Medium    | Medium       |
| Password                       | Low      | High      | High         |

## Decide which authentication methods to enable

Budget constraints prevent some passwordless options. You can't buy new PCs with Windows Hello for Business or FIDO2 security keys. On the other hand, remote employees who sign in with SMS or voice call already have phones that run either Android or iOS. Microsoft Authenticator is a free app that can turn those phones into a strong  credential that is more secure than SMS or voice call and also capable for passwordless sign-in. 

You decide to promote Microsoft Authenticator push notifications as an easy way to move remote employees from less secure methods. You'll create a *registration campaign* to nudge users to set up Microsoft Authenticator whenever they sign. 

:::image type="content" border="true" source="../media/switch.png" alt-text="Table showing switch to more secure authentication methods.":::

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->