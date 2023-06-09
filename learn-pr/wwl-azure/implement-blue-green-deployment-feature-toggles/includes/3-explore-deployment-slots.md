When using a cloud platform like Azure, doing blue-green deployments is relatively easy. You don't need to write your code or set up infrastructure. You can use an out-of-the-box feature called deployment slots when using web apps.

Deployment slots are a feature of Azure App Service. They're live apps with their hostnames. You can create different slots for your application (for example, Dev, Test, or Stage). The production slot is the slot where your live app stays. You can validate app changes in staging with deployment slots before swapping them with your production slot.

You can use a deployment slot to set up a new version of your application, and when ready, swap the production environment with the new staging environment. It's done by an internal swapping of the IP addresses of both slots.

## Swap

The swap eliminates downtime when you deploy your app with seamless traffic redirection, and no requests are dropped because of swap operations.

To learn more about Deployment slots and swap, see also:

 -  [Set up Staging Environments in Azure App Service](/azure/app-service/deploy-staging-slots).
 -  [Considerations on using Deployment Slots in your DevOps Pipeline](https://blogs.msdn.microsoft.com/devops/2017/04/10/considerations-on-using-deployment-slots-in-your-devops-pipeline/).
 -  [What happens during a swap.](/azure/app-service/deploy-staging-slots)
