As the IT team continues its transition to passwordless authentication, it turns to employees who work remotely or across multiple devices.

Unlike office-based staff, these users need a method that isn't tied to a single device. To support this flexibility, the team introduces authenticator apps.

## What are authenticator apps?

Authenticator apps (such as [Microsoft Authenticator](/training/modules/improve-sign-in-security-authenticator/)) enable users to verify their identity using a trusted mobile device instead of a password.

Common authentication methods include:

- Push notifications that require approval
- Number matching to confirm intent within a limited timeframe
- Biometric verification, such as face or fingerprint ID

Because authentication is tied to a registered device, rather than a shared secret, this approach is more resistant to phishing and credential theft.

For users, authenticator apps provide flexibility across devices as well as a familiar mobile-based experience.

## How authenticator apps work

Authenticator apps use a time-limited, challenge-based authentication model:

- A user attempts to sign in.
- A verification request is sent to their mobile device.
- The user confirms the request before it expires.
- Access is granted without entering a password.

This diagram shows a simplified view of how authenticator apps help secure access across multiple devices.

:::image type="content" border="true" source="../media/authenticator-app.svg" alt-text="Diagram that shows the linear progression from a login attempt to a push notification/one-time code, then user response, and finally access." lightbox="../media/authenticator-app.svg":::

This process ensures that only users with access to the registered device can approve sign-ins. An attacker with access to compromised credentials would need to overcome the additional hurdle of getting approval from the user's authenticator before it expires.

In the organization's deployment, this allows remote workers to securely sign in from anywhere, without relying on passwords that could be intercepted or reused.

## Set up an authenticator app

Users can configure an authenticator app on their mobile device.

To set up an authenticator app:

- Install the authenticator app on a mobile device.
- Open the app and sign in or add an account.
- Follow the prompts to link the app to your user account.
- Approve a test sign-in to complete the setup.

>[!NOTE]
> Organizations often require users to register an authenticator app as part of onboarding or security setup.

## When to use authenticator apps

In the IT team's rollout, authenticator apps are best suited for:

- Remote or hybrid workers
- Users who sign in across multiple devices
- Scenarios requiring flexibility and portability, such as when users sign in from outside their typical working location

They might be less ideal for:

- Environments with limited mobile device access
- High-risk roles requiring the strongest phishing resistance

## Key takeaway

Authenticator apps provide flexible, passwordless authentication using a trusted mobile device.

For the IT team, authenticator apps become the preferred option for remote employees—delivering secure, convenient access across devices without relying on passwords.
