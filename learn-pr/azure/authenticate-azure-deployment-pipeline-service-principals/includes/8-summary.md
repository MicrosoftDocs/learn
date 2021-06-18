You're planning your first deployment pipeline for your toy company. Before you start building it, you needed to plan how the pipeline would securely identify itself to Azure.

In this module, you learned about service principals. You learned what they are and why you use them in a deployment pipeline. You also learned about the two types of credentials you can use with a service principal, as well as managed identities, which don't need you to main credentials. Then, you learned how to grant a service principal access to your Azure environment using the principle of least privilege.

By using service principals, you can start to build deployment pipelines that support the automation of your infrastructure. Service principals enable you to create tightly scoped identities that represent a single pipeline, and you can grant them access to do exactly what they need to do.

<!--
  - https://docs.microsoft.com/azure/active-directory/fundamentals/service-accounts-introduction-azure
  - https://docs.microsoft.com/azure/active-directory/fundamentals/service-accounts-principal#move-from-a-user-account-to-a-service-principal
  - https://docs.microsoft.com/azure/active-directory/fundamentals/service-accounts-governing-azure
  - https://docs.microsoft.com/azure/active-directory/develop/active-directory-how-applications-are-added#what-are-service-principals-and-where-do-they-come-from
  - https://docs.microsoft.com/azure/role-based-access-control/overview
-->