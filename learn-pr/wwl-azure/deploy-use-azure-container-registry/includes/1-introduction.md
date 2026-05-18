This module covers the creation of an Azure Container Registry instance with the Azure portal.

## Scenario

In this scenario, you learn how to create a private registry service for building, storing, and managing container images and related artifacts. You use Docker commands to push a container image into the registry, and finally pull and run the image from your registry.

## Prerequisites

To complete the hands-on steps, you need:

 -  An Azure subscription.
 -  Permissions to create the registry and assign Azure roles in the subscription. If you can't assign roles, ask an administrator to assign you the Container Registry Repository Writer role for push/pull and the Container Registry Repository Catalog Lister role for portal repository listing after the registry is created.
 -  Azure CLI installed on your local machine. You sign in during the exercise and use it to authenticate to the registry.
 -  Docker installed locally with the Docker daemon running so `az acr login` and the Docker commands can work with the registry.

## Learning objectives

After completing this module, you'll be able to:

 -  Describe Azure Container Registry as a private registry service for building, storing, and managing container images and related artifacts.
 -  Create an Azure container registry instance with the Azure portal.
 -  Sign in to the registry instance using the Azure CLI on your local machine.
 -  Push an image to the registry instance.
 -  Remove the registry-tagged local image reference from your local Docker environment.
 -  View the image in your registry.
 -  Pull and run the container image from your container registry.

## Goals

The goal of this module is to teach you how to create and manage an Azure Container Registry instance, and to push, pull, and run container images from the registry.
