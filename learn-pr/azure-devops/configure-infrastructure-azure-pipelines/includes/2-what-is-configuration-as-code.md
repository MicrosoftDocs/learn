_Configuration as code_ enables you to describe the configuration you need to run your application or service.. In this section, you learn TODO, (TODO concept concept concept), and what tools you can use.

Tim's happy with how Terraform and other infrastructure toolks make it easy to scale out the _Space Game_ website on Azure. He can see how having a single configuration file that's kept in version control simplifies his life. He can control the deployment environments just by editing a single file and running it through the pipeline. Everything feels much better organized, it's easy to keep track of when changes happen and, if there's a problem, he can always roll back to the last version of the configuration file until he figures out what went wrong.

Although the _Space Game_ web application runs on Azure App Service, Tim also maintains a growing number of virtual machines (VMs) that support billing and other functions. Tim is wondering how automation can help him get control of all the VMs that he needs to manage. His network is getting too large to maintain them on a server-by-server basis.

Andy has offered to help. Tim sets up a meeting with him at Andy's favorite coffee shop.

## The meeting

**Tim:** Terraform is working great for the _Space Game_ website.

**Andy:** Yes. Management is really impressed at how we've been able to scale out our deployments.

**Tim:** You thought automation could help me configure VMs, too. They need a lot of attention. There's always something that needs to be updated, and I've got a big problem with _configuration drift_.

**Andy:** What is that exactly?

**Tim:** Configuration drift is where servers become more and more different as time goes on. The state of the machine deviates, or drifts, from the baseline because of manual changes and updates.

I used to think configuration drift was inevitable and just a part of running a datacenter. Now, I suspect it's because a lot of changes are rough, cobbled-together solutions. They might be put in place to fix an immediate problem and they're not even written down. I think automation can fix the problem.

I've been impressed with what Terraform does for automatic provisioning on Azure. I want to do the same to define how our infrastructure is configured.

_Andy nods._

**Andy:** I get it. I think what you're talking about here is _configuration as code_. Configuration as code enables you to describe the configuration you need to run your application or service. With it, you describe the packages, user accounts, firewall rules, and so on, that your application needs.

Here's a short video where Abel Wang, Cloud Advocate at Microsoft, explains the concepts of configuration as code.

**Ask Abel**

> [!VIDEO https://channel9.msdn.com/Blogs/One-Dev-Minute/What-is-Configuration-as-Code--One-Dev-Question/player?format=ny]

Just like the Terraform plan you built in the [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true) module, you typically check in your configuration code to source control along with your application code. Doing so enables you to version, build, test, configure, and deploy your applications as a unit.

## What is configuration management?

_Configuration management_ is a term that's associated with configuration as code. In fact, you might hear the term _configuration management_ more often.

Configuration management refers to the automated management of configuration, typically in the form of automated scripts or programs that you run regularly on your deployments.

For example, say you have dozens or even hundreds of systems that serve the same or similar function, and you need each of them to be configured in the exact same way. How might you open a new firewall port on each system? You could connect to each system remotely and open the port. However, that task is time-consuming and prone to errors. A better way might be to modify an existing configuration management script, and then apply that script through automation to your fleet. Doing so takes much less time and is less prone to error.

When comparing manual configuration processes to those that are more automated, automated processes typically enable you to:

* Reproduce bugs or inconsistencies more easily.
* More easily trace and audit changes over time.
* Configure many related systems more consistently and with fewer errors.
* Deploy more often and at larger scale.

Configuring your systems through automation also frees you from the need to document the differences among systems. Through automation, each system is configured in the exact same way. Your configuration code documents the requirements and the expected results.

Configuration as code helps you implement a configuration management strategy. A good configuration management strategy includes running automated tools to keep all of your systems configured the exact same way. When you run configuration tools in your CI/CD pipeline, such as Azure Pipelines, you ensure that your infrastructure is always configured the way you need it as you build out new features.

## What is configuration drift?

_Configuration drift_ happens when resources change over time from their original deployment state. This is caused by changes made by people, processes, or programs and can happen manually or through automated processes.

Eventually, an environment may become a _snowflake_. A snowflake is a unique configuration that cannot be reproduced automatically, and are typically a result of configuration drift. Inconsistency among environments can lead to unexpected issues during deployment. With snowflakes, infrastructure administration and maintenance typically become manual processes, which can be hard to track and prone to human error. The more an environment drifts from its original state, the more likely it is for an application to encounter issues. The greater the degree of configuration drift, the longer it takes to troubleshoot and fix issues.

### Security considerations

Configuration drift can also introduce security vulnerabilities into your environments. For example:

* Firewall ports may be opened that should be kept closed.
* Updates and security patches might not be applied across environments consistently.
* Software might be installed that doesn't meet compliance requirements.

While eliminating configuration drift entirely can be difficult, running a configuration management tool can help you manage it.

## How does configuration as code relate to infrastructure as code?

The concept of configuration as code is similar to the concept of infrastructure as code. In fact, you can combine the two models to automatically provision and then configure your systems all in one step.

For example, your CI/CD pipeline might use an Azure Resource Manager template, Terraform, or another automated provisioning process to bring up your infrastructure. Then, you might run Chef, Puppet, Ansible, or another configuration tool to configure to set up your infrastructure with everything your application or service needs to run. You'll learn about these tools shortly.

## How do configuration management tools work?

TODO: (reword) Before we compare the tools you can use, there are a few concepts you should understand that releate to most of them. They are:

* Idempotency
* Imperative versus declarative code
* Agent versus agentless models
* Push versus pull model

### Idempotency

You learned about idempotency in [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true). As a refresher, an idempotent operation is one that provides the same result each time you apply it. Idempotency is a term that's used in both mathematics and in computer science.

As with infrastructure as code tools such as Azure Resource Manager templates and Terraform, most configuration as code tools are also idempotent. Although we didn't yet discuss the various tools you can use, consider the following configuration written with Chef:

```ruby
powershell_script 'Install IIS' do
  action :run
  code 'Add-WindowsFeature Web-Server'
end

service 'w3svc' do
  action [ :enable, :start ]
end

template 'c:\inetpub\wwwroot\Default.htm' do
  source 'Default.htm.erb'
  rights :read, 'Everyone'
end
```

On Windows, this configuration:

* Installs Internet Information Services (IIS) web server.
* Starts the World Wide Web Publishing Service (W3SVC), the service that powers IIS.
* Sets the default homepage, *c:\inetpub\wwwroot\Default.htm*.

When you run this configuration for the first time, Chef ensures that IIS is installed, W3SVC is running, and that the home page is set. When you run this configuration a second time, Chef applies the configuration only if the desired state doesn't match. In other words, Chef applies the configuration only when there's work to do. In most cases, Chef makes no changes because the system is already in the desired state, so this configuration is safe to apply as many times as you'd like.

### Imperative versus declarative code

In [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true), you learned the difference between imperative and declarative code.

Generally speaking, _imperative_ code defines both _what_ the program should accomplish as well as _how_ to achieve the result.

In contrast, _declarative_ code defines what the program should accomplish but does _not_ define how to achieve the result.

Think about how you write code in languages like Python, C#, or Java. Each of these languages are imperative. You use variables, conditional statements, and loops to control the state of your program and express the steps you need.

Compare these languages to HTML, which is declarative. HTML describes _what_ elements appear on the page, but it doesn't describe _how_ to display them. The "how" is the web browser's responsibility.

Just like infrastructure as code tools such as Azure Resource Manager templates and Terraform, most configuration use the declarative code model. Consider this very basic Chef configuration:

```ruby
package 'vim'
```

On Linux, this configuration ensures that the Vim text editor is installed. It declares that the **vim** package should be installed, but it doesn't specify _how_ to install it. Chef understands the Linux distribution that's running and can use the appropriate package manager to install the package, for example, **apt** on Debian-based systems or **yum** on Red Hat Enterprise Linux.

### Nodes

These are the devices and/or machines and environments that are being managed. Managed nodes can also be referred to as hosts. Ansible is not installed on nodes.

### Agent versus agentless models

In configuration management, an _agent_ is a background process, such as a service or daemon, that listens for 

In this module, you apply configuration changes each time a change moves through Azure Pipelines. But you can also schedule your systems, or nodes, to . 

Ansible is agent-less, that means no need of any agent installation on remote nodes, so it means there are no any background daemons or programs are executing for Ansible, when it’s not managing any nodes.

Some configuration management tools use an agent-based model; some use an agentless model. Some let you choose which model you want to use.

https://www.tecmint.com/install-and-configure-ansible-automation-tool-in-linux/

### Push versus pull model

asdf

