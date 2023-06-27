Conditional Access is a tool that Azure Active Directory uses to allow (or deny) access to resources based on identity signals. These signals include who the user is, where the user is, and what device the user is requesting access from.

Conditional Access helps IT administrators:

 -  Empower users to be productive wherever and whenever.
 -  Protect the organization's assets.

Conditional Access also provides a more granular multifactor authentication experience for users. For example, a user might not be challenged for second authentication factor if they're at a known location. However, they might be challenged for a second authentication factor if their sign-in signals are unusual or they're at an unexpected location.

During sign-in, Conditional Access collects signals from the user, makes decisions based on those signals, and then enforces that decision by allowing or denying the access request or challenging for a multifactor authentication response.

The following diagram illustrates this flow:

:::image type="content" source="../media/conditional-access-9bd268b8.png" alt-text="Diagram showing the conditional access flow of a signal leading to a decision, leading to enforcement.":::


Here, the signal might be the user's location, the user's device, or the application that the user is trying to access.

Based on these signals, the decision might be to allow full access if the user is signing in from their usual location. If the user is signing in from an unusual location or a location that's marked as high risk, then access might be blocked entirely or possibly granted after the user provides a second form of authentication.

Enforcement is the action that carries out the decision. For example, the action is to allow access or require the user to provide a second form of authentication.

## When can I use Conditional Access?

Conditional Access is useful when you need to:

 -  Require multifactor authentication (MFA) to access an application depending on the requester’s role, location, or network. For example, you could require MFA for administrators but not regular users or for people connecting from outside your corporate network.
 -  Require access to services only through approved client applications. For example, you could limit which email applications are able to connect to your email service.
 -  Require users to access your application only from managed devices. A managed device is a device that meets your standards for security and compliance.
 -  Block access from untrusted sources, such as access from unknown or unexpected locations.
