Our banking company needed to provide its users access to protected resources. We wanted to create a secure web app that asks the users to authenticate themselves before getting access to these resources.

The Microsoft identity platform helps you build applications your users and customers can sign in to using several identity types. We created a Django web app and secured it using the Microsoft identity platform. We created a single-tenant app registration in an Azure AD tenant and configured our Django web app using the app registration details. Finally, using the Microsoft identity web library for Python, we authenticated users using their sign-in credentials, that is, username and password.

If the banking company decided to build their own auth system, they'd have to write all required code to handle this. The banking company would also have to come up with a user management strategy. The company would have to maintain their code and keep it up to date to handle any security attacks and incidences. They would need to think of storing the user's credentials safely.

Microsoft identity platform offers integration of modern innovations in the identity and security space. It took us a short time to add auth capabilities to our web app. We easily registered an app and created a user account. We also got the benefit of using a modern authentication approach without having to think of a custom solution. The app can now scale to handle more users and more complex scenarios such as conditional access.

## References

- [Microsoft identity platform documentation](/azure/active-directory/develop/v2-overview)
- [Django sample app](https://github.com/Azure-Samples/ms-identity-python-django-tutorial/tree/main/1-Authentication/sign-in)

<!-- Do not include any other content -->
