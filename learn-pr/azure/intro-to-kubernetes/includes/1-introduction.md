Containers are an excellent choice when developing software based on microservice architectures. They make efficient use of hardware, provide security features to run multiple instances simultaneously on the same host without affecting each other, and allow a service to be scaled out by deploying more instances.

:::image type="content" source="../media/container_benefits.svg" alt-text="Image that shows three benefits of containerization; efficiency, isolation, and scalability." border="false":::

The standard container management runtime focuses on managing individual containers. If you want to scale a complex system with multiple containers working together, it will become challenging. Consider the following aspects you'll have to take care of:

- Configure and meintain load balancing
- Network connectivity
- Orchestration of the deployment process

It's common to use a **container management platform** such as **Kubernetes** to make the management process easier.

Suppose you work at a drone management company. Your company provides a drone tracking solution to customers worldwide. The solution is built and deployed as microservices and includes several major applications:

:::image type="content" source="../media/1-drone-solution-arch.svg" alt-text="Diagram of the high-level architecture that describes the drone tracking solution." border="false":::

- Web front end: shows maps and information about tracked drones.
- Cache service: stores frequently requested information displayed on the website.
- RESTful API: used by tracked drones to send data about their status, such as a GPS location and battery charge levels.
- Qeue: holds unprocessed data collected by the RESTful API.
- Data processing service: fetches and processes data from the queue.
- NoSQL database: stores processed tracking data and user information captured from the website and the data processing service.

You're using containerized instances to quickly deploy into new customer regions and scale resources as needed to meet customer demands. To simplify the development, deployment, and management of these complex containerized applications you want to use a container orchestration platform.

## Learning objectives

In this module, you will:

- Describe how Kubernetes supports container orchestration
- Describe the difference between control planes and nodes
- Evaluate whether Kubernetes is an appropriate orchestration platform for a given workload

## Prerequisites

- Basic concepts of microservice architectures
- Basic understanding of how Docker containers work
- Basic knowledge of how to install software by using a command-line interface
