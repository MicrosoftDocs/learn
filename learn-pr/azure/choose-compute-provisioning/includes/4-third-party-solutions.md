Consider Chef and Terraform against the same criteria as in the previous unit:

## Chef

- **Scalability** -   Highly scalable for provisioning compute resources from small to large infrastructure.

- **Ease of set up** - Master/agent set up. The Chef server runs on the master machine and the Chef clients run as agents on each client machine.  You can provision a Chef server through the Azure Portal.

- **Ease of management** -   The management of Chef can be difficult as it uses its own configuration language called Ruby. So, you may need a programmer to manage the configuration.

- **Interoperability** -   Chef server only works under Linux/Unix, but the Chef client can be on Windows.

- **Configuration language** – Ruby

- **Limitation/drawbacks** - Templating language can be hard to learn, especially for those not already familiar with the Ruby programming language. Other platforms have better pre-configured deployment scripts.

- **Scenario**

  Your organization has decided to let the developers create some virtual machines for their own testing purposes. The development team are well-versed in various programming languages and recently started writing Ruby applications, they'd like to be able to scale these applications and run them on test environments.  They are very familiar with Linux.  The developers are only running Linux based machines and destroying them once testing is complete.

  The scenario is ideal for Chef, since you are letting the programmers create their own environments using their own Ruby configuration scripts.  They are already familiar with Ruby since they've written applications with the language already.

- **Summary** - Chef is suitable for high scale infrastructure deployment and configuration, and makes it easy for you to automate the deployment of an entire infrastructure, such as in the workflow of a development team.

## Terraform

- **Scalability** - Highly scalable for provisioning compute resources from small to large infrastructure.

- **Ease of set up** - In order to install Terraform, all you would have to do is download the right version corresponding to your operating system, and install it.

- **Management**  -  Terraform is very easy to manage.

- **Interoperability** -   Supports Amazon Web Services, Microsoft Azure, and Google cloud platform.

- **Configuration language** -   Terraform uses Hashicorp Configuration Language (HCL). Alternately you can also use JSON (JavaScript Object Notation).

- **Limitation/Drawbacks** -   Because Terraform is a tool managed separately from Azure, it is reasonable to expect that there will be instances where you will not be able to provision a service or a resource, because it may take some time for an Azure resource or service to be represented and available to provision using Terraform.

- **Scenario**  

  Your organization has gained a new client who wants to create multiple virtual machines across several cloud providers.  The client has asked that 3 new virtual machines be created in Azure and one other public cloud, the client wants the virtual machines to be similar and these machines should be created using a script that can be used on both providers.  This will help the client have a better idea of what they have provisioned across providers.

  Terraform would be a good solution for this scenario and would make it possible for you to create virtual machines and other resources on multiple providers in a relatively easy manner.

- **Summary** -   Terraform allows you to plan the infrastructure as code, and gives you a preview of what the code will create. You can have that code peer-reviewed, so it helps to minimize errors in configuration. Terraform will allow you to structure, and also deploy your cloud infrastructure by taking a preventative approach to unforeseen issues.
