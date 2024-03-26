
If you're a programmer or techie, you've at least heard of Docker: a helpful tool for packing, shipping, and running applications within "containers."

With all the attention it's getting these days, it would be hard not to, from developers and system admins alike.

There's a difference between containers and Docker. A container is a thing that runs a little program package, while Docker is the container runtime and orchestrator.

## What are containers, and why do you need them?

Containers are a solution to the problem of how to get the software to run reliably when moved from one computing environment to another.

It could be from a developer's laptop to a test environment, from a staging environment to production. Also, from a physical machine in a data center to a VM in a private or public cloud.

Problems arise when the supporting software environment isn't identical.

For example, say you'll develop using Python 3, but when it gets deployed to production, it will run on Python 2.7. It's likely to cause several issues.

It's not limited to the software environment; you're likely to come across issues in production if there are differences in the networking stack between the two environments.

## How do containers solve this problem?

A container consists of an entire runtime environment:

 -  An application, plus all its dependencies.
 -  Libraries and other binaries.
 -  Configuration files needed to run it, bundled into one package.

You can resolve it by containerizing the application platform and its dependencies. Also, differences in OS distributions and underlying infrastructure are abstracted.

## What's the difference between containers and virtualization?

Containers and VMs are similar in their goals: to isolate an application and its dependencies into a self-contained unit that can run anywhere. They remove the need for physical hardware, allowing for:

 -  More efficient use of computing resources.
 -  Energy consumption.
 -  Cost-effectiveness.

The main difference between containers and VMs is in their architectural approach. Let's take a closer look.

### Virtual Machines

A VM is essentially an emulation of a real computer that executes programs like a real computer. VMs run on top of a physical machine using a "hypervisor."

As you can see in the diagram, VMs package up the virtual hardware, a kernel (OS), and user space for each new VM.

:::image type="content" source="../media/virtual-machine-hypervisor-architecture-1a5d17c1.png" alt-text="Diagram that shows a VM Hypervisor architecture.":::


### Container

Unlike a VM, which provides hardware virtualization, a container provides operating-system-level virtualization by abstracting the "user space."

This diagram shows that containers package up just the user space, not the kernel or virtual hardware like a VM does. Each container gets its isolated user space to allow multiple containers to run on a single host machine. We can see that all the operating system-level architecture is being shared across containers. The only parts that are created from scratch are the bins and libs. It's what makes containers so lightweight.

:::image type="content" source="../media/container-architecture-d3507692.png" alt-text="Diagram that shows a Container architecture with multiple apps.":::
