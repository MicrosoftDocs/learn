Kubernetes differs itself from other tool mostly because of its ease to create workloads and manage the cluster. After talking about `kubectl` and how we can create an AKS cluster, now is time to talk about how you can create workloads in your AKS cluster.

## Understand manifest files

Instead of telling exactly what to do and how to create the resources, as in a _imperative creation_, Kubernetes have manifest files that allow you to describe your workloads in the YAML format. These manifest files contain everything that is needed to create and manage the workload it's refereeing to.

There are several types of workloads Kubernetes supports, each one has its own uses and purposes, for this website we'll be using the __Deployment__, __Service__, and __Ingress__ types.

### Creating a deployment file

Kubernetes groups containers and applications into logical structures called __Pods__, these pods have no intelligence and are composed of one or more application containers (Docker containers) and each one has its own IP address and network rules, as well as exposed ports.

Deployments are an evolution of pods, they wrap the Pods into a intelligent structure that allows them to _scale out_, which means you can easily duplicate and scale your application to support more load without the need to configure complex network rules.

<!--
1. Link to the demo repo explaining they can find more information in the example files: https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app/tree/master/kubernetes
2. Create deployment file with explanations
3. Deploy to the AKS cluster
 -->
