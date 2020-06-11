Kubernetes differs itself from other tool mostly because of its ease to create workloads and manage the cluster. After talking about `kubectl` and how we can create an AKS cluster, now is time to talk about how you can create workloads in your AKS cluster.

## Understand manifest files

Instead of telling exactly what to do and how to create the resources, Kubernetes have manifest files that allow you to describe your workloads in the YAML format. These manifest files contain everything that is needed to create and manage the workload it describes.

There are several types of workloads Kubernetes supports. Each one has its own uses and purposes, for this website we'll be using the __Deployment__, __Service__, and __Ingress__ types.

All the example files can be found in the [official demo repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app/tree/master/kubernetes) under the `Kubernetes` directory.

### Creating a deployment file

Kubernetes groups containers and applications into logical structures called __Pods__. These pods have no intelligence and are composed of one or more application containers (Docker containers). Each one has its own IP address and network rules, as well as exposed ports.

Deployments are an evolution of pods. They wrap the Pods into an intelligent structure that allows them to _scale out_, which means you can easily duplicate and scale your application to support more load without the need to configure complex networking rules.

Also, deployments allow users to update applications just by changing the image tag without downtime. Which means that any deployment will be able to update the pods inside it with no visible effect in availability, this action is called __rolling update__.

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

    Let's pause the creation of the `deployment.yaml` file for a bit. If we wanted to create a pod outside of a deployment, we'd need to create a structure similar to the one we created for the deployment itself. It needs a metadata:

    ```yml
    # pod-part.yaml
    metadata:
      labels:
        app: contoso-website
    ```

    As you can see, we're not creating a `name` tag inside `metadata`, that's because pods don't have given names when created inside deployments, the pod's name will be the deployment's name with a random ID added to the end.

    Instead of `name` we added the `labels` key. Kubernetes can tag workloads with labels. These labels allow for the system to query the cluster for workloads that have one or more labels, for example, if we wanted to search all workloads related to the `contoso-website` we could query the cluster for everything with the label `app` and the value of that label being `contoso-website`.

    Labels are the way deployments find and group pods within their bounds.

    All pods also have a `spec` key that allows us to define the containers inside that pod.

    ```yml
    # pod-part.yaml
    metadata:
      labels:
        app: contoso-website
    spec:
      containers: # Here we define all containers
    ```

    The `containers` key is an array of container specs, because a pod can have one or more containers. These specs are `image`, `name`, `resources`, `ports`, and other important information.

    Let's define the image our container will run. For this, we use the `spec[0].image` key:

    ```yml
    # pod-part.yaml
    metadata:
      labels:
        app: contoso-website
    spec:
      containers:
        - image: <your-registry-name>.azurecr.io/contoso-website # The image the container will run
    ```

<!-- TODO:
3. Deploy to the AKS cluster
 -->
