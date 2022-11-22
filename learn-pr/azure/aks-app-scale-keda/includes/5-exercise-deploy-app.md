In this exercise, you'll deploy your company's backend messaging service as a test app onto Azure Kubernetes Service (AKS). The service will connect to the Redis PaaS service created in the previous exercise.

> [!NOTE]
> The code for the service is available in this [GitHub repository](https://github.com/Azure-Samples/mslearn-aks-app-scaling-keda) if you want to explore the source code further.

## Create a list in Redis

We first need to create a list in Redis and populate it with some random elements.  What we are simulating here is a queue that is receiving data.  Each item in the queue represents something that our microservice will process.  For simplicity sake, we are adding a static number of items. As you will see later in the exercise, we scale the microservice to the number of items that are in the queue (Redis List).

1. Create a Redis container locally to connect to the Azure Cache for Redis we created earlier:

    ```azurecli
    docker run -it --rm redis redis-cli -h $REDIS_HOST -a $REDIS_KEY
    ```

    You should see something similar to this:

    ```output
    redis-contoso-video.redis.cache.windows.net:6379>
    ```

2. Create a list and some random items:

    ```azurecli
    lpush keda Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris eget interdum felis, ac ultricies nulla. Fusce vehicula mattis laoreet. Quisque facilisis bibendum dui, at scelerisque nulla hendrerit sed. Sed rutrum augue arcu, id maximus felis sollicitudin eget. Curabitur non libero rhoncus, pellentesque orci a, tincidunt sapien. Suspendisse laoreet vulputate sagittis. Vivamus ac magna lacus. Etiam sagittis facilisis dictum. Phasellus faucibus sagittis libero, ac semper lorem commodo in. Quisque tortor lorem, sollicitudin non odio sit amet, finibus molestie eros. Proin aliquam laoreet eros, sed dapibus tortor euismod quis. Maecenas sed viverra sem, at porta sapien. Sed sollicitudin arcu leo, vitae elementum
    ```

  3. You can now verify the length of the list by running the following command:

      ```azurecli
      llen keda
      ```

4. To exit the Redis shell, just type `exit`.

## Create a Deployment manifest

You create a Deployment manifest file to deploy your application. The manifest file allows you to define what type of resource you want to deploy and all the details associated with the workload.

Kubernetes groups containers into logical structures called pods, which have no intelligence. Deployments add the missing intelligence to create your application. Let's create a Deployment file.

1. In Cloud Shell, create a manifest file for the Kubernetes Deployment called `deployment.yaml` by using the integrated editor.

    ```azurecli
    touch deployment.yaml
    ```

2. Open the integrated editor in Cloud Shell by entering `code .`

3. Open the `deployment.yaml` file, and add the following code section of YAML.

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-microservice
    spec:
      replicas: 1                   # Here we are telling K8S the number of containers to process the Redis list items
      selector:                     # Define the wrapping strategy
        matchLabels:                # Match all pods with the defined labels
          app: contoso-microservice # Labels follow the `name: value` template
      template:                     # This is the template of the pod inside the Deployment
        metadata:
          labels:
            app: contoso-microservice
        spec:
          containers:
            - image: mcr.microsoft.com/mslearn/samples/redis-client:latest
              name: contoso-microservice
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 100m
                  memory: 128Mi
              env:
                - name: REDIS_HOST
                  value: "redis-contoso-video.redis.cache.windows.net" # *** REPLACE with your value ***
                - name: REDIS_PORT
                  value: "6379"                                        # *** REPLACE with your value ***
                - name: REDIS_LIST
                  value: "keda"                                        # *** REPLACE with your value ***
                - name: REDIS_KEY
                  value: "******************************************"  # *** REPLACE with your value ***
    ```

    > [!NOTE]
    > The env (environment) values should be updated with the values that you have kept track of from your Redis instance.

4. Save the manifest file and close the editor.

## Apply the manifest

1. In Cloud Shell, run the `kubectl apply` command to submit the Deployment manifest to your cluster.

    ```azurecli
    kubectl apply -f ./deployment.yaml
    ```

    The command should output a result similar to the following example.

    ```output
    deployment.apps/contoso-microservice created
    ```

2. Run the `kubectl get deployments` command to check if the Deployment was successful.

    ```azurecli
    kubectl get deploy contoso-microservice
    ```

    The command should output a table similar to the following example.

    ```output
    NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
    contoso-microservice   0/1     1            0           16s
    ```

3. Run the `kubectl get pods` command to check if the pod is running.

    ```azurecli
    kubectl get pods
    ```

    The command should output a table similar to the following example.

    ```output
    NAME                                    READY   STATUS    RESTARTS   AGE
    contoso-microservice-7c58c5f699-r79mv   1/1     Running   0          63s
    ```
