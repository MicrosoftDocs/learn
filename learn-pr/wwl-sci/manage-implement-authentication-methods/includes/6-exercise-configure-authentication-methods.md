Contoso's IT security team is ready to roll out stronger authentication controls. In this exercise, you configure an MFA registration policy to enroll users, require MFA for cloud admin portals using Conditional Access, and enable phishing-resistant sign-in with passkeys (FIDO2). A test user account (Delia Dennis) lets you verify each configuration end-to-end.

In this exercise, you complete the following tasks:

- **Task 1**: Enable the MFA registration policy in Identity Protection
- **Task 2**: Require MFA for cloud admin portals using Conditional Access
- **Task 3**: Enable phishing-resistant MFA using passkeys (FIDO2)

## Prerequisites

To complete this exercise, you need:

- A Microsoft Entra ID tenant with a **Global Administrator** or equivalent account
- The **Microsoft Authenticator** app installed on your mobile phone
- A Bluetooth-enabled mobile phone (required for passkey setup in Task 3)
- A test user account — the steps use **Delia Dennis** (`DeliaD@<your domain>`)

> [!NOTE]
> Microsoft Entra ID P2 is required for the Identity Protection MFA registration policy in Task 1. Microsoft Entra ID P1 or P2 is required for the Conditional Access policies in Tasks 2 and 3.

[Launch Lab - Configure MFA and Passkeys](https://github.com/MicrosoftLearning/mslearn-sec-identity/blob/master/Instructions/Labs/01-mfa-ssrp-passkey.md)
