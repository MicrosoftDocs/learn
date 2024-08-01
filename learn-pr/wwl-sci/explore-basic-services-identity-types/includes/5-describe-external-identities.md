
Today’s world is about collaboration, working with people both inside and outside of your organization. That means you'll sometimes need to provide access to your organization’s applications or data to external users.

Microsoft Entra External ID combines powerful solutions for working with people outside of your organization. With External ID capabilities, you can allow external identities to securely access your apps and resources. Whether you’re working with external partners, consumers, or business customers, users can bring their own identities. These identities can range from corporate or government-issued accounts to social identity providers like Google or Facebook.

:::image type="content" source="../media/external-identities-overview.png" alt-text="Image showing elements of Microsoft External ID. On the left, it shows Consumers business customers, and guests. On the right, it shows business apps, consumer apps, and on-premises apps. In the center, is a circle showing secure user access, seamless experience, and secure app development.":::

Microsoft Entra External ID addresses the scenarios that are encountered when it comes to working with external users.

- Collaborate with business guests
- Secure your apps for consumers and business customers

Also, each of these scenarios suggests a different approach for how an organization configures their Microsoft Entra ID tenant.

There are two ways to configure a tenant, depending on how the organization intends to use the tenant and the resources they want to manage:

- A workforce tenant configuration is for your employees, internal business apps, and other organizational resources. You can invite external business partners and guests to your workforce tenant.
- An external tenant configuration is used exclusively for External ID scenarios where you want to publish apps to consumers or business customers.

:::image type="content" source="../media/external-id-tenant-configurations.png" alt-text="Image showing a representation of the two external ID scenarios and the corresponding tenant type. Collaboration with business guests uses a workforce tenant configuration. External facing apps use an external tenant configuration.":::

### Collaborate with business guests

If you want to enable your employees to collaborate with business partners and guests, use External ID for B2B collaboration.

External ID B2B collaboration allows your workforce to collaborate with external business partners.

Using your workforce tenant, you can use B2B collaboration to share your company's applications and services with guests, while maintaining control over your own corporate data. You can invite anyone to sign in to your Microsoft Entra organization using their own credentials so they can access the apps and resources you want to share with them.

Use B2B collaboration when you need to let business guests access your Office 365 apps, software-as-a-service (SaaS) apps, and line-of-business applications. There are no credentials associated with business guests. Instead, they authenticate with their home organization or identity provider, and then your organization checks the user’s eligibility for guest collaboration.

:::image type="content" source="../media/b2b-collaboration-overview.png" alt-text="Image showing a representation of B2B collaboration.":::

### Secure your apps for consumers and business customers

If you’re an organization or a developer creating consumer apps, use External ID to quickly add authentication and customer identity and access management (CIAM) to your application.

Microsoft Entra External ID includes Microsoft's customer identity and access management (CIAM) solution that includes features like self-service registration, personalized sign-in experiences including single sign-on (SSO) with social and enterprise identities, and customer account management. Because these CIAM capabilities are built into Microsoft Entra ID, you also benefit from platform features like enhanced security, compliance, and scalability.

:::image type="content" source="../media/overview-ciam.png" alt-text="Image showing a representation of External ID in an external tenant.":::
