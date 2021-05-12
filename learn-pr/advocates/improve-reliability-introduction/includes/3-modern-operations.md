Earlier in this module, we claimed that modern operations practices can
help, but we didn't say very much about what those practices were or why
looking to them for assistance makes sense. Let's discuss that now as a
prelude to the map we will be using to navigate our reliability work.

In this module and throughout the Modern Operations learning path, we use
the term _modern operations practices_ as a container for two different
practices:

-   DevOps
-   Site reliability engineering (SRE)

Let's take a quick look at both of them and what they have to offer us in
this context.

## DevOps

DevOps is a many-splendored thing that different people have understood and
interpreted in different ways. This means there are a number of good
definitions for it. Lets look at a few of them to give you a well-rounded
view:

### Continuous delivery of value

> DevOps is the union of people, process, and products to enable continuous
> delivery of value to our end users. The contraction of "Dev" and "Ops"
> refers to replacing siloed Development and Operations to create
> multidisciplinary teams that now work together with shared and efficient
> practices and tools. Essential DevOps practices include agile planning,
> continuous integration, continuous delivery, and monitoring of
> applications. -- Sam Guckenheimer, What is DevOps?

### Culture of collaboration, ownership and learning

> DevOps is an engineering culture of collaboration, ownership, and
> learning with the purpose of accelerating the software development life
> cycle from ideation to production. -- Emily Freeman, DevOps for Dummies

### Work together to imagine, develop, deploy and operate a system

> DevOps: a culture where people, regardless, of title, or background, work
> together to imagine, develop, deploy and operate a system. -- Ken Murage

## Site Reliability Engineering

If a key word in the DevOps realm is "delivery", the key word for site
reliability engineering would be "reliability". While there are a few
definitions for SRE that have been discussed in the field, there appears to
be more consensus on the topic. Here's our definition that captures the key
aspects of that consensus:

> Site reliability engineering is an engineering discipline devoted to
> helping an organization sustainably achieve the appropriate level of
> reliability in their systems, services, and products.

## Why these practices? Why now?

DevOps and SRE were both created by operations professionals in the last 15
years or so in response to a specific set of challenges in the operations
space. They recognized that a number of factors were going to require a new
approach, including:

-   The growing complexity of production environments
-   Increasing business dependency on the continuous functioning of those
    environments
-   The inability to scale the workforce linearly with the size of these
    environments

While they are different practices with somewhat of a different focus (for
example, "delivery" vs. "reliability" as mentioned before), both DevOps and
SRE have both developed principles and practices that are core to
reliability work. These include monitoring/observability, proper incident
response, automation and collaboration. All of these things play a
prominent role in the material we will be discussing in the _Improve your
Reliability_ learning path.

So let's get into that work. We are going to start with a model that can
help us structure and plan our reliability efforts.
