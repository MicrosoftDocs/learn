Kubernetes differs itself from other tool mostly because of its ease to create workloads and manage the cluster. After talking about `kubectl` and how we can create an AKS cluster, now is time to talk about how you can create workloads in your AKS cluster.

## Create and push images

Recalling the last unit, we need to create and push a container image to a container registry so we can deploy the app to our cluster.

### Create a container registry

Kubernetes can only spin up an image if that image is hosted in a container registry. Container registries allow you to store your images safely in the cloud and download them later on.

For this exercise, we'll use Azure Container Registry. So, let's create an Azure Container Registry to store our image and deploy the image to our Kubernetes cluster.

1. Run the following command to create a new container registry. Replace `<resource-group-name>` with the name of your resource group.

    ```azurecli
    az acr create \
        --resource-group <resource-group-name> \
        --name ContosoContainerRegistry$RANDOM \
        --sku Basic
    ```

### Connect the AKS cluster to the ACR

Since we are working with a private container registry, we'll need to tell our AKS cluster to authenticate with that registry so it can download the stored images. Luckily, using both ACR and AKS this integration can be easily done.

1. Check if you have the `aks-preview` extension enabled in your CLI

    ```azurecli
    az extension list
    ```

1. If the list is empty, Run the following command on your terminal to update your AKS cluster

    ```azurecli
    az aks update -n contoso-kubernetes-cluster -g contoso-aks --attach-acr ContosoContainerRegistry$RANDOM
    ```

1. If not, run the preview command:

    ```azurecli
    az aks update -n contoso-kubernetes-cluster -g contoso-aks --acr ContosoContainerRegistry$RANDOM --enable-acr
    ```

The result will be the attachment of your ACR to your AKS cluster.

### Log in to your container registry

Once the CR is created, you need to connect your local Docker runtime to the :::no-loc text="registry"::: so it can push your image to the remote destination. To do so, follow these steps:

1. Open your terminal and type the following Azure CLI command:

    ```azurecli
    az acr login -n ContosoContainerRegistry$RANDOM
    ```

    There's no need to include the `.azurecr.io` in the name of the CR when logging in.

    If you ever need to see your sign-in credentials, just access the ACR resource in the [Azure portal](https://portal.azure.com) and go to the "Access keys" tab on the left-hand side:

    :::image type="content" source="../media/4-acr-login.png" alt-text="Check your credentials on the 'Access Keys' tab":::

1. After the sign-in, your local Docker runtime should be already connected to the ACR resource.

### Push an image to the ACR

Now it's time to put everything together and push the image to the ACR you created.

1. Run the following commands in Cloud Shell to clone the GitHub repository that contains the files for the application, and change to that directory.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app.git
    cd mslearn-aks-deploy-container-app
    ```

1. Next, run the the `acr build` command to start building the image.

    ```azurecli
    az acr build --image contoso-website --registry ContosoContainerRegistry$RANDOM --file Dockerfile .
    ```

    Using the `-t` option will add the `contoso-website` tag to the image. After the image is built, it'll be pushed directly to the registry.

## Kubernetes manifest files

Instead of telling exactly what to do and how to create the resources, Kubernetes have manifest files. They allow you to describe your workloads in the YAML format. These manifest files contain everything that is needed to create and manage the workload it describes.

There are several types of workloads Kubernetes supports. Each one has its own uses and purposes, for this website we'll be using the __Deployment__, __Service__, and __Ingress__ types.

All the example files can be found in the [official demo repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app/tree/master/kubernetes) under the `Kubernetes` directory.

### Creating a deployment manifest

Kubernetes groups containers and applications into logical structures called __Pods__. These pods have no intelligence and are composed of one or more application containers (Docker containers). Each one has its own IP address and network rules, and exposed ports.

Deployments are an evolution of pods. They wrap the Pods into an intelligent structure that allows them to _scale out_. That means you can easily duplicate and scale your application to support more load without the need to configure complex networking rules.

Also, deployments allow users to update applications just by changing the image tag without downtime. Which means any deployment can update the pods inside it with no visible effect in availability. This action is called __rolling update__.

Let's begin creating a deployment file:

1. Create a file called `deployment.yaml` in any directory of your choosing
1. Open it in your favorite text editor and start the following changes:

    First, we need to tell Kubernetes what kind of workload this file refers and what endpoint of the Kubernetes api it's related to. To do that, we need the `apiVersion` and `kind` YAML keys, like so:

    ```yml
    # deployment.yaml
    apiVersion: apps/v1 # Where in the API it resides
    kind: Deployment # The kind of workload we're creating
    ```

    > [!TIP]
    > You can find more information about `apiVersion` and what values to put in this key by visiting the official Kubernetes documentation, linked at the end of this module.

1. Next up, we need to define the metadata for this deployment, which includes the name we'll give it. So we'll add another key named `metadata` and, inside it, another one called `name`:

    ```yml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website # This will be the name of the deployment
    ```

1. Deployments are pod controllers, so they wrap pods – which have containers – adding more intelligence to them. Because of this, all deployments follow a `template` key in its specification. This key has all the needed information to describe what that deployment will hold, in other words, the `spec.template` key is the definition of the pod we're putting inside the deployment:

    ```yml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      template: # This is the template of the pod inside the deployment
    ```

    If we wanted to create a pod outside of a deployment, we'd need to create a structure similar to the one we created for the deployment itself. It needs a metadata:

    ```yml
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
    ```

    As you can see, we're not creating a `name` tag inside `metadata`, that's because pods don't have given names when created inside deployments, the pod's name will be the deployment's name with a random ID added to the end.

    Instead of `name` we added the `labels` key. Kubernetes can tag workloads with labels. These labels allow for the system to query the cluster for workloads that have one or more labels, for example, if we wanted to search all workloads related to the `contoso-website` we could query the cluster for everything with the label `app` and the value of that label being `contoso-website`.

    Labels are the way deployments find and group pods within their bounds.

1. All pods also have a `spec` key that allows us to define the containers inside that pod.

    ```yml
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
    ```

    The `containers` key is an array of container specs, because a pod can have one or more containers. These specs are `image`, `name`, `resources`, `ports`, and other important information.

    Let's define the image our container will run. For this, we use the `spec.containers[0].image` key:

    ```yml
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
            - image: <your-registry-name>.azurecr.io/contoso-website # The image the container will run
    ```

1. After the image, we need to give our pod a name through the `spec.containers[0].name` key:

    ```yml
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
            - image: <your-registry-name>.azurecr.io/contoso-website # The image the container will run
              name: contoso-website
    ```

    All pods will follow the name `contoso-website-<UUID>`, where UUID is a generated ID to uniquely identify all resources.

1. After that, it's a good practice to define how many resources the app will be allowed to use from the cluster, a minimum amount, and a maximum amount. We do this limiting by adding a `resources` key inside the `spec.containers[0]`:

    ```yml
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
            - image: <your-registry-name>.azurecr.io/contoso-website
              name: contoso-website
              resources:
                requests: # Minimum amount of resources requested
                  cpu: 100m
                  memory: 128Mi
                limits: # Maximum amount of resources requested
                  cpu: 250m
                  memory: 256Mi
    ```

    You can find more about the measure units for resources in the Kubernetes documentation.

1. Lastly, we define the ports this container will expose externally through the `port` key inside `spec.containers[0]`:

    ```yml
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
            - image: <your-registry-name>.azurecr.io/contoso-website
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

    Notice we named the port using the `name` key inside `spec.containers[0].ports[0]`. Naming ports allows us to change the port being exposed without changing files that reference that port.

    Also notice that the `ports` key is an array of objects, which means that a container in a pod can expose multiple ports with multiple names if needed.

1. Back to the deployment configurations. We need to define which workloads the deployment will wrap. We can run this query by adding another key named `selector` inside the deployment `spec` key, and fill it with the rules we want through the `matchLabels` key:

    ```yml
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
          containers:
            - image: <your-registry-name>.azurecr.io/contoso-website
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

Save the deployment file and now all we need to do to deploy an application is described inside it, making it easily versionable and explicit.

## Deploy resources to the cluster

Now that we have our file saved, we need to deploy it.

1. Open the terminal in the same directory as the `deployment.yaml` file.
1. Run the command:

    ```bash
    kubectl apply -f ./deployment.yaml
    ```

    Wait for the command to respond
1. Check if the deployment was successful by issuing the command:

    ```bash
    kubectl get deploy contoso-website
    ```

    The command should output a table similar to the following:

    |NAME  |READY  |UP-TO-DATE  |AVAILABLE  |
    |---------|---------|---------|---------|
    |contoso-website     |1/1         |1         |1         |
