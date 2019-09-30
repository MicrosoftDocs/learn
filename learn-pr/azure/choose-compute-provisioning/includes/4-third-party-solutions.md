Let's consider Chef and Terraform against the same criteria as in the previous unit.

## Chef

- **Ease of setup** - The Chef server runs on the master machine and Chef clients run as agents on each of your client machines. You can also use hosted Chef and get started much faster instead of having to running your own server.
- **Ease of management** - The management of Chef can be difficult as it uses a Ruby-based domain-specific language. So, you may need a programmer to manage the configuration.
- **Interoperability** - Chef server only works under Linux/Unix, but the Chef client can be on Windows.
- **Configuration language** – A Ruby-based domain-specific language.
- **Limitation/drawbacks** - The language can take time to learn, especially for those developers not already familiar with the Ruby programming language.

### Scenario

Your organization has decided to let the developers create some virtual machines for their own testing purposes. The development team are well-versed in various programming languages and recently started writing Ruby applications, they'd like to be able to scale these applications and run them on test environments. They're familiar with Linux. The developers are only running Linux-based machines and destroying them once testing is complete.

The scenario is ideal for Chef, since you're letting the programmers create their own environments using their own Ruby configuration scripts. They're already familiar with Ruby since they've written applications with the language already.

### Summary

Chef is suitable for high scale infrastructure deployment and configuration, and makes it easy for you to automate the deployment of an entire infrastructure, such as in the workflow of a development team.

## Terraform

- **Ease of setup** - To get started with Terraform, you have to download the right version corresponding to your operating system, and install it.
- **Management** - Terraform is easy to manage.
- **Interoperability** - Supports Azure, Amazon Web Services, and Google Cloud Platform.
- **Configuration language** - Terraform uses Hashicorp Configuration Language (HCL). Alternately you can also use JSON (JavaScript Object Notation).
- **Limitation/Drawbacks** - Because Terraform is a tool managed separately from Azure, it's reasonable to expect that there will be instances where you can't provision a service or a resource, because it may take some time for an Azure resource or service to be represented and available to provision using Terraform.

### Scenario

Your organization has gained a new client who wants to create multiple virtual machines across several cloud providers. The client has asked that three new virtual machines be created in Azure and one other public cloud. The client wants the virtual machines to be similar and these machines should be created using a script that can be used on both providers. This approach will help the client have a better idea of what they've provisioned across providers.

Terraform would be a good solution for this scenario and would make it possible for you to create virtual machines and other resources on multiple providers in a relatively easy manner.

### Summary

Terraform allows you to plan the infrastructure as code, and gives you a preview of what the code will create. You can have that code peer-reviewed, so it helps to minimize errors in configuration. Terraform supports infrastructure configurations across multiple different cloud service providers.
