Moving Data API Builder from local development to Azure production environments requires choosing the right hosting platform and configuring deployment automation. Azure offers several options for running DAB, each with different characteristics for scalability, management overhead, and integration with other Azure services.

Your deployment strategy affects not only where DAB runs but also how you manage configuration, handle secrets, and scale to meet demand. Understanding these deployment options helps you select the approach that best fits your application architecture and operational requirements.

## Deploy to Azure Container Apps

[Azure Container Apps](/azure/container-apps/overview?azure-portal=true) provides a serverless container platform that handles infrastructure management automatically. It's well-suited for Data API Builder because it can scale from zero when idle and automatically scale up based on request volume.

To deploy DAB to Container Apps, first create a container image with your configuration:

```dockerfile
FROM mcr.microsoft.com/azure-databases/data-api-builder:latest

COPY dab-config.json /App/dab-config.json

ENV DATABASE_CONNECTION_STRING=""
ENV ASPNETCORE_URLS="http://+:5000"

EXPOSE 5000
```

This Dockerfile starts from the official DAB image and adds your configuration file. Environment variables handle the connection string and port configuration.

Deploy using the Azure CLI:

```bash
az containerapp create \
  --name dab-api \
  --resource-group myResourceGroup \
  --environment myContainerAppEnv \
  --image myregistry.azurecr.io/dab-api:v1 \
  --target-port 5000 \
  --ingress external \
  --secrets database-conn="<connection-string>" \
  --env-vars DATABASE_CONNECTION_STRING=secretref:database-conn
```

Container Apps integrates with Azure Key Vault for secret management. Reference secrets in your environment variables rather than storing credentials in configuration files or container images.

> [!TIP]
> Enable Azure Container Apps managed identity and grant it access to your Azure SQL Database. This approach eliminates stored credentials entirely by using Microsoft Entra authentication.

## Deploy to Azure App Service

[Azure App Service](/azure/app-service/overview?azure-portal=true) offers a mature platform with built-in deployment slots, custom domains, and comprehensive monitoring. For teams already using App Service, adding DAB follows familiar patterns.

Configure App Service to run the DAB container:

```bash
az webapp create \
  --name dab-api \
  --resource-group myResourceGroup \
  --plan myAppServicePlan \
  --deployment-container-image-name mcr.microsoft.com/azure-databases/data-api-builder:latest
```

Set environment variables through App Service configuration:

```bash
az webapp config appsettings set \
  --name dab-api \
  --resource-group myResourceGroup \
  --settings DATABASE_CONNECTION_STRING="@Microsoft.KeyVault(SecretUri=https://myvault.vault.azure.net/secrets/db-connection)"
```

The Key Vault reference syntax lets App Service pull secrets at runtime without exposing them in configuration. Enable system-assigned managed identity on the App Service and grant it access to Key Vault.

## Deploy to Azure Static Web Apps

[Azure Static Web Apps](/azure/static-web-apps/overview?azure-portal=true) includes Data API Builder as a built-in feature called database connections. This integration provides the simplest deployment experience when your API complements a static frontend.

Link your database through the Azure portal or CLI:

```bash
az staticwebapp dbconnection create \
  --name myStaticWebApp \
  --resource-group myResourceGroup \
  --db-type mssql \
  --db-resource-id /subscriptions/.../servers/myserver/databases/mydb
```

The `staticwebapps.database.config.json` file in your repository defines entity configurations using the same structure as standalone DAB:

```json
{
  "data-source": {
    "database-type": "mssql"
  },
  "entities": {
    "Product": {
      "source": "dbo.Products",
      "permissions": [
        { "role": "anonymous", "actions": ["read"] }
      ]
    }
  }
}
```

Static Web Apps automatically handles authentication integration with its built-in auth providers. API routes appear under `/.auth/` and `/data-api/` paths by default.

> [!NOTE]
> Database connections in Static Web Apps have some limitations compared to standalone DAB, including restricted stored procedure support. Review the documentation for current feature availability.

## Implement CI/CD deployment pipelines

Automated deployment pipelines ensure consistent configuration across environments and enable rapid iteration. GitHub Actions provides a straightforward approach for DAB deployments.

Create a workflow file at `.github/workflows/deploy-dab.yml`:

```yaml
name: Deploy Data API Builder

on:
  push:
    branches: [main]
    paths:
      - 'dab-config*.json'
      - 'Dockerfile'

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Login to Azure Container Registry
        uses: azure/docker-login@v1
        with:
          login-server: ${{ secrets.ACR_LOGIN_SERVER }}
          username: ${{ secrets.ACR_USERNAME }}
          password: ${{ secrets.ACR_PASSWORD }}
      
      - name: Build and push container
        run: |
          docker build -t ${{ secrets.ACR_LOGIN_SERVER }}/dab-api:${{ github.sha }} .
          docker push ${{ secrets.ACR_LOGIN_SERVER }}/dab-api:${{ github.sha }}
      
      - name: Deploy to Container Apps
        uses: azure/container-apps-deploy-action@v1
        with:
          resourceGroup: myResourceGroup
          containerAppName: dab-api
          imageToDeploy: ${{ secrets.ACR_LOGIN_SERVER }}/dab-api:${{ github.sha }}
```

This workflow triggers on changes to configuration files or the Dockerfile. It builds a new container image, pushes it to Azure Container Registry, and updates the Container App.

## Configure environment-specific deployments

Production deployments require careful separation between environments. Use environment-specific configuration files combined with deployment variables.

Structure your repository with multiple configuration files:

```
/
├── dab-config.json           # Base configuration (shared settings)
├── dab-config.development.json
├── dab-config.staging.json
├── dab-config.production.json
└── Dockerfile
```

Modify your Dockerfile to accept a build argument:

```dockerfile
FROM mcr.microsoft.com/azure-databases/data-api-builder:latest

ARG ENVIRONMENT=production
COPY dab-config.json /App/dab-config.json
COPY dab-config.${ENVIRONMENT}.json /App/dab-config.${ENVIRONMENT}.json

ENV DAB_ENVIRONMENT=${ENVIRONMENT}
```

Build environment-specific images:

```bash
docker build --build-arg ENVIRONMENT=production -t dab-api:production .
```

> [!IMPORTANT]
> Never include actual connection strings or secrets in configuration files committed to source control. Use environment variable references (`@env()`) and manage secrets through Azure Key Vault or your deployment pipeline's secret management.

## Monitor deployment health

After deployment, configure health checks to verify DAB is operating correctly. Container Apps and App Service support health probes:

```json
{
  "probes": [
    {
      "type": "liveness",
      "httpGet": {
        "path": "/",
        "port": 5000
      },
      "periodSeconds": 30
    },
    {
      "type": "readiness",
      "httpGet": {
        "path": "/api/Product?$first=1",
        "port": 5000
      },
      "periodSeconds": 10
    }
  ]
}
```

The liveness probe checks that DAB is responding. The readiness probe verifies database connectivity by making an actual API request. Configure your orchestration platform to restart unhealthy instances automatically.
