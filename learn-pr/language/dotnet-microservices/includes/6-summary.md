The cloud has changed how developers build applications. 

Some of the changing business needs include:

- A service that's built and operated at scale to reach customers in new geographic regions.
- Faster delivery of features and capabilities to respond to customer demands in an agile way.
- Improved resource utilization to reduce costs.

A microservices architecture helps address these needs by building a single application that's composed of a set of small services. Each microservice implements a specific, end-to-end domain or business capability within a certain context boundary. Each microservice must be developed autonomously and be independently deployable.

Using containers is a common approach to building microservices. Each application or service, its dependencies, and its configuration (abstracted as deployment manifest files) are packaged together as a container image. Docker is a popular way to containerize applications.

A _Dockerfile_ is a text file that contains instructions for how to build a Docker image. The .NET SDK now directly enables you to create containers through the `dotnet publish` command and support the same commands as the Dockerfile. A Docker Compose file is a YAML file that groups together several Docker containers for build and deployment. 

Finally, .NET was built to be cloud-native first. It runs cross-platform, so your container image can be based on a flavor of Linux, and your .NET code still runs. .NET is extremely fast, and Microsoft has already created .NET images for containers and Docker.

## Cleanup Codespace

You can delete the codespace on [GitHub](https://github.com/codespaces) under **By repository** where you see **MicrosoftDocs/mslearn-dotnet-cloudnative**.

## Related content

These resources can help you learn more about microservices with .NET:

- [Containers with .NET and Docker for Beginners](https://aka.ms/dotnet/beginnervideos/youtube/containers)
- [Microservices explained | Build your first microservice with .NET (Video)](https://youtu.be/DFDbh1c9zyE)
- [.NET microservices: Architecture for containerized .NET applications](/dotnet/architecture/microservices/)
- [Create and deploy a cloud-native ASP.NET Core microservice](/training/modules/microservices-aspnet-core/)
- [Introduction to Docker containers](/training/modules/intro-to-docker-containers/)
- [Introduction to Kubernetes](/training/modules/intro-to-kubernetes/)
