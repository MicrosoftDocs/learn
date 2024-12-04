You're planning your first deployment pipeline for your toy company. Before you started building the pipeline, you needed to plan how the pipeline would securely identify itself to Azure.

In this module, you learned what service principals are and why you use them in a deployment pipeline. You also learned about the two types of credentials that you can use with a service principal (certificates and keys), and that managed identities don't require you to work with credentials. Then, you learned how to grant a service principal access to your Azure environment by using the principle of least privilege.

By using service principals, you can start to build deployment pipelines that support the automation of your infrastructure. Service principals enable you to create tightly scoped identities that represent a single pipeline, and you can grant them access to do only what they need to do.

## Learn more

- [Introduction to securing Azure service accounts](/azure/active-directory/fundamentals/service-accounts-introduction-azure)
- [What are service principals and where do they come from?](/azure/active-directory/develop/active-directory-how-applications-are-added#what-are-service-principals-and-where-do-they-come-from)
- [Application and service principal objects in Microsoft Entra ID](/azure/active-directory/develop/app-objects-and-service-principals)
- [Securing service principals](/azure/active-directory/fundamentals/service-accounts-principal)
- [Governing Microsoft Entra service accounts](/azure/active-directory/fundamentals/service-accounts-governing-azure)
- [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview)
- [Azure built-in roles](/azure/role-based-access-control/built-in-roles)
- [Azure custom roles](/azure/role-based-access-control/custom-roles)
