Suppose you are the web administrator for an online clothing store, and you are looking to migrate your existing web sites to Azure web apps. As part of this migration, you want to replace your in-house, custom authentication solution with the authentication services that are provided in Azure. To determine if the authentication features provided by the Azure App Service can support the kind of authentication and authorization your company's business requires, you'll start by testing browser-based authentication for a simple web application. 

We'll begin by looking at authentication and authorization with browser-based apps, and how to use the Azure App Service to authenticate app users.

## Authentication and Authorization

**Authentication** validates a user's identity, this is part of an authentication flow that validates against a known, trusted identity authority. Users authenticate with some form of credentials. The credentials can be username-password, and if the credentials are valid, the identity is ***authenticated***. An authenticated identity can then be **authorized** to access specific resources.

## Azure Web Apps

Web apps are applications that are accessed through a web browser, and do not typically use any local resources on the browser's device, or access the device's operating system (OS).

If you are doing anything in an app that uses a user identity, then you'll need to authenticate those identities. However, you can't use of any security or identity management tools that are within the device's OS, and this is where the authentication services provided by Azure App Services fit in.