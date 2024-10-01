In the previous exercise, we created an Azure Container Registry and a Kubernetes cluster in AKS. To deploy a container image to the cluster, we can connect to the cluster from the Cloud Shell.

AKS can use either the Kubernetes command-line tool, `kubectl`, or the Azure CLI to manage deployments.

## Open-source benefits

With kubectl and AKS, you can leverage open-source tools like Argo CD, which is a continuous-delivery tool for Kubernetes that creates infrastructure visualizations. Argo CD helps increase your confidence in your systems, as you can show a deployment rollout or scaling operation happening in real-time. If an error occurs, Argo CD helps troubleshoot by showing when and where the problem has occurred.

![Animation of Argo CD.](../media/argocd-ui.gif)

## Deploying to a cluster

We can use kubectl to deploy a container from our container registry to the Kubernetes cluster. Although Azure Container Registry is a private registry for container images, we already integrated our registry to AKS when we created the cluster. To deploy an image, we need to create a manifest file that contains instructions for the deployment.

### Creating a deployment manifest

Manifest files contain all the information needed to deploy your container image. A Kubernetes manifest file allows you to describe your deployment in a YAML format, which simplifies Kubernetes management.

![Diagram of Kubernetes deployment.](../media/4-1-container-registry-diagram.png)

## Storing an image in Kubernetes

When we send a container image to a cluster, it's hosted in a pod. Containers are grouped into pods, and those pods scale to your desired state. Pods run an instance of your container and are the smallest deployable units of computing that you can create and manage in Kubernetes.

![Diagram of Kubernetes node hosting a pod.](../media/2-diagram-pod-with-website.png)

These pods have no intelligence. Each one has an IP address, network rules, and exposed ports, which are all managed for you by the Kubernetes API server.

## Kubernetes health checks

One of the key benefits of Kubernetes its self-healing ability, which restores applications to the exact instance that you tested and saved. When you replicate or save containers, Kubernetes can check on the health of the containers and replace them with an original copy if necessary. This is especially important at scale, when you might need multiple instances of containers spread across multiple regions.

## Example scenario: What our container will do

The Kubernetes API server will route REST messages from smart fridges to our Node container. The smart fridges will send REST messages to the cloud, where AKS will receive them. AKS will route the messages to an instance of our Node.js container.

The container will run a program that processes messages, and then route them to the management web app.

![Diagram of your current architecture.](../media/4-2-architecture.png)
