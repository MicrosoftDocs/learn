Docker is a platform that enables developers to host applications within a container.

:::image type="content" source="../media/docker-c787c4b8.png" alt-text="Diagram of Docker Hub communicating with Docker Host.":::


A container is essentially a standalone package that contains everything that is needed to execute a piece of software. The package includes:

 -  The application executable code.
 -  The runtime environment (such as .NET Core).
 -  System tools.
 -  Settings.

The Docker platform is available on both Linux and Windows and can be hosted on Azure. The key thing that Docker provides is the guarantee that the containerized software will always run the same. It doesn't matter if the code is run locally on Windows, Linux or in the cloud on Azure. The software can be developed locally within a Docker container, shared with Quality Assurance resources for testing. and then deployed to production in the Azure Cloud. Once deployed, the application can easily be scaled using the Azure Container Instances (ACI).

## Docker terminology

You should be familiar with the following key terms before using Docker and Container Instances to create, build, and test containers:

 -  **Container**. Container is an instance of a Docker image. It represents the execution of a single application, process, or service. It consists of the contents of a Docker image, an execution environment, and a standard set of instructions. When scaling a service, you create multiple instances of a container from the same image. Or a batch job can create multiple containers from the same image, passing different parameters to each instance.
 -  **Container image**. Container image refers to a package with all the dependencies and information required to create a container. The dependencies include frameworks and the deployment and execution configuration that a container runtime uses. Usually, an image derives from multiple base images that are layers stacked on top of each other to form the container's file system. An image is immutable once it has been created.
 -  **Build**. Build refers to the action of building a container image based on the information and context provided by the Dockerfile. The build also includes any other files that are needed. You build images by using the Docker docker build command.
 -  **Pull**. Pull refers to the process of downloading a container image from a container registry.
 -  **Push**. Push refers to the process of uploading a container image to a container registry.
 -  **Dockerfile**. Dockerfile refers to a text file that contains instructions on how to build a Docker image. The Dockerfile is like a batch script. The first line identifies the base image. The rest of the file includes the build actions.
