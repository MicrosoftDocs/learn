So far, you've been provisioning individual pods to illustrate the security and storage related AKS concepts. However, the recommended approach to provisioning pods relies on using deployments. In this unit, we examine the differences between pods and deployments and describe the benefits associated with the latter.

### Explore Kubernetes pods

Kubernetes uses *pods* to run individual instances of containerized applications. A pod is a logical Kubernetes resource, but application workloads run within a container. There's typically a 1:1 mapping between a pod and a container, although there are scenarios in which a pod may contain multiple, closely integrated containers. All containers that are part of the same pod run on the same node and share their resources.

When you create a pod, you can define *resource requests* to specify the required amount of CPU or memory resources to be allocated to that pod. The Kubernetes Scheduler attempts to satisfy this request by scheduling the pod to run on a node with a sufficient amount of available resources. You can also specify upper resource limits to prevent a pod from negatively affecting the status of the underlying node or other pods.

Since pods are by default ephemeral and disposable, deploying them as individual resources considerably limits their resiliency and is typically not suitable for production environments. To realize the high availability and redundancy benefits offered by the AKS platform, you should deploy and manage pods by using Kubernetes *Controllers*, such as the Deployment Controller.

### Explore Kubernetes deployments

A *deployment* represents a group of identical pods managed by the Kubernetes Deployment Controller. A deployment defines the number of pod *replicas* to create. The Kubernetes Scheduler ensures that other pods are scheduled on healthy nodes if pods or nodes encounter a problem affecting their availability.

You can update deployments to change the configuration of pods, their container image, or attached storage. During update, the Deployment Controller:

 -  Drains and terminates a given number of replicas.
 -  Creates replicas from the new deployment definition.
 -  Continues the process until all replicas in the deployment are updated.

In addition, if your application requires a minimum number of available instances, you can use *Pod Disruption Budgets* to define how many pod replicas in a deployment can be brought down during an update or node upgrade.

Most stateless applications in AKS should use the deployment model rather than scheduling individual pods. Kubernetes can monitor deployment health and status to ensure that the required number of replicas run within the cluster. When scheduled individually, pods aren't restarted following their failure and aren't rescheduled on a healthy node if their current node fails. In addition, deployments support controlled rollouts and rollbacks.

To help define the deployment, you use a manifest file in the YAML format. You reference the manifest file when running the`kubectl create` or kubectl apply commands.

The following example creates a basic deployment of the NGINX web server. The deployment specifies *three (3)* replicas to be created, and exposes the web server via port *80* on the container. Resource requests and limits specify the expected and maximum amounts of CPU and memory to be allocated to each pod replica.

<!--- raw content start --->
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: Three
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: mcr.microsoft.com/oss/nginx/nginx:1.15.2-alpine
        ports:
        - containerPort: Eighty
        resources:
          requests:
            cpu: 250m
            memory: 64Mi
          limits:
            cpu: 500m
            memory: 256Mi
<!--- raw content end --->

More complex applications can be also integrated with load balancers by including services in their YAML deployment manifest.

### Deploy AKS workloads with Helm

Rather than authoring and managing YAML manifests directly, you might want to consider using Helm. Helm is a package manager for Kubernetes. It automates management of containerized applications by relying on reusable packages referred to as Helm *charts* that contain a packaged version of application code and Kubernetes YAML manifests. You can store Helm charts either locally or in a remote repository, such as an Azure Container Registry.

### Namespaces

Kubernetes resources, such as pods and deployments, are logically grouped into *namespaces*, which helps with organizing them in the manner that reflects their intended use. Namespaces also provide a degree of isolation that facilitates segregating their access.

When you create an AKS cluster, the following namespaces are available:

 -  **default:** serves as the default namespace for resources that weren't allocated to another namespace during their creation. When you interact with the Kubernetes API (for example, when running kubectl get pods), the default namespace is used when none is specified.
 -  **kube-system:** host core resources, including DNS and proxy components. When using AKS, you don't deploy your own applications into this namespace.
 -  **kube-public:** is intended for resources to be visible across the entire cluster to any user.
