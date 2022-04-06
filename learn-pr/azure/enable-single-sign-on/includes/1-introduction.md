Employees are typically expected to use many applications to accomplish tasks. When the employee is required to sign-in to each of the applications individually, frustration rises and productivity suffers. When an administrator sets up single sign-on, the employee only has to sign in once when they use their Azure AD credentials to access all the applications they need.

## Example scenario

Suppose you’re an IT administrator at a retail company. The company depends on many applications for users to complete tasks, such as marketing, sales, and operations. A team asked for a new application to be added to help with company promotion. The application needs to be made available to team members as appropriate.

You realize that this addition causes users to sign in to yet another application using specific credentials for it. Users get frustrated because they have to sign in many times a day. You want to be able to set up the system so that a user can sign in once and get access to all applications they need.

## What will we be doing?

For single sign-on, a combination of tasks are required both in the Azure portal and at the application host. User accounts need to exist in both locations, a certificate is created, and URLs must be shared between both for a trusted relationship. Testing single sign-on is very important before introducing the feature to the employees.

:::image type="content" source="../media/sso-flow.png" alt-text="Diagram showing the flow of single sign-on configuration." border="false":::

## What is the main goal?

Upon completion of this module, the learner will be able to configure Azure Active Directory and applications to enable users to sign in once to access all the applications they need.