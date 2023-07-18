Hosting microservices in their own containers is a common pattern for microservice-based development. It's not uncommon to have many different microservices composing a single application. Trying to coordinate and maintain all of those microservices and their containers manually can quickly overwhelm you.

A container orchestrator is a system that automatically deploys and manages containerized apps. Kubernetes is a portable, extensible open-source platform for managing and orchestrating containerized workloads. Kubernetes abstracts away complex container management tasks and provides you with declarative configuration to orchestrate containers in different computing environments.

In this module, you learned how to take a .NET application that was already partitioned into containerized microservices and deploy it into a Kubernetes environment. You first pushed the Docker images to Docker Hub to make the images available to the Kubernetes instance to download, then created deployment files to declaratively describe what Kubernetes should do to each microservice. You also learned how straightforward it is to scale a containerized microservice using Kubernetes.

## References

The following are great resources to learn more about deploying .NET microservices:

- [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices/)
- [Create and deploy a cloud-native ASP.NET Core microservice](/training/modules/microservices-aspnet-core/)
- [Microservice deployment tutorial](https://dotnet.microsoft.com/learn/aspnet/deploy-microservice-tutorial/intro)
- [Introduction to Kubernetes](/training/modules/intro-to-kubernetes/)
