[Azure AD](/azure/active-directory/fundamentals/active-directory-whatis) is the Azure solution for identity and access management. Azure AD is a multitenant, cloud-based directory, and identity management service. It combines core directory services, application access management, and identity protection into a single solution. Azure AD can be used in cloud or hybrid environments. 

### Things to know about Azure AD identity management

As you plan the identity and access management strategy for Tailwind Traders, consider these characteristics of Azure AD:

- You can implement Azure AD as a **cloud-only identity solution** for all your Tailwind Traders employee user accounts.

- The cloud-only identity solution provides both identity management and protection for your accounts, including role-based access control (RBAC), conditional access, and access reviews. We examine these features later in this module.

- Azure AD also offers a **hybrid identity solution** for identity management in Tailwind Traders hybrid environments.

- In hybrid environments, Azure AD [extends on-premises Active Directory](/azure/active-directory/hybrid/whatis-hybrid-identity) to the cloud.

- With Azure AD Connect or Azure AD Connect cloud sync, you can bring on-premises identities into Azure AD. After the on-premises accounts are in Azure AD, they'll get the benefits of easy management and identity protection. 

:::image type="content" source="../media/on-premises-identities.png" alt-text="Diagram that shows how Azure AD Connect syncs Active Directory Domain Services and Azure Active Directory." border="false":::

### Things to consider when using Azure AD identity management

Tailwind Traders plans to use Azure AD in its identity management solution. There are several considerations to review as you work on the configuration.

- **Consider benefits of centralized identity management**. (Microsoft recommended) Integrate your on-premises and cloud directories when you're working in a hybrid identity scenario. Integration enables your Tailwind Traders IT team to manage accounts from one location, whenever an account is created. Centralized integration also helps your users be more productive by providing a common identity for accessing both cloud and on-premises resources.

- **Consider using a single Azure AD instance**. Use a single authoritative source and consistency to increase clarity and reduce security risks from human errors and configuration complexity. Designate a single Azure AD directory as the authoritative source for Tailwind Traders corporate and organizational accounts.

- **Consider limiting account synchronization**. Don't synchronize accounts to Active Directory that have high privileges in your existing Azure AD Tailwind Traders instance. By default, Azure AD Connect filters out these high privileged accounts. This configuration mitigates the risk of adversaries pivoting from cloud to on-premises assets (which could result in a major incident).

- **Consider password hash synchronization**. Enable [password hash synchronization](/azure/active-directory/hybrid/whatis-phs) to sync user password hashes from an on-premises Azure AD instance to a cloud-based Azure AD instance. This sync helps to protect Tailwind Traders against leaked credentials being replayed from previous sign-ins.

- **Consider single sign-on (SSO)**. Enable SSO to reduce the need for multiple passwords. Multiple passwords increase the likelihood of users reusing passwords or using weak passwords. With SSO, users provide their primary work or school account for their domain-joined devices and company resources. Their application access can be automatically provisioned (or deprovisioned) based on their Tailwind Traders organization group memberships and their status as an employee. 

- **Consider overhead of managing separate identities**. Calculate the overhead of not integrating the Tailwind Traders on-premises identity with their cloud identity. Separate identities can result in extra account management. This overhead increases the likelihood of mistakes and security breaches.