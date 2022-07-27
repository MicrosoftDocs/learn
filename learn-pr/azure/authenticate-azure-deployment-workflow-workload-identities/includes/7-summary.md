You're planning your first deployment workflow for your toy company. Before you started building it, you needed to plan how the workflow would securely identify itself to Azure.

In this module, you learned what workload identities are and why you use them in a deployment workflow. You also how workload identities can use federated credentials to securely authenticate GitHub Actions workflows without storing any secrets. Then, you learned how to grant a workload identity access to your Azure environment by using the principle of least privilege.

By using workload identities, you can start to build deployment workflows that support the automation of your infrastructure. Workload identities enable you to create tightly scoped identities that represent a single workflow, and you can grant them access to do exactly what they need to do.

## Learn more

<!-- TODO -->
- [Introduction to securing Azure service accounts](/azure/active-directory/fundamentals/service-accounts-introduction-azure)
- [What are service principals and where do they come from?](/azure/active-directory/develop/active-directory-how-applications-are-added#what-are-service-principals-and-where-do-they-come-from)
- [Securing service principals](/azure/active-directory/fundamentals/service-accounts-principal)
- [Governing Azure AD service accounts](/azure/active-directory/fundamentals/service-accounts-governing-azure)
- [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview)
- [Azure built-in roles](/azure/role-based-access-control/built-in-roles)
- [Azure custom roles](/azure/role-based-access-control/custom-roles)
