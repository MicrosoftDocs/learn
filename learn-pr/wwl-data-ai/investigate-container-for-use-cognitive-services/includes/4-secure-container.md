Security of your Cognitive Services endpoints is critical to keep sensitive data protected and avoid a nefarious person using resources that cost you money. Azure Cognitive Services, which are not containerized, require you to authenticate with a subscription key by default. However, when running as a container those permissions are not in place. Once you are hosting the service, you are responsible for securing access to the container.

## Scan container for vulnerabilities

Container security practices apply to the Cognitive ServiceA good practice is to periodically scan containers with tools that detect potential vulnerabilities. When deploying to Azure Container Registry, you have the option to use Azure Security Center to scan all Linux images.

## Restrict external networks

In most cases, the container is deployed into an environment where only other containers on the cluster can reach it. You control access to the deployed container by keeping the container endpoint private and limiting connections from the internal network. Once secured, access should be from specific containers in the application or through a front-facing component that is secured.

In the previous exercise, a public port was specified on the language detection container. You can remove the public port to protect the container from unwanted requests. This change would happen in the Kubernetes manifest (the YAML file that defined the deployment).

You should also restrict network access to the Kubernetes cluster. The steps vary depending on how you run Kubernetes. If you are responsible for the cluster network security, be sure to read up on Kubernetes network security. When working with Azure Kubernetes Service you have options to run within a virtual network, use Azure Firewall, and use a private cluster. You can learn more by reviewing documentation on network security options in AKS. 

## Add ingress controller

Access to containers in your application will be limited, but you need to interact with the application. An ingress controller will provide one entry point to the containers you have deployed. It will act as a gateway to your containers and can secure traffic so connections use TLS and must authenticate before using your services. There are many options for ingress controllers in Kubernetes.

You may consider a solution such as Istio or NGINX to act as the secure front-facing endpoint. Authentication can be added at the ingress controller. For example, INGINX Ingress Controller supports basic authentication or certificate authentication with a few setup steps. Additional capability like OAuth can be added with some additional external components. Another option specific to Azure is the Application Gateway Ingress Controller.

:::image type="content" source="../media/03-container-deploy-unsecure-connect.png" alt-text="Diagram showing unsecure container access with users connecting directly to cognitive services container. ":::

:::image type="content" source="../media/03-container-deploy-secure-ingress-controller.png" alt-text="Diagram showing secure container access with users connecting through ingress controller.":::
