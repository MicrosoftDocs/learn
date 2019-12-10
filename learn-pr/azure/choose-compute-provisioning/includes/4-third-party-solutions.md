Let's consider Chef and Terraform against the same criteria as in the previous unit.

## Chef

- **Ease of setup.** The Chef server runs on the master machine and Chef clients run as agents on each of your client machines. You can also use hosted Chef and get started much faster, instead of running your own server.
- **Management.** The management of Chef can be difficult as it uses a Ruby-based domain-specific language. You may need a Ruby developer to manage the configuration.
- **Interoperability.** Chef server only works under Linux and Unix, but the Chef client can run on Windows.
- **Configuration language.** Chef uses a Ruby-based domain-specific language.
- **Limitations and drawbacks.** The language can take time to learn, especially for those developers who are not already familiar Ruby.

### Scenario

Your organization has decided to let the developers create some virtual machines for their own testing purposes. The development team know various programming languages and recently started writing Ruby applications. They'd like to be able to scale these applications and run them on test environments. They're familiar with Linux. The developers run only Linux-based machines and destroy them once testing is complete.

The scenario is ideal for Chef, since you're letting the programmers create their own environments by using their own Ruby configuration scripts. They're already familiar with Ruby, since they've written applications with the language.

### Solution summary

Chef is suitable for large-scale infrastructure deployment and configuration, and makes it easy for you to automate the deployment of an entire infrastructure, such as in the workflow of a development team.

## Terraform

- **Ease of setup.** To get started with Terraform, you have to download the version that corresponds with your operating system, and install it.
- **Management.** Terraform's configuration files are designed to be easy to manage.
- **Interoperability.** Terraform supports Azure, Amazon Web Services, and Google Cloud Platform.
- **Configuration language.** Terraform uses Hashicorp Configuration Language (HCL). Alternately you can also use JSON.
- **Limitations and drawbacks.** Because Terraform is managed separately from Azure, you may find that you can't provision some types of services or resources.

### Scenario

Your organization has gained a new client who wants to create multiple virtual machines across several cloud providers. The client has asked that three new virtual machines be created in Azure and one other public cloud. The client wants the virtual machines to be similar and these machines should be created by using a script that works with both providers. This approach will help the client have a better idea of what they've provisioned across providers.

Terraform would be a good solution for this scenario and would make it possible for you to create virtual machines and other resources on multiple providers easily.

### Solution summary

Terraform allows you to plan the infrastructure as code, and gives you a preview of what the code will create. You can have that code peer-reviewed, to minimize errors in configuration. Terraform supports infrastructure configurations across multiple different cloud service providers.
