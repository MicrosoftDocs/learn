The cloud has changed how developers build applications. 

Some of the changing business needs include:

- A service that's built and operated at scale to reach customers in new geographic regions
- Faster delivery of features and capabilities to respond to customer demands in an agile way
- Improved resource utilization to reduce costs

Microservice architecture helps address those needs by building a single application that is composed of a set of small services. Each microservice implements a specific end-to-end domain or business capability within a certain context boundary, and each must be developed autonomously and be deployable independently.

Containers are a great approach to building microservices. Each application or service, its dependencies, and its configuration (abstracted as deployment manifest files) are packaged together as a container image. And Docker is a popular way of containerizing applications.

A Docker file is a text file that contains instructions on how to build a Docker image, and a Docker compose file is a YAML file that groups together several docker containers for build and deployment.

Finally, .NET was built to be cloud native first. It runs cross-platform, so your Docker image could be based on a flavor of Linux and your .NET code will still run. In addition, there are already .NET images created for Docker by Microsoft. Plus, .NET is extremely fast, with the ASP.NET's Kestrel web server routinely outperforming other web servers.

## References

Here are some great resources to learn more about microservices with .NET:

- [Microservices Explained | Build your first microservice with .NET (Video)](https://youtu.be/DFDbh1c9zyE)
- [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices/)
- [Create and deploy a cloud-native ASP.NET Core microservice](/learn/modules/microservices-aspnet-core/)
- [Introduction to Docker containers](/learn/modules/intro-to-docker-containers/)
- [Introduction to Kubernetes](/learn/modules/intro-to-kubernetes/)