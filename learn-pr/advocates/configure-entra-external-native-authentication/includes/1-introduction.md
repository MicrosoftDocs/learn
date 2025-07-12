## Introduction to Native authentication in Microsoft Entra External ID

Microsoft Entra's native authentication allows you to have full control over the design of your mobile and desktop application sign-in experiences. Unlike browser-based solutions, native authentication enables you to create visually appealing, pixel-perfect authentication screens that seamlessly blend into your app's interface. With this approach, you can fully customize the user interface, including design elements, logo placement, and layout, ensuring a consistent and branded look.

The standard app sign-in process, which relies on browser-delegated authentication, often results in a disruptive transition during authentication. Users are temporarily redirected to a system browser for authentication, only to be brought back to the app once the sign-in is complete.

## Available authentication methods

Currently, native authentication supports local account identity provider for two authentications methods:

- Email with one-time passcode (OTP) sign-in.
- Email and password sign-in with support for self-service password reset (SSPR).

## When to use native authentication

When it comes to implementing authentication for mobile and desktop apps on External ID, you have two options:

- Microsoft-hosted browser-delegated authentication.
- Fully custom SDK based native authentication.

Whether you choose native authentication or browser-delegated authentication, Microsoft Entra External ID supports both.

The following table compares the two authentication methods to help you decide the right option for your app.

| | **Browser-delegated authentication** | **Native authentication** |
|---|---|---|
| **User authentication experience** | Users are taken to a system browser or embedded browser for authentication only to be redirected back to the app when the sign-in is complete. This method is recommended if the redirection doesn't negatively affect the end user experience. | Users have a rich, native sign-up and sign-in journey without ever leaving the app. |
| **Customization experience** | Managed [branding and customization options](/entra/external-id/customers/how-to-customize-branding-customers) are available as an out-of-the-box feature. | This API-centric approach offers a high level of customization, providing extensive flexibility in design and the ability to create tailored interactions and flows. |
| **Applicability** | Suitable for workforce, B2B, and B2C apps, it can be used for native apps, single-page applications, and web apps. | For customer first-party apps, when the same entity operates the authorization server and the app and the user perceives them both as the same entity. |
| **Go live effort** | Low. Use it straight out of the box. | High. The developer builds, owns, and maintains the authentication experience. |
| **Maintenance effort** | Low. | High. For each feature that Microsoft releases, you need to update the SDK to use it. |
| **Security** | Most secure option. | Security responsibility is shared with developers, and best practices need to be followed. It's prone to phishing attacks. |
| **Supported languages and frameworks** | ASP.NET Core, Android (Kotlin, Java), iOS/macOS (Swift, Objective-C), JavaScript, React, Angular, Nodejs, Python, Java | Android (Kotlin, Java), iOS/macOS (Swift, Objective-C). For other languages and platforms, you can use the [native authentication API](/entra/identity-platform/reference-native-authentication-overview). |
