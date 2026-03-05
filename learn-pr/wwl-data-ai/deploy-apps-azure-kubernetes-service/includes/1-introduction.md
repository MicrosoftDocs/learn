Azure Kubernetes Service (AKS) is a managed Kubernetes cluster running on Azure infrastructure, allowing you to deploy and manage containerized applications without managing the control plane. This module guides you through deploying and exposing AI workloads—like model inference APIs, vector search services, and other containerized applications—on AKS.

Imagine you built a Python FastAPI application that provides AI model inference capabilities. Your application is containerized and ready to run, but you need to deploy it where multiple users can access it with high availability. Without AKS, you'd manage Kubernetes infrastructure yourself or use other deployment methods with limited scalability. With AKS, you define simple YAML manifests and deploy your containerized app to a fully managed Kubernetes cluster—your application automatically scales, survives pod crashes, and becomes accessible to external clients through a load balancer.

## After completing this module, you'll be able to:

- Explain how Deployments, Services, and Pods work together in AKS
- Create Kubernetes Deployment manifests to define how your containerized applications run
- Write Service manifests to expose applications for internal or external access
- Use kubectl to deploy manifests and verify applications are running
- Troubleshoot common deployment issues using kubectl commands
- Deploy and expose an AI inference API on an AKS cluster

## Key Concepts

Before diving into manifests and deployment, understand these core Kubernetes concepts:

**Pods**: The smallest deployable unit in Kubernetes. A Pod wraps your containerized application (for example, a Docker image containing your Python API). While you could run a single Pod directly, you typically don't—Deployments manage Pods for you.

**Deployments**: Define how many copies (replicas) of your application should run. If a Pod crashes, the Deployment automatically restarts it. Deployments are how you specify your container image, resource requirements, environment variables, and other configuration—all in a YAML manifest.

**Services**: Provide a stable, persistent endpoint for accessing Pods. Services use selectors (labels) to find which Pods to send traffic to. Different Service types (ClusterIP, NodePort, LoadBalancer) determine whether traffic comes from within the cluster or the internet.

**kubectl**: The command-line tool for interacting with Kubernetes. You use kubectl to apply manifests, check pod status, view logs, and troubleshoot issues.

These four concepts—Pods, Deployments, Services, and kubectl—are all you need to deploy and expose applications on AKS.
