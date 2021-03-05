Your company is looking at ways to deploy your cloud-based video rendering service. You've chosen Azure Kubernetes Service (AKS) as your cloud-native development platform. With the cluster configured, you're ready to deploy one of the components in your video rendering application. You decide to deploy a static version of your company's website to explore the Kubernetes deployment process.

Before we discuss the Kubernetes way of deployment, let's review some of the steps you'd take to deploy a similar application to a non-Kubernetes environment.

Assume you're using an Azure virtual machine (VM) as your target platform. The first step is to prepare the server software to host the application. You will:
- Install the operating system.
- Make sure to update the OS to the latest security and software patches.
- Install and configure the web server software.
- Deploy the web application.

You'll repeat this process for each new VM when you decide to scale the website out to handle an increase in demand from customers.

An alternative approach is to run the website on a container-based platform like Azure Container Instances. You don't need to worry about the underlying server technology, but you'll have to configure and manage several containers to use this strategy manually.

Kubernetes and AKS help you orchestrate containers. The Kubernetes container orchestration features make it easy to manage workloads on the cluster. You deploy workloads by using containers built from container images to run your applications within an AKS cluster.

Here you'll explore how to create workloads in your AKS cluster.

## What is a container registry?

A container registry allows you to store container images safely in the cloud for later deployment. You can think of the container registry as an archive that stores multiple versions of your container image. Each stored image has a tag assigned for identification.

For example, you might have the image `contoso-website:latest`, which would be a different version of the image with the tag `contoso-website:v1.0.0`.

:::image type="content" source="../media/4-1-container-registry-diagram.png" alt-text="A diagram that shows how container images are downloaded from a container registry to a Kubernetes cluster by using a manifest file.":::

Container registries might be public or private. Private registries require credentials to access and download images and will be the strategy you'll follow when you store container images.

Kubernetes only allows you to deploy images hosted in a container registry. Creating a private container registry will normally be part of your standard AKS deployment strategy.

## What is a Kubernetes pod?

A Kubernetes *pod* groups containers and applications into logical structure. These pods have no intelligence and are composed of one or more application containers. Each one has an IP address, network rules, and exposed ports.

For example, if you wanted to search all workloads related to the `contoso-website`, you'll query the cluster for pods with the label `app` and the value `contoso-website`.

## What is Kubernetes deployment?

:::image type="content" source="../media/4-2-deployments-diagram.png" alt-text="A diagram that shows a Kubernetes deployment with a label and three pods.":::

A Kubernetes deployment is an evolution of pods. A deployment wraps the pods into an intelligent object that allows them to _scale out_. You can easily duplicate and scale your application to support more load without the need to configure complex networking rules.

Deployments allow users to update applications just by changing the image tag without downtime. When you update a deployment, instead of deleting all apps and creating new ones, the deployment turns off the online apps one by one and replaces them with the newest version. This aspect means any deployment can update the pods inside it with no visible effect in availability.

## Kubernetes manifest files

A Kubernetes manifest file allows you to describe your workloads in the YAML format declaratively and simplify Kubernetes object management.

Imagine you have to deploy a workload by hand. You need to think about and manage several aspects. You'd need to create a container, select a specific node, wrap it in a pod, run the pod, monitor execution, and so on.

Manifest files contain all the information that's needed to create and manage the described workload.

## What is a Kubernetes label?

A Kubernetes label allows you to logically group Kubernetes objects. These labels enable the system to query the cluster for objects that match a label with a specific name.

## The structure of a manifest file

The structure of manifest files differs depending on the type of resource that you create. However, manifest files share common instructions. These instructions define various aspects, such as the APIs to use and the type of workload to create.

The first two entries in all manifest files have two important keys, `apiVersion` and `kind`. Here's an example of a deployment file.

```yaml
apiVersion: apps/v1 # Where in the API it resides
kind: Deployment # The kind of workload we're creating
```

The `apiVersion` key defines the API server endpoint that manages the object you'll deploy.

The `kind` key defines the workload this deployment will create.

Other common keys for all the files are the `metadata` and `name` keys. All Kubernetes resources *must* have a name. This name goes inside the `metadata` key.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-website # This will be the name of the deployment
```

## Group objects in a deployment

Deployments make use of a `label` to find and group pods. You define the label as part of your deployment's manifest file.

Here's an example. Notice the `matchLabels` value defined in the `selector` definition added to the `spec` definition.

```yaml
# deployment.yaml
# ...
spec:
  selector:
    matchLabels:
      app: contoso-website
# ...
```

From this point on, all files have different structures based on what kind of resource you're telling Kubernetes to create.

## Apply a deployment file

You deploy a Kubernetes deployment manifest file by using `kubectl`. Here's an example of the command.

```bash
kubectl apply -f ./deployment.yaml
```
