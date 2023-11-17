IT data centers use virtualization to consolidate dedicated servers into more cost-effective hardware by using them as hosts for virtual machines. Cloud service providers also use it to isolate users sharing a single hardware layer by partitioning physical servers into virtual machines. For example, when you provision an EC2 instance in AWS, Amazon provisions a virtual machine on a server in one of its data centers and begins timing your usage so they can bill you at the end of the month.

Let's examine the benefits of virtualization and understand why it's so important to cloud computing.

**Enabling the cloud computing system model:** A major use case for virtualization is cloud computing. As you know, cloud computing adopts a model whereby software, compute resources, and storage are offered as services. These services include full-blown applications such as Google Docs (Software-as-a-Service, or SaaS), platforms such as Azure App Service for running applications (Platform-as-a-Service, or PaaS), and virtual machines such as Amazon EC2 instances (Infrastructure-as-a-Service, or IaaS). Provisioning a VM involves creating virtual versions of every physical machine component: CPU, memory, I/O, and storage, and is made possible by hypervisors, which rely on both software and firmware. Examples of leading hypervisors include Xen, VMware, and Hyper-V. Amazon EC2 uses Xen to provision VMs for users. Azure uses a custom version of Hyper-V known as the Azure Hypervisor<sup>[1][^1]</sup>.

**Elasticity:** A major benefit of the cloud is elasticity, or the ability to respond quickly to user demands by expanding and contracting resources dynamically. This benefit applies to all cloud service models -- that is, SaaS, PaaS, and IaaS. As shown in Figure 4, virtualization enhances elasticity by allowing providers and users to dynamically increase or decrease the cloud resources being used for a task. For instance, Google App Engine automatically expands servers during demand spikes and contracts them when demand diminishes. Amazon EC2 allows users to expand and contract virtual clusters manually or automatically, the latter by using Amazon Auto Scaling. Azure does the same with Virtual Machine Scale Sets. In short, virtualization is a key technology for elasticity in the cloud, and the fact that we can quickly create and delete VMs is key to elasticity.

![Figure 4: Provisioning a VM on a physical system.](../media/fig4-4.png)

_Figure 4: Provisioning a VM on a physical system._

**Sandboxing:** A VM provides a sandbox that isolates one environment from others, ensuring a level of security that may not be possible with normal operating systems. First, a user who runs an application on a private machine might be reluctant to move her applications to the cloud unless you can guarantee her applications and activities can't be accessed or monitored by other cloud users. Virtualization plays a key role in ensuring safety for every user by making it impossible for one user to observe or alter the data or activity of another user. Second, if an application running in one VM fails, it can't affect applications running in other VMs, even if the VMs are running on the same host. This property is known as **fault containment, and it** increases the robustness of the system. In a non-virtualized environment, by contrast, erratic behavior by one application can bring down the entire system.

As shown in Figure 5, sandboxing presents other interesting possibilities as well. A specific VM can be used as a sandbox whereby security attacks -- for example, denial-of-service attacks or malicious packets inserted into legitimate IP communication streams -- can be safely permitted and monitored. This technique allows researchers to inspect the effects of such attacks, uncover their specific behaviors, and replay them so they can design defenses against future attacks without worrying about compromising a physical server. Furthermore, security teams can send suspicious network packets or input to a specific test VM before it's forwarded to the intended VM to prevent any potential ill effect. A VM can be thrown away after it has served its purpose, while reprovisioning a physical server is both expensive and time-consuming.

![Figure 5: Using virtual machines to isolate and analyze attacks.](../media/fig4-5.png)

_Figure 5: Using virtual machines to isolate and analyze attacks._

**Improved system utilization and reduced costs and energy consumption:** It's well known that computer hardware resources are often underutilized. The concept of resource sharing has been successfully applied in multitasking operating systems to improve system utilization. Such resource sharing is based on the process abstraction -- that is, partitioning running applications into separate processes, each of which is isolated from other processes.

Virtualization takes this a step further by creating an illusion of a complete system where multiple VMs can be hosted at the same time, each running its own operating system image and applications. For instance, in cloud services like Amazon EC2, seven or more VMs can be provisioned on a single server, providing resource utilization of approximately 60% to 80%. In contrast, approximately 5% to 10% average resource utilization is typical in non-virtualized data centers<sup>2</sup>. Virtualization allows consolidating physical servers into virtual servers that run on many fewer physical servers by enabling multiple VMs to be hosted on a single physical server. This concept is called *server consolidation*. Consolidation leads to improved system utilization and reduced costs. VMs can also be migrated from one server to another to balance loads on the servers within a data center.

Another benefit of server consolidation is reduced energy consumption in cloud data centers. Data centers hosting cloud applications consume tremendous amounts of energy, resulting in high operational costs and carbon dioxide emissions<sup>3</sup>. Server consolidation is an effective way to improve the energy efficiency of data centers, by reducing the number of physical servers required. One physical server utilized 80% of the time consumes less energy than eight servers utilized 10% of the time. Studies show that server consolidation can save up to 20% on data-center energy consumption<sup>4, 5</sup>.

Reducing energy consumption in cloud data centers is a key challenge in cloud computing. This has led to innovations like locating data centers underwater to utilize green energy sources and reduce cooling costs<sup>[6][^6],[7][^7]</sup>. Up to 40% of a typical data center's electricity goes to the cooling system. (Thousands of running servers generate a lot of heat.) In 2012, Google reported it saved \$1 billion on cooling costs by increasing the ambient temperature in its data centers from 68 to 80 degrees Fahrenheit<sup>[8][^8]</sup>.

**Mixed-OS environment:** As shown in Figure 6, a single hardware platform hosting virtual machines can support multiple operating systems simultaneously. This ability provides tremendous flexibility for users by allowing them to install their own operating systems, libraries, and applications. For instance, a user can install one operating system for office software and another for application development and testing, all on a single desktop computer or in the cloud.

![Figure 6: Mixed-OS environment offered by system virtualization.](../media/fig4-6.png)

_Figure 6: Mixed-OS environment offered by system virtualization._

**Facilitating research:** Running an OS in a VM allows the hypervisor to instrument access to hardware resources and count specific event types like page faults. Execution traces and machine-state dumps at various points of interest can be taken at the VM level. This simply can't be done on native systems. Finally, system execution can be replayed on VMs from saved state to analyze system behavior ing various scenarios. The complete state of a VM can be saved, cloned, encrypted, moved, and restored -- actions that aren't so easy to do with physical machines<sup>9</sup>. Not surprisingly, it's now common for operating-system researchers to conduct most of their experiments using VMs rather than native hardware platforms<sup>10</sup>.

**Software testing:** Virtualization plays a role in software development by giving engineers a way to test software in an environment that is predictable, replicable, isolated, and platform-agnostic.

- Platform-agnostic: With virtual machines, you can test software written for Linux on a Windows PC by hosting Linux in a VM.
- Isolated: If the software crashes, it can't harm the underlying system
- Replicable: The VM can quickly be deleted and started again
- Predictable: Upon restarting, the VM is in the same state that it was in when last started, and it runs identically on every machine

### References

1. _Microsoft (2019). Design Principles Behind the Windows Azure Hypervisor._

2. _Michelle Bailey (2009). \"The Economics of Virtualization: Moving Toward an Application-Based Cost Model.\" VMware Sponsored Whitepaper._

3. _A. Beloglazov and R. Buyya (2010). \"Energy Efficient Allocation of Virtual Machines in Cloud Data Centers.\" CCGrid._

4. _Silicon Valley Leadership Group (2008). \"Accenture, Data Centre Energy Forecast Report.\" Technical Report._

5. _Y. Jin, Y. Wen, and Q. Chen (2012). \"Energy Efficiency and Server Virtualization in Data Centers: An Empirical Investigation.\" Computer Communications Workshops (INFOCOM WKSHPS)._

6. _Microsoft (2018). *Under the sea, Microsoft tests a datacenter that's quick to deploy, could provide internet connectivity for years*. <https://news.microsoft.com/features/under-the-sea-microsoft-tests-a-datacenter-thats-quick-to-deploy-could-provide-internet-connectivity-for-years/>._

7. _Microsoft (2016). *Microsoft research project puts cloud in ocean for the first time*. <https://news.microsoft.com/features/microsoft-research-project-puts-cloud-in-ocean-for-the-first-time/>._

8. _AirPac (2012). *How Google Saved 1 Billion Dollars in Data Center Cooling Costs*. <https://www.airpacinc.com/blog/bid/83313/How-Google-Saved-1-Billion-Dollars-in-Data-Center-Cooling-Costs>._

9. _Chen and Noble (2001). \"When Virtual Is Better Than Real.\" IEEE Computer Society, Washington, DC, USA_

10. _JE Smith and Nair (2005). \"Virtual Machines: Versatile Platforms for Systems and Processes.\" Morgan Kaufmann._

[^1]: <>  "Microsoft (2019). *Design Principles Behind the Windows Azure Hypervisor*."

[^6]: <https://news.microsoft.com/features/under-the-sea-microsoft-tests-a-datacenter-thats-quick-to-deploy-could-provide-internet-connectivity-for-years/>  "Microsoft (2018). *Under the sea, Microsoft tests a datacenter that's quick to deploy, could provide internet connectivity for years*."

[^7]: <https://news.microsoft.com/features/microsoft-research-project-puts-cloud-in-ocean-for-the-first-time/>  "Microsoft (2016). *Microsoft research project puts cloud in ocean for the first time*."

[^8]: <https://www.airpacinc.com/blog/bid/83313/How-Google-Saved-1-Billion-Dollars-in-Data-Center-Cooling-Costs>  "AirPac (2012). *How Google Saved 1 Billion Dollars in Data Center Cooling Costs*."
