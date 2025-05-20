Deployment slots are configured in the Azure portal. You can swap your app content and configuration elements between deployment slots, including the production slot.

### How to use deployment slots in Azure App Service

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=b8909968-03b3-47da-ac69-63bee05b8a6c]

### Things to know about creating deployment slots

Let's review some details about how deployment slots are configured.

- New deployment slots can be empty or cloned.

- Deployment slot settings fall into three categories:
   - Slot-specific app settings and connection strings (if applicable).
   - Continuous deployment settings (when enabled).
   - Azure App Service authentication settings (when enabled).

- When you clone a configuration from another deployment slot, the cloned configuration is editable. Some configuration elements follow the content across the swap. Other slot-specific configuration elements stay in the source slot after the swap.

#### Swapped settings versus slot-specific settings

The following table lists settings that are swapped between deployment slots. The table also lists settings that remain in the source slot (slot-specific). As you review these settings, consider which features are required for your App Service apps. Read more about [which settings are swapped](/azure/app-service/deploy-staging-slots?tabs=portal#which-settings-are-swapped).

| Swapped settings | Slot-specific settings | 
| --- | --- |
| Language stack and version, 32/64-bit <br> App settings __\*__ <br> Connection strings __\*__ <br> Mounted storage accounts* <br> Public certificates <br> WebJobs content <br> Hybrid connections __\*\*__ <br> Service endpoints __\*\*__ <br> Azure Content Delivery Network __\*\*__ <br> Path mapping | Custom domain names <br> Nonpublic certificates and TLS/SSL settings <br> Scale settings <br> Always On <br> IP restrictions <br> WebJobs schedulers <br> Diagnostic settings <br> Cross-origin resource sharing (CORS) <br> Virtual network integration <br> Managed identities <br> |

__*__ Setting can be configured to be slot-specific.

__**__ Feature isn't currently available.