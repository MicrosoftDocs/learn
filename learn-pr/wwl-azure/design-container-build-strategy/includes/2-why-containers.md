## Container

Unlike a VM, which provides hardware virtualization, a container provides operating-system-level virtualization by abstracting the "user space," not the entire operating system.

The operating system level architecture is being shared across containers. It's what makes containers so lightweight.

## What other benefits do containers offer?

Containers are **portable**. A container will run wherever Docker is supported.

Containers allow you to have a **consistent** development environment. For example, a SQL Server 2019 CU2 container that one developer is working with will be identical to another developer.

Containers can be lightweight. A container may be only tens of megabytes in size, but a virtual machine with its entire operating system may be several gigabytes in size.

Because of it, a single server can host far more containers than virtual machines.

Containers can be efficient: fast to deploy, fast to boot, fast to patch, quick to update.
