Kubernetes is one of the most well-liked tools for managing the deployment, scaling, and operation of containerized applications. Cloud Native Computing Foundation (CNCF) is responsible for maintenance.

Kubernetes is formed from *control planes* and *workers*. Control planes serve Kubernetes API (Application Programming Interface), scheduling containers, storing cluster state, and controller manager. Workers serve kubelet, kube-proxy, and the runtime. Here's a high-level overview of the Kubernetes architecture.

:::image type="content" source="../media/5-kubernetes-cluster.png" alt-text="Diagram that shows the components of the Kubernetes control plane and the worker nodes.":::

Managing Kubernetes can get tricky. Azure Kubernetes Services (AKS) helps you manage the overhead involved. It reduces complexity and management tasks like upgrades. In the next sections, we'll explore Kubernetes components and how you can troubleshoot each of them. Keep in mind AKS abstracts much of the infrastructure for you. However, you're responsible for worker nodes and troubleshooting applications on top of an AKS cluster.

## Kubelet

Kubelet is an agent that runs on each node in a Kubernetes cluster. Its primary responsibility is to ensure that containers are running on the node as expected. It communicates with the Kubernetes control plane to get instructions on what containers should be running and how they should be configured. It then takes actions to ensure those containers are running and healthy.

Kubelet is an important component of the Kubernetes architecture. It's important to understand its responsibilities, which are the following tasks:

- Pull container images from a container registry.
- Start and stop containers.
- Monitor container health and restart failed containers.
- Mount and unmount volumes.
- Run lifecycle hooks.
- Report container status to the control plane.

In summary, Kubelet is a critical component of a Kubernetes cluster as it's responsible for ensuring that containers are running smoothly and according to the cluster's desired state.

By default, the kubelet logs can be found at `C:\k\kubelet.log`.

## Interacting with Kubernetes API

Kubernetes API server is the main control plane on a Kubernetes environment. Knowing how to interact with it allows you to define your cluster and resources. The main tool to query the Kubernetes API for information is *kubectl*. You first need a kube_config file that describes the server endpoint, your user, and your token. Usually you find it in `~/.kube/config`.

 One of the most common commands to retrieve information about objects is `kubectl get`. You can add `-o wide` to provide additional information about the queried objects. This command retrieves the list of nodes in a Kubernetes cluster:

```powershell
kubectl get nodes -o wide
```

This command retrieves the pods on a specific namespace:

```powershell
kubectl get pods -n <namespace> -o wide
```

This command retrieves the services on a specific namespace:

```powershell
kubectl get service -n <namespace> -o wide
```

In addition to `-o wide`, you can get the YAML specification of an object by adding the `yaml` flag to the command.

You can also get detailed information, including events, of Kubernetes objects by using the `kubectl` describe command:

```powershell
kubectl describe pod <pod id> -n <namespace>
```

This command returns the extended specification of the specified pod, and the latest events associated to it. Finally, the `kubectl describe` command can be used with other objects such as nodes, services, ingress, etc.

## Connect to AKS Windows node RDP

As a managed Kubernetes service, you shouldn't have to manually manage Windows nodes on AKS. The node lifecycle is managed for you by Azure. However, you might want to check what's going on with the Windows node to troubleshoot a potential problem. In those cases, you can enable RDP to the Windows nodes running on an AKS cluster.

First, you need to deploy a Windows node to the same subnet as your AKS cluster. It's basically a jump box. Then, add an inbound security rule for 3389 (RDP port) to connect to the jump box. Next, you need the internal IP address of the target node, which you can retrieve using this command:

```powershell
kubectl describe node
```

You can change the Windows admin password for the Kubernetes Windows nodes with:

```bash
az aks update -g myResourceGroup -n myAKSCluster --windows-admin-password $WINDOWS_ADMIN_PASSWORD
```

Finally, RDP from the jump box to the target Kubernetes node. From there, you can follow all the troubleshooting ideas described so far to solve your issue.

## Node selector

By default, Kubernetes doesn't know if a container should be scheduled on Linux or Windows. If you want to schedule a pod/deployment to a Windows node, you need to specify a `nodeSelector`.

NodeSelector is the simplest recommended form of node selection constraint. You can add the `nodeSelector` field to your deployment specification and specify the node labels you want the target node to have. Kubernetes only schedules the Pod onto nodes that have each of the labels you specify.

An example of deployment can look like this:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iissample
  labels:
    app: iissample
spec:
  replicas: 1
  template:
    metadata:
      name: iissample
      labels:
        app: iissample
    spec:
      nodeSelector:
        "kubernetes.io/os": windows
      containers:
      - name: iissample
        image: mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022
        resources:
          limits:
            cpu: 1
            memory: 800M
          requests:
            cpu: .5
            memory: 400M
        ports:
          - containerPort: 80
  selector:
    matchLabels:
      app: iissample
```

The YAML specification describes a deployment of an IIS image. To ensure the pod is scheduled on a Windows node, note the NodeSelector information, which specifies the label `Kubernetes.io/os` needs to be set up to Windows.

## Registry authentication

By default, Kubernetes clusters don't have the credential to log into private container registries. In these cases, your Kubernetes cluster is in a fault state as the nodes can't pull the images you'd like to deploy. To avoid, you need to configure registry authentication manually as part of your deployment and cluster configuration. However, if you're using Azure Container Registry (ACR), Microsoft makes the integration easy. You can run:

```bash
az aks update -n myAKSCluster -g myResourceGroup –attach-acr <acr-name>
```

The command attaches the private ACR registry to the AKS cluster, and configures the necessary authentication in the background. It works with AKS clusters and ACR registries in the same Azure Resource Group (RG).

If you use any other registries or an ACR registry on another Azure RG or subscription, you need to create a `regcred` secret. `Regcred` is the standard name, and it needs to exist in the namespace in which you want the deployment. You can create it like this:

```powershell
kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```

You also need to specify in the deployment to use this secret:

```yml
apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  containers:
  - name: private-reg-container
    image: <your-private-image>
  imagePullSecrets:
  - name: regcred
```

If you need to populate many namespaces with the same secret, you can use a replicator. It automates the creation of your Configmaps and Secrets to other namespaces.

## Debug Pods

When analyzing a pod, you might encounter it in a faulty state. Here are some common pod states that you might find:

- **Pending**

   If a container has the status as Pending, it means the scheduler was unable to allocate it to a node. Make sure you properly configured the NodeSelector. Other causes can be lack of resources, exhausting CPU, or available memory.

- **Waiting**

   The waiting state indicates the container is scheduled but unable to run. Use `kubectl describe pod`, which might give us the latest events and potential clues on why it can't run on the associated node. Usual root causes are an incorrect image name or an image not in the indicated registry.

- **CrashLoopBackOff**

   When this message appears, it means that the runtime is unable to run the image. Once again, `kubectl describe pod` is the first step to identify potential issues. Reasons for this state vary, but are usually around application failure or a mismatch between container version and host version. To see why the application failed, you can query for the logs. Make sure you use LogMonitor to include all of the logs to STDOUT. Kubectl logs should retrieve the logs and potentially inform of other issues with the application or pod.

   To retrieve the logs of a container, you can use:

   ```powershell
   kubectl logs <pod name>
   ```

   The command will show the existing logs for the specified pod. If you need to catch the logs in real time, for a running application, you can use:

   ```powershell
   kubectl logs -f <pod name>
   ```

## Connect to the container

Just like with Docker, you can use `kubectl` to open an interactive session and connect to a running container to debug the running environment:

```powershell
kubectl -n <namespace> exec -it <podname> ps
```
