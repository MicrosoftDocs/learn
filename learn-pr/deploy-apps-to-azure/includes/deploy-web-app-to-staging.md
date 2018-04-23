> [!VIDEO https://www.youtube.com/embed/KUhJfqKav8Y]

Web App deployment slots are live apps with their own hostnames. App content and configurations elements can be swapped between two deployment slots, including the production slot. Deploying your application to a deployment slot has the following benefits:

- You can validate app changes in a staging deployment slot before swapping it with the production slot.
- Deploying an app to a slot first and swapping it into production ensures that all instances of the slot are warmed up before being swapped into production. This eliminates downtime when you deploy your app. The traffic redirection is seamless, and no requests are dropped as a result of swap operations. This entire workflow can be automated by configuring Auto Swap when pre-swap validation is not needed.
- After a swap, the slot with previously staged app now has the previous production app. If the changes swapped into the production slot are not as you expected, you can perform the same swap immediately to get your "last known good site" back.

Settings that are swapped between deployment slots:

- General settings - such as framework version, 32/64-bit, Web sockets
- App settings (can be configured to stick to a slot)
- Connection strings (can be configured to stick to a slot)
- Handler mappings
- Monitoring and diagnostic settings
- WebJobs content

Settings that are not swapped between deployment slots:

- Publishing endpoints
- Custom Domain Names
- SSL certificates and bindings
- Scale settings
- WebJobs schedulers