Here, you learn about the criteria used when deciding if AKS Edge Essentials is appropriate to automate and run your containerized applications. Then you apply the criteria to the scenario described in the introduction unit.

## Decision criteria

AKS Edge Essentials is a Microsoft-supported Kubernetes platform that automates running containerized applications at scale. It's designed for static, predefined configurations and has minimal compute and memory requirements (4-GB RAM and 2 vCPUs). AKS Edge Essentials runs on Windows 10/11 (IoT Enterprise / Enterprise / Pro) or Windows (Server / Server IoT) 2019/2022. If you require a longer servicing option and don’t need functionality and feature updates as frequently as other general purpose devices in the organization, then you shall consider Windows IoT Enterprise with a 10-year Long-Term Servicing Channel (LTSC) for the host OS.

AKS Edge Essentials doesn't enable dynamic VM creation/deletion or cluster lifecycle management. Each machine in an AKS Edge Essentials cluster can only have one Linux and/or Windows VM. The Linux VM acts as the control node and worker node for Linux workloads in the Kubernetes cluster. If you need a failover clustering support with dynamic creation of virtual machines that enables High Availability at the infrastructure layer, then you shall consider AKS on Azure Stack HCI or Windows Server.

Let's take a look at some of the criteria you should consider when determining if AKS Edge Essentials is best for you:

| **Criteria** | **Analysis**|
| --- | --- |
| **High availability at the infrastructure layer** | AKS Edge Essentials doesn't enable dynamic VM creation/deletion or cluster lifecycle management. If you need a failover clustering support with dynamic creation of virtual machines that enables High Availability at the infrastructure layer, then you shall consider AKS on Azure Stack HCI or Windows Server.|
| **Compute and memory requirements** | At the operational edge, containerized workloads generally must run alongside other applications like a Point-of-Sale application or a healthcare application on an MRI machine. AKS Edge Essentials consumes limited resources. In its minimum configuration, AKS Edge Essentials has minimal compute and memory requirements (4-GB RAM and 2 vCPUs).|
| **Fixed purpose device** | Windows powers many ATM machines, point-of-sale terminals, industrial automation systems, thin clients, medical devices, digital signage, kiosks, and other fixed purpose devices. Windows IoT Enterprise allows you to build these fixed purpose devices with specific allowances and restrictions in the license agreement. Opt by running AKS Edge Essentials on Windows IoT Enterprise when you plan for a production IoT scenario.|
| **10-year Long-Term Servicing Channel (LTSC)** | When targeting fixed purpose devices that often require a longer servicing option and don’t need feature updates as frequently as other devices in the organization, then you shall consider running AKS Edge Essentials on Windows IoT Enterprise with a 10-year Long-Term Servicing Channel (LTSC).|

## Apply the criteria

The following flowchart illustrates the key questions to ask when you're considering using AKS Edge Essentials to automate and run your containerized applications.

:::image type="content" source="../media/4-aks-edge-criteria-inline.png" alt-text="Diagram that summarizes the decision process for determining if AKS Edge Essentials is appropriate to automate and run your containerized applications." lightbox="../media/4-aks-edge-criteria-expanded.png":::

AKS Edge Essentials works at its full potential when it's not mandatory to have High Availability at the infrastructure layer and you're targeting PC-class fixed purpose devices for production IoT Scenarios. The decision is often a judgment call though and there are edge cases that are difficult to decide. Let's think about how to apply these criteria to the example scenario.

| Criteria | Requirement | Use AKS Edge Essentials? |
| --- | --- | --- |
| **High availability at the infrastructure layer** | On each grocery store, you configured an AKS Edge Essentials cluster to run on multiple machines to support a distributed microservices architecture. You defined static CPU and memory resources that you'd like to allocate for each of the VMs on each machine, and don't require dynamic VM creation/deletion or cluster lifecycle management. | No |
| **Compute and memory requirements** | Each grocery store has their unique set of cameras streaming to one or more PC-class devices sitting at the store facilities. | Yes |
| **Fixed purpose device** | You're deploying fixed purpose devices for a production IoT scenario. | Yes |
| **10-year Long-Term Servicing Channel (LTSC)**| The scenario is targeting **core services** like governance, monitoring, application, machine learning, and data services from the multiple camera streams. The specialized devices at each grocery store need to work without constant update feature disturbances. | Yes - use Windows IoT Enterprise LTSC as the host OS|