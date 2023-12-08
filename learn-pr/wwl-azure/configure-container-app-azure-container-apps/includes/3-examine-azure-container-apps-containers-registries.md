Azure Container Apps manages the details of Kubernetes and container orchestration for you. Containers in Azure Container Apps can use the runtime, programming language, or development stack of your choice.

![Screenshot showing how containers for container app instances are grouped together in pods inside revision snapshots.](../media/azure-container-apps-containers.png)

Azure Container Apps supports:

- Any Linux-based x86-64 (linux/amd64) container image with no required base image

- Containers from any public or private container registry

- Sidecar and init containers

Features also include:

- Changes to the template configuration section trigger a new container app revision.

- If a container crashes, it automatically restarts.

Jobs features include:

- Job executions use the template configuration section to define the container image and other settings when each execution starts.

- If a container exits with a non-zero exit code, the job execution is marked as failed. You can configure a job to retry failed executions.

> [!NOTE]
> In Azure Container Apps, a revision is a snapshot of your container app. Multiple revisions can be used to represent different versions of your container app.

## Configuration

The following code is an example of the containers array in the properties.template section of a container app resource template. The excerpt shows the available configuration options when setting up a container.

```json
{
  "properties": {
    "template": {
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
              "mountPath": "/appsettings",
              "volumeName": "appsettings-volume"
            }
          ],
          "probes": [
            {
              "type": "liveness",
              "httpGet": {
                "path": "/health",
                "port": 8080,
                "httpHeaders": [
                  {
                    "name": "Custom-Header",
                    "value": "liveness probe"
                  }
                ]
              },
              "initialDelaySeconds": 7,
              "periodSeconds": 3
            },
            {
              "type": "readiness",
              "tcpSocket": {
                "port": 8081
              },
              "initialDelaySeconds": 10,
              "periodSeconds": 3
            },
            {
              "type": "startup",
              "httpGet": {
                "path": "/startup",
                "port": 8080,
                "httpHeaders": [
                  {
                    "name": "Custom-Header",
                    "value": "startup probe"
                  }
                ]
              },
              "initialDelaySeconds": 3,
              "periodSeconds": 3
            }
          ]
        }
      ]
    },
    "initContainers": [
      {
        "name": "init",
        "image": "[parameters('init_container_image')]",
        "resources": {
          "cpu": 0.25,
          "memory": "0.5Gi"
        },
        "volumeMounts": [
          {
            "mountPath": "/appsettings",
            "volumeName": "appsettings-volume"
          }
        ]
      }
    ]
    ...
  }
  ...
}
```

| Setting | Description | Remarks |
| --- | --- | --- |
| image | The container image name for your container app. | This value takes the form of `repository/<IMAGE_NAME>:<TAG>`. |
| name | Friendly name of the container. | Used for reporting and identification. |
| command | The container's startup command. | Equivalent to Docker's entrypoint field. |
| args | Start up command arguments. | Entries in the array are joined together to create a parameter list to pass to the startup command. |
| env | An array of key/value pairs that define environment variables. | Use secretRef instead of the value field to refer to a secret. |
| resources.cpu | The number of CPUs allocated to the container. | With the Consumption plan, values must adhere to the following rules:<br><br>• greater than zero<br>• less than or equal to 2<br>• can be any decimal number (with a max of two decimal places)<br><br>For example, `1.25` is valid, but `1.555` is invalid.<br>The default is 0.25 CPUs per container.<br><br>When you use the Consumption workload profile on the Dedicated plan, the same rules apply, except CPUs must be less than or equal to 4.<br><br>When you use the Dedicated plan, the maximum CPUs must be less than or equal to the number of cores available in the profile where the container app is running. |
| resources.memory | The amount of RAM allocated to the container. | With the Consumption plan, values must adhere to the following rules:<br><br>• greater than zero<br>• less than or equal to `4Gi`<br>• can be any decimal number (with a max of two decimal places)<br><br>For example, `1.25Gi` is valid, but `1.555Gi` is invalid.<br>The default is `0.5Gi` per container.<br><br>When you use the the Consumption workload on the Dedicated plan, the same rules apply except memory must be less than or equal to `8Gi`.<br><br>When you use the Dedicated plan, the maximum memory must be less than or equal to the amount of memory available in the profile where the container app is running. |
| volumeMounts | An array of volume mount definitions. | You can define a temporary volume or multiple permanent storage volumes for your container. |
| probes | An array of health probes enabled in the container. | This feature is based on Kubernetes health probes. |

## Multiple containers

In advanced scenarios, you can run multiple containers in a single container app. Use this pattern only in specific instances where your containers are tightly coupled.

For most microservice scenarios, the best practice is to deploy each service as a separate container app.

The multiple containers in the same container app share hard disk and network resources and experience the same application lifecycle.

There are two ways to run multiple containers in a container app: sidecar containers and init containers.

### Sidecar containers

You can define multiple containers in a single container app to implement the sidecar pattern.

Examples of sidecar containers include:

- An agent that reads logs from the primary app container on a shared volume and forwards them to a logging service.

- A background process that refreshes a cache used by the primary app container in a shared volume.

These scenarios are examples, and don't represent the only ways you can implement a sidecar.

To run multiple containers in a container app, add more than one container in the containers array of the container app template.

### Init containers

You can define one or more init containers in a container app. Init containers run before the primary app container and are used to perform initialization tasks such as downloading data or preparing the environment.

Init containers are defined in the initContainers array of the container app template. The containers run in the order they're defined in the array and must complete successfully before the primary app container starts.

> [!NOTE]
> Init containers support image pulls using managed identities, but processes running in init containers don't have access to managed identities.

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

Saved credentials are used to pull a container image from the private registry as your app is deployed.

The following example shows how to configure Azure Container Registry credentials in a container app.

```json
{
  ...
  "configuration": {
    "secrets": [
      {
        "name": "acr-password",
        "value": "my-acr-password"
      }
    ],
    ...
    "registries": [
      {
        "server": "myacr.azurecr.io",
        "username": "someuser",
        "passwordSecretRef": "acr-password"
      }
    ]
  }
}
```

> [!NOTE]
> Docker Hub limits the number of Docker image downloads. When the limit is reached, containers in your app will fail to start. Use a registry with sufficient limits, such as Azure Container Registry to avoid this problem.
