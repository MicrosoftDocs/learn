AKS Edge Essentials is the lightest weight AKS hybrid solution available. It's designed to run with a small resource footprint and simple installation experience, making it easy to run Kubernetes on PC-class or "light" edge hardware, such as Windows 10/11 (IoT Enterprise / Enterprise / Pro) or Windows (Server / Server IoT) 2019/2022. It brings cloud-native best practices to your edge application, making it easier to get started with your containerized application.

To maintain a small resource footprint with the most focused possible experience, AKS Edge Essentials is designed for running predefined AKS configurations in production. Each machine in an AKS Edge Essentials cluster can have one Linux and an optional Windows node. The Linux VM acts as the control node and worker node for Linux workloads in the Kubernetes cluster.

:::image type="content" source="../media/2-aks-edge-essentials-light-edge-inline.png" alt-text="Diagram of AKS solution spanning cloud-to-edge - Light Edge" lightbox="../media/2-aks-edge-essentials-light-edge-expanded.png":::

### Microsoft-managed Kubernetes platform

AKS Edge Essentials includes the following features, managed by Microsoft:

- A lightweight, CNCF-conformant K8S and K3S distribution that is supported and managed by Microsoft. The key difference between AKS on server-class hardware (AKS-HCI) and AKS on "light" edge hardware running Windows is the minimal compute and memory requirements (4-GB RAM and 2 vCPUs).
- Each Kubernetes node runs in its own Hyper-V isolated virtual machine and includes many features to help secure your container infrastructure. The Linux VM is fully managed and is based on a curated CBL-Mariner image, which is a lightweight image that helps reduce attack surface, ensures better performance, and provides less overhead for patching vulnerabilities.
- Microsoft-maintained Linux and Windows worker nodes virtual machine images adhere to security best practices. Microsoft also refreshes these images monthly with the latest security updates.
- Simplified installation experience with PowerShell cmdlets and agents to enable provisioning and control of VMs and infrastructure. Microsoft provides automatic updates for your Kubernetes deployment, so you stay up-to-date with the latest available Kubernetes versions.

### Locally install nodes on single or multiple machines

AKS Edge Essentials simplifies the process of Kubernetes setup by providing PowerShell scripts and cmdlets to set up Kubernetes and create single or multi node Kubernetes clusters.

### Run Linux and Windows containers

AKS Edge Essentials fully supports both Linux-based and Windows-based containers. When you create a Kubernetes cluster on AKS, you can choose to run Linux containers, Windows containers, or both.

### Cloud-based management using Azure Arc

Once you have set up on-premises Kubernetes using AKS Edge Essentials and created a Kubernetes cluster, you can manage your Kubernetes infrastructure using the Azure portal, which provides a centralized management console for Kubernetes clusters running anywhere. In addition, various Azure Arc-enabled services like Azure policy, Azure monitor, and Azure Machine Learning services enable you to ensure compliance, monitor your clusters, and run cloud-services on your edge clusters. It helps to ensure that applications and clusters are consistently deployed and configured at scale from source control.

## How AKS Edge Essentials helps manage multiple camera streams at once?

Remember that our company wants to provide an efficient shopping experience for their customers, and needs a solution to incorporate software that is able to ingest, process and manage multiple camera streams at once, while making it secure and reliable. AKS Edge Essentials running on a Windows IoT Enterprise machine helps us automate and run our containerized applications, as it simplifies on-premises Kubernetes deployment by making it easy to install, configure clusters, and manage application deployment across all clusters using a cloud-based management plane.

:::image type="content" source="../media/2-aks-edge-Windows-inline.png" alt-text="Diagram of AKS Edge Essentials architecture." lightbox="../media/2-aks-edge-Windows-expanded.png":::