Hosting applications and processes inside of containers is gaining in popularity, and for good reasons. In this Microsoft Learn module you will learn a bit about what a container is, how to create container images, and how to run applications inside of a container.

If you are familiar with virtual machines, a container may appear to be incredibly similar. Both a VM and a container have an operating system, a file system, and can be accessed over a network using an IP address. They both run applications and processes, store data, and can be created and destroyed using tooling and automation. When working inside of a container, the differences between a container and a virtual or physical system may be indistinguishable.

So, what are the differences?

At a high level, containers are a new way of delivering applications and compute processes. When using containers, applications and all dependencies are packaged into what is known as a container image. These container images are super portable using a container image registry. This means that you can create a container image on your development system, and then run an instance of that image in an Azure datacenter and have confidence that it will work without additional modification.

## Container efficiencies

Containers and container images are built in such a way that they efficiently use host resources such as disk space, memory, and CPU. Due to these efficiencies, containers start quickly. In some cases, starting a new instance of a container is almost instantaneous. This not only allows for quick provisioning of applications but also a new model of on-demand processing and scale operations.

Envision this scenario: You run a batch processing service that occasionally sees a large spike in demand. Using containers and slightly of automation, you can build a system that reacts to increased demand by quickly provisioning new container instances to meet the increased demand. That is powerful and not easy to achieve with traditional virtual machines.
In addition to fast start, with containers you can achieve hyper density. This effectively means that you can run more applications and processes with less virtual or physical resources.

## Use cases

While containers are a great platform for running traditional workload like webservers, they also help open opportunities such as burstable batch processing, applications built with a modern and distributed architecture, and anything that requires on-demand scale.

## Cloud native

We hope that this quick introduction to containers helps give you a basic understanding of what a container is and some ideas on how containers can be used. Containers may be one of the first born in the cloud technologies and have the potential to revolutionize application delivery and datacenter and cloud management operations.