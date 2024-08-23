In this exercise, you'll deploy a scale object custom resource definition (CRD) into your AKS cluster. The scaler object contains the trigger that connects your deployed application to KEDA. After deploying to AKS, KEDA monitors the Redis List and scales up if the list length exceeds the defined threshold and scales down if the list length falls below the defined threshold.

## `ScaledObject` manifest overview

* `scaleTargetRef`: This section describes which workload KEDA observes.

    ```yaml
      scaleTargetRef:
        apiVersion: apps/v1                           # Optional. Default: apps/v1
        kind: deployment                              # Optional. Default: Deployment
        name: contoso-microservice                    # Mandatory. Must be in the same namespace as the ScaledObject
        envSourceContainerName: contoso-microservice  # Optional. Default: .spec.template.spec.containers[0]
    ```

* `minReplicaCount` and `maxReplicaCount`: These attributes determine the range of replicas KEDA uses for scaling. In this case, you instruct KEDA to scale from a minimum of zero to a max of 20.

    ```yaml
      minReplicaCount: 0            # Optional. Default: 0
      maxReplicaCount: 20           # Optional. Default: 100
    ```

    > [!NOTE]
    > `minReplicaCount: 0` takes the Deployment default replica count from one to zero. This occurs if the service is idle and not processing any events. In this case, if there are no items in the Redis List, and the service remains idle, KEDA scales to zero.

* `advanced`: This section is related to advanced customizations of KEDA. The `restoreToOriginalReplicaCount` instructs KEDA to return the replica count to the original value after scale-up events. In this case, you set it to `false`, which causes a scale down to the `minReplicaCount` value of zero.

    ```yaml
      restoreToOriginalReplicaCount: false        # Optional. Default: false
      horizontalPodAutoscalerConfig:              # Optional. Section to specify HPA related options
        behavior:                                 # Optional. Use to modify HPA's scaling behavior
          scaleDown:
            stabilizationWindowSeconds: 300
            policies:
            - type: Percent
              value: 100
              periodSeconds: 15
    ```

* `triggers`: This section uses `scalers` to detect if the object should be activated or deactivated and feed custom metrics for specific event sources. The `listLength` metric instructs KEDA to scale up when there are ten items in the list.

    ```yaml
      triggers:
      - type: redis
        metadata:
          # address:                  # Format must be host:port
          passwordFromEnv: REDIS_KEY
          listName: keda              # Required
          listLength: "10"            # Required
          enableTLS: "false"          # optional
          databaseIndex: "0"          # optional
          hostFromEnv: REDIS_HOST
          portFromEnv: REDIS_PORT
    ```

For more information, see [KEDA Scalers](https://keda.sh/docs/2.2/scalers/).

## Create the `ScaledObject` manifest

1. In Cloud Shell, create a manifest file for the Kubernetes Deployment called `scaled-object.yaml` using the `touch` command:

    ```azurecli-interactive
    touch scaled-object.yaml
    ```

2. Open the integrated editor in Cloud Shell by entering `code .`

3. Open the `scaled-object.yaml` file and add the following code section of YAML:

    ```yaml
    apiVersion: keda.sh/v1alpha1
    kind: ScaledObject
    metadata:
      name: scaled-contoso
    spec:
      scaleTargetRef:
        apiVersion: apps/v1                             # Optional. Default: apps/v1
        kind: deployment                                # Optional. Default: Deployment
        name: contoso-microservice                      # Mandatory. Must be in the same namespace as the ScaledObject
        envSourceContainerName: contoso-microservice    # Optional. Default: .spec.template.spec.containers[0]
      pollingInterval: 30                               # Optional. Default: 30 seconds
      cooldownPeriod:  120                              # Optional. Default: 300 seconds
      minReplicaCount: 0                                # Optional. Default: 0
      maxReplicaCount: 20                               # Optional. Default: 100
      advanced:                                         # Optional. Section to specify advanced options
        restoreToOriginalReplicaCount: false            # Optional. Default: false
        horizontalPodAutoscalerConfig:                  # Optional. Section to specify HPA related options
          behavior:                                     # Optional. Use to modify HPA's scaling behavior
            scaleDown:
              stabilizationWindowSeconds: 300
              policies:
              - type: Percent
                value: 100
                periodSeconds: 15
      triggers:
      - type: redis
        metadata:
          # address:                  # Format must be host:port
          passwordFromEnv: REDIS_KEY
          listName: keda              # Required
          listLength: "10"            # Required
          enableTLS: "false"          # optional
          databaseIndex: "0"          # optional
          hostFromEnv: REDIS_HOST
          portFromEnv: REDIS_PORT
    ```

4. Save the manifest file (<kbd>CTRL + S</kbd>) and close the editor(<kbd>CTRL + Q</kbd>).

## Apply the manifest

1. Deploy the manifest to your cluster using the `kubectl apply` command:

      ```azurecli-interactive
      kubectl apply -f ./scaled-object.yaml
      ```

      Your output should look similar to the following example output:

      ```output
      scaledobject.keda.sh/scaled-contoso created
      ```

2. Check the number of running pods using the `kubectl get pods` command:

      ```azurecli-interactive
      kubectl get pods
      ```

    Your output should look similar to the following example output, with one pod running:

      ```output
      NAME                                  READY   STATUS    RESTARTS   AGE
      contoso-microservice-794d98b5-4flvg   1/1     Running   0          2m1s
      ```

3. Periodically run the `kubectl get pods` command to verify the Deployment is scaling the number of pods according to the backlog of work.

    > [!NOTE]
    > If you have the Linux utility watch installed, you can use the `watch kubectl get pods` command to see the pods scale to process the Redis list items. If not, you can use the `kubectl get pods -w` command.

    Your output should look similar to the following example output:

    ```output
      NAME                                  READY   STATUS    RESTARTS   AGE
      contoso-microservice-794d98b5-4flvg   1/1     Running   0          3m
      contoso-microservice-794d98b5-4jpxp   1/1     Running   0          3m
      contoso-microservice-794d98b5-4lw7b   1/1     Running   0          2m15s
      contoso-microservice-794d98b5-5fqj5   1/1     Running   0          3m
      contoso-microservice-794d98b5-5kdbw   1/1     Running   0          2m15s
    ```

After all the items are processed and the `cooldownPeriod` expires, you'll see that the number of pods is *zero*. This is because KEDA removed all running replicas and has no items left to process.
