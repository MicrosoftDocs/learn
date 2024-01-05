


Azure Container Apps manages the details of Kubernetes and container orchestration for you. Containers in Azure Container Apps can use any runtime, programming language, or development stack of your choice.

:::image type="content" source="../media/azure-container-apps-containers.png" alt-text="Diagram showing how containers for an Azure Container App are grouped together in pods inside revision snapshots.":::

Azure Container Apps supports any Linux-based x86-64 (`linux/amd64`) container image. There's no required base container image, and if a container crashes it automatically restarts. 

## Configuration

The following code is an example of the `containers` array in the `properties.template` section of a container app resource template. The excerpt shows some of the available configuration options when setting up a container when using Azure Resource Manager (ARM) templates. Changes to the template ARM configuration section trigger a new container app revision.

```json
"containers": [
  {
       "name": "main",
       "image": "[parameters('container_image')]",
    "env": [
      {
        "name": "HTTP_PORT",
        "value": "80"
      },
      {
        "name": "SECRET_VAL",
        "secretRef": "mysecret"
      }
    ],
    "resources": {
      "cpu": 0.5,
      "memory": "1Gi"
    },
    "volumeMounts": [
      {
        "mountPath": "/myfiles",
        "volumeName": "azure-files-volume"
      }
    ]
    "probes":[
        {
            "type":"liveness",
            "httpGet":{
            "path":"/health",
            "port":8080,
            "httpHeaders":[
                {
                    "name":"Custom-Header",
                    "value":"liveness probe"
                }]
            },
            "initialDelaySeconds":7,
            "periodSeconds":3
// file is truncated for brevity
```

## Multiple containers

You can define multiple containers in a single container app to implement the [sidecar pattern](/azure/architecture/patterns/sidecar). The containers in a container app share hard disk and network resources and experience the same application lifecycle.

Examples of sidecar containers include:

* An agent that reads logs from the primary app container on a shared volume and forwards them to a logging service.
* A background process that refreshes a cache used by the primary app container in a shared volume.
 
> [!NOTE]
> Running multiple containers in a single container app is an advanced use case. In most situations where you want to run multiple containers, such as when implementing a microservice architecture, deploy each service as a separate container app.

To run multiple containers in a container app, add more than one container in the containers array of the container app template.

## Container registries

You can deploy images hosted on private registries by providing credentials in the Container Apps configuration.

To use a container registry, you define the required fields in registries array in the properties.configuration section of the container app resource template. The passwordSecretRef field identifies the name of the secret in the secrets array name where you defined the password.

```json
{
  ...
  "registries": [{
    "server": "docker.io",
    "username": "my-registry-user-name",
    "passwordSecretRef": "my-password-secret-name"
  }]
}
```

With the registry information added, the saved credentials can be used to pull a container image from the private registry when your app is deployed.

## Limitations

Azure Container Apps has the following limitations:

* **Privileged containers**: Azure Container Apps can't run privileged containers. If your program attempts to run a process that requires root access, the application inside the container experiences a runtime error.
* **Operating system**: Linux-based (`linux/amd64`) container images are required.
