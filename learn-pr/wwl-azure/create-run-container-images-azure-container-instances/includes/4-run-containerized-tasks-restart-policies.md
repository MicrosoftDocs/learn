The ease and speed of deploying containers in Azure Container Instances provides a compelling platform for executing run-once tasks like build, test, and image rendering in a container instance.

With a configurable restart policy, you can specify that your containers are stopped when their processes are completed. Because container instances are billed by the second, you're charged only for the compute resources used while the container executing your task is running.

## Container restart policy

When you create a container group in Azure Container Instances, you can specify one of three restart policy settings.

Restart policy | Description 
- | -
`Always` | Containers in the container group are always restarted. This is the **default** setting applied when no restart policy is specified at container creation.
`Never` | Containers in the container group are never restarted. The containers run at most once.
`OnFailure` | Containers in the container group are restarted only when the process executed in the container fails (when it terminates with a nonzero exit code). The containers are run at least once.

## Specify a restart policy

Specify the `--restart-policy` parameter when you call `az container create`.

```bash
az container create \
    --resource-group myResourceGroup \
    --name mycontainer \
    --image mycontainerimage \
    --restart-policy OnFailure
```

## Run to completion

Azure Container Instances starts the container, and then stops it when its application, or script,  exits. When Azure Container Instances stops a container whose restart policy is `Never` or `OnFailure`, the container's status is set to **Terminated**.
