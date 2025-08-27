Create a release pipeline to deploy to QA devices and smoke test the edge runtime in a containerized device.

The steps to achieve this are:

1. Run an instance of [azure-iot-edge-device-container](https://github.com/toolboc/azure-iot-edge-device-container) configured as a QA device.

1. Probe the IoT hub to ensure the QA device receives the correct deployment configuration and runs all configured modules successfully. This test is in [edgeSmokeTest.sh](https://github.com/MicrosoftDocs/mslearn-oxford-implement-cicd-iot-edge/blob/master/scripts/edgeSmokeTest.sh).

## Add tests

Integration testing is vital for Azure IoT Edge solutions that rely on services to accomplish their functionality.

1. Set up deployment of QA devices using an Azure Kubernetes cluster.

1. Monitor these devices using the dockerappinsights module, which is configured in deployment.template.json. Completion of this step will require the configuration of Azure Kubernetes Service.

## Configure Azure Kubernetes Service

1. Create an Azure Kubernetes Service cluster in the Azure portal.

1. Add a new stage after **Smoke Test** to the pipeline. Use the **Deploy an application to a Kubernetes cluster by using its Helm chart** template.

In Kubernetes, Helm helps you manage Kubernetes applications. Helm charts help you define, install, and upgrade the Kubernetes application.
