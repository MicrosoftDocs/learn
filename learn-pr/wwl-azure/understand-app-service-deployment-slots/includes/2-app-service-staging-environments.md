When you deploy your web app, web app on Linux, mobile back end, or API app to Azure App Service, you can use a separate deployment slot instead of the default production slot. This approach is available if you run in the **Standard**, **Premium**, or **Isolated** App Service plan tier. Deployment slots are live apps with their own host names. App content and configurations elements can be swapped between two deployment slots, including the production slot.

Deploying your application to a nonproduction slot has the following benefits:

* You can validate app changes in a staging deployment slot before swapping it with the production slot.
* Deploy an app to a slot first and swapping it into production makes sure that all instances of the slot are warmed up before being swapped into production. This eliminates downtime when you deploy your app. The traffic redirection is seamless, and no requests are dropped because of swap operations. You can automate this entire workflow by configuring auto swap when pre-swap validation isn't needed.
* After a swap, the previous production app is located in the staging slot. If the changes swapped into the production slot aren't as you expect, you can perform the same swap immediately to get your "last known good site" back.

Each App Service plan tier supports a different number of deployment slots. There's no extra charge for using deployment slots. To find out the number of slots your app's tier supports, visit [App Service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits).

To scale your app to a different tier, make sure that the target tier supports the number of slots your app already uses. For example, if your app has more than five slots, you can't scale it down to the **Standard** tier, because the **Standard** tier supports only five deployment slots.

When you create a new deployment slot the new slot has no content, even if you clone the settings from a different slot. You can deploy to the slot from a different repository branch or a different repository.

The slot's URL has the format `http://sitename-slotname.azurewebsites.net`. To keep the URL length within necessary domain name system limits, the site name is truncated at 40 characters. The combined site name and slot name must be fewer than 59 characters.

