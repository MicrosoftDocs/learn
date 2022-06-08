Employees are typically expected to use many applications to accomplish tasks. For most of the applications, Employees have to sign in and consent to the application's permissions before they can use the application. When the employee isn't able to consent to an application they want to use, frustration rises and productivity declines. An administrator can configure admin consent workflow to enable the employee to request admin consent right from the consent screen when the employee is unable to grant consent themselves.

## Example scenario

Suppose you work as an IT admin for a retail company that focuses on integrating applications for the employees in your organization. To be as secure as possible, you have not allowed users to grant access to any applications in their tenant, which means only administrators can grant access to adding an application. Sometimes, your coworkers send you emails asking you to add applications they would like to use with their work accounts. Your email has been overwhelmed, and you’re having to research the permissions and information about each application. You hear about admin consent workflow, which can field and track requests in the Azure portal and give trusted and up to date information for each application.

## What we'll be doing

Admin consent workflow provides a secure way for administrators to onboard new applications into their organizations while still supporting the users through the process.

For admin consent workflow, a combination of tasks is required.

- **Create a single page application and register it as an Azure AD application** - Download a code sample to quickly set up the application locally. Register this application in Azure AD to acquire an access token for users to sign in with Azure AD.
- **Configure and test the admin consent workflow** - Sign in to the Azure portal and enable admin consent workflow. Add designated reviewers to review consent requests.
- **Review admin consent request** - Sign in to the Azure portal to view and act on the pending admin consent requests.
