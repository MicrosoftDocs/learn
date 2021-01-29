
In Azure Active Directory (Azure AD), all users are granted a set of default permissions. A user’s access consists of the type of user, their role assignments, and their ownership of individual objects. The default user permissions can be changed only in user settings in Azure AD.

### Member and guest users

The set of default permissions received depends on whether the user is a native member of the tenant (member user) or if the user is brought over from another directory as a B2B collaboration guest (guest user).

- Member users can register applications, manage their own profile photo and mobile phone number, change their own password, and invite B2B guests. In addition, users can read all directory information (with a few exceptions).

- Guest users have restricted directory permissions. They can manage their own profile, change their own password, and retrieve some information about other users, groups, and apps; however, they cannot read all directory information. For example, guest users cannot enumerate the list of all users, groups, and other directory objects. Guests can be added to administrator roles, which grant them full read and write permissions contained in the role. Guests can also invite other guests.

The following default permissions for member users can be restricted in the following ways:

| **Permission**| **Setting explanation**|
| :--- | :--- |
| Users can register application| <ul><li>By default, member users can register applications.</li> <li>Setting this option to No prevents users from creating application registrations. The ability can then be granted back to specific individuals by adding them to the Application Developer role.</li></ul>|
| Restrict access to Azure AD administration portal| <ul><li>Setting this option to No lets non-administrators use the Azure AD administration portal to read and manage Azure AD resources. Yes restricts all non-administrators from accessing any Azure AD data in the administration portal.</li> <li>This setting does not restrict access to Azure AD data using PowerShell or other clients such as Visual Studio. When set to Yes, to grant a specific non-admin user the ability to use the Azure AD administration portal assign any administrative role such as the Directory Readers role.</li> <li>This role allows reading basic directory information, which member users have by default (guests and service principals do not).</li></ul>|

### Sign in with LinkedIn

With more than 500 million members worldwide, LinkedIn is the largest and most trusted source of professional identities. Leverage this power to enhance the sign-in experience of your sites and applications.

Use sign in with LinkedIn to:

- Reduce friction and obtain more sign-ups by allowing members to Sign In with LinkedIn, without having the need to create a new account.

- Minimize the costs and time associated with implementing your own login, identity, profile management, and password management.

- Personalize your sites and applications with the latest member profiles.

### Manage security defaults

Managing security can be difficult with common identity-related attacks like password spray, replay, and phishing becoming more and more popular. Security defaults make it easier to help protect your organization from these attacks with preconfigured security settings:

- Requiring all users to register for Azure AD Multi-Factor Authentication.

- Requiring administrators to perform multi-factor authentication.

- Blocking legacy authentication protocols.

- Requiring users to perform multi-factor authentication when necessary.

- Protecting privileged activities like access to the Azure portal.

### Availability

Microsoft is making security defaults available to everyone. The goal is to ensure that all organizations have a basic level of security enabled at no extra cost.

