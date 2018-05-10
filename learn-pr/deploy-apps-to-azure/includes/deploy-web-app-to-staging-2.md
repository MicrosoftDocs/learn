Azure Web App deployment slots are live apps that have their own host names. App content and configuration elements can be swapped between two deployment slots, including the production slot. Deploying your application to a deployment slot has the following benefits:

- You can validate app changes in a staging deployment slot before swapping it with the production slot.
- Deploying an app to a slot first and then swapping it into production ensures that all instances of the slot are warmed up before being swapped into production. This eliminates downtime when you deploy your app. The traffic redirection is seamless, and no requests are dropped as a result of swap operations. You can automate this entire workflow by configuring auto swap when pre-swap validation isn't needed.
- After a swap, the slot with a previously staged app now has the previous production app. If the changes swapped into the production slot aren't as you expected, you can perform the same swap immediately to get your "last known good" site back.

These settings are swapped between deployment slots:

- General settings, such as framework version, 32-bit/64-bit, WebSockets
- App settings (can be configured to stick to a slot)
- Connection strings (can be configured to stick to a slot)
- Handler mappings
- Monitoring and diagnostic settings
- WebJobs content

These settings are not swapped between deployment slots:

- Publishing endpoints
- Custom domain names
- SSL certificates and bindings
- Scale settings
- WebJobs schedulers

Now, create a Web App staging slot and deploy it to review by using the Team Services CI/CD pipeline.