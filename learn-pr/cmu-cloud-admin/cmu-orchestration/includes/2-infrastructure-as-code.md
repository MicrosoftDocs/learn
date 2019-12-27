+-----------------------------------------------------------------------+
| # Learning Objectives {#learning-objectives}                          |
+=======================================================================+
| Explain the concept of Infrastructure-as-Code and enumerate the       |
| advantages that it offers over ordinary scripting                     |
+-----------------------------------------------------------------------+

Prior to the cloud, when an organization needed to build out its
computing infrastructure, it deployed new physical servers and added
them to the network behind a load balancer and firewall. When an
operations manager was charged with estimating the capital expenditures
required to support added capacity, those estimates were rendered in
terms of whole servers. "Architecture," such as it was, was conducted by
calculator. One of the oft-repeated tips of capacity planning at the
time was to add a "cushion," an overestimate -- say, 20 percent -- in
case the initial estimates were too low.

The cloud changed that by offering computing infrastructure as a
service. Suddenly adding capacity became a matter of clicking buttons in
a portal, typing commands into a console, or running scripts
encapsulating those commands. This, however, gave rise to a new set of
challenges. Given that an entire solution comprising dozens or even
hundreds of cloud services can be deployed in minutes by a single person
sitting in front of a computer, how can you make sure solutions are
properly deployed, that individual resources are properly configured,
and that the operator didn't make a mistake? Moreover, how do you
reliably modify a solution after it's deployed while minimizing the
potential for human error? Scripting is one solution, but as we learned
in the previous lesson, it solves certain problems while introducing
others.

The next step on the journey to automating the processes involved in
managing cloud infrastructure is *Infrastructure-as-Code*, or IaC. The
principal objective of IaC is to make the composition of a solution
deployed to the cloud both explicitly definable and dynamic like a
program. Run the program and you create a solution; change the program,
and you change the solution. IaC provides a mechanism for defining what
a solution looks like. It contains many of the elements of a program
without necessarily relying on a programming language: declaration of
assets (variables), reusable functions and procedures, error trapping
and recovery, and most importantly of all, formal support for testing
and debugging (Figure 6.3).

![](media/image1.png){width="5.99375in" height="4.297916666666667in"}

Figure 6.3. Parallels between Infrastructure-as-Code and software
programs.

IaC relies on configuration files that are analogous to the source code
for application programs. An IaC configuration file might not look like
source code, and it probably isn't written in Python or another
traditional programming language. Yet all the principal components that
a software developer would look for are there in the configuration file,
albeit with a different syntax. A configuration file may lack imperative
commands or step-by-step procedures that a Python program or a
PowerShell script has, but it defines both an *outcome* and a *process
for achieving that outcome* just the same.

This is the concept of Infrastructure-as-Code. Cloud dynamics transforms
the resources that comprise a solution into fluid commodities that
transcend the boundaries of the machines that support them. A system
that oversees their disposition should also transcend those boundaries,
treating the entire cloud data center, on-premises and off-, as if it
were one programmable, composable machine.

# Configuration Management

A multitude of industries besides IT benefit from configuration
management (CM), particularly as it applies to manufacturing and
production. In automotive production, for example, CM refers to the
methods and processes used to manufacture a product that meets specific
standards or customer requirements. In industrial equipment
manufacturing (IEM), which produces parts used to build machines, there
are parts-numbering systems, release-management systems,
change-management systems, and status-accounting systems, all of which
have to be coordinated to produce a repeatable outcome.

Automating configuration management in IT is not all that different. It
involves managing systems in transitioning states. And it involves
coordinating various subsystems so that they work together. At issue
today for IT administrators are fundamental philosophical questions:
Should the system maintain and preserve the processes by which
cloud-based infrastructure is provisioned and assembled? Or should it
instead codify the infrastructural components necessary for meeting
customer or user requirements, and ascertain the means for meeting those
requirements based on the infrastructure's current operating status?
There are CM systems in use today that take one approach or the other.

In 1993, while the notion of virtualization in the data center was still
in its infancy, an Oslo University quantum-field-theory researcher named
Mark Burgess produced in his spare time, and in-between
government-funded projects into thermal field theory[^1], what's
believed to be the first modern configuration-management tool. Called
*CFEngine*, it began as a domain-specific language (DSL) that
implemented conditional tests based on criteria gleaned from a
computer's configuration. These tests were used to determine which
instructions would be the most appropriate to execute in order for the
system to attain a desired configuration state.

As they evolved, the criteria for these conditional tests became phrased
like declarations --- statements describing what the desired state of
the system should be. Up to that time (and for some period thereafter),
system configuration was describable as an initial state of a system
that undergoes a sequence of transformations. The same can be used to
characterize a typical administrative script: a list of everything a CLI
interpreter needs to do to amend the state of an existing system, or to
build something into a state beginning with no state at all.

Seven years later, for his seminal textbook on network and system
administration[^2], Burgess effectively codified the use of the term
"infrastructure" to refer to the resources that collectively comprise
and support the data center. There, he also put forth his five
requirements for any data center's infrastructure to be considered
stable: scalability, reliability, redundancy, homogeneity, and
reproducibility.

Those requirements may be met, Burgess surmised, through a
configuration-management system whose language has its developer start
with the desired end state, and let the system itself guide development
backwards towards the present state. In an essay published on his
personal Web site[^3], Burgess describes the direction that conventional
scripting tends to go as *congruence*, which he likened to a recipe
leading someone through the steps of how to build something without
describing what that something is. The direction he prefers is
*convergence*, which he compares to using a map depicting the
destination and planning a route that leads back to where you are now.

# Puppet and the Declarative Model

In 2006, open-source software developer Luke Kanies released under the
General Public License (GPL) a tool he called *Puppet*. Describing it as
"Next Generation Configuration Management[^4]," he introduced it to his
fellow IT professionals as an "operating system abstraction layer." That
phrase did not catch on, but the idea did. His premise was that the
language of a configuration-management system (a tool for overseeing the
regular disposition of a solution in a data center) could be devised to
*declare* the required components of a class of resources such as
virtual machines. The system could then be charged with taking whatever
steps were necessary at the present time to meet those requirements, or
something close to them, even when the sequence of those steps was
likely to change. (Further details about the Puppet language and how the
system works are presented in the next lesson.)

With Puppet, an operator can specify a class of *service*, not server,
which is comprised of the application packages and other resources
required to deliver something of value to users. The job of the
configuration-management system becomes to provision the proper
resources needed to deliver that service, as it has been classified
within Puppet. This may involve the provisioning of virtual machines or,
with more recent systems that incorporate containerization
(virtualization based on workloads rather than servers), the
instantiation of containers and the resources that support them.

# Developers and Operators

Almost the very moment an enterprise begins serious consideration of
leveraging the benefits of IaC, it begins discussing whether two
historically separate departments --- IT administration and software
development --- should coalesce. The DevOps movement arose from the
realization that any plan executed at this level of the business, upon
which so much of the modern business model actually depends, cannot be
undertaken by two teams separated by campus walls.

The "DevOps" portmanteau is attributed to inspiration from a 2009
computer-industry conference, during which two of the speakers were John
Allspaw, at the time head of technical operations, and Paul Hammond,
head of the engineering team, at photo-sharing service Flickr. Their
joint session introduced this notion, which at the time was somewhat
radical: If data-center infrastructure could be made adaptable and
responsive to the changing needs of workloads, then it could support
applications and services with much shorter release cycles, and much
faster rates of deployment and continuous improvement.

As the advocates of DevOps will assert, IaC, continuous integration and
continuous deployment (CI/CD), and the realignment of teams around
projects and goals rather than managers and org charts, have been joined
together as part of the same evolutionary trend. This trend is leading
to organizational changes in the business that people outside of the IT
department can recognize and appreciate:

-   **Software is being developed faster**, or for those organizations
    that have never developed their own applications or services,
    software is being developed where it wasn't being developed before.
    Release cycles for software used to be extended for months, even
    years, until a set delivery time on the itinerary that was
    convenient for the entire organization. One reason for such
    extensions was to allow windows of opportunity for hardware to be
    upgraded or replaced, or entirely new data centers to be
    established, just prior to a software release that would otherwise
    be impacted by an infrastructure shift mid-cycle. With cloud
    platforms now enabling operators to make more incremental changes to
    their infrastructure more frequently, there's no longer sufficient
    reason or incentive to delay software-release cycles.

-   **Testing is being treated more seriously and rigorously.** In a
    data-center environment that has adopted CI/CD, software is tested
    in at least one separate phase, perhaps two, before it is released
    into production. It may not be practical to construct similar
    development and staging phases for cloud infrastructure, but IaC
    tools do allow for "dry run" planning, where administrators can
    observe and predict the effects of changes applied to cloud
    solutions before they're committed.

-   **Infrastructure management tools are being integrated with
    automation servers** such as Jenkins. As a result, the same
    "pipelined" itinerary used to plan the release cycles for
    applications and services are synchronized with infrastructure
    plans, recipes (Chef), or playbooks (Ansible), so that the state of
    the infrastructure is always closely aligned with the workloads it
    supports.

-   **Management methods for software teams are being tried for IT
    teams**, one example being the celebrated Agile methodology. In an
    Agile framework, a smaller team with a designated project leader
    defines simpler goals that can be achieved in shorter intervals,
    driving towards those goals more methodically. Multiple teams may
    coordinate with one another, and consequently may more accurately
    gauge their progress. An Agile, or Agile-like, operations team may
    be more closely aligned with a software team in ensuring that
    infrastructure resources are available and can be relied upon.

Of course, IaC is merely an abstract concept without tools to implement
it. The next lesson introduces some of the more widely adopted
configuration-management tools, all of which embrace the notion of
Infrastructure-as-Code to varying degrees.

[^1]: http://markburgess.org/bio.html

[^2]: https://www.wiley.com/en-us/Principles+of+Network+and+System+Administration%2C+2nd+Edition-p-9780470868072

[^3]: http://markburgess.org/blog\_cd.html

[^4]: https://www.usenix.org/publications/login/february-2006-volume-31-number-1/puppet-next-generation-configuration-management
