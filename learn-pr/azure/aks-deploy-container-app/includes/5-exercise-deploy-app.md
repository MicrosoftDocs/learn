In this exercise, deploy your company's website as a test app onto Azure Kubernetes Service (AKS). The website is a static website with an underlying technology stack of HTML, CSS, and JavaScript. It doesn't receive as many requests as the other services and provides us with a safe way to test deployment options.

> [!NOTE]
> The code for the web app is available in this [GitHub repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app) if you want to explore the source code further. Also, this sample app only deploys on a Linux node pool.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create a deployment manifest

You create a deployment manifest file to deploy your application. The manifest file allows you to define what type of resource you want to deploy and all the details associated with the workload.

Kubernetes groups containers into logical structures called pods, which have no intelligence. Deployments add the missing intelligence to create your application. Let's create a deployment file.

1. On your computer, use a text editor like Visual Studio Code, and copy and paste the following YAML code into a file named _deployment.yaml_ and save the file.

    ```yaml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      selector:
        matchLabels:
          app: contoso-website
      template:
        metadata:
          labels:
            app: contoso-website
        spec:
          nodeSelector:
            kubernetes.io/os: linux
          containers:
            - image: mcr.microsoft.com/mslearn/samples/contoso-website
              name: contoso-website
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 250m
                  memory: 256Mi
              ports:
                - containerPort: 80
                  name: http
    ```

    - Two keys are used to define the `apiVersion` and `kind` of manifest you're creating. For more information about `apiVersion` and what values to put in this key, see the [official Kubernetes deployments documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).
    - The `name` is the name of the deployment. Use it to identify and query the deployment information when you use `kubectl`.
    - The template definition defines the pod information within the manifest file. The template is placed in the manifest file under the deployment specification section.
    - The `labels` key to allow deployments to find and group pods.
    - In an AKS cluster that has Linux and Windows node pools, the deployment manifest defines a `nodeSelector` to tell your AKS cluster to run the sample application's pod on a node that can run Linux containers. Linux nodes can't run Windows containers and vice versa.
    - The `containers` key is an array of container specifications because a pod can have one or more containers. The specification defines an `image`, a `name`, `resources`, `ports`, and other important information about the container. All running pods follow the name `contoso-website-<UUID>`, where UUID is a generated ID to identify all resources uniquely.
    - It's a good practice to define a minimum and a maximum amount of resources that the app is allowed to use from the cluster. You use the `resources` key to specify this information. The resource section allows you to specify the minimum resource amount as a request and the maximum resource amount as a limit.
    - The ports this container exposes externally through the `ports` key. The `ports` key is an array of objects, which means that a container in a pod can expose multiple ports with multiple names. You name the port by using the `name` key. Naming ports allows you to change the exposed port without changing files that reference that port.

1. Upload _deployment.yaml_ to your Cloud Shell session by selecting **Manage files** > **Upload**.

## Apply the manifest

1. In Cloud Shell, run the `kubectl apply` command to submit the deployment manifest to your cluster.

    ```bash
    kubectl apply -f ./deployment.yaml
    ```

    The command should output a result similar to the following example.

    ```output
    deployment.apps/contoso-website created
    ```

1. Run the `kubectl get deploy` command to check if the deployment was successful.

    ```bash
    kubectl get deploy contoso-website
    ```

    The command should output a table similar to the following example.

    ```output
    NAME              READY   UP-TO-DATE   AVAILABLE   AGE
    contoso-website   1/1     1            1           19s
    ```

1. Run the `kubectl get pods` command to check if the pod is running.

    ```bash
    kubectl get pods
    ```

    The command should output a table similar to the following example.

    ```output
    NAME                               READY   STATUS    RESTARTS   AGE
    contoso-website-1c2b3b4b5b-dzsvm   1/1     Running   0          68s
    ```
