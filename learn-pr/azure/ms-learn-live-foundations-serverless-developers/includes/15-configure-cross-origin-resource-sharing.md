CORS is short for "Cross Origin Resource Sharing". It's a SECURITY mechanism employed by browsers to prevent them making calls to another website. CORS is implemented via an HTTP response header to specify which domains, ports, and protocols can access its resources. 

## Objective

- Configure CORS to enable the client application to communicate with the API

## Instructions

For local development, you can configure CORS to "*" which allows all origins to call into the API.
For the solution deployed to Azure, a more restrictive setting is recommended.

### Configure locally

Open the projects `local.settings.json` file and add:

```json
"Host": {
 "CORS": "*"
}
```

### Configure on Azure

- Open the functions app in Azure portal
- From the side menu select "CORS"
- Tick the checkbox to enable CORS
- Add a setting of "*" if you want to allow any client to use the API, or enter the hostname of a specific client.