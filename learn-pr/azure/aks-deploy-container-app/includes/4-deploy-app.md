Next, we'll use a static web application built using Hugo, a static website generator written in Golang. This application is available [in this repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app).

Here, we'll run through all the engineering aspects of a containerized application and discuss how you can create one, and what makes them different from other applications.

## Images

The first thing you'll notice is that there's a Dockerfile in the root of the repository. That's because you'll be using a Docker image to spin up your application.

Kubernetes is a __container__ orchestrator. Which means that we'll be using Docker containers to build and run the application within an image and deploy this image to the AKS cluster.
