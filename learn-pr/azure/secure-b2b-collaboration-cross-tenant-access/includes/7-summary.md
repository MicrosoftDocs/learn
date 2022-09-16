You needed to allow employees in your financial institution to collaborate with partners on marketing and communications projects. But because your internal accounting applications contain sensitive data, you wanted to make sure the only users who could access these applications were employees in a recently acquired branch.

With cross-tenant access settings, you can allow or block B2B collaboration with other Azure AD organizations by default and on a per-organization basis. First, you configured your default cross-tenant access settings to allow outbound B2B collaboration and block inbound B2B collaboration. Then you added the branch tenant and configured their cross-tenant access settings to allow inbound B2B collaboration. You also trusted multi-factor authentication claims from the branch to streamline the sign-in experience for their employees.

Without cross-tenant access settings, you wouldn't have this level of control over your collaboration with other Azure AD organizations. Being able to allow and block B2B collaboration for specific organizations, users, and applications, gives you more security when sharing and collaborating with others.

## References

* [External Identities documentation](/azure/active-directory/external-identities/)
