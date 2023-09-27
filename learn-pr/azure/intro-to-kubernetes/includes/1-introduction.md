Containers are an excellent choice when developing software based on microservice architectures. They make efficient use of hardware, provide security features to run multiple instances simultaneously on the same host without affecting each other, and enable a service to be scaled out by deploying more instances.

:::image type="content" source="../media/1-container-benefits.svg" alt-text="Diagram that shows three benefits of containerization; efficiency, isolation, and scalability." border="false":::

The standard container management runtime focuses on managing individual containers. If you want to scale a complex system with multiple containers working together, this scenario becomes challenging. Consider the following aspects you'll have to address:

- Configuring and maintaining load balancing
- Network connectivity
- Orchestrating the deployment process

To make the management process easier, it's common to use a **container management platform** such as **Kubernetes**.

Suppose you work at a drone-management company. Your company provides a drone-tracking solution to customers worldwide.

:::image type="content" source="../media/1-drone-solution-arch.svg" alt-text="Diagram of the high-level architecture that describes the drone-tracking solution." border="false":::

The solution is built and deployed as microservices, and includes several major applications:

- **Web front end**: Shows maps and information about tracked drones.
- **Cache service**: Stores frequently requested information shown on the website.
- **RESTful API**: Used by tracked drones to send data about their status, such as a GPS location and battery-charge levels.
- **Queue**: Holds unprocessed data collected by the RESTful API.
- **Data-processing service**: Fetches and processes data from the queue.
- **NoSQL database**: Stores processed tracking data and user information captured from the website and the data-processing service.

You're using containerized instances to quickly deploy into new customer regions and scale resources as needed to meet customer demands. To simplify developing, deploying, and managing these complex containerized applications, you want to use a container orchestration platform.

## Learning objectives

In this module, you will:

- Describe how Kubernetes supports container orchestration.
- Describe the difference between control planes and nodes.
- Evaluate whether Kubernetes is an appropriate orchestration platform for a given workload.

## Prerequisites

- Basic concepts of microservice architectures
- Basic understanding of how Docker containers work
- Basic knowledge of how to install software by using a command-line interface (CLI)
