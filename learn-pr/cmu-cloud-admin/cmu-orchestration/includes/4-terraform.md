HashiCorp Terraform is an infrastructure orchestration tool created by
Mitchell Hashimoto, a veteran Chef and Puppet user who realized he
envisioned infrastructure in a different way, and then founded a company
based on that idea. Terraform's stated goal is to produce a
provider-agnostic, though technically replete, view of cloud
infrastructure to the services and applications that make use of it.[^1]

As Hashimoto evolved his platform, Terraform grew to become capable of
administering oversight to any service, from any source, that
communicates using an API. Theoretically, an analytics service provider
could be integrated into an infrastructure platform managed by
Terraform, perhaps providing forecasts for resource performance or
warnings about consumption trends. As long as a plug-in can be
constructed that maps the APIs methodologies into states that can be
represented symbolically (using variables), then a Terraform plan can be
built around that API. In an unusually metaphor-free environment, the
method Terraform constructs to perform a task is called a *plan*. A plan
is what Terraform assembles after analyzing the state of the
infrastructure, and the requirements of the workloads it will
orchestrate as specified by its scripts.

Terraform has been called a configuration-management (CM) system.
Technically, it is not, for the following reasons:

-   **It is designed to utilize other CM tools**, and can be integrated
    with infrastructure that already uses Chef, Puppet, or Ansible.
    HashiCorp offers its own alternatives as well, including a networked
    configuration system called Consul.

-   **It works with resources** in on-premises infrastructure as well as
    the public cloud. Chef recipes, Puppet modules, and Ansible
    playbooks may then provision those resources for their own
    respective purposes.

-   **The patterns and best practices adapted through regular use of
    Terraform may be encoded**, making them plans unto themselves ---
    for example, deprovisioning unused resources, reconfiguring network
    address loops, and performing periodic health checks of configured
    systems.

-   **Terraform can help bridge the gap between first-generation
    virtualization and containerization.** A containerized
    infrastructure is different from one built around virtual machines
    since what's being virtualized is the application, not the operating
    system and services that support it. Typically, a CM installation
    deals with one type of environment or the other. Terraform can
    manage an infrastructure in which both components play active roles.

As Figure 9 depicts, Terraform itself has no remote, client-side
agents (though HashiCorp makes platform components that do), nor is its
central component considered a server *per se*. HashiCorp calls this
component the *core*. Rather than communicating with something designed
to communicate exclusively with it, the core is designed to communicate
with *resource providers* by way of REST APIs. When a resource provider
builds an API around its services, borrowing an idea from the SQL
database language, it typically phrases its methods using some form of
the four basic commands for handling resources, which Terraform
interprets as create, read, update, and delete. It's up to the
intermediate plugins to map the commands the API provides to methods it
can generally recognize.

![Figure 9: The Terraform core uses plugins that in turn call cloud
provider APIs](../media/fig6-9.png)

Figure 9: The Terraform core uses plugins that in turn call cloud
provider APIs.

A CM system provisions resources for one set of requests at a time.
Terraform takes into account the collective needs of all the services
that its infrastructure will host, examining the requests they make for
resources as a group. From those requests, it assembles a working
virtual network around components that need to share connectivity with
one another.

## Terraform syntax

Terraform works somewhat differently than the CM tools examined in the
previous lesson. It does use a domain-specific language for declaring
the desired state of infrastructure. Its DSL is declarative, not
imperative, and will not appear too foreign to an administrator who uses
Puppet. Because it is not imperative and therefore not mired down with
general-purpose programming language rules, Terraform's syntax is rather
straightforward. Most every instruction spells out an association,
equating a value with a symbol. In that light, Terraform's intentions
could very well have been expressed instead with JSON or YAML without
losing much in translation. As it stands, however, Terraform code is
clear, legible, and where appropriate, implicit.

An earlier lesson presented a Bash script that provisioned an Ubuntu VM
in Azure with a LAMP stack installed. Suppose you want to prevision a
similar VM in AWS and use Terraform to do it. First, since Terraform's
declarative language can be used like a template, variables must be
declared before they're invoked, usually in a separate file. The
following example defines a variable named ami that contains an AWS
catalog number that the script will need in order to locate a Bitnami
LAMP image:

variable \"ami\" {

default = \"ami-7679c91e\"

description = \"AMI catalog number for Bitnami LAMP stack image\"

}

Next, in a file named "main.tf," a resource block establishes the
conditions for provisioning the LAMP stack instance. Notice the
placeholder in curly braces for the interpreter to fill in with the
value of variable ami:

resource \"aws\_instance\" \"web\" {

ami = \"\${var.ami}\"

instance\_type = \"t2.micro\"

tags = {

Name = \"CMU\_LampStack\"

}

}

It is the AWS plugin for Terraform that takes care of mapping these
inputs to a command that AWS will recognize. When the command executes,
the plugin also makes the results of the command available to the core.

## Terraform operation

It might seem as if there is no functional difference between Terraform
and a CM system. Terraform does, after all, use a declarative language
to express instructions for provisioning a LAMP stack server.

Here is where everything changes. Terraform's principal job is not to
add a configuration to a platform that's already running. It creates
virtual infrastructure around *all* the components that infrastructure
will host simultaneously, the example above representing just one
component of many. Getting Terraform to build the plan for this big job
is an interactive process, though not a graphical one. First, all the
scripts for tasks belonging to the plan are assembled in their
designated directories. The core now knows what to look for.

From this point forward, the interaction process is deceptively simple.
The core is launched with this command:

terraform init

It requires no parameters or qualifiers, because the inputs have already
been written as files and stored in their proper directories. The launch
process essentially looks for potential errors with the declarations and
points them out if they exist. What the administrator is looking for
here is a blank response with zero warnings.

Now the administrator moves on to the second stage:

terraform plan

Again, no parameters are required, although there are a handful of
optional ones. The core will take a few minutes to analyze the scripts
in its directories and ascertain the sum total of changes that must be
made in the infrastructure in order to accommodate everything. If it's
building the infrastructure from scratch, then it will ascertain
everything it needs to build; if it's making adjustments, then the core
will calculate the differences between the current state and the desired
state of the infrastructure. If services can be supported through the
provisioning of two VMs instead of three without impacting the overall
configuration or performance, then that's the plan it will build.

For a containerized infrastructure rather than a VM-based platform,
Terraform is capable of working with Kubernetes directly to make
decisions about cluster organization and resource capacities. As an
example, containers often require persistent storage volumes for
maintaining databases even after containers are deprovisioned. Terraform
can keep track of the capacity of the persistent storage volumes that
multiple containers claim in order to determine how much to provision.

Once Terraform has completed its analysis, before it makes even the
smallest change, it presents this plan as a detailed report to the
operator. The plan may also be saved to a file in JSON format by adding
an -out argument to the command. The report not only shows what actions
will be taken, but in what order, and with natural-language explanations
for why certain changes are necessary. It lists the resulting state of
variables or data when it knows what that state will be. For example, it
may know how large a VM instance needs to be, but it may not know what
IP address it will be assigned.

HashiCorp recommends that administrators share the plan report file with
stakeholders throughout their organizations who may be affected by any
changes. This gives people the opportunity to ask questions and weigh in
before a plan is committed to and deployed. If there are objections,
then the plan need not be implemented at all. Suggestions may be
incorporated into the scripts, the system can be reset, and terraform
plan can be reinitialized.

If all stakeholders have signed off and the plan is ready to go, then
the administrator need only enter the following command:

terraform apply

The core implements the plan in place and reports on progress. An
exception may occur, however, if the state of the infrastructure
configuration has changed since the plan was compiled. This could
certainly happen if the deliberations that HashiCorp recommends take a
week or so. In that case, for safety, the core will not execute the
plan, and will instead advise that terraform plan be re-run.

As changes are being made to the infrastructure configuration, it's
important to note that services may still be running as they're being
transitioned. This is especially true in a containerized environment
where services may be disposed of and scaled down in a controlled
fashion. But even in a system with conventional virtualization, the core
has been programmed to create new resources before destroying the old
ones when possible. It can be set to always create before destroying by
adding this configuration block to one of the scripts[^2]:

lifecycle {

create\_before\_destroy = true

}

## Configuration management vs. infrastructure orchestration

Orchestration can be achieved in a system without, to borrow a phrase
from the marketing department, "making everything work seamlessly
together." Coalition is not necessary, and sometimes even cooperation is
impossible. The key to a well-orchestrated infrastructure is to ensure
that all applications and services have access to the resources and
connectivity they need to perform their tasks, without interference.

This is what conventional CM cannot always anticipate: where
configurations collide. Organizations that are heavily dependent on
computing infrastructure often end up relying on their IT department
leaders, administrators, and systems analysts to understand how various
systems work together and where conflicts may occur. As a result, they
may hesitate to request new features their customers need or want, or
that they themselves need to maintain a competitive edge, until IT can
render a verdict as to whether side effects can be contained. This is
the situation that infrastructure orchestration seeks to mitigate, and
Terraform is a prime example of that effort put into action.

### References

[^1]: https://thenewstack.io/hashicorp-containers-should-be-managed-just-like-vms-so-where-does-that-leave-pets-and-cattle/

[^2]: https://www.hashicorp.com/blog/zero-downtime-updates-with-terraform
