In this exercise, you'll deploy your company's back-end messaging service as a test app onto Azure Kubernetes Service (AKS). The service connects to the Redis PaaS service you created in the previous exercise.

> [!NOTE]
> The code for the service is available in the [GitHub repository](https://github.com/Azure-Samples/mslearn-aks-app-scaling-keda).

## Create a list in Redis

You need to create a list in Redis and populate it with some random elements to simulate a queue receiving data. Each item in the queue represents something that the microservice will process. For this exercise, you'll add a static number of items. Later in the exercise, you'll scale the microservice to the number of items in the queue.

1. Make sure Docker is running on your computer.

1. Create a Redis container locally to connect to your Azure Cache for Redis using the `docker run` command:

    ```azurecli-interactive
    docker run -it --rm redis redis-cli -h $REDIS_HOST -a $REDIS_KEY
    ```

    Your output should look similar to the following example output:

    ```output
    redis-contoso-video.redis.cache.windows.net:6379>
    ```

1. Create a list and populate it with random elements using the `lpush keda` command:

    ```azurecli-interactive
    lpush keda Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris eget interdum felis, ac ultricies nulla. Fusce vehicula mattis laoreet. Quisque facilisis bibendum dui, at scelerisque nulla hendrerit sed. Sed rutrum augue arcu, id maximus felis sollicitudin eget. Curabitur non libero rhoncus, pellentesque orci a, tincidunt sapien. Suspendisse laoreet vulputate sagittis. Vivamus ac magna lacus. Etiam sagittis facilisis dictum. Phasellus faucibus sagittis libero, ac semper lorem commodo in. Quisque tortor lorem, sollicitudin non odio sit amet, finibus molestie eros. Proin aliquam laoreet eros, sed dapibus tortor euismod quis. Maecenas sed viverra sem, at porta sapien. Sed sollicitudin arcu leo, vitae elementum
    ```

1. Verify the length of the list using the `llen keda` command:

    ```azurecli-interactive
    llen keda
    ```

1. Exit the Redis shell by typing `exit`.

## Create a Deployment manifest

You create a Deployment manifest file to deploy your application. The manifest file allows you to define what type of resource you want to deploy and the details associated with the workload.

Kubernetes groups containers into logical structures called pods, which have no intelligence. Deployments add the missing intelligence to create your application.

1. In Cloud Shell, create a manifest file for the Kubernetes Deployment called `deployment.yaml` using the `touch` command:

    ```azurecli-interactive
    touch deployment.yaml
    ```

2. Open the integrated editor in Cloud Shell by entering `code .`

3. Open the `deployment.yaml` file and paste in the following manifest code. Make sure to replace the Redis environment variables with your own values.

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-microservice
    spec:
      replicas: 1                   # Tells K8S the number of containers to process the Redis list items
      selector:                     # Define the wrapping strategy
        matchLabels:                # Match all pods with the defined labels
          app: contoso-microservice # Labels follow the `name: value` template
      template:                     # Template of the pod inside the Deployment
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

4. Save the manifest file (<kbd>CTRL + S</kbd>) and close the editor(<kbd>CTRL + Q</kbd>).

## Apply the manifest

1. Deploy the manifest to your cluster using the `kubectl apply` command:

    ```azurecli-interactive
    kubectl apply -f ./deployment.yaml
    ```

    Your output should look similar to the following example output:

    ```output
    deployment.apps/contoso-microservice created
    ```

2. Verify the deployment was successful using the `kubectl get deployment` command:

    ```azurecli-interactive
    kubectl get deployment contoso-microservice
    ```

    Your output should look similar to the following example output:

    ```output
    NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
    contoso-microservice   1/1     1            0           16s
    ```

3. Verify the pod is running using the `kubectl get pods` command:

    ```azurecli-interactive
    kubectl get pods
    ```

    Your output should look similar to the following example output:

    ```output
    NAME                                    READY   STATUS    RESTARTS   AGE
    contoso-microservice-7c58c5f699-r79mv   1/1     Running   0          63s
    ```
