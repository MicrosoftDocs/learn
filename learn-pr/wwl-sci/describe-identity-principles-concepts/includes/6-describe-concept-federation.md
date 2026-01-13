
Federation enables the access of services across organizational or domain boundaries by establishing trust relationships between the respective domain’s identity provider.  With federation, there's no need for a user to maintain a different username and password when accessing resources in other domains.

![Diagram showing a simplified view of how federation works](../media/5-federated-identification.png)

The simplified way to think about this federation scenario is as follows:

- The website, in domain A, uses the authentication services of Identity Provider A (IdP-A).
- The user, in domain B, authenticates with Identity Provider B (IdP-B).
- IdP-A has a trust relationship configured with IdP-B.
- When the user wants to access the website, the website relies on the trust relationship with the identity provider to accept the user's authentication from IdP-B.

With federation, trust isn't always bidirectional.  Although IdP-A may trust IdP-B and allow the user in domain B to access the website in domain A, the opposite isn't true, unless that trust relationship is configured.

A common example of federation in practice is when a user signs in to an application using an account from a different organization (B2B collaboration) or a social identity provider (for example, Google). In these scenarios, different identity providers establish trust so the application can accept the user's sign-in.
