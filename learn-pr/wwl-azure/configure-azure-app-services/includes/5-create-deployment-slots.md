When you deploy your web app, web app on Linux, mobile backend, or API app to Azure App Service, you can use a separate deployment slot instead of the default production slot.

### Things to know about deployment slots

Let's take a closer look at the characteristics of deployment slots.

- Deployment slots are live apps that have their own hostnames.

- Deployment slots are available in the Standard, Premium, and Isolated App Service pricing tiers. Your app needs to be running in one of these tiers to use deployment slots.

- The Standard, Premium, and Isolated tiers offer different numbers of deployment slots.

- App content and configuration elements can be swapped between two deployment slots, including the production slot.

:::image type="content" source="../media/deployment-slots-5b3660cc.png" alt-text="Screenshot that shows how to work with deployment slots in the Azure portal.":::

### Things to consider when using deployment slots

There are several advantages to using deployment slots with your App Service app. Review the following benefits and think about how they can support your App Service implementation.

- **Consider validation**. You can validate changes to your app in a staging deployment slot before swapping the app changes with the content in the production slot.

- **Consider reductions in downtime**. Deploying an app to a slot first and swapping it into production ensures that all instances of the slot are warmed up before being swapped into production. This option eliminates downtime when you deploy your app. The traffic redirection is seamless, and no requests are dropped because of swap operations. The entire workflow can be automated by configuring **Auto swap** when pre-swap validation isn't needed.

- **Consider restoring to last known good site**. After a swap, the slot with the previously staged app now has the previous production app. If the changes swapped into the production slot aren't as you expected, you can perform the same swap immediately to return to your "last known good site."

- **Consider Auto swap**. Auto swap streamlines Azure DevOps scenarios where you want to deploy your app continuously with zero cold starts and zero downtime for app customers. When Auto swap is enabled from a slot into production, every time you push your code changes to that slot, App Service automatically swaps the app into production after it's warmed up in the source slot. Auto swap isn't currently supported for Web Apps on Linux.