After you've enabled a registration campaign for Microsoft Authenticator, you want to validate the new sign-in experience works as expected before running the campaign production.

You want to apply the new policy to a test user and confirm Microsoft Authenticator is the new default sign-in method.

In the next exercise, you'll create a new user account in Microsoft Entra ID and enable it for Microsoft Authenticator. Then you'll sign in, perform MFA, and set up Microsoft Authenticator. After you confirm the new user account has Microsoft Authenticator as the new default sign-in method, you'll apply the policy to the remote employees group.

:::image type="content" border="true" source="../media/how-to-nudge-authenticator-app/setup.png" alt-text="Screenshot of Microsoft Authenticator setup.":::

## Validate the registration campaign

You want to see how the registration campaign works for a test user account. After you confirm it works as expected, you plan to run the campaign for the remote employees.  

### Create a test user and perform MFA

Before users can get the prompt to set up Microsoft Authenticator, they need to perform MFA as they do normally. For remote employees in your company, they'll need to sign in by using their currently preferred authentication methods: username and password with either an SMS message or voice call to complete MFA. After they perform MFA, they'll be nudged to set up Microsoft Authenticator.

### Confirm Microsoft Authenticator is the new default sign-in method

Your goal is to switch users from SMS and voice call to Microsoft Authenticator push notifications for better security. After users install and register Microsoft Authenticator, push notifications will become their new default sign-in method.
