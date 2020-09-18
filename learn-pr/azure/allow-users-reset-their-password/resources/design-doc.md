# Module Design

## Title

Allow users to reset their password with Azure Active Directory self-service password reset

## Role(s)

- Administrator
- Solution architect

## Level

- Beginner

## Product(s)

- Azure Active Directory

## Prerequisites

- Basic understanding of Azure Active Directory

## Summary

Evaluate self-service password reset to allow users in your organization to reset their passwords or unlock their accounts. Set up, configure, and test self-service password reset.

## Learning objectives

1. Decide whether to implement self-service password reset
1. Implement self-service password reset to meet your requirements
1. Configure self-service password reset to customize the experience

## Chunk your content into subtasks

Identify the subtasks of *Allow users to reset their password with Azure Active Directory self-service password reset*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
|Why Self-Service Password Reset (SSPR)? | Being overwhelmed with password reset requests | Knowledge check | 1 | Yes |
|Process of implementing SSPR | Business evaluation | Exercise | 1 | Yes|
|Configure self-service password reset to customize the experience| Employees being unproductive waiting for passwords to be reset | Exercise | 2| Yes |

## Outline the units

1. **Introduction**

   You're an IT administrator for a large organization. Your organization has just started using Azure Active Directory to allow employees to securely sign in and use SaaS apps, and access organization resources in Microsoft 365. You're overwhelmed with password reset requests because you currently reset employee's passwords manually. To get these employees back to being productive quickly and reduce your workload, you decide to evaluate and set up self-service password reset in Azure Active Directory.  

1. **What is self-service password reset in Azure Active Directory?**

    - Azure AD self-service password reset (SSPR)b - How it works
    - Concepts and process
        - Registration page, Notifications, and customization
        - Helps address password reset issues for directory integrated applications
    - Advantages of using SSPR
        - Makes user more productive and provides better service
        - Provides cost savings for an organization by  reducing workload for the service desk
        - Improves security and reduces risk of data breaches
    - Licenses - Azure AD comes in four editions: Free, Basic, Premium P1, and Premium P2. 
        - There are several different features that make up self-service password reset, including change, reset, unlock, and writeback, that are available in the different  editions of Azure AD.
        - SSPR is not available in Free - it's in Basic and up.
        - Change password is available in all editions - just not the reset tool. Can go to profile to change password. So if you forgot your password you can't do a reset yourself in tool (if you have Free version). If you're already authenticated, then can change in every version (including Free). 
    - Authentication methods
        - Select methods available to users that your organization wants to allow.
        - Best practice is Authenticator app, then fallback to phone call or email. SMS is spoof-able so that's the least recommended. In trial mode, can't use phone call. 

    **Knowledge check**

    - When is a user considered registered?
        - A: A user is considered registered for SSPR when they have registered at least the number of methods required to reset a password that you have set in the Azure portal. 
    - Can users register their own password reset data?

1. **Implement Azure AD self-service password reset**

    A self-service password reset solution that allows an end user to self-reset their domain password in Windows Active Directory remotely from a web browser without calling the help desk is an essential requirement.

    When a user accesses the self-service password reset portal a workflow is initiated:

    1. Verify User
    1. Authenticate User
    1. Reset Password
    1. Notify User

    How to configure self-service password reset to customize the experience to match your users' needs.
    - Steps to configure SSPR
    - Even if SSPR is not enabled, users still have a "Contact your administrator" link on the password reset portal. If a user selects this link, it either:
    
      - Emails your administrators and asks them for assistance in changing the user's password.
      - Sends your users to a URL that you specify for assistance.
1. **Exercise - Set up self-service password reset**

    1. Use the portal to go to the Active Directory section
    1. Create a group and add users to it or select an existing group that has some users in it
    1. Pick a group (Only members of this specific selected Azure AD group that can use the Self-Service Password Reset functionality)
    1. From the Authentication methods page, make the choices such as: Email, Mobile Phone etc.
    1. From the Registration page, select choices: - Select Yes for Require users to register when signing in, - Set Number of days

    Now let's test the SSPR configuration with a test user:

   1. Browse to https://aka.ms/ssprsetup
   1. Sign in with a non-administrator test user, and register your authentication phone.
   1. Browse to https://aka.ms/sspr
   1. Enter your non-administrator test user's User ID, and the characters from the CAPTCHA
   1. Follow the verification steps to reset your password

1. **Exercise - Customize directory branding**

    - The graphics you choose are shown in the following circumstances:
       - After a user enters their username
       - If the user accesses the customized URL:
          - By passing the **whr** parameter to the password reset page, like https://login.microsoftonline.com/?whr=contoso.com
          - By passing the username parameter to the password reset page, like https://login.microsoftonline.com/?username=admin@contoso.com
    - To Customize your branding

    1. Use the portal to go to AD-> Company Branding to configure settings 
    1. On the Configure company branding page, provide the relevant information, and save

1. **Summary**

  How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

- Users should be able to go through exercises by creating a new directory within sandbox or their own account. This would be on a trial license for AD that's created outside the Azure sandbox scope. We think users won't be able to delete or clean up this tenant- it will just expire after a month (with no charge). So we'll want to group together AD learning paths. See [Quickstart: Set up a dev environment](https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-create-new-tenant#work-and-school-accounts-or-personal-microsoft-accounts). There is another module in development that will use this same set-up process.
- Show how to do steps in Azure portal when possible. Otherwise, show steps in PowerShell.
- We should consider creating a diagram to show the overall process.

## Resources
- [Licensing info](https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-sspr-licensing)
- In lieu of sandbox: [Quickstart: Set up a dev environment](https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-create-new-tenant#work-and-school-accounts-or-personal-microsoft-accounts)
- [How it works & configuration options (authentication method, registration, notification)](https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-sspr-howitworks) (should probably have swim lane-like diagram to show overall process)
- [How you'd deploy if you didn't require pre-registering](https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-sspr-authenticationdata)
- [Quickstart on how to enable](https://docs.microsoft.com/en-us/azure/active-directory/authentication/quickstart-sspr)
- [Tutorial](https://docs.microsoft.com/en-us/azure/active-directory/authentication/tutorial-sspr-pilot)
- [Guidance on roll out](https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-sspr-deployment) - shouldn't really cover this information other than to mention it briefly
- Authentication methods. See notes in <https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-authentication-methods#mobile-phone> under phone call.