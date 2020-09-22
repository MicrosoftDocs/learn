Create a release pipeline that deploys to QA devices and smoke tests the edge runtime in a containerized device.

The steps to achieve this are:

- Run an instance of [azure-iot-edge-device-container](https://github.com/toolboc/azure-iot-edge-device-container), which is configured as a QA device.

- Probe the IoT hub to ensure the QA device receives the desired deployment configuration and is able to successfully run all configured modules. This test is contained in [edgeSmokeTest.sh](https://github.com/MicrosoftDocs/mslearn-oxford-implement-cicd-iot-edge/blob/master/scripts/edgeSmokeTest.sh).

## Adding tests

Scalable integration testing is vital for Azure IoT Edge solutions that rely on services to accomplish desired functionality.

- Set up a scalable deployment of QA devices using an Azure Kubernetes cluster.
- Monitor these devices using the dockerappinsights module, which is configured in deployment.template.json.
- Completion of this step will require the configuration of Azure Kubernetes Service.

## Configuring an Azure Kubernetes Service

- Creating an Azure Kubernetes Service cluster in the Azure portal.
- Add a new stage after **Smoke Test** based on the **Deploy an application to a Kubernetes cluster by using its Helm chart** template to the pipeline.
- In Kubernetes, Helm helps you manage Kubernetes applications. Helm Charts help you define, install, and upgrade the Kubernetes application.
