So, we've talked a lot about governance elements and the need to move out of configuration files.

Let us now use some of the magic available in Kubernetes and Azure Key Vault to implement it.

In particular, we would be using the following capabilities of these technologies:

 -  Azure Key Vault Secret store.
 -  Kubernetes ConfigMaps.
 -  Kubernetes Secrets.

## Why not just use Kubernetes, you may ask?

It's a valid question since Kubernetes supports both a ConfigMap store and a Secret Store.

Remember our principle around the separation of concerns. Ensure enhanced security by separating configuration from secrets.

Having secrets in the same cluster as the configuration store can make them prone to higher risks. Another benefit is Maintainability.

Azure Key Vault gives the ability to provide a distributed “Secure Store as a Service” option that provides not just secret management but also Certificates and Key management as part of the service.

The SecOps engineers can lock down access to the store without the need for cluster admin's permissions. It allows for a clear delineation of responsibilities and access.

## The scenario

We'll be building a Vehicle microservice that provides CRUD operations for sending vehicle data to a CosmosDB document store.

The sample micro-service needs to interact with the Configuration stores to get connection string, database name, collection name, and so on.

We interact with Azure Key Vault for this purpose.

Additionally, the application needs the Authentication token for Azure Key Vault itself. These details, along with other Configuration, will be stored in Kubernetes.

## Responsibilities

The Ops Engineer/scripts are the Configuration Custodian, and they're the only ones who work in the outer loop to manage all the configuration.

CI/CD scripts would inject these configurations or use popular framework tools to enable the insertion during the build process.

## Integration

The Vehicle API is the [ASP.NET](http://asp.net/) Core 2.0 application and is the Configuration Consumer here.

The consumer is interested in getting the values without worrying about the value and which environment it belongs to.

The [ASP.NET](http://asp.net/) Core framework provides excellent support for it through its Configuration extensibility support.

You can add as many providers as you like. They can be bound to an IConfiguration object, which provides access to all the configurations.

In the following code snippet, we provide the configuration to be picked up from environment variables instead of a configuration file.

The [ASP.NET](http://asp.net/) Core 2.0 framework also supports extensions to include Azure Key Vault as a configuration provider.

Under the hood, the Azure Key Vault client allows for secure access to the values required by the application.

```
// add the environment variables to config.
  config.AddEnvironmentVariables();

// add Azure Key Vault configuration-using environment variables.
var buildConfig = config.Build();

// get the Key Vault  URI.
var vaultUri = buildConfig["kvuri"].Replace("{vault-name}",  buildConfig["vault"]);
// set up KeyVault store for getting configuration values
config.AddAzureKeyVault(vaultUri, buildConfig["clientId"], buildConfig["clientSecret"]);

```

AzureKeyVault is the Secret Store for all the secrets that are application-specific.

It allows for the creation of these secrets and also managing the lifecycle of them.

It's recommended that you have a separate Azure KeyVault per environment to ensure isolation.

The following command can be used to add a new configuration into KeyVault:

```
#Get a list of existing secrets
az keyvault secret list --vault-name  -o table

#add a new secret to keyvault
az keyvault secret set -n MySecret --value MyValue --description "my custom value" --vault-name


```

Kubernetes is the Configuration Store and serves multiple purposes here:

 -  Creation of the ConfigMaps and Secret: Since we inject the Azure KeyVault authentication information-using Kubernetes, the Ops engineer will provide these values using two constructs provided in the Kubernetes infrastructure. ConfigMaps and Secrets. The following example shows how to add config maps and secrets from the Kubernetes command line:

```
kubectl create configmap vault --from-literal=vault=
kubectl create configmap kvuri --from-literal=kvuri=https://{vault-name}.vault.azure.net/
kubectl create configmap clientid --from-literal=clientId=
kubectl create secret generic clientsecret --from-literal=clientSecret=


```

The clientsecret is the only piece of secure information we store in Kubernetes; all the application-specific secrets are stored in Azure KeyVault.

It's comparatively safer since the above scripts don't need to go in the same git repo.

So we don't check them in by mistake and can be managed separately.

We still control the expiry of this secret-using Azure KeyVault, so the Security engineer still has full control over access and permissions.

 -  Injecting Values into the Container: During runtime, Kubernetes will automatically push the above values as environment variables for the deployed containers, so the system doesn't need to worry about loading them from a configuration file. The Kubernetes configuration for the deployment looks like the following example. As you would notice, we only provide a reference to the ConfigMaps and Secret created instead of punching in the actual values.

```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: vehicle-api-deploy #name for the deployment
  labels:
    app: vehicle-api #label that will be used to map the service, this tag is important
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vehicle-api #label that will be used to map the service, this tag is important
  template:
    metadata:
      labels:
        app: vehicle-api #label that will be used to map the service, this tag is important
    spec:
      containers:

      - name: vehicleapi #name for the container configuration
        image: <yourdockerhub>/<youdockerimage>:<youdockertagversion> # **CHANGE THIS: the tag for the container to be deployed
        imagePullPolicy: Always #getting latest image on each deployment
        ports:

        - containerPort: 80 #map to port 80 in the docker container
        env: #set environment variables for the docker container-using configMaps and Secret Keys

        - name: clientId
          valueFrom:
            configMapKeyRef:
              name: clientid
              key: clientId

        - name: kvuri
          valueFrom:
            configMapKeyRef:
              name: kvuri
              key: kvuri

        - name: vault
          valueFrom:
            configMapKeyRef:
              name: vault
              key: vault

        - name: clientsecret
          valueFrom:
            secretKeyRef:
              name: clientsecret
              key: clientSecret
      imagePullSecrets: #secret to get details of private repo, disable it if using public docker repo.

      - name: regsecret

```
