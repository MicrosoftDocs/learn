New deployment slots can be empty or cloned. When you clone a configuration from another deployment slot, the cloned configuration is editable. Some configuration elements follow the content across a swap (not slot specific), whereas other configuration elements stay in the same slot after a swap (slot specific). Deployment slot settings fall into three categories.

 -  Slot-specific app settings and connection strings, if applicable.
 -  Continuous deployment settings, if enabled.
 -  App Service authentication settings, if enabled.

Watch this video on how to use deployment slots. This video is based on [Azure Tips and Tricks #306 How to use deployment slots ](https://microsoft.github.io/AzureTipsAndTricks/blog/blog/tip306.html). The video also refers to [Azure Tips and Tricks #236 Deploy your web app]https://microsoft.github.io/AzureTipsAndTricks/blog/blog/tip236.html

<br/>
<iframe width="1280" height="720" src="https://www.youtube.com/embed/5rR5C4Z5dU4" title="How to use Deployment Slots in Azure App Service for Containers | Azure Tips and Tricks" frameborder="0" allowfullscreen></iframe>


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
