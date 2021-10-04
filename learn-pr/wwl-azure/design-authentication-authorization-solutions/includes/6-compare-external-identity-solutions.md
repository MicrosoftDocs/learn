With some basic knowledge on identity solutions, let’s review our design choices. 

| | Azure AD B2B| Azure AD B2C |
| - | - | - |
| Purpose| Collaborating with business partners from external organizations like suppliers, partners, vendors. Users appear as guest users in your directory. These users may or may not have managed IT.| Customers of your product. These users are managed in a separate Azure AD directory / tenant. |
| Users| Partner users acting on behalf of their company or employees of the company| Customers acting as themselves. |
| Profiles| Managed through access reviews, email verification, or access/deny lists.| Users manage their own profiles. |
| Discoverability| Partner users are discoverable and can find other users from their organization.| Customers are invisible to other users. Privacy and content are enforced. |
| Identity providers supported| External users can collaborate using work accounts, school accounts, any email address, SAML and WS-Fed based identity providers, Gmail, and Facebook.| Consumer users with local application accounts (any email address or user name), various supported social identities, and users with corporate and government-issued identities via SAML/WS-Fed based identity provider federation. |
| External user management| External users are managed in the same directory as employees but are typically annotated as guest users. Guest users can be managed the same way as employees, added to the same groups, and so on.| External users are managed in the Azure AD B2C directory. They're managed separately from the organization's employee and partner directory (if any). |
| Branding| Host/inviting organization's brand is used.| Fully customizable branding per application or organization. |


> [!IMPORTANT]
> Take a few minutes to decide if Azure B2B or Azure B2C would be required by your organization. Write down a few thoughts on how these options would be used. 