Token expiration and refresh are a standard mechanism in the industry. When a client application like Outlook connects to a service like Exchange Online, the API requests are authorized using OAuth 2.0 access tokens. By default, access tokens are valid for one hour, when they expire the client is redirected to Microsoft Entra ID to refresh them. That refresh period provides an opportunity to reevaluate policies for user access. For example: we might choose not to refresh the token because of a Conditional Access policy, or because the user has been disabled in the directory.

However, there is lag between when conditions change for a user, and when policy changes are enforced. Timely response to policy violations or security issues really requires a "conversation" between the token issuer, and the relying party (enlightened app). This two-way conversation gives us two important capabilities. The relying party can see when properties change, like network location, and tell the token issuer. It also gives the token issuer a way to tell the relying party to stop respecting tokens for a given user because of account compromise, disablement, or other concerns. The mechanism for this conversation is continuous access evaluation (CAE).

### Benefits

There are several key benefits to continuous access evaluation.

 -  User termination or password change/reset: User session revocation will be enforced in near real time.
 -  Network location change: Conditional Access location policies will be enforced in near real time.
 -  Token export to a machine outside of a trusted network can be prevented with Conditional Access location policies.

### Evaluation and revocation process flow

:::image type="content" source="../media/user-revocation-event-flow-8219101e.png" alt-text="Diagram of the process flow when an access token is revoked and a client has to reverify access.":::


1.  A continuous access evaluation (CAE)-capable client presents credentials or a refresh token to Microsoft Entra ID asking for an access token for some resource.
2.  An access token is returned along with other artifacts to the client.
3.  An Administrator explicitly revokes all refresh tokens for the user. A revocation event will be sent to the resource provider from Microsoft Entra ID.
4.  An access token is presented to the resource provider. The resource provider evaluates the validity of the token and checks whether there's any revocation event for the user. The resource provider uses this information to decide to grant access to the resource or not.
5.  In the case of the diagram, the resource provider denies access, and sends a 401+ claim challenge back to the client.
6.  The CAE-capable client understands the 401+ claim challenge. It bypasses the caches and goes back to step 1, sending its refresh token along with the claim challenge back to Microsoft Entra ID. Microsoft Entra ID will then reevaluate all the conditions and prompt the user to reauthenticate in this case.
