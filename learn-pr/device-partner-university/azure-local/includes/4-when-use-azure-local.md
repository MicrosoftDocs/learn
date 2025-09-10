Imagine you're working for a regional healthcare provider with multiple hospitals and clinics. Each facility has strict data residency requirements and must run critical workloads with high availability—even in disconnected environments. At the same time, leadership wants to modernize the datacenter, integrate with cloud services, and centralize management without fully migrating to Azure.

Your organization’s goals are to improve infrastructure reliability, simplify virtualization management, support edge and hybrid scenarios, and maintain compliance with healthcare regulations.

![A photograph of a healthcare worker reviewing a patient X-ray on a digital tablet.](../media/healthcare.png)

## Why Azure Local is a good fit

Azure Local provides hybrid cloud capabilities with on-premises infrastructure, making it a strong option in this scenario. Here's why:

- **Hybrid flexibility**: You need to run workloads locally but want to connect to Azure services for backup, monitoring, and management. Azure Local offers deep Azure integration without forcing a full cloud move.
- **Data sovereignty**: Healthcare data must remain on-premises. Azure Local ensures local storage and compute, while still enabling cloud-based visibility via Azure Arc.
- **High availability**: Clinics require resilient infrastructure to support electronic medical records, imaging systems, and scheduling platforms. Azure Local provides built-in clustering and fault tolerance with validated hardware.
- **Modern virtualization**: You're replacing aging hardware and traditional virtualization platforms. Azure Local runs virtual machines and containers on modern, cost-efficient, hyperconverged infrastructure.
- **Centralized management**: IT teams want consistent management across locations. Azure Local integrates with Windows Admin Center and Azure for centralized monitoring, updates, and policy control.
- **Scalability**: As needs grow, you can scale compute and storage by adding nodes without rearchitecting the environment.

## Why Azure Local might not be a good fit

While Azure Local is powerful, there are situations where it might not align with your environment or goals:

- **Azure dependency**: To get the most value, integration with Azure services is essential. If your organization avoids cloud connectivity, you lose some key benefits.
- **Hardware limitations**: Azure Local must run on validated hardware from approved vendors, which could increase upfront costs or limit customization.
- **Not cloud-native**: If your team is focused on serverless or Kubernetes-first workloads, this platform might feel like a step backward. While it supports containers and Azure Kubernetes Service on hyperconverged infrastructure, it's still virtual machine-centric at its core.
- **Cost model**: Licensing is per-core and might involve both Windows Server and Azure billing, which can be confusing without proper cost modeling.