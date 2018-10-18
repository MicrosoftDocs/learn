The ease and speed of deploying containers in Azure Container Instances makes it a great fit for executing run-once tasks like image rendering or building and testing applications.

With a configurable restart policy, you can specify that your containers are stopped when their processes have completed. Because container instances are billed by the second, you're charged only for the compute resources used while the container executing your task is running.

## What are container restart policies?

Azure Container Instances has three restart-policy options:

| Restart policy   | Description |
| ---------------- | :---------- |
| **Always** | Containers in the container group are always restarted. This policy makes sense for long-running tasks such as a web server. This is the **default** setting applied when no restart policy is specified at container creation. |
| **Never** | Containers in the container group are never restarted. The containers run one time only. |
| **OnFailure** | Containers in the container group are restarted only when the process executed in the container fails (when it terminates with a nonzero exit code). The containers are run at least once. This policy works well for containers that run short-lived tasks. |

## Run a container to completion

To see the restart policy in action, create a container instance from the **microsoft/aci-wordcount** Docker image and specify the **OnFailure** restart policy. This container runs a Python script that analyzes the text of Shakespeare's Hamlet, writes the 10 most common words to standard output, and then exits.

1. Run this `az container create` command to start the container.

    ```azurecli
    az container create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name mycontainer-restart-demo \
      --image microsoft/aci-wordcount:latest \
      --restart-policy OnFailure \
      --location eastus
    ```

    Azure Container Instances starts the container and then stops it when its process (a script, in this case) exits. When Azure Container Instances stops a container whose restart policy is **Never** or **OnFailure**, the container's status is set to **Terminated**.

1. Run `az container show` to check your container's status.

    ```azurecli
    az container show \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name mycontainer-restart-demo \
      --query containers[0].instanceView.currentState.state
    ```

    Repeat the command until it reaches the **Terminated** status.

1. View the container's logs to examine the output. To do so, run `az container logs` like this.

    ```azurecli
    az container logs \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name mycontainer-restart-demo
    ```

    You see this.

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