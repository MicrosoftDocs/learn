When you swap two slots (for example, from a staging slot to the production slot), App Service completes the following process to ensure that the target slot doesn't experience downtime:

1. Apply the following settings from the target slot (for example, the production slot) to all instances of the source slot:

    * Slot-specific app settings and connection strings, if applicable.
    * Continuous deployment settings, if enabled.
    * App Service authentication settings, if enabled.

    Any of these cases trigger all instances in the source slot to restart. During **swap with preview**, this marks the end of the first phase. The swap operation is paused, and you can validate that the source slot works correctly with the target slot's settings.

1. Wait for every instance in the source slot to complete its restart. If any instance fails to restart, the swap operation reverts all changes to the source slot and stops the operation.

1. If local cache is enabled, trigger local cache initialization by making an HTTP request to the application root ("/") on each instance of the source slot. Wait until each instance returns any HTTP response. Local cache initialization causes another restart on each instance.

1. If auto swap is enabled with custom warm-up, trigger Application Initiation by making an HTTP request to the application root ("/") on each instance of the source slot.

    * If `applicationInitialization` isn't specified, trigger an HTTP request to the application root of the source slot on each instance.

    * If an instance returns any HTTP response, it's considered to be warmed up.

1. If all instances on the source slot are warmed up successfully, swap the two slots by switching the routing rules for the two slots. After this step, the target slot (for example, the production slot) has the app that's previously warmed up in the source slot.

1. Now that the source slot has the pre-swap app previously in the target slot, perform the same operation by applying all settings and restarting the instances.

At any point of the swap operation, all work of initializing the swapped apps happens on the source slot. The target slot remains online while the source slot is being prepared and warmed up, regardless of where the swap succeeds or fails. To swap a staging slot with the production slot, make sure that the production slot is always the target slot. This way, the swap operation doesn't affect your production app.

When you clone configuration from another deployment slot, the cloned configuration is editable. Some configuration elements follow the content across a swap (not slot specific), whereas other configuration elements stay in the same slot after a swap (slot specific). The following table shows the settings that change when you swap slots.

| Settings that are swapped | Settings that aren't swapped |
|--|--|
| General settings, such as framework version, 32/64-bit, web sockets | Publishing endpoints |
| App settings (can be configured to stick to a slot) | Custom domain names |
| Connection strings (can be configured to stick to a slot) | Non-public certificates and TLS/SSL settings |
| Handler mappings | Scale settings |
| Public certificates | WebJobs schedulers |
| WebJobs content | IP restrictions |
| Hybrid connections * | Always On |
| Azure Content Delivery Network * | Diagnostic log settings |
| Service endpoints * | Cross-origin resource sharing (CORS) |
| Path mappings | Virtual network integration |
| | Managed identities |
| | Settings that end with the suffix `_EXTENSION_VERSION` |

Features marked with an asterisk (*) are planned to be unswapped.

> [!NOTE]
> To make settings swappable, add the app setting `WEBSITE_OVERRIDE_PRESERVE_DEFAULT_STICKY_SLOT_SETTINGS` in every slot of the app and set its value to `0` or `false`. These settings are either all swappable or not at all. You can't make just some settings swappable and not the others. Managed identities are never swapped and are not affected by this override app setting.

To configure an app setting or connection string to stick to a specific slot (not swapped), go to the Configuration page for that slot. Add or edit a setting, and then select **Deployment slot setting**. Selecting this check box tells App Service that the setting isn't swappable.
