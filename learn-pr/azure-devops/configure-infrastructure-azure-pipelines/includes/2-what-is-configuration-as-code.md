_Configuration as code_ enables you to describe the configuration you need to run your application or service. In this section, you learn some of the important concepts that relate to configuration management, and how configuration management tools work.

In [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true), you used Terraform to provision the _Space Game_ website on Azure. Tim's happy with how Terraform and other infrastructure tools make it easy to scale out. He can see how having a single configuration file that's kept in version control simplifies his life. He can control the deployment environments just by editing a file and running it through the pipeline. Everything feels much better organized, it's easy to keep track of when changes happen, and, if there's a problem, he can always roll back to the last version of the configuration file until he figures out what went wrong.

Although the _Space Game_ web application runs on Azure App Service, Tim also maintains a growing number of virtual machines (VMs) that support billing and other functions. Tim is wondering how automation can help him get control of all the VMs that he needs to manage. His network is getting too large to maintain them on a server-by-server basis.

Andy has offered to help. Tim sets up a meeting with him at Andy's favorite coffee shop.

## The meeting

**Tim:** Terraform is working great for the _Space Game_ website.

**Andy:** Yes. Management is really impressed at how we've been able to scale out our deployments.

**Tim:** You thought automation could help me configure VMs, too. They need a lot of attention. There's always something that needs to be updated, and I've got a big problem with _configuration drift_.

**Andy:** What's that exactly?

**Tim:** Configuration drift is where servers differ more and more as time goes on. The state of the machine deviates, or drifts, from the baseline because of manual changes and updates.

I used to think configuration drift was inevitable and just a part of running a datacenter. Now, I suspect it's because a lot of changes are rough, cobbled-together solutions. They might be put in place to fix an immediate problem, and they're not even written down. I think automation can fix the problem.

I've been impressed with what Terraform does for automatic provisioning on Azure. I want to do the same to define how our infrastructure is configured.

_Andy nods._

**Andy:** I get it. I think what you're talking about here is _configuration as code_. Configuration as code enables you to describe the configuration you need to run your application or service. With it, you describe the packages, user accounts, firewall rules, and so on, that your application needs.

Here's a short video where Abel Wang, Cloud Advocate at Microsoft, explains the concepts of configuration as code.

**Ask Abel**

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4LJmS]

Just like the Terraform plan you built in the [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true) module, you typically check in your configuration code to source control, along with your application code. Doing so enables you to version, build, test, configure, and deploy your applications as a unit.

## What is configuration management?

_Configuration management_ is a term that's associated with configuration as code. Configuration management refers to the automated management of configuration, typically in the form of automated scripts or programs that you run regularly on your deployments.

For example, say you have dozens or even hundreds of systems that serve the same or similar function, and you need each of them to be configured in the exact same way. How might you open a new firewall port on each system? You might connect to each system remotely and open the port. However, that task is time-consuming and prone to errors. A better way might be to modify an existing configuration management script. Then, through automation, you apply that script to your fleet. Doing so takes much less time and is less prone to error.

Comparing manual configuration processes to those that are more automated, automated processes typically enable you to:

* Reproduce bugs or inconsistencies more easily.
* More easily trace and audit changes over time.
* Configure many related systems more consistently and with fewer errors.
* Deploy more often and at greater scale.

Configuring your systems through automation also frees you from the need to document the differences among systems. Through automation, each system is configured in the exact same way. Your configuration code documents the requirements and the expected results.

Configuration as code helps you implement a configuration management strategy. A good configuration management strategy includes running automated tools to keep all of your systems configured the exact same way. When you run configuration tools in your CI/CD pipeline, such as Azure Pipelines, you ensure that your infrastructure is always configured the way you need it as you build out new features.

## What is configuration drift?

_Configuration drift_ happens when resources change over time from their original deployment state. This is caused by changes made by people, processes, or programs, and can happen manually or through automated processes.

Eventually, an environment can become a _snowflake_. A snowflake is a unique configuration that can't be reproduced automatically, and is typically a result of configuration drift. Inconsistency among environments can lead to unexpected issues during deployment. With snowflakes, infrastructure administration and maintenance typically become manual processes, which can be hard to track and are prone to human error. The more an environment drifts from its original state, the more likely it is for an application to encounter issues. The greater the degree of configuration drift, the longer it takes to troubleshoot and fix issues.

### Security considerations

Configuration drift can also introduce security vulnerabilities into your environments. For example:

* Firewall ports can be opened that should be kept closed.
* Updates and security patches might not be applied across environments consistently.
* Software might be installed that doesn't meet compliance requirements.

While eliminating configuration drift entirely can be difficult, running a configuration management tool can help you manage it.

## How does configuration as code relate to infrastructure as code?

The concept of configuration as code is similar to the concept of infrastructure as code. In fact, you can combine the two models to automatically provision and then configure your systems all in one step.

For example, your CI/CD pipeline might use an Azure Resource Manager template, Terraform, or other automated provisioning process to bring up your infrastructure. Then, you might run Chef, Puppet, Ansible, or other configuration tool to set up your infrastructure with everything your application or service needs to run. You'll learn about these tools shortly.

## How do configuration management tools work?

Soon, you'll learn about some of the configuration management tools that you can use. But first, there are a few concepts you should understand. They are:

* Idempotency
* Imperative code versus declarative code
* Agent model versus agentless model
* Push model versus pull model

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
* Sets the contents of the default homepage, *c:\inetpub\wwwroot\Default.htm*.

When you run this configuration for the first time, Chef ensures that IIS is installed, W3SVC is running, and that the home page is set. When you run this configuration a second time, Chef applies the configuration only if the desired state doesn't match. In other words, Chef applies the configuration only when there's work to do. In most cases, Chef makes no changes because the system is already in the desired state, so this configuration is safe to apply as many times as you'd like.

### Imperative versus declarative code

In [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true), you learned the difference between imperative and declarative code.

Generally speaking, _imperative_ code defines both _what_ the program should accomplish as well as _how_ to achieve the result.

In contrast, _declarative_ code defines what the program should accomplish, but does _not_ define how to achieve the result.

Think about how you write code in languages like Python, C#, or Java. Each of these languages is imperative. You use variables, conditional statements, and loops to control the state of your program and express the steps you need.

Compare these languages to HTML, which is declarative. HTML describes _what_ elements appear on the page, but it doesn't describe _how_ to display them. The "how" is the web browser's responsibility.

Just like infrastructure as code tools such as Azure Resource Manager templates and Terraform, most configuration management tools use the declarative code model. Consider this very basic Chef configuration:

```ruby
package 'vim'
```

On Linux, this configuration ensures that the Vim text editor is installed. It declares that the **vim** package should be installed, but it doesn't specify _how_ to install it. Chef understands the Linux distribution that's running, and can use the appropriate package manager to install the package. For example, Chef might use **apt** on Debian or Ubuntu systems, and **yum** on Red Hat Enterprise Linux or CentOS systems.

### Nodes and hosts

Most configuration management systems use the term _node_ to refer to any device or machine under management. A managed node can also be referred to as a _host_.

Although the term node often refers to virtual machines and physical machines, it can refer to any kind of system you can manage, including network routers and switches.

### Agent model versus agentless model

In configuration management, an _agent_ is a background process, such as a service or daemon, that listens for configuration requests or applies configuration changes on a schedule. The agent runs on each node under management. Some agents also report data to a central configuration server or database, so that administrators can track configuration changes over time.

Chef and Puppet, for example, use agents to apply configuration changes and report back on what changes were made. Ansible doesn't use agents. Rather, Ansible connects to Linux machines over the SSH protocol (and Windows machines over WinRM), and uses Python to apply configuration changes.

### Push model versus pull model

In a _push model_, a central configuration server pushes, or sends, the latest configuration requirements to each node under management.

In a _pull model_, each node under management pulls, or requests, the latest configuration changes from a central configuration server.

Generally speaking:

* The push model offers you greater control than the pull model, but requires you to schedule maintenance runs. For example, if a node is being provisioned or rebooted, you might need to reschedule the run to happen later, when the node is available.
* The pull model scales better than the push model, but typically requires agent software to be installed on each node under management.

As you evaluate the various configuration management tools, you should understand which models that tool supports. That way, you can best plan how and when you schedule maintenance runs on your nodes.
