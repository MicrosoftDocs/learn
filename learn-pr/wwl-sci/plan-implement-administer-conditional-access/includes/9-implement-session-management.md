In complex deployments, organizations might have a need to restrict authentication sessions. Some scenarios might include:

 - Resource access from an unmanaged or shared device.
 - Access to sensitive information from an external network.
 - High priority or executive users.
 - Critical business applications.

Conditional Access controls allow you to create policies that target specific use cases within your organization without affecting all users.

Before diving into details on how to configure the policy, let’s examine the default configuration.

## User sign-in frequency

Sign-in frequency defines the time period before a user is asked to sign in again when attempting to access a resource.

The Microsoft Entra ID default configuration for user sign-in frequency is a rolling window of 90 days. Asking users for credentials often seems like a sensible thing to do, but it can backfire: Users who are trained to enter their credentials without thinking can unintentionally supply them to a malicious credential prompt.

It might sound alarming to not ask for a user to sign back in; in reality any violation of IT policies will revoke the session. Some examples include a password change, an incompliant device, or an account disable. You can also explicitly revoke users’ sessions using PowerShell. The Microsoft Entra ID default configuration comes down to 'don’t ask users to provide their credentials if the security posture of their sessions hasn't changed.'

The sign-in frequency setting works with apps that have implemented OAUTH2 or OIDC protocols according to the standards. Most apps for Windows, Mac, and mobile, including the following web applications, comply with the setting.

 - Word, Excel, PowerPoint Online
 - OneNote Online
 - Office.com
 - Microsoft 365 Admin portal
 - Exchange Online
 - SharePoint and OneDrive
 - Teams web client
 - Dynamics CRM Online
 - Azure portal

The sign-in frequency setting works with SAML applications as well, as long as they don't drop their own cookies and are redirected back to Microsoft Entra ID for authentication on a regular basis.

### User sign-in frequency and multifactor authentication

Sign-in frequency previously applied only to the first factor authentication on devices that were Microsoft Entra joined, Hybrid Microsoft Entra joined, and Microsoft Entra registered. There was no easy way for our customers to re-enforce multifactor authentication (MFA) on those devices. Based on customer feedback, sign-in frequency will apply for MFA as well.

:::image type="content" source="../media/conditional-access-flow-chart.png" alt-text="Diagram of multifactor authentication sign-in process with sign-in frequency.":::

### User sign-in frequency and device identities

If you have Microsoft Entra joined, hybrid Microsoft Entra joined, or Microsoft Entra registered devices, when a user unlocks their device or signs in interactively, this event will satisfy the sign-in frequency policy as well. In the following two examples user sign-in frequency is set to one hour:

Example 1:

 - At 00:00, a user signs in to their Windows 10 Microsoft Entra joined device and starts work on a document stored on SharePoint Online.
 - The user continues working on the same document on their device for an hour.
 - At 01:00, the user is prompted to sign in again based on the sign-in frequency requirement in the Conditional Access policy configured by their administrator.

Example 2:

 - At 00:00, a user signs in to their Windows 10 Microsoft Entra joined device and starts work on a document stored on SharePoint Online.
 - At 00:30, the user gets up and takes a break, locking their device.
 - At 00:45, the user returns from their break and unlocks the device.
 - At 01:45, the user is prompted to sign in again based on the sign-in frequency requirement in the Conditional Access policy configured by their administrator since the last sign-in happened at 00:45.

## Persistence of browsing sessions

A persistent browser session allows users to remain signed in after closing and reopening their browser window. The Microsoft Entra ID default for browser session persistence allows users on personal devices to choose whether to persist the session by showing a 'Stay signed in?' prompt after successful authentication.

## Validation

Use the What-If tool to simulate a sign-in from the user to the target application and other conditions based on how you configured your policy. The authentication session management controls show up in the result of the tool.

:::image type="content" source="../media/conditional-access-what-if-tool-result.png" alt-text="Screenshot of the Conditional Access What If tool results.":::

## Policy deployment

To make sure that your policy works as expected, the recommended best practice is to test it before rolling it out into production. Ideally, use a test tenant to verify whether your new policy works as intended.

## Continuous Access Evaluation (CAE)

Token expiration and refresh are a standard mechanism in the industry. When a client application like Outlook connects to a service like Exchange Online, the API requests are authorized using OAuth 2.0 access tokens. By default, access tokens are valid for one hour, when they expire the client is redirected to Microsoft Entra ID to refresh them. That refresh period provides an opportunity to reevaluate policies for user access. For example: we might choose not to refresh the token because of a Conditional Access policy, or because the user has been disabled in the directory.

However, there is lag between when conditions change for a user, and when policy changes are enforced. Timely response to policy violations or security issues really requires a "conversation" between the token issuer, and the relying party (enlightened app). This two-way conversation gives us two important capabilities. The relying party can see when properties change, like network location, and tell the token issuer. It also gives the token issuer a way to tell the relying party to stop respecting tokens for a given user because of account compromise, disablement, or other concerns. The mechanism for this conversation is continuous access evaluation (CAE).

### Benefits

There are several key benefits to continuous access evaluation.

 - User termination or password change/reset: User session revocation will be enforced in near real time.
 - Network location change: Conditional Access location policies will be enforced in near real time.
 - Token export to a machine outside of a trusted network can be prevented with Conditional Access location policies.

### Evaluation and revocation process flow

:::image type="content" source="../media/user-revocation-event-flow.png" alt-text="Diagram of the process flow when an access token is revoked and a client has to reverify access.":::

1. A continuous access evaluation (CAE)-capable client presents credentials or a refresh token to Microsoft Entra ID asking for an access token for some resource.
2. An access token is returned along with other artifacts to the client.
3. An Administrator explicitly revokes all refresh tokens for the user. A revocation event will be sent to the resource provider from Microsoft Entra ID.
4. An access token is presented to the resource provider. The resource provider evaluates the validity of the token and checks whether there's any revocation event for the user. The resource provider uses this information to decide to grant access to the resource or not.
5. In the case of the diagram, the resource provider denies access, and sends a 401+ claim challenge back to the client.
6. The CAE-capable client understands the 401+ claim challenge. It bypasses the caches and goes back to step 1, sending its refresh token along with the claim challenge back to Microsoft Entra ID. Microsoft Entra ID will then reevaluate all the conditions and prompt the user to reauthenticate in this case.

