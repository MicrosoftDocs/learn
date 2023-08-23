Deployment slots are configured in the Azure portal. You can swap your app content and configuration elements between deployment slots, including the production slot.

Watch the following video on how to use deployment slots. This video is based on [Azure Tips and Tricks #306 - How to use deployment slots](https://microsoft.github.io/AzureTipsAndTricks/blog/blog/tip306.html). The video also refers to [Azure Tips and Tricks #236 - Deploy your web app](https://microsoft.github.io/AzureTipsAndTricks/blog/blog/tip236.html).

#### <!-- Video -->

> [!VIDEO https://www.youtube.com/embed/5rR5C4Z5dU4]

### Things to know about creating deployment slots

Let's review some details about how deployment slots are configured.

- New deployment slots can be empty or cloned.

- Deployment slot settings fall into three categories:
   - Slot-specific app settings and connection strings (if applicable)
   - Continuous deployment settings (when enabled)
   - Azure App Service authentication settings (when enabled)

- When you clone a configuration from another deployment slot, the cloned configuration is editable. Some configuration elements follow the content across the swap. Other slot-specific configuration elements stay in the source slot after the swap.

#### Swapped settings versus slot-specific settings

The following table lists the settings that are swapped between deployment slots, and settings that remain in the source slot (slot-specific). As you review these settings, consider which features are required for your App Service apps.

| Swapped settings | Slot-specific settings | 
| --- | --- |
| General settings, such as framework version, 32/64-bit, web sockets <br> App settings __\*__ <br> Connection strings __\*__ <br> Handler mappings <br> Public certificates <br> WebJobs content <br> Hybrid connections __\*\*__ <br> Service endpoints __\*\*__ <br> Azure Content Delivery Network __\*\*__ <br> Path mapping | Custom domain names <br> Non-public certificates and TLS/SSL settings <br> Scale settings <br> Always On <br> IP restrictions <br> WebJobs schedulers <br> Diagnostic settings <br> Cross-origin resource sharing (CORS) <br> Virtual network integration <br> Managed identities <br> Settings that end with the suffix _EXTENSION_VERSION |

__*__ Setting can be configured to be slot-specific.

__**__ Feature isn't currently available.