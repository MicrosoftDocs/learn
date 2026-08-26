::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=e00b64ac-a278-4663-9d88-7a2ee18eb0fa]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

In this module, you learned how Azure App Service sidecars add supporting AI capabilities without combining every process in one container image. You evaluated lifecycle, scaling, capacity, and trust trade-offs before selecting the pattern. You configured main and sidecar container roles, unique target ports, environment variables, and managed-identity image pulls from Azure Container Registry. You also connected containers over `localhost` and exchanged files through the default shared `/home` volume. Finally, you used container-specific logs, App Service metrics, configuration inspection, and endpoint tests to diagnose image pull, startup, resource, connectivity, and shared-file failures.

::: zone-end

## Additional resources

The following resources provide deeper guidance for the App Service sidecar features covered in the module. You can use the overview for architecture decisions and the configuration reference for implementation details.

- [Sidecars overview in Azure App Service](/azure/app-service/overview-sidecar) explains container roles, lifecycle behavior, networking, and common sidecar types.
- [Configure a custom container for Azure App Service](/azure/app-service/configure-custom-container#use-persistent-shared-storage) explains the default shared `/home` storage behavior for Linux custom containers.
- [Azure CLI commands for App Service site containers](/cli/azure/webapp/sitecontainers) provides current syntax for creating, inspecting, converting, and diagnosing site containers.
