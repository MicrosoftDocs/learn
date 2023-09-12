Now that you've implemented a fully functional CI/CD pipeline that deploys a cloud-native application to an AKS cluster, you want to explore the use of DevOps principles in IoT scenarios. To accomplish this, you decide to test Azure Pipelines, which offers tight integration with Azure IoT Edge.

## What is IoT Edge?

Azure IoT Edge is a managed service that provides the ability to deploy and manage containerized workloads on cross-platform IoT devices. Such workloads benefit from cloud intelligence by using services such as Azure Machine Learning and Azure AI services. You can build Azure IoT Edge solutions by using a wide range of programming languages, including C#, Node.js, Python, Java, or C, and package your code as Windows or Linux containers.

## How to apply DevOps principles in IoT Edge scenarios

The same rationale that favors the use of DevOps in regard to cloud-native applications applies to IoT apps. While the choice of the DevOps solution is mainly a matter of preference, Azure Pipelines simplify the task of authoring CI/CD pipelines by providing the built-in Azure IoT Edge task, which includes support for building and deploying Azure IoT Edge images.

When authoring Azure Pipelines, you have a choice between using the classic or YAML-based approach:

- With the classic approach, you rely on the visual designer included in the Azure DevOps web-based portal to define a build pipeline that builds your code, tests it, and publishes resulting artifacts. You also use a similar graphical interface to define a release pipeline that consumes and deploys these artifacts to deployment targets. Neither of these pipelines resides in the code repository, but instead, both are hosted by Azure Pipelines.
- With the YAML-based approach, your pipeline takes the form of a YAML-formatted file, which, by default, resides in the same repository as the code used to build artifacts. You can define the build and deployment within the same file. Because the pipeline is part of your code, you benefit from the version control functionality, which allows you to track pipeline changes and simplify the identification of potential issues related to these changes.

When you plan a pipeline, you usually begin by identifying its stages. Typically, a stage maps to an environment, but this isn't required. In the context of Azure Pipelines, an environment represents one or more deployment targets, such as groups of development, testing, and production Azure App Service instances.

You can execute parts of the pipeline corresponding to individual stages independently. You can invoke this execution manually or configure it to take place automatically in response to a trigger. Such triggers can be based on a predefined schedule or an event, such as a repository commit (in case of CI) or successful completion of the build process (in case of CD).

## How to design CI/CD for Azure IoT Edge applications

You're considering a design that will include the following infrastructure components:

- Azure Repos. One of Azure DevOps components that serves as code repository.
- Azure Pipelines. One of Azure DevOps components that automates builds and deployments.
- Azure Container Registry. An Azure-hosted private Docker registry that serves as a store for containerized IoT Edge modules.
- Azure IoT Hub. An Azure service that provides the ability to connect to, monitor, and manage IoT devices.
- Azure IoT Hub Device Provisioning Service. A component of Azure IoT hub that facilitates the automatic provisioning of IoT devices.

You intend to deliver the new version of your app across three stages: dev, qa, and production. An Azure build pipeline will test, build, and store the latest version of an IoT app pushed into Azure Repos. Through continuous integration, a successful build will trigger the release pipeline, which will provision the remaining infrastructure components in the target environment and deploy the app into them. To conclude the deployment, the pipeline will invoke a smoke test that checks the following conditions:

- The availability of the IoT devices.
- The connectivity between the IoT device and the IoT hub.
- The presence of the new deployment manifest on the IoT devices.
- The online status of the modules specified in the deployment manifest.

A successful outcome for all of these checks is required for the continuous delivery to the next stage.

## How to implement CI/CD for Azure IoT Edge applications

From the implementation standpoint, the build pipeline will perform the following sequence of actions:

- Perform unit testing of the newly developed version of the app (the choice of the most suitable task depends on the development framework).
- Provision an Azure container registry instance or connect to an existing one (by using an Azure Resource group deployment task).
- Retrieve the credentials necessary to push an image to the Azure container registry instance (by using an Azure CLI task).
- Build an Azure IoT module image (by using the Azure IoT Edge task).
- Push the Azure IoT module image (by using the Azure IoT Edge task).
- Copy files, such as the smoke test script, to the artifact staging directory (by using the Copy Files task).

The delivery pipeline for each stage will perform the following sequence of actions:

- Provision an IoT Edge device (by using an Azure CLI task or an Azure Resource Manager template).
- Retrieve credentials necessary to pull a module image from the Azure container registry instance (by using an Azure CLI task).
- Generate a deployment manifest (by using the Azure IoT Edge task).
- Deploy the module image into Azure IoT Edge device (by using the Azure IoT Edge task).
- Perform the smoke test (by using an Azure CLI task).

The delivery to the dev stage will include provisioning of an IoT hub. You have the option of using the same hub for subsequent deployments or creating one for each stage. Optionally, you could also implement Azure Application Insights to monitor status and performance of the deployed module.

:::image type="content" source="../media/6-azure-devops-iot-pipeline.png" alt-text="Image illustrating an Azure DevOps pipeline that deploys Azure IoT Edge modules." border="false":::
