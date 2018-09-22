The ease and speed of deploying containers in Azure Container Instances makes it a great fit for executing run-once tasks like build, test, and image rendering.

With a configurable restart policy, you can specify that your containers are stopped when their processes have completed. Because container instances are billed by the second, you're charged only for the compute resources used while the container executing your task is running.

## Container restart policies

Azure Container Instances has three restart-policy options:

| Restart policy   | Description |
| ---------------- | :---------- |
| `Always` | Containers in the container group are always restarted. This policy makes sense for long-running tasks such as a web server. This is the **default** setting applied when no restart policy is specified at container creation. |
| `Never` | Containers in the container group are never restarted. The containers run at most once. |
| `OnFailure` | Containers in the container group are restarted only when the process executed in the container fails (when it terminates with a nonzero exit code). The containers are run at least once. This policy works well for containers that run short-lived tasks. |

## Run to completion

To see the restart policy in action, create a container instance from the *microsoft/aci-wordcount* image and specify the *OnFailure* restart policy. This example container runs a Python script that analyzes the text of Shakespeare's Hamlet, writes the 10 most common words to STDOUT, and then exits.

Run the example container with the following `az container create` command:

```azurecli
az container create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name mycontainer-restart-demo \
    --image microsoft/aci-wordcount:latest \
    --restart-policy OnFailure \
    --location eastus
```

Azure Container Instances starts the container then stops it when its application (or script, in this case) exits. When Azure Container Instances stops a container whose restart policy is *Never* or *OnFailure*, the container's status is set to **Terminated**.

You can check a container's status with the `az container show` command:

```azurecli
az container show \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name mycontainer-restart-demo \
    --query containers[0].instanceView.currentState.state
```

Once the example container's status shows **Terminated**, you can see its task output by viewing the container logs. Run the `az container logs` command to view the script's output:

```azurecli
az container logs \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name mycontainer-restart-demo
```

Output:

```json
[('the', 990),
 ('and', 702),
 ('of', 628),
 ('to', 610),
 ('I', 544),
 ('you', 495),
 ('a', 453),
 ('my', 441),
 ('in', 399),
 ('HAMLET', 386)]
```