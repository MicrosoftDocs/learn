The goal here was to help you evaluate whether Kubernetes would be a good choice as a container-orchestration platform for your business. You looked at several features that enhance the Azure Kubernetes Service (AKS) offering. You learned how these features can help you decide if Kubernetes is a good fit for new projects, or if you should move to Kubernetes to orchestrate current container deployments.

You saw how Kubernetes provides for:

- Deployment of containers.
- Self-healing of containers.
- Dynamically scaling container count up or down.
- Automated rolling updates and rollbacks of containers.
- Management of storage.
- Management of network traffic.
- Storage and management of sensitive information such as usernames and passwords.

To deploy and manage your drone-tracking solution into new customer regions, you were looking for a container-orchestration platform. You now understand how Kubernetes can help you develop, deploy, and manage apps in your container environment.

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
