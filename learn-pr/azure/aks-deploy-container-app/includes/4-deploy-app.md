Next, we'll use a static web application built using Hugo, a static website generator written in Golang. This application is available [in this repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app).

Here, we'll run through all the engineering aspects of a containerized application and discuss how you can create one, and what makes them different from other applications.

## Images

The first thing you'll notice is that there's a Dockerfile in the root of the repository. That's because you'll be using a Docker image to spin up your application.

Kubernetes is a __container__ orchestrator. Which means that we'll use Docker containers to build and run the application within an image and deploy this image to the AKS cluster.

## Container Registries

Kubernetes can only spin up an image if that image is hosted in a container registry. Container registries allow you to store your images safely in the cloud and download them later on.

Think of registries as archives to your images. It stores all the images described by their tags, so an image `contoso-website:latest` has a different tag than `contoso-website:v1.0.0`. These tags describe the versions of your image, and you can have multiple of them in your registry.

[//]: # (DIAGRAM HERE)

Container registries may be public, which means anyone has access to it and download images without the need of a credential. They can also be private, which is the opposite, to download any image you'll need to run a sign-in step.

## Kubernetes manifest files

Instead of telling exactly what to do and how to create the resources, Kubernetes have manifest files. They allow you to describe your workloads in the YAML format. These manifest files contain everything that is needed to create and manage the workload it describes.

[//]: # (DIAGRAM HERE)

There are several types of workloads Kubernetes supports. Each one has its own uses and purposes, for this website we'll be using the __Deployment__, __Service__, and __Ingress__ types.

Manifest files can differ depending on the type of resource that it creates. But all manifest files have common instructions. The first lines of all files have two important keys `apiVersion` and `kind`.

First, we need to tell Kubernetes what kind of workload this file refers using the `kind` key, and then the API endpoint it refers to using the `apiVersion` key in the YAML file, like this:

    ```yml
    # deployment.yaml
    apiVersion: apps/v1 # Where in the API it resides
    kind: Deployment # The kind of workload we're creating
    ```

Other common keys for all the files are the `metadata` and `name` keys. All Kubernetes resources __must__ have a name, and this name goes inside the `metadata` key.

    ```yml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website # This will be the name of the deployment
    ```

From this point on, all files have different structures based on what kind of resource we're telling Kubernetes to create for us. This is the example of a deployment manifest file:

    ```yml
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
          containers:
            - image: registry.azurecr.io/contoso-website
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

### Kubernetes Deployments

Kubernetes groups containers and applications into logical structures called __Pods__. These pods have no intelligence and are composed of one or more application containers (Docker containers). Each one has its own IP address and network rules, and exposed ports.

Deployments are an evolution of pods. They wrap the Pods into an intelligent structure that allows them to _scale out_. That means you can easily duplicate and scale your application to support more load without the need to configure complex networking rules. To create this wrapping, deployments need a `label`. Labels are the way deployments find and group pods within their bounds.

[//]: # (DIAGRAM HERE)

Kubernetes can tag workloads with labels. These labels allow for the system to query the cluster for workloads that have one or more labels, for example, if we wanted to search all workloads related to the `contoso-website` we could query the cluster for everything with the label `app` and the value of that label being `contoso-website`. This can be seen in the `selector` key of our previous example:

    ```yml
    # deployment.yaml
    # ...
    spec:
      selector:
        matchLabels:
          app: contoso-website
    # ...
    ```

Also, deployments allow users to update applications just by changing the image tag without downtime. Which means any deployment can update the pods inside it with no visible effect in availability. This action is called __rolling update__.

