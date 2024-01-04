You're planning your first deployment workflow for your toy company. Before you started building it, you needed to plan how the workflow would securely identify itself to Azure.

In this module, you learned what workload identities are and why you use them in a deployment workflow. You also learned how workload identities can use federated credentials to securely authenticate GitHub Actions workflows without storing any secrets. Then, you learned how to grant a workload identity access to your Azure environment by using the principle of least privilege.

By using workload identities, you can start to build deployment workflows that support the automation of your infrastructure. Workload identities enable you to create tightly scoped identities that represent a single workflow. You can grant these identities access to do exactly what they need to do.

## Learn more

- [What are workload identities?](/azure/active-directory/develop/workload-identities-overview)
- [Application and service principal objects in Microsoft Entra ID](/azure/active-directory/develop/app-objects-and-service-principals)
- [Workload identity federation](/azure/active-directory/develop/workload-identity-federation)
  - [Microsoft Entra ID - Configure an app to trust a GitHub repo](/azure/active-directory/develop/workload-identity-federation-create-trust-github)
  - [GitHub - Configuring OpenID Connect in Azure](https://docs.github.com/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
- [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview)
- [Azure built-in roles](/azure/role-based-access-control/built-in-roles)
- [Azure custom roles](/azure/role-based-access-control/custom-roles)
