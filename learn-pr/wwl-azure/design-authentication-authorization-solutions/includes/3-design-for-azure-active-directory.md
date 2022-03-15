Let’s begin with [Azure Active Directory (Azure AD)](/azure/active-directory/fundamentals/active-directory-whatis). Azure AD is the Azure solution for identity and access management. Azure AD is a multitenant, cloud-based directory, and identity management service. It combines core directory services, application access management, and identity protection into a single solution. Azure AD can be used in cloud or hybrid environments. 

**Cloud identity solution**. You can use Azure AD as a cloud only solution for all your employee user accounts. Azure AD provides not only identity management but protection for those accounts. For example, role-based access control, conditional access, and access reviews. We’ll cover those features, later in this module. 

**Hybrid identity solution**. You can also use Azure AD in hybrid environments. Azure AD [extends on-premises Active Directory](/azure/active-directory/hybrid/whatis-hybrid-identity) to the cloud. With Azure AD Connect or Azure AD Connect cloud sync, you can bring on-premises identities into Azure AD. Once the on-premises accounts are in Azure AD they will get the benefits of easy management and identity protection. 

:::image type="content" source="../media/on-premises-identities.png" alt-text="Azure AD Connect syncs Active Directory Domain Services and Azure Active Directory.":::


## Best practices with Azure ID identity management

- **Centralize identity management**. In a hybrid identity scenario, we recommend that you integrate your on-premises and cloud directories. Integration enables your IT team to manage accounts from one location, whenever an account is created. Integration also helps your users be more productive by providing a common identity for accessing both cloud and on-premises resources.

- **Establish a single Azure AD instance**. Consistency and a single authoritative source will increase clarity and reduce security risks from human errors and configuration complexity. Designate a single Azure AD directory as the authoritative source for corporate and organizational accounts.

- **Don’t synchronize accounts to Azure AD that have high privileges in your existing Active Directory instance.** By default, Azure AD Connect filters out these high privileged accounts. This configuration mitigates the risk of adversaries pivoting from cloud to on-premises assets (which could create a major incident).

- **Turn on password hash synchronization**. [Password hash synchronization](/azure/active-directory/hybrid/whatis-phs) is a feature used to sync user password hashes from an on-premises Active Directory instance to a cloud-based Azure AD instance. This sync helps to protect against leaked credentials being replayed from previous sign-ins.

- **Enable single sign-on (SSO).** SSO reduces the need for multiple passwords. Multiple passwords increase the likelihood of users reusing passwords or using weak passwords. With SSO, users provide their primary work or school account for their domain-joined devices and company resources. Their application access can be automatically provisioned (or deprovisioned) based on their organization group memberships and their status as an employee. 

> [!NOTE]
> Organizations that don’t integrate their on-premises identity with their cloud identity can have more overhead in managing accounts. This overhead increases the likelihood of mistakes and security breaches.