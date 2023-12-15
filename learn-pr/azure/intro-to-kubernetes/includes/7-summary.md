The goal here was to help you evaluate whether Kubernetes would be a good choice as a container-orchestration platform for your business. You built an app with Kubernetes running on a virtual machine. You evaluated whether Kubernetes is a good fit for new projects with multiple pieces. If you plan to use Kubernetes to orchestrate your container deployments, the Azure Kubernetes Service offers built-in cloud native support to simplify your journey.

Through this module, you saw how Kubernetes provides for:

- Deployment of containers.
- Self-healing of containers.
- Dynamically scaling container count up or down.
- Automated rolling updates and rollbacks of containers.
- Management of storage.
- Management of network traffic.
- Storage and management of sensitive information such as usernames and passwords.

To deploy and manage your drone-tracking solution into new customer regions, you found a container-orchestration platform. You now understand how Kubernetes can help you develop, deploy, and manage apps in your container environment.

## Uninstall MicroK8s

To recover space on your development machine, you can remove everything you've deployed so far, even the VM. Keep in mind that this procedure is optional.

1. To remove the add-ons from the cluster, run the `microk8s.disable` command, and specify the add-ons to remove:

    ```bash
    sudo microk8s.disable dashboard dns registry
    ```

1. To remove MicroK8s from the VM, run the `snap remove` command:

    ```bash
    sudo snap remove microk8s
    ```

If you want to remove the Multipass VM manager from your machine, there are a few extra steps to take on Windows and macOS.

1. To exit the VM, run the `exit` command:

    ```bash
    exit
    ```

1. To stop the VM, run the `multipass stop` command and specify the VM's name:

    ```bash
    multipass stop microk8s-vm
    ```

1. To delete and purge the VM instance, run `multipass delete`, then run `multipass purge`:

    ```console
    multipass delete microk8s-vm
    multipass purge
    ```

## Learn more

To learn more about Kubernetes, running Kubernetes on Azure, and related tools, visit the following sites and articles:

- [Kubernetes](https://kubernetes.io?azure-portal=true)
- [Azure Kubernetes Service](https://azure.microsoft.com/services/kubernetes-service/?azure-portal=true)
- [MicroK8s](https://microk8s.io?azure-portal=true)
- [Multipass GitHub repository](https://github.com/canonical/multipass/releases?azure-portal=true)
