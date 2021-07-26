The top-level resource in Azure Container Instances is the container group. A container group is a collection of containers that get scheduled on the same host machine. The containers in a container group share a lifecycle, resources, local network, and storage volumes. It's similar in concept to a pod in Kubernetes.

:::image type="content" source="../media/container-groups-ea19ee6b.png" alt-text="Diagram depicts a container group that includes two containers.":::


An example container group:

 -  Is scheduled on a single host machine.
 -  Is assigned a DNS name label.
 -  Exposes a single public IP address, with one exposed port.
 -  Consists of two containers. One container listens on port 80, while the other listens on port 1433.
 -  Includes two Azure file shares as volume mounts, and each container mounts one of the shares locally.

## Deployment options

Here are two common ways to deploy a multi-container group: use a Resource Manager template or a YAML file. A Resource Manager template is recommended when you need to deploy additional Azure service resources (for example, an Azure Files share) when you deploy the container instances. Due to the YAML format's more concise nature, a YAML file is recommended when your deployment includes only container instances.

## Resource allocation

Azure Container Instances allocates resources such as CPUs, memory, and optionally GPUs to a multi-container group by adding the resource requests of the instances in the group. Taking CPU resources as an example, if you create a container group with two container instances, each requesting one CPU, then the container group is allocated 2 CPUs.

## Networking

Container groups can share an external-facing IP address, one or more ports on that IP address, and a DNS label with a fully qualified domain name (FQDN). To enable external clients to reach a container within the group, you must expose the port on the IP address and from the container. Because containers within the group share a port namespace, port mapping isn't supported. A container group's IP address and FQDN will be released when the container group is deleted.

## Common scenarios

Multi-container groups are useful in cases where you want to divide a single functional task into a small number of container images. These images can then be delivered by different teams and have separate resource requirements. Example usage could include:

 -  A container serving a web application and a container pulling the latest content from source control.
 -  An application container and a logging container. The logging container collects the logs and metrics output by the main application and writes them to long-term storage.
 -  An application container and a monitoring container. The monitoring container periodically makes a request to the application to ensure that it's running and responding correctly, and raises an alert if it's not.
 -  A front-end container and a back-end container. The front end might serve a web application, with the back end running a service to retrieve data.
