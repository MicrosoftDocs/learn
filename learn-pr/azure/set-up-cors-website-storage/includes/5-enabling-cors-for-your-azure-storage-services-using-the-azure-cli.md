Enabling CORS for your Storage Services will provide a secure way of external HTTP calls accessing your Azure Storage Services resources, and the Azure Command Line Interface (CLI) provides support for managing your CORS configuration.

In the utilities company scenario, it might not always appropriate to use the REST API to configure CORS, so your team has asked you to investigate how to use the Azure CLI to perform this task.

In this unit, you'll learn how to use the Azure CLI to enable CORS for Azure storage.

## Enable CORS using the Azure CLI 

Use the `az storage cors add` Azure CLI command to enable CORS for an Azure storage service. The syntax for this command is:

```azurecli
az storage cors add
   --methods {DELETE, GET, HEAD, MERGE, OPTIONS, POST, PUT}
   --origins
   --services
   [--account-key]
   [--account-name]
   [--allowed-headers]
   [--connection-string]
   [--exposed-headers]
   [--max-age]
   [--sas-token]
   [--subscription]
   [--timeout]
```

The parameters for this command are:

| Parameter | Necessity | Description |
|---|---|---|
| `--methods` | **Required** | Specifies a space-separated list of HTTP methods allowed to be executed by the origin; the supported methods are: DELETE, GET, HEAD, MERGE, OPTIONS, POST, and PUT. |
| `--origins` | **Required** | Specifies a space-separated list of the origin domains that will be allowed via CORS, or you can specify '*' to allow all domains. |
| `--services` | **Required** | Specifies one or more storage services to configure from the following options: <table><tr><th>Option</th><th>Service</th></tr><tr><th>b</th><td>Blob</td></tr><tr><th>f</th><td>File</td></tr><tr><th>q</th><td>Queue</td></tr><tr><th>t</th><td>Table</td></tr></table> |
| `--account-key` | *Optional* | Specifies the storage account key; this parameter is required if you specify the `--account-name` parameter. <sup>[See the **Note** below]</sup> |
| `--account-name` | *Optional* | Specifies the storage account name; this parameter is required if you specify the `--account-key` parameter. <sup>[See the **Note** below]</sup> |
| `--connection-string` | *Optional* | Specifies the storage account connection string; you can use this parameter instead of the `--account-key` and `--account-name` parameters. |
| `--allowed-headers` | *Optional* | Specifies a space-separated list of response headers that are allowed as part of the cross-origin request. |
| `--exposed-headers` | *Optional* | Specifies a space-separated list of response headers to expose to CORS clients. |
| `--max-age` | *Optional* | Specifies the maximum number of seconds the client/browser should cache a preflight response. |

> [!NOTE]
> If you don't specify the account key and account name parameters, the Azure CLI will attempt to use the current authenticated Azure account.

The following example enables CORS for HTTP GET requests to your Blob storage account from the *www.contoso.com* domain.

```azurecli
az storage cors add --account-name wingtiptoys  --account-key AbCdEfGhIjKlMnOpQrStUvWxYz --origins 'www.contoso.com' --methods GET --max-age 200 --services b
```

## Clear CORS rules using the Azure CLI 

You can use the `az storage cors clear` command to remove all of your CORS rules for an Azure storage service. The syntax for this command is:

```azurecli
az storage cors clear
    --services
    --timeout
    --account-key
    --account-name
    --connection-string
    --sas-token
```

The parameters for this command are:

| Parameter | Necessity | Description |
|---|---|---|
| `--services` | **Required** | Specifies one or more storage services to configure from the following options: <table><tr><th>Option</th><th>Service</th></tr><tr><th>b</th><td>Blob</td></tr><tr><th>f</th><td>File</td></tr><tr><th>q</th><td>Queue</td></tr><tr><th>t</th><td>Table</td></tr></table> |
| `--timeout` | *Optional* | Specifies the request timeout in seconds; this applies to each call to the service. |
| `--account-key` | *Optional* | Specifies the storage account key; this parameter is required if you specify the `--account-name` parameter. |
| `--account-name` | *Optional* | Specifies the storage account name; this parameter is required if you specify the `--account-key` parameter. |
| `--connection-string` | *Optional* | Specifies the storage account connection string; you can use this parameter instead of the `--account-key` and `--account-name` parameters. |
| `--sas-token` | *Optional* | Specifies a Shared Access Signature; this parameter must be used with the `--account-name` parameter. |
