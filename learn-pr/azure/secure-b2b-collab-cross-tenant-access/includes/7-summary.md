Employees in your financial institution need to collaborate with partners on marketing and communications projects. But you want only employees in a recently acquired branch to be able to access your interal accounting applications.

With cross-tenant access settings, you can allow or block B2B collaboration with other Azure AD organizations by default and on a per-organization basis. First, you configured your default cross-tenant access settings to allow outbound B2B collaboration and block inbound B2B collaboration. Then you added the branch tenant and customized their settings to allow inbound B2B collaboration. You also trusted multi-factor authentication claims from the branch to streamline the sign-in experience for their employees.

Without cross-tenant settings, you wouldn't have this level of control over your collaboration with other Azure AD organizations. The ability to allow and block B2B collaboration down to the user and application level lets you share resources with external Azure AD organizations securely.

## References

* [External Identities documentation](https://docs.microsoft.com/azure/active-directory/external-identities/)
