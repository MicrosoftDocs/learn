In this exercise, you'll deploy the scaling object custom resource definition (CRD) into Azure Kubernetes Service (AKS). The scaling object contains the trigger that connects the deployed app from the previous exercise to KEDA. After deploying to AKS, KEDA will monitor the Redis list and scale up if the list length exceeds the defined threshold and scale down if the list length falls below it.

## Create the ScaledObject with a Redis trigger

This is where we will see what KEDA can do.  We will create a `ScaledObject` to scale based on the number of items in Redis list.  Before we apply the manifest, let's dissect the key sections of the spec.

1. `scaleTargetRef` - this section describes which workload KEDA observes. In our Deployment manifest from above we use the following values to tie the scaled object to the Deployment.

    ```yaml
      scaleTargetRef:
        apiVersion: apps/v1                           # Optional. Default: apps/v1
        kind: deployment                              # Optional. Default: Deployment
        name: contoso-microservice                    # Mandatory. Must be in the same namespace as the ScaledObject
        envSourceContainerName: contoso-microservice  # Optional. Default: .spec.template.spec.containers[0]
    ```

2. `minReplicaCount` and `maxReplicaCount` - these two attributes determine the range of replicas KEDA uses for scaling.  In our case, we instruct KEDA to scale from a minimum of zero with a max of twenty.

    ```yaml
      minReplicaCount: 0            # Optional. Default: 0
      maxReplicaCount: 20           # Optional. Default: 100
    ```

    > [!NOTE]
    > `minReplicaCount: 0` will take our Deployment default replica count from one to zero.  This will occur if the service is idle and not processing any events.  In this exercise, if there are no items in the Redis list, and the service remains idle, KEDA will scale to zero.

3. `advanced` - this section is generally related to advanced customization of KEDA. The `restoreToOriginalReplicaCount` instructs KEDA that after any scaling up scenarios, KEDA will return replica count to the original value.  In the case of our example, we set it to `false`, thus we do not return the original value of one, but scale down to the `minReplicaCount` value of zero.

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

4. `triggers` - this section uses `scalers` to detect if the object should be activated or deactivated, and feed custom metrics for a specific event source.  For our example, we use the Redis `scaler` to connect the Redis instance and to the Redis list.  The important metric in this `scaler` is `listLength`.  This instructs KEDA to scale up when there are ten items in the list.

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

  For detailed information on available `scalers` see the documentation at the [KEDA site](https://keda.sh/docs/2.2/scalers/).

### Deploying the manifest

1. In Cloud Shell, create a manifest file for the Kubernetes Deployment called `scaled-object.yaml` by using the integrated editor.

      ```bash
      touch scaled-object.yaml
      ```

2. Open the integrated editor in Cloud Shell by entering `code .`

3. Open the `scaled-object.yaml` file, and add the following code section of YAML.

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

4. Save the manifest file and close the editor.

### Apply the manifest

1. In Cloud Shell, run the `kubectl apply` command to submit the Deployment manifest to your cluster.

      ```bash
      kubectl apply -f ./scaled-object.yaml
      ```

2. Run the `kubectl get pods` command to check then number of running pods.

      ```bash
      kubectl get pods
      ```

    The command should output a table similar to the following example.

      ```output
      NAME                                  READY   STATUS    RESTARTS   AGE
      contoso-microservice-794d98b5-4flvg   1/1     Running   0          2m1s
      ```

    You should initially see 1 replica ready, the scaling of the replica will start after the polling period is eclipsed.

3. Periodically run the `kubectl get pods` command to verify the Deployment is scaling the number of pods according to the backlog of work.

    > [!NOTE]
    > If you have Linux utility `watch` installed you can run the following command to see the pods scale to process the Redis list items: `watch kubectl get pods`  If not, you can also use `kubectl get pods -w`.

    The command should output a table similar to the following example:

    ```output
      NAME                                  READY   STATUS    RESTARTS   AGE
      contoso-microservice-794d98b5-4flvg   1/1     Running   0          3m
      contoso-microservice-794d98b5-4jpxp   1/1     Running   0          3m
      contoso-microservice-794d98b5-4lw7b   1/1     Running   0          2m15s
      contoso-microservice-794d98b5-5fqj5   1/1     Running   0          3m
      contoso-microservice-794d98b5-5kdbw   1/1     Running   0          2m15s
      contoso-microservice-794d98b5-64qsm   1/1     Running   0          3m
      contoso-microservice-794d98b5-bmh7b   1/1     Running   0          3m8s
      contoso-microservice-794d98b5-gkstw   1/1     Running   0          2m15s
      contoso-microservice-794d98b5-pl7v7   1/1     Running   0          2m15s
      contoso-microservice-794d98b5-rgmvx   1/1     Running   0          2m15s
    ```

    And after all the items have been processed and the `cooldownPeriod` has expired, you will see that the number of pods is zero.  Why zero?  The reason that KEDA removes all running replicas is that there are no items left to process, within our `ScaledObject` manifest we set `minReplicaCount: 0` and `restoreToOriginalReplicaCount: false`.
