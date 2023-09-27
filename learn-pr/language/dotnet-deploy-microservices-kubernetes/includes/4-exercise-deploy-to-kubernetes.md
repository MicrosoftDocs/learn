Kubernetes runs containers for you. You describe what you want Kubernetes to do through a YAML file. This exercise walks you through creating the file so you can deploy and run the **backend** service on Kubernetes.

> [!IMPORTANT]
> Before proceeding, you must be sure you have a Kubernetes implementation installed. We'll be using the implementation included with Docker Desktop. Follow <a href="https://docs.docker.com/desktop/kubernetes/" target="blank">these directions from Docker</a> in order to enable it.

## Create a deployment file for the backend service

You can create a file to manage deploying a container into Kubernetes with a YAML file. Let's create a file to deploy the backend service.

1. Open a text editor such as Visual Studio Code and switch to the directory you cloned the project files to earlier.
1. Create a new file in the root of the project called **backend-deploy.yml**.
1. Copy the following text into the file and then save it.

    ```yml
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: pizzabackend
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: pizzabackend
        spec:
          containers:
          - name: pizzabackend
            image: [YOUR DOCKER USER NAME]/pizzabackend:latest
            ports:
            - containerPort: 80
            env:
            - name: ASPNETCORE_URLS
              value: http://*:80
      selector:
        matchLabels:
          app: pizzabackend
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: pizzabackend
    spec:
      type: ClusterIP
      ports:
      - port: 80
      selector:
        app: pizzabackend
    ```

1. Replace the placeholder `[YOUR DOCKER USER NAME]` with your actual Docker username.

This file does a couple of things.

The first portion defines a deployment spec for the container that will be deployed into Kubernetes. It specifies there will be one replica, where to find the container image, which ports to open on the container, and sets some environment variables. This first portion also defines labels and names that the container and spec can be referenced by.

The second portion then defines that the container will run as a Kubernetes ClusterIP. For this module, you don't need to understand all of the specifics of ClusterIPs, but you should know that this type of service doesn't expose an external IP address. It's only accessible from other services running from within the same Kubernetes cluster.

## Deploy and run the backend microservice

Next, let's deploy and run the microservice.

1. Open a command prompt to the same directory where you created the **backend-deploy.yml** file.
1. Run the following command:

    ```bash
    kubectl apply -f backend-deploy.yml
    ```

    This command is telling Kubernetes to run the file we created. It will download the image from Docker Hub and create the container.

1. The `kubectl apply` command will return quickly. But the container creation may take a while. To view the progress, use the following code.

    ```bash
    kubectl get pods
    ```

    In the resulting output, you'll have a row with **pizzabackend** followed by a string of random characters under the **NAME** column. When everything is ready, there will be a **1/1** under the **READY** column and **Running** under the **STATUS** column.

1. Browse to `http://localhost/pizzainfo`, which returns an HTTP 404 Not Found message. This error is because the pizza backend service isn't accessible from the outside world.

## Create a deployment file and run the frontend service

Much like the backend service, we'll need a deployment file for the front end as well.

1. Create a new file named **frontend-deploy.yml**
1. Paste the following code into the file:

    ```yml
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: pizzafrontend
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: pizzafrontend
        spec:
          containers:
          - name: pizzafrontend
            image: [YOUR DOCKER USER NAME]/pizzafrontend:latest
            ports:
            - containerPort: 80
            env:
            - name: ASPNETCORE_URLS
              value: http://*:80
            - name: backendUrl
              value: http://pizzabackend
      selector:
        matchLabels:
          app: pizzafrontend
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: pizzafrontend
    spec:
      type: LoadBalancer
      ports:
      - port: 80
      selector:
        app: pizzafrontend
    ```

1. Replace the placeholder `[YOUR DOCKER USERNAME]` with your actual Docker username.

    You'll notice this file is similar to the one we created for the backend microservice. There are three differences:

    - We're specifying a different container to run under the deployment's `spec.template.spec.containers.image` value.
    - There's a new environment variable under the `spec.template.spec.containers.env` section. The code in the **pizzafrontend** application calls the backend, but because we haven't specified a fully qualified domain name (FQDN), nor will we know the IP address of the backend microservice, we use the name we specified under the `metadata.name` node of the `Deployment`. Kubernetes will then take care of the rest.
    - In the service section, we're specifying a value of **LoadBalancer** for `spec.type`, and port 80 is open. We'll now be able to browse the pizza frontend by navigating to **http://localhost**.

1. Deploy the container to Kubernetes with the following command:

    ```bash
    kubectl apply -f frontend-deploy.yml
    ```

    Again you can use `kubectl get pods` to see the status of the deployment. Once the row for **pizzafrontend** displays **Running** under the **STATUS** column, everything is ready to go.

1. When the container has been successfully deployed, browse to `http://localhost` to see both microservices running.

In this exercise, you created a deployment file that described exactly how you wanted the containers to run within Kubernetes. You then had Kubernetes download the image from Docker Hub and start up the containers.
