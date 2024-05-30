:::image type="content" source="../media/guest-user-diagram-ade26ab5.png" alt-text="Diagram of allowing external users to join your Microsoft Entra tenant as a guest user.":::


### Define guest users

Microsoft Entra B2B collaboration is a feature within Microsoft Entra External Identities, part of Microsoft Entra that lets you invite guest users to collaborate with your organization. With B2B collaboration, you can securely share your company's applications and services with external users, while maintaining control over your own corporate data. Work safely and securely with external partners, large or small, even if they don't have Microsoft Entra ID or an IT department.

### How guest users join your Microsoft Entra tenant

A simple invitation and redemption process lets partners use their own credentials to access your company's resources. You can also enable self-service sign-up user flows to let external users sign up for apps or resources themselves. Once the external user has redeemed their invitation or completed sign-up, they're represented in your directory as a user object. B2B collaboration user objects are typically given a user type of "guest" and can be identified by the \#EXT\# extension in their user principal name.

Developers can use Microsoft Entra ID business-to-business APIs to customize the invitation process or write applications like self-service sign-up portals.

### B2B collaboration

B2B collaboration is a capability of Microsoft Entra External Identities that lets you collaborate with users and partners outside of your organization. With B2B collaboration, an external user is invited to sign in to your Microsoft Entra organization using their own credentials. This B2B collaboration user can then access the apps and resources you want to share with them. A user object is created for the B2B collaboration user in the same directory as your employees. B2B collaboration user objects have limited privileges in your directory by default, and they can be managed like employees, added to groups, and so on.
