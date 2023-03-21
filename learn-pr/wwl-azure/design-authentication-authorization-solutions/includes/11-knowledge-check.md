Tailwind Traders is planning on making some significant changes to their identity and access management solution. They've asked for your assistance on some recommendations and questions. Here are the specific requirements.

- **Device access to company applications**. The CTO has agreed to allow some level of device access. Employees at the company’s retail stores will now be able to access certain company applications. This access, however, should be restricted to only approved devices. 

- **Company reorganization**. A company-wide reorganization has affected many employees. These employees are now in new roles. The IT team needs to ensure users have the correct access based on their new jobs. 

- **External developer accounts**. A new development project requires external software developers to access company data files. The IT team needs to create user accounts for approximately five developers.

- **User sign-in attempts**. A recent audit of user sign-ins attempts revealed anonymous IP addresses and unusual locations. The IT team wants to require multifactor authentication for these attempted sign-ins. 

### Answer the following questions

Choose the best response for each of the questions below. Then select **Check your answers**.

---

## quiz title

## Multiple Choice

How can Tailwind Traders permit employees at their retail stores to access company apps from approved tablet devices only?
( ) Single sign-on (SSO) {{Incorrect. SSO helps a user to remember only one ID and one password for multiple apps. SSO doesn't verify the device that's trying to access an app.}}
(x) Conditional access {{Correct. Conditional access lets you require users to access your apps from approved, or managed, devices only.}}
( ) Multifactor authentication (MFA) {{Incorrect. MFA provides extra security for your identities. MFA doesn't verify the device that's trying to access the resource or app.}}

## Multiple Choice

What should Tailwind Traders do to ensure employees have the correct permissions for their job role?
( ) Create a conditional access policy {{Incorrect. Conditional access policies won't validate employee job role access.}}
( ) Review each user's role-based access control (RBAC) permissions {{Incorrect. Although RBAC might work, the process would be long and tedious. Also, IT personnel aren't in the best position to determine if an employee's access is correct.}}
(x) Require an access review {{Correct. An access review will give managers an opportunity to validate the employee's access.}}

## Multiple Choice

What should Tailwind Traders do to give access to their partner developers?
( ) Use AD Connect to bring in the developer accounts {{Incorrect. AD Connect is used to bring in on-premises accounts.}}
( ) Ask the developers to sign in with a social identification like Google, LinkedIn, or Facebook. {{Incorrect. External social accounts are used for business-to-customer (B2C) apps.}}
(x) Invite the developers as guest users to their directory {{Correct. In business-to-business (B2B) scenarios, guest user accounts are created. You can then apply the appropriate permissions.}}

## Multiple Choice

What solution would be best for user sign-in attempt requirement?
( ) Create a user risk policy {{Incorrect. A user risk policy represents the probability a given identity or account is compromised. A scenario would be where a user's valid credentials are leaked.}}
(x) Create a sign-in risk policy {{Correct. A sign-in risk policy can identify anonymous IP and atypical locations. Secondary MFA can then be required.}}
( ) Require an access review {{Incorrect. An access review provides an opportunity to validate an employee's continued access to assets.}}