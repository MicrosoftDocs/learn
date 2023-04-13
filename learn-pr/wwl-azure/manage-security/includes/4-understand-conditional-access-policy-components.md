

Conditional Access policies are if-then statements: If an assignment is met, then apply these access controls.

When configuring Conditional Access policies, conditions are called *assignments*. Conditional Access policies allow you to enforce access controls on your organization’s apps based on certain assignments.

:::image type="content" source="../media/understand-conditional-access-04a5e2d3.png" alt-text="Screenshot showing how to create a policy.":::


Assignments define the following:

 -  Users and groups to be affected by the policy.
 -  Cloud apps or actions to which the policy will apply.
 -  Conditions under which the policy will apply.

Access controls settings determine how to enforce a policy:

 -  Grant or Block access to cloud apps.
 -  Session controls enable limited experiences within specific cloud apps.

## Ask the right questions to build your policies

Policies answer questions about who should access your resources, what resources they should access, and under what conditions. Policies can be designed to grant access, or to block access. Be sure to ask the right questions about what your policy is trying to achieve.

Document the answers to questions for each policy before building it out.

**Users and Groups**

 -  Which users and groups will be included in or excluded from the policy?
 -  Does this policy include all users, specific group of users, directory roles, or external users?

**Cloud apps or actions**

 -  What application(s) will the policy apply to?
 -  What user actions will be subject to this policy?

**Conditions**

 -  Which device platforms will be included in or excluded from the policy?
 -  What are the organization’s trusted locations?
 -  What locations will be included in or excluded from the policy?
 -  What client app types (browser, mobile, desktop clients, apps with legacy authentication methods) will be included in or excluded from the policy?
 -  Do you have policies that would drive excluding Azure AD Joined devices or Hybrid Azure AD joined devices from policies?
 -  If using Identity Protection, do you want to incorporate sign-in risk protection?
