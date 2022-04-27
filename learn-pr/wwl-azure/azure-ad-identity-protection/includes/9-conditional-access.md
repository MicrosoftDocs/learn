The old world of security behind a corporate firewall, having your secure network perimeter just doesn’t work anymore, not with people wanting to work from anywhere, being able to connect to all sorts of cloud applications.

Conditional Access is the tool used by Azure Active Directory to bring signals together, to make decisions, and enforce organizational policies. Conditional Access is at the heart of the new **identity driven control plane**.

Conditional access policy is really a next generation policy that’s built for the cloud. It’s able to consider massive amounts of data, as well as contextual data from a user sign-in flow and make sure that the right controls are enforced.

## Identity as a Service—the new control plane

What is the basis for saying that identity management is the new control plane? First, what is the control plane? In a switch or router, the control plane is the part that controls where the traffic is to go, but it’s not responsible for the movement of the traffic. The control plane learns the routes, either static or dynamic. The part responsible for moving the traffic is the forwarding plane. The following figure depicts a simple switch diagram.

:::image type="content" source="../media/az500-control-plan-890d319d.png" alt-text="Flowchart. BGP, OSPR, and Learning connected to RIB. RIB connects to Forwarding decision. Forwarding decision connects to forwarding and data plane.":::


A user’s identity is like a control plane, because it controls which protocols the user will interact with, which organizational programs the user can access, and which devices the user can employ to access those programs. Identity is what helps protect user and corporate data. For example, should that data be encrypted, deleted, or ignored when an issue occurs?

Now, everything pivots around that user identity. You know what their activities are, and where they are located. You know what devices they’re using. Then we leverage that information in conditional access policy to be able to enforce things like multifactor authentication or require a compliant device.

There are the **conditions**, which indicate when the policy is going to apply. This can be, again, the location, type of application that you’re on, any **detected risk**. How is the risk determined? It is determined from all the analysis and intel that we have across organizations using Azure Active Directory, as well as Microsoft consumer identity offerings. Conditional Access is the tool used by Azure Active Directory to bring signals together, to make decisions, and enforce organizational policies. Conditional Access policies at their simplest are **if-then statements**, if a user wants to access a resource, then they must complete an action. Example: A payroll manager wants to access the payroll application and is required to perform multifactor authentication to access it.

Administrators are faced with two primary goals:

 -  Empower users to be productive wherever and whenever
 -  Protect the organization's assets

By using Conditional Access policies, you can apply the right access controls when needed to keep your organization secure and stay out of your user’s way when not needed.

:::image type="content" source="../media/az500-conditional-access-process-8b2e3d10.png" alt-text="Signals are verified to determine access to apps.":::


Conditional Access policies are enforced after the first-factor authentication has been completed. Conditional Access is not intended as an organization's first line of defense for scenarios like denial-of-service (DoS) attacks but can use signals from these events to determine access.

> [!IMPORTANT]
> Conditional Access is an effective way to enable access to resources after specific conditions have been met.
