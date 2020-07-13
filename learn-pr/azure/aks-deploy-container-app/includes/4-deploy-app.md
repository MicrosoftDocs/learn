Now we have our cluster set up, let's make it work by deploying our application. The first application we decided to move was the company's website, because it's a simple static website with just the basic tech stack of HTML, CSS, and JavaScript. And also, it doesn't receive as many requests as the other services, this way we have a safe way to test everything.

If we aren't using Kubernetes, we'd have to spin um an Azure Virtual Machine. In this VM, we'd install a webserver like NGINX and then we'd upload the website files to the public folder so they are served.

In a single VM, we can only upload a small number of files, and most of the times, we'd have to spin up other VMs to make the website scalable and available.

The other option is to run the website in a container-based ecosystem like Azure Container Instances, but we'd have to spin up several containers to make it work. That's how Kubernetes and AKS come to help. We can harness the power of several VMs and control them all in one single place. Here, we'll run through all the engineering aspects of a containerized application and discuss how you can create one, and what makes them different from other applications.

> If you want to know more about this application, it's hosted [in this repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app).

## Images

The first thing you'll notice is that there's a Dockerfile in the root of the repository. That's because you'll be using a Docker image to spin up your application.

Kubernetes is a **container** orchestrator, which means you'll use containers to build and run the application within an image and deploy this image to the AKS cluster. You'll typically use Docker containers.

## Container Registries

Container registries allow you to store your images safely in the cloud and download them later on. You can think of the container registry as an archive that stores multiple versions of your container image. Each stored image has a tag assigned for identification.

For example, you may have the image `contoso-website:latest`, which would be a different version of the image with the tag `contoso-website:v1.0.0`.

:::image type="content" source="../media/4-1-cr-diagram.png" alt-text="Container Registry Diagram":::

Container registries may be public or private. Private registries require credentials to access and download images and will be the strategy you'll follow when storing container images.

Kubernetes only allows you to deploy images hosted in a container registry. Creating a private container registry will normally be part of your standard AKS deployment strategy.

### Kubernetes Deployments

Kubernetes groups containers and applications into logical structures called **Pods**. These pods have no intelligence and are composed of one or more application containers (Docker containers). Each one has its own IP address and network rules, and exposed ports.

Deployments are an evolution of pods. They wrap the Pods into an intelligent structure that allows them to _scale out_. That means you can easily duplicate and scale your application to support more load without the need to configure complex networking rules. To create this wrapping, deployments need a `label`. Labels are the way deployments find and group pods within their bounds.

:::image type="content" source="../media/4-2-deployments-diagram.png" alt-text="Deployments diagram":::

Kubernetes can tag workloads with labels. These labels allow the system to query the cluster for workloads that have one or more labels. For example, if we wanted to search all workloads related to the `contoso-website`, we could query the cluster for everything with the label `app` and the value of that label being `contoso-website`. This can be seen in the `selector` key of our previous example:

    ```yml
    # deployment.yaml
    # ...
    spec:
      selector:
        matchLabels:
          app: contoso-website
    # ...
    ```

Deployments allow users to update applications just by changing the image tag without downtime. When you update a deployment, instead of deleting all apps and creating new ones, the deployment turns off the online apps one by one, replacing them with the newest version. This aspect means any deployment can update the pods inside it with no visible effect in availability.

## Kubernetes manifest files

Instead of telling exactly what to do and how to create the resources, Kubernetes have manifest files. They allow you to describe your workloads in the YAML format. These manifest files contain everything that is needed to create and manage the workload it describes.

The biggest difference between an imperative paradigm, where we tell the cluster what and how we want it to deploy our apps, and the declarative one, is that we do not need to worry about node availability. This is why we don't need to tell to which node we want our application deployed unless it's necessary, because the control plane has all the information needed to balance the application load among all the nodes.

Also, declarative paradigm allows us to version our infrastructure in a way we don't need to worry about how the environment will deploy the apps, but only on what apps are going to be deployed instead.

Manifest files can differ depending on the type of resource that it creates. But all manifest files have common instructions. The first lines of all files have two important keys `apiVersion` and `kind`.

First, we need to tell Kubernetes what kind of workload this file refers to using the `kind` key, and then the API endpoint refers to using the `apiVersion` key in the YAML file, like this:

    ```yml
    # deployment.yaml
    apiVersion: apps/v1 # Where in the API it resides
    kind: Deployment # The kind of workload we're creating
    ```

Other common keys for all the files are the `metadata` and `name` keys. All Kubernetes resources **must** have a name, and this name goes inside the `metadata` key.

    ```yml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website # This will be the name of the deployment
    ```

From this point on, all files have different structures based on what kind of resource we're telling Kubernetes to create for us. In the next unit, we'll build a deployment manifest and understand all the aspects of the declarative paradigm and manifest files.
