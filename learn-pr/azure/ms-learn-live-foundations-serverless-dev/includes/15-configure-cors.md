## 💻 Exercise - Configure CORS

CORS is short for “Cross Origin Resource Sharing”. It’s a SECURITY mechanism employed by browsers to prevent them making calls to another website. CORS is implemented via an HTTP response header to specify which domains, ports and protocols can access its resources. 

## Objective

- Configure CORS to enable to client application to communicate with the API

## Instructions

For local development you can confifure CORS to "*" which allows all origins to call into the API.
For the solution deployed to Azure a more restrictive setting is recommended.

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
- Add a setting of "*" if you want all clients to be able use the API or enter the host of the client you'd like to allow.
