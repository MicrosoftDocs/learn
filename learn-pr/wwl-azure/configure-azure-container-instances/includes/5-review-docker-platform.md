Docker is a platform that enables developers to host applications within a container. A container in Docker is essentially a standalone package that contains everything needed to execute a piece of software.

Docker Hub provides a large global repository of container images from developers, open source projects, and independent software vendors. You can access Docker Hub to find and share container images for your app and containers. Docker Hosts are machines that run Docker and allow you to run your apps as containers.

The following illustration shows how Docker Hub communicates with Docker Host.

:::image type="content" source="../media/docker-c787c4b8.png" alt-text="Diagram that shows Docker Hub communicating with Docker Host." border="false":::

### Things to know about Docker and containers

Examine the following characteristics of the Docker platform and containers.

- The Docker platform is available on both Linux and Windows and can be hosted on Azure.

- A Docker container package includes the application executable code, the runtime environment such as .NET Core, system tools, and settings.

- A **Dockerfile** is a text file with instructions on how to build a Docker image. The Dockerfile is like a batch script. The first line identifies the base image. The rest of the file includes the build actions.

- The key feature of Docker is the guarantee that containerized software always runs the same locally on Windows or Linux, or in the cloud on Azure.

- Develop your code locally within a Docker container, share your code with Quality Assurance resources for testing, and deploy your code to production in the Azure cloud. After your code is deployed, your app can easily be scaled by using Azure Container Instances.

### Things to consider when using Docker

Before you begin using Docker and Azure Container Instances to create, build, and test containers, it's helpful to be familiar with the terminology and concepts.

- **Container**: An instance of a Docker image. A container represents the execution of a single application, process, or service. It consists of the contents of a Docker image, an execution environment, and a standard set of instructions. When scaling a service, you create multiple instances of a container from the same image. A batch job can create multiple containers from the same image, and pass different parameters to each instance.

- **Container image**: A package with all the dependencies and information required to create a container. The dependencies include frameworks and the deployment and execution configuration that a container runtime uses. Usually, an image derives from multiple base images that are layers stacked on top of each other to form the container's file system. An image is immutable after it's created.

- **Build**: The process of creating a container image based on the information and context provided by the Dockerfile. The build also includes any other necessary files. You build images by using the Docker `docker build` command.

- **Pull**: The process of downloading a Docker container image from a container registry.

- **Push**: The process of uploading a Docker container image to a container registry.