Your banking company needed to provide its users access to protected resources. You needed to create a secure web app that asks the users to authenticate themselves before getting access to these resources.

The Microsoft identity platform helps you build applications that your users and customers can sign in to by using several identity types. You created a Django web app and secured it by using the Microsoft identity platform. You created a single-tenant app registration in an Azure Active Directory (Azure AD) tenant and configured a Django web app by using the app registration details. Finally, by using the Microsoft identity web library for Python, you authenticated users by using their sign-in credentials: username and password.

If the banking company decided to build its own authentication system, it would have to:

- Write all the required code.
- Create a user management strategy.
- Maintain the code and keep it updated to handle any security attacks and incidents.
- Store users' credentials safely.

The Microsoft identity platform offers integration of modern innovations in the identity and security space. It took you a short time to add authentication capabilities to a web app. You easily registered an app and created a user account. You also got the benefit of using a modern authentication approach without having to think of a custom solution. The app can now scale to handle more users and more complex scenarios, such as conditional access.

## References

- [Microsoft identity platform documentation](/azure/active-directory/develop/v2-overview)
- [Django sample app](https://github.com/Azure-Samples/ms-identity-python-django-tutorial/tree/main/1-Authentication/sign-in)
