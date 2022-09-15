Organizations build apps to serve various use cases. While most applications require users to interact with them, there are also requirements to build applications that run as background processes, for example, the generation of monthly reports. Because these apps access resources independently of users, the apps themselves need to prove their identity. Azure Active Directory (Azure AD) enables you to authenticate your app and provide authorized access to a protected web API.

## Example scenario

Suppose you work at a financial company as a software developer. The company depends on many applications that run as background processes rather than being under the direct control of a user. These applications support business operations like generating loan reports, loan repayment reports, and processing payroll at the end of the month.

Your company uses Azure AD, which is an identity provider, to ensure that company data is accessed in a secure way. You've been tasked with building an application that will acquire a token to call a protected web API on behalf of itself.

## What will you be doing?

In this module, you'll prepare an Azure AD tenant to authenticate an app and write a daemon application that can acquire a token from the Microsoft identity platform to call a protected web API on behalf of itself. In the following flow, the app interacts directly with the Azure AD `/token` endpoint to obtain access:

:::image type="icon" source="../media/convergence-scenarios-daemon.svg" border="false":::

## What is the main goal?

By the end of this module, you'll be able to create a Python daemon app that uses its own identity to get an access token. The token is then included in the app's requests to a protected web API.
