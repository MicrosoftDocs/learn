As the IT team expands its passwordless strategy, it identifies a group of users who remain at elevated risk of compromise—administrators and other privileged accounts with access to sensitive information like personnel records and financial accounts.

These users are frequent targets of sophisticated phishing attacks. To provide an even higher level of protection, the team deploys security keys to these select users.

## What are security keys?

Security keys are physical authentication devices used to verify a user's identity without a password.

They typically support standards such as [FIDO2](https://www.microsoft.com/security/business/security-101/what-is-fido2) and require:

- A physical key (USB, NFC, or Bluetooth)
- A user action, such as tapping or inserting the device

Because authentication requires possession of the physical key, this method helps protect against phishing and credential theft.

For organizations, security keys provide strong protection against account compromise and are a high-assurance authentication option for sensitive roles.

## How security keys work

Security keys use a cryptographic authentication model:

- During registration, a public/private key pair is created.
- The public key is stored with the service administering the security key.
- The private key is stored exclusively on the physical security key device.

When a user signs in:

- The service sends a challenge.
- The user interacts with the security key device.
- The device signs the challenge using the private key.
- The service verifies the response using the public key.

This diagram shows a simplified view of how security keys help provide access to trusted users while minimizing additional verification steps.

:::image type="content" border="true" source="../media/security-key.svg" alt-text="Diagram that shows how security key authentication proceeds from the service to the key and back to ultimately provide access." lightbox="../media/security-key.svg":::

Because the private key never leaves the device, it's much more difficult for attackers to intercept or reuse it.

This means even highly targeted phishing attempts against the organization's leaders are less likely to capture usable credentials, because access to privileged accounts requires both the device and user interaction.

## Set up a security key

Users register a security key with their account before using it to sign in.

### To set up a security key

1. Insert or connect the security key to the device.
2. Open the account security or sign-in settings.
3. Select the option to add a security key.
4. Follow the prompts to register the device.
5. Test the key by completing a sign-in.

>[!NOTE]
> Organizations often require users to register at least one backup method in case the security key is lost or unavailable. Since this adds a potential point of vulnerability for attackers to exploit, it's important to ensure these backup methods are also secured.

## When to use security keys

Security keys are best suited for:

- Administrators and privileged users
- Accounts with access to sensitive data or systems
- Environments requiring strong phishing resistance

They might be less ideal for broad user populations where cost and distribution are constraints. Security keys could also be troublesome to manage if users frequently forget or misplace physical devices.

## Key takeaway

Security keys provide one of the strongest levels of passwordless protection through hardware-based, phishing-resistant authentication.

For the IT team, they become the standard for high-risk users—ensuring that even advanced credential attacks can't compromise critical accounts.
