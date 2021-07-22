New deployment slots can be empty or cloned. When you clone a configuration from another deployment slot, the cloned configuration is editable. Some configuration elements follow the content across a swap (not slot specific), whereas other configuration elements stay in the same slot after a swap (slot specific). Deployment slot settings fall into three categories.

 -  Slot-specific app settings and connection strings, if applicable.
 -  Continuous deployment settings, if enabled.
 -  App Service authentication settings, if enabled.

:::image type="content" source="../media/add-slot-ef3c31cf.png" alt-text="Screenshot of the Add a Web App blade. Several configuation sources are shown.":::


**Settings that are swapped:**

 -  General settings, such as framework version, 32/64-bit, web sockets
 -  App settings (can be configured to stick to a slot)
 -  Connection strings (can be configured to stick to a slot)
 -  Handler mappings
 -  Public certificates
 -  WebJobs content
 -  Hybrid connections \*
 -  Service endpoints \*
 -  Azure Content Delivery Network \*

Features marked with an asterisk (\*) are planned to be unswapped.

**Settings that aren't swapped:**

 -  Publishing endpoints
 -  Custom domain names
 -  Non-public certificates and TLS/SSL settings
 -  Scale settings
 -  WebJobs schedulers
 -  IP restrictions
 -  Always On
 -  Diagnostic settings
 -  Cross-origin resource sharing (CORS)
 -  Virtual network integration
