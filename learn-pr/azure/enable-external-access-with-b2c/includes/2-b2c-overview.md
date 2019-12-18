Your application is a web app that needs to handle patients' healthcare-related data. You've been asked to ensure patients can securely access the data they need through the application. Patients should be able to use an existing social identity, such as Facebook or Twitter.

Here, you'll discover why you should use Azure Active Directory B2C. You'll also explore the concepts that will help you achieve customized, and secure access for your patients.

## Why should you use Azure Active Directory B2C?

![Azure AD B2C overview](../media/2-azureadb2c-overview.png)

Azure Active Directory B2C (Azure AD B2C) is a service you use to manage your customers' identities and access to your applications. The service can support millions of users. Use Azure AD B2C to securely authenticate your customers through their preferred identity providers. Azure AD B2C can handle billions of authentications per day. Use the service to monitor for, and automatically take care of, threats like brute force and denial-of service attacks. Azure AD B2C integrates with other services such as Azure's Application Insights. Use this integration to improve your applications' security and user experience.

### Configure user journeys through policies

A user journey is the path you want your user to take on your application to achieve their goal. For example, your user's might want to make a new account, or make updates to their profile. You use policies in Azure AD B2C to configure your user journeys. Policies help you detail things like profile creation, sign-in, or account-editing for your users. Azure AD B2C comes with pre-configured policies that you can configure, called user flows. Use user flows to control how users interact with your application. Use user flows to configure things like:

- Which account types that are used on your application. For example, social accounts like twitter, or local accounts managed by you.
- What data to collect from your users, like location, age or clothing size.
- Whether you want to enable multi-factor authentication.

You can reuse the same user flows across different applications. Reuse your user flows so you'll have consistent user journeys across your applications.

![A user flow](../media/2-userflow.png)

There are different types user flows that you can use, like profile editing, or password reset user flows. A sign-up and sign-in user flow, for example, defines the steps and pages the user goes through to sign up, and sign in, to your application. The user flow might have steps like this:

![Sign-in user flow](../media/2-signin-user-flow.png)

First, the user goes to your application perhaps using their computer's internet browser or on their mobile phone. The user is then presented with a sign-in form so they can be authenticated for your application.  The user provides their account credentials in the sign-in form. If you've enabled multi-factor authentication for your user flow, the user will then be prompted to enter a code that they can receive on their mobile device. The user's code is then verified, and  if successful, they'll be forwarded to your application.

Azure AD B2C also supports industry standard OAuth 2.0 and OpenID Connect authentication protocols for your user flows. You can use these protocols when you're building apps like Web API, or mobile applications. In this way, sign-up and sign-in can be outsourced to Azure AD B2C for your applications, regardless of the languages your applications might be built on.

### Allow users to use different identity providers

Use identity providers to let users sign in with their social identities. You can let your users sign in with social accounts like their Microsoft account, Facebook, Twitter, or LinkedIn.

You'll need to choose the identity providers you want for your application. You can create your own identity provider, or you can choose from the list of providers.

![Identity providers](../media/2-identity-providers.png)

### Customize your user interface

You can change the look of the pages that form part of your user flow. You write your own HTML and CSS, or use built-in templates called *page layout templates*.

You enable different page layout templates in the Azure portal. You go to your user flow, and select the template you want. The template will be applied automatically.

![Set template](../media/2-set-template.png)

For example, if you were to choose **Ocean Blue** for your template, it would be applied to your user flow. When your user navigates to your application, they'll see the layout has changed, as shown below. Take advantage of templates to customize the user experience for your users.

![Customized UI](../media/2-customized-ui.png)
