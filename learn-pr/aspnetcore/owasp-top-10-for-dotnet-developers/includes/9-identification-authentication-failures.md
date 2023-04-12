
Identification and Authentication Failures category, previouslyu 'Broken Authentication' related to 'Broken Access Control', covers weaknesses in confirming user’s identity, authentication, and session management in protection against authentication-related attacks.

As covered in prior unit, authentication is a process in which a user provides credentials that are then compared to those stored in an operating system, database, app or resource. If they match, users authenticate successfully, and can then perform actions that they're authorized for, during an authorization process. The authorization refers to the process that determines what a user is allowed to do.

Cross site request forgery, session hijacking or brute force credential stuffing are just a few techniques used by attackers to exploit broken authentication. The result may be temporal or permanent information disclosure or account hijacking.

> [!TIP]
> Follow [Security Development Lifecycle](https://www.microsoft.com/securityengineering/sdl/practices) and [Operational Security](https://www.microsoft.com/securityengineering/osa/practices) best practices to ensure Multi-Factor Authentication, Zero Trust and established Design Requirements are in place.

Operations related to user's identity, authentication or session management should be adequately protected and implemented correctly. Avoid security through obscurity.

Luckily [ASP.NET](/aspnet/core/security) Core and Entity Framework contain features that help you secure your apps and prevent security breaches. For example, ASP.NET MVC framework has a build-in helper methods, which can add anti-forgery tokens to your Razor pages:

``` razor
@using (Html.BeginForm("Manage", "Account")) {
    @Html.AntiForgeryToken()
}
```

Known and common attach techniques is cross-site scripting (XSS). XSS works by tricking your application into inserting a `<script>` tag into your rendered page, or by inserting an On* event into an element.
Never put untrusted data into your HTML input. Untrusted data is any data that may be controlled by an attacker, HTML form inputs, query strings, HTTP headers, even data sourced from a database as an attacker may be able to breach your database even if they cannot breach your application.

Before putting untrusted data into a URL query string ensure it's URL encoded. HTML encoding takes characters such as `<` and changes them into a safe form like `&lt`. Don't make authorization decisions based on the state of the UI but only from component state. Consider using Content Security Policy (CSP) to protect against XSS attacks.

### Code Review Notes

As part of your code review you decided to analyze Cross-Origin Resource Sharing (CORS) configuration of your app. The same-origin policy is a browser security feature that prevents a web page from making requests to a different domain than the one that served the web page, preventing from man-in-the-middle attack.
Confirmation of the user’s identity, authentication and session management is critical to protect against authentication–related attacks.
The Microsoft Authentication Library (MSAL) enables developers to acquire security tokens from the Microsoft identity platform to authenticate users and access secured web APIs. It can be used to provide secure access to Microsoft Graph, other Microsoft APIs, third-party web APIs, or your own web API. MSAL supports many different application architectures and platforms including .NET, JavaScript, Java, Python, Android, and iOS.
