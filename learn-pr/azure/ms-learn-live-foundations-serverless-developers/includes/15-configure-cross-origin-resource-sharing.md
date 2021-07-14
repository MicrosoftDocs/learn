Cross Origin Resource Sharing (CORS) is a security mechanism employed by browsers to prevent them from making calls to another website. CORS is implemented via an HTTP response header to specify which domains, ports, and protocols can access its resources.

## Objective

- Configure CORS to enable the client application to communicate with the API.

## Instructions

For local development, you can configure CORS to "*" which allows all origins to call into the API. For the solution deployed to Azure, we recommend a more restrictive setting.

### Configure CORS locally

Open the projects `local.settings.json` file and add:

```json
"Host": {
 "CORS": "*"
}
```

### Configure CORS on Azure

To configure CORS on Azure:

1. Open the functions app in Azure portal.

1. From the left menu pane, select **CORS**.

1. Tick the checkbox to enable CORS.

1. Add a setting of "*" if you want to allow any client to use the API, or enter the hostname of a specific client.