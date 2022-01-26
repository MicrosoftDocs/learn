An application that needs to deploy or configure resources through Azure Resource Manager must be represented by its own identity. Just as a user is represented by a security principal called a user principal, an app is represented by a service principal. The service principal provides an identity for your app, allowing you to delegate only the necessary permissions to the app.

As an example, you may have a configuration management app that uses Azure Resource Manager to inventory Azure resources. In this scenario, you can create a service principal, grant the "reader" role to that service principal, and limit the configuration management app to read-only access.

Like a user, an app must present credentials during authentication. This authentication consists of two elements:

 -  An **Application ID**, sometimes referred to as a Client ID. A GUID that uniquely identifies the app's registration in your Active Directory tenant.
 -  A **secret** associated with the application ID. You can either generate a client secret string (similar to a password), or specify an X509 certificate (which uses its public key).

Running an app under its own identity is preferable to running it under the user's identity for the following reasons:

 -  **Stronger credentials** \- an app can sign in using an X509 certificate, instead of a textual shared secret/password.
 -  **More restrictive permissions** can be assigned to an app. Typically, these permissions are restricted to only what the app needs to do, known as the *principle of least privilege*.
 -  **Credentials and permissions don't change as frequently** for an app as user credentials. For example, when the user's responsibilities change, password requirements dictate a change, or when a user leaves the company.

You start by creating a new app registration in your directory, which creates an associated service principal object to represent the app's identity within the directory.
