In this exercise, deploy your company's website as a test app onto Azure Kubernetes Service (AKS). The website is a static website with an underlying technology stack of HTML, CSS, and JavaScript. It doesn't receive as many requests as the other services and provides us with a safe way to test deployment options.

> [!NOTE]
> The code for the web app is available in this [GitHub repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app) if you want to explore the source code further. Also, this sample app will be deployed on a Linux node pool only.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create a deployment manifest

You create a deployment manifest file to deploy your application. The manifest file allows you to define what type of resource you want to deploy and all the details associated with the workload.

Kubernetes groups containers into logical structures called pods, which have no intelligence. Deployments add the missing intelligence to create your application. Let's create a deployment file.

1. Sign in to Azure Cloud Shell.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/bash?azure-portal=true)

1. In Cloud Shell, create  a manifest file for the Kubernetes deployment called `deployment.yaml` by using the integrated editor.

    ```bash
    touch deployment.yaml
    ```

1. Open the integrated editor in Cloud Shell by entering `code .`

1. Open the `deployment.yaml` file, and add the following code section of YAML.

    ```yaml
    # deployment.yaml
    apiVersion: apps/v1 # The API resource where this workload resides
    kind: Deployment # The kind of workload we're creating
    metadata:
      name: contoso-website # This will be the name of the deployment
    ```

    In this code, you added the first two keys to tell Kubernetes the `apiVersion` and `kind` of manifest you're creating. The `name` is the name of the deployment. Use it to identify and query the deployment information when you use `kubectl`.

    > [!TIP]
    > For more information about `apiVersion` and what values to put in this key, see the official Kubernetes documentation. Find a link at the end of this module.

1. A deployment wraps a pod. You make use of a template definition to define the pod information within the manifest file. The template is placed in the manifest file under the deployment specification section.

    Update the `deployment.yaml` file to match the following YAML.

    ```yaml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      template: # This is the template of the pod inside the deployment
        metadata: # Metadata for the pod
          labels:
            app: contoso-website
    ```

    Pods don't use the same names as the deployments. The pod's name is a mix of the deployment's name with a random ID added to the end.

    Notice the use of the `labels` key. You add the `labels` key to allow deployments to find and group pods.

1. A pod wraps one or more containers. All pods have a specification section that allows you to define the containers inside that pod.

    Update the `deployment.yaml` file to match the following YAML.

    ```yaml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      template: # This is the template of the pod inside the deployment
        metadata:
          labels:
            app: contoso-website
        spec:
          containers: # Here we define all containers
            - name: contoso-website
    ```

    The `containers` key is an array of container specifications because a pod can have one or more containers. The specification defines an `image`, a `name`, `resources`, `ports`, and other important information about the container.

    All running pods follow the name `contoso-website-<UUID>`, where UUID is a generated ID to identify all resources uniquely.

1. It's a good practice to define a minimum and a maximum amount of resources that the app is allowed to use from the cluster. You use the `resources` key to specify this information.

    Update the `deployment.yaml` file to match the following YAML.

    ```yaml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      template: # This is the template of the pod inside the deployment
        metadata:
          labels:
            app: contoso-website
        spec:
          containers:
            - image: mcr.microsoft.com/mslearn/samples/contoso-website
              name: contoso-website
              resources:
                requests: # Minimum amount of resources requested
                  cpu: 100m
                  memory: 128Mi
                limits: # Maximum amount of resources requested
                  cpu: 250m
                  memory: 256Mi
    ```

      Notice how the resource section allows you to specify the minimum resource amount as a request and the maximum resource amount as a limit.

1. The last step is to define the ports this container exposes externally through the `ports` key. The `ports` key is an array of objects, which means that a container in a pod can expose multiple ports with multiple names.

    Update the `deployment.yaml` file to match the following YAML.

    ```yaml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      template: # This is the template of the pod inside the deployment
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
                - containerPort: 80 # This container exposes port 80
                  name: http # We named that port "http" so we can refer to it later
    ```

    Notice how you name the port by using the `name` key. Naming ports allows you to change the exposed port without changing files that reference that port.

1. Finally, add a selector section to define the workloads the deployment manages. The `selector` key is placed inside the deployment specification section of the manifest file. Use the `matchLabels` key to list the labels for all the pods managed by the deployment.

    Update the `deployment.yaml` file to match the following YAML.

    ```yaml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      selector: # Define the wrapping strategy
        matchLabels: # Match all pods with the defined labels
          app: contoso-website # Labels follow the `name: value` template
      template: # This is the template of the pod inside the deployment
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

    > [!NOTE]
    > In an AKS cluster which has multiple node pools (Linux and Windows), the deployment manifest file previously listed also defines a `nodeSelector` to tell your AKS cluster to run the sample application's pod on a node that can run Linux containers.

    Linux nodes can't run Windows containers and vice versa.

1. Save the manifest file and close the editor.

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
    contoso-website   0/1     1            0           16s
    ```

1. Run the `kubectl get pods` command to check if the pod is running.

    ```bash
    kubectl get pods
    ```

    The command should output a table similar to the following example.

    ```output
    NAME                               READY   STATUS    RESTARTS   AGE
    contoso-website-7c58c5f699-r79mv   1/1     Running   0          63s
    ```
