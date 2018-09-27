Now that you've been introduced to the Azure compute services available, let's look at each more closely to help you decide when to use each service.

## Azure virtual machines

:::row:::
  :::column:::
    ![Image representing Azure virtual machines](../media/3-azure-vms.png)
  :::column-end:::
  :::column span="3":::
When you need total control over the operating system and environment, virtual machines are an ideal choice. You're able to customize all of the software running on the VM, just like a physical computer. This is especially ideal when running custom software or custom hosting configurations.
  :::column-end:::
:::row-end:::

VMs are also an excellent choice when moving from a physical server to the cloud. You can often create an image of the physical server and host it within a virtual machine. This gives you complete freedom to choose operating systems and application execution environments, meaning you can develop in almost any language that uses the tools of your choice.

However, you'll be required to maintain the virtual machine. This means updating the operating system and the software it runs. 

It also requires more consideration when scaling. You can scale up the virtual machine, meaning you can add more compute and memory resources. But if you need to run multiple instances in parallel, or scale out, you may need to add additional services, such as load balancers.

So, imagine you're running a web site that enables scientists to upload astronomy images that need to be processed. If you duplicated the VM, you'd need an additional service to route requests between multiple instances of the web site VM.

There are also advanced virtual machine services available in Azure:

- Use the **Virtual Machine Scale Sets** option when you need to run consistently available instances of the same app, or sets of apps, on similarly configured VMs. It automatically generates thousands of identical VMs loaded with your application in minutes, so your users never have to wait. And, since you don't have to pre-provision virtual machines, you use only the compute resources your application needs at any time.

- Use the **Batch** option when you need cloud-scale job scheduling and compute management with the ability to scale to tens, hundreds, or thousands of VMs. There may be situations in which you need raw computing power or supercomputer level compute power &mdash; Azure provides these capabilities.

## Azure containers

:::row:::
  :::column:::
    ![Image representing Azure containers](../media/3-azure-containers.png)
  :::column-end:::
  :::column span="3":::
If you wish to run multiple instances of an application on a single virtual machine, containers are an excellent choice. The container orchestrator can start, stop, and scale out application instances as needed.
  :::column-end:::
:::row-end:::

#### VMs versus containers

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yuaq]

However, containers are commonly used to create solutions using a microservice architecture. Containers are often used to create solutions using a microservice architecture, as they are often used to break solutions into smaller pieces. For example, you may split a web site into a container hosting your front end, another hosting your back end, and a third for storage. This allows you to separate portions of your app into logical sections that can be maintained, scaled, or updated independently.

#### What is a microservice?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yual]

Imagine your web site back end has reached capacity but the front end and storage aren't being stressed. You could scale the back end separately to improve performance, or you could decide to use a different storage service. Or you could even replace the storage container without affecting the rest of the application.

If your team is comfortable with using Kubernetes container orchestration, consider the **Azure Kubernetes Service (AKS)** option. It simplifies and automates the management, deployment, and operations of Kubernetes orchestration.

#### What is Kubernetes?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEuX]

## Azure Functions

:::row:::
  :::column:::
    ![Image representing Azure Functions](../media/3-azure-functions.png)
  :::column-end:::
  :::column span="3":::
When you're concerned only about the code running your service, and not the underlying platform or infrastructure, Azure Functions are ideal. They're commonly used when you need to perform work in response to an event, often via a REST request, timer, or message from another Azure service and when that work can be completed quickly, within seconds or less.
  :::column-end:::
:::row-end:::

Azure Functions scale automatically, so they're a solid choice when demand is variable, and you're charged only when a function is triggered. For example, you may be receiving messages from an IoT solution used to monitor a fleet of delivery vehicles. You'll likely have more data arriving during business hours.

Furthermore, Azure Functions are stateless; they behave as if they're restarted every time they respond to an event. This is ideal for processing incoming data. And if state is required, they can be connected to an Azure storage service.
