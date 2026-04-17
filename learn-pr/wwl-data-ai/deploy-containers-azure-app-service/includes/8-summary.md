In this module, you learned how to deploy and manage containerized applications on Azure App Service. You deployed a custom container from Azure Container Registry using managed identity authentication, which eliminates the need to store registry credentials. You configured container runtime behavior including startup commands, port settings to route traffic correctly, and persistent storage to preserve files across restarts. You also configured application settings to provide environment-specific values without rebuilding the image. Finally, you enabled container logging and used diagnostic tools including the log stream and the SCM (Kudu) site to verify configuration and troubleshoot issues.

## Additional resources

Use the following resources to learn more about deploying containers to Azure App Service:

- [Configure a custom container for Azure App Service](/azure/app-service/configure-custom-container) provides comprehensive documentation for all container configuration options including advanced scenarios.

- [Use Key Vault references as app settings](/azure/app-service/app-service-key-vault-references) explains how to integrate Azure Key Vault for centralized secrets management with automatic rotation.

- [Enable diagnostic logging for apps in Azure App Service](/azure/app-service/troubleshoot-diagnostic-logs) covers all logging options including Azure Monitor integration for long-term retention and analysis.

- [Tutorial: Migrate custom software to Azure App Service using a custom container](/azure/app-service/tutorial-custom-container) walks through containerizing an existing application and deploying it to App Service.
