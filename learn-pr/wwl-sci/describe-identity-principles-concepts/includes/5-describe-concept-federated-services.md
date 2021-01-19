Federation enables the access of services across organizational or domain boundaries by establishing trust relationships between the respective domain’s identity provider.  With federation, there is no need for a user to maintain a different username and password when accessing resources in other domains.

:::image type="content" source="../media/5-federated-identification.png" alt-text="Federated identification":::

The simplified way to think about this federation scenario is as follows:

- The website uses the authentication services of IdP-A.
- The user authenticates with IdP-B.
- IdP-A has a trust relationship configured with IdP-B.
- When the user’s credentials are passed to the website, the website trusts the user and allows access.

With federation, trust is not always bi-directional.  Although IdP-A may trust IdP-B and allow the user in domain B to access the website in domain A, the opposite is not true, unless that trust relationship is configured.

A common example of federation in practice is when a user logs into a 3rd party site with their social media account, such as Twitter.  In this scenario, Twitter is an identity provider, and the 3rd party site may be using a different identity provider, such as Azure AD. There is a trust relationship between Azure AD and Twitter.
