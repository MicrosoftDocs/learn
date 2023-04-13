Here, you'll learn about two recommended authentication systems employed by GitHub Enterprises. You'll also learn how to do a basic but important 2FA audit for user compliance.

When it comes to user authentication, security should be the number one consideration that comes to mind. Strong security is essential. It seems like every month or so, a company reports a data breach. Credentials are stolen because of inefficient security processes, or simply because of a lack of up-to-date security features within the company. Establishing secure user authentication can be a difficult task if user adoption requires long and frustrating steps to authenticate. Ask any security professional and they'll mention several ways that companies authenticate their users.

There are two recommended authentication methods you can implement when authenticating your users on GitHub: SAML SSO and multifactor authentication, also known as 2FA.

## Authentication with SAML SSO

SAML authentication is a process used to verify user identity and credentials against a known identity provider. Nowadays, your company may likely already be using this form of authentication. If so, you can link your existing IdP to GitHub for user sign-in management. The following is a high-level overview of the process that occurs with enabled SAML SSO within your GitHub Enterprise:

- Before enabling SAML SSO with your GitHub Enterprise, an Administrator needs to connect the GitHub organization to a supported IdP.
- Next, when a member accesses resources within an organization that uses SAML SSO, GitHub redirects the member to the IdP to authenticate.
- After successful authentication, the IdP redirects the member back to GitHub, where the member can access the organization's resources. The result means that even after configuring SAML SSO, members of the GitHub organization will continue to be prompted to log into their user accounts on GitHub.

### Enforce SAML SSO for your organization

It's important to note that if you have enabled SAML SSO across your organization, you'll need to enforce authentication after the setting has been enabled. This enforcement will make the authentication process a requirement. As the organization administrator, you can enforce this setting by selecting *Your organizations*, then selecting *Settings*, and then choosing *Organization security*. Under SAML single sign-on, select *Require SAML SSO authentication for all members of the organization*.

:::image type="content" source="../media/require-saml-sso-authentication.png" alt-text="Screenshot of the setting to require SSO authentication for all members of an organization." :::

After you enforce authentication for an organization, GitHub will then remove any members of the organization that haven't authenticated successfully with your SAML IdP.

> [!IMPORTANT]
> Keep in mind that GitHub will not remove members of the *enterprise* that have not yet authenticated successfully with your SAML IdP. The member will be prompted to authenticate with your SAML IdP the next time the member accesses the enterprise's resources or tries to authenticate after the setting has been enabled.

## Multifactor authentication or 2FA

Two-factor authentication is an extra level of security available to GitHub Enterprise accounts. With 2FA, a member in your organization is required to log in with username and password, and also provide a secondary form of authentication. This second form of authentication needs to be something only the user knows or has access to. You can require organization members, outside collaborators, and billing managers to enable two-factor authentication for their personal accounts by selecting an organization security setting.

:::image type="content" source="../media/require-2fa-checkbox.png" alt-text="Screenshot of the checkbox requiring two-factor authentication for members in the organization.":::

Keep in mind that before you can require organization members, outside collaborators, or billing managers to use two-factor authentication, they must enable the two-factor authentication setting for their account on GitHub. You'll need to communicate this requirement to your team via email or some other means of communication.

> [!WARNING]
> When you require the use of two-factor authentication for your organization, all accounts that do not use 2FA will be removed from the organization and lose access to its repositories. This includes bot accounts.

For more detailed information about 2FA, see [Securing your account with two-factor authentication (2FA)](https://docs.github.com/en/github/authenticating-to-github/securing-your-account-with-two-factor-authentication-2fa).

### Options to identify with 2FA

Only users who legitimately need access to your organization's data should have it. Insufficient data security could lead to an attack or breach of important data. One way to ensure that your organization is meeting basic security requirements is by enabling 2FA. When you require 2FA, a malicious actor needs more than just a user's password and username to access an account. 2FA makes it much harder for malicious actors to access your organization's data, because they don't have access to your users' physical devices.

The codes used for 2FA expire in a short amount of time. Once expired, the login attempt is no longer valid, and the access request is canceled. By enabling 2FA, your user's accounts will be better protected from malicious attacks and data breaches. In your GitHub enterprise, your users have three ways that they can authenticate with 2FA: security keys, TOTP, and SMS.

#### Security keys

With security keys, your enterprise can achieve a higher level of user security and protection. With two-factor authentication enabled, security keys provide a strong, convenient, and phishing-proof option for 2FA. Authentication with a security key requires that TOTP or SMS authentication has already been completed. On most devices, you can use a physical security key over USB or NFC. A user can register a new security key by accessing their profile setting and following the security key’s documentation. Using these keys is the most secure form of 2FA, because they're nearly impossible for a malicious party to replicate. When using a security key, none of the sensitive information ever leaves the physical security key device. Authentication with a security key is the most secure way to authenticate, but your users will need to complete one of the following authentication methods to configure the key.

#### TOTP

GitHub recommends using a cloud-based TOTP app to configure 2FA. TOTP applications are more reliable than SMS, especially for locations outside the United States. TOTP apps support the secure backup of your authentication codes in the cloud, and can be restored if you lose access to your device.

:::image type="content" source="../media/two-factor-identification-totp-example.png" alt-text="Screenshot of the time-based one-time password code." :::

#### SMS

If your users aren't able to authenticate using a TOTP mobile app, they can authenticate using SMS messages. This form of 2FA relies on the assumption that the user is the only person with access to their mobile device. GitHub doesn't support authentication via SMS in all countries/regions. Before an Administrator allows users to authenticate via SMS, they should confirm that it's supported in the country/region where the users are located.

:::image type="content" source="../media/two-factor-authentication-sms-six-digit-code-example.png" alt-text="Screenshot of the sms code." :::

### Audit 2FA for user compliance

You can review which organization owners, members, and outside collaborators have enabled two-factor authentication by navigating to the right corner of GitHub.com, clicking your profile photo, clicking **Your organizations**, then selecting the name of the chosen organization. Under the organization name, click the **People** tab and then select the **2FA** option. From here, you can see which members in the organization have enabled two-factor authentication, and which outside contributors have it enabled.

:::image type="content" source="../media/two-factor-authentication-enabled-example.png" alt-text="Screenshot of the account-security setting." :::

Revoking access for users in your enterprise who aren't compliant is possible, but you'll need to contact them outside of GitHub to relay the reason they no longer have access to your organization. Communication to non-compliant users is traditionally done through email notification.
