Earlier in this module, we claimed that modern operations practices can
help, but we didn't say very much about what those practices were or why
looking to them for assistance makes sense. Let's discuss that now as a
prelude to the map we will be using to navigate our reliability work.

In this learning path, we use the term "modern operations practices" as a
container for two different practices: DevOps and site reliability
engineering (along with other related work in the operations space). Let's
take a quick look at both of them and what they have to offer us in this
context. If either of these practices interests you, be sure to check out
the other Microsoft Learn modules on these topics listed below.

## DevOps

DevOps is a many-splendored thing that different people have understood and
interpreted in different ways. This means there are a number of good
definitions for it. Lets look at a few of them to give you a well-rounded
view:

### continuous delivery of value

> DevOps is the union of people, process, and products to enable continuous
> delivery of value to our end users. The contraction of "Dev" and "Ops"
> refers to replacing siloed Development and Operations to create
> multidisciplinary teams that now work together with shared and efficient
> practices and tools. Essential DevOps practices include agile planning,
> continuous integration, continuous delivery, and monitoring of
> applications. (from Sam Guckenheimer,
> [What is DevOps?](https://docs.microsoft.com/azure/devops/learn/what-is-devops))

### culture of collaboration, ownership and learning

> DevOps is an engineering culture of collaboration, ownership, and
> learning with the purpose of accelerating the software development life
> cycle from ideation to production. (from Emily Freeman,
> [DevOps for Dummies](https://www.dummies.com/business/operations-management/devops-for-dummies-cheat-sheet/))

### work together to imagine, develop, deploy and operate a system

> DevOps: a culture where people, regardless, of title, or background, work
> together to imagine, develop, deploy and operate a system. (from Ken
> Murage)

If you are interested in exploring DevOps more, there are some good
learning resources on Microsoft Learn: XXXXXX. (XXX also Docs?)

## Site Reliability Engineering

If a key word in the DevOps realm is "delivery", the key word for site
reliability engineering would be "reliability". While there are a few
definitions for SRE that have been discussed, there appears to be somewhat
more consensus on the topic. Here's our definition that tries to capture
the key aspects:

> Site reliability engineering is an engineering discipline devoted to
> helping an organization sustainably achieve the appropriate level of
> reliability in their systems, services, and products.

We will dive further into this definition later in this learning path (XXXX
reference to OPS10?) because it offers some further insight into questions
about monitoring.

In the meantime, if you are interested in exploring site reliability
engineering more, there are some good learning resources on the
[Azure SRE hub](https://docs.microsoft.com/azure/site-reliability-engineering/).

## Why these practices? Why now?

DevOps and SRE were both created in response to a specific set of
challenges in the operations space. They recognized that a number of
factors were going to require a new approach, including:

    - the growing complexity of our production environments
    - increasing business dependency on the continuous functioning of those environments
    - the inability to scale the workforce linearly with the size of these environments

While they are different practices with somewhat of a different focus (for
example, "delivery" vs. "reliability" as mentioned before), both DevOps and
SRE have both developed principles and practices that are core to
reliability work. These include monitoring/observability, proper incident
response, automation and collaboration. All of these things play a
prominent role in the material we will be discussing in this learning path.

So let's get into that work. We are going to start with a model that can
help us structure and plan our reliability efforts.
