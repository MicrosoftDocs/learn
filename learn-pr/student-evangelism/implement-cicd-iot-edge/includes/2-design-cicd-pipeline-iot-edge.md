In the scenario outlined in the introduction, you were responsible for addressing two main problems:

Firstly, you wanted to create a smoke testing strategy for IoT Edge devices. Secondly, you wanted to integrate code from several developers as an automated process through a DevOps (Continuous Integration and Continuous Delivery) strategy. In this unit, we'll plan the sequence of steps needed to implement a solution to this problem statement.

The design for the solution should provide two main benefits:

1. Because it is expensive to deploy to different physical IoT devices, the use of a smoke test for virtual IoT device saves costs. A successful smoke test ensures that the program is ready for further testing. 
2. Automated smoke testing avoids expensive rework for more sophisticated tests, optimizing the time for your developer and the test teams.

To implement this solution, you will create a smoke test as a subset of your main functionality. The test should be self-scoring and automated. It should be capable of running on virtual IoT devices. Also, the test should incorporate the principles of DevOps (Continuous Integration and Continuous Delivery) for IoT Edge devices. 

You will use the following components in the overall design:

**Application Insights:** Used to monitor performance metrics of Docker Host and IoT Edge Modules

**Azure Container Registries:** A private docker registry service used to store published IoT Edge Modules

**Azure IoT Hub Device Provisioning Service:** Allows for automatic provisioning of IoT Devices in a secure and scalable manner

**Azure IoT Hubs:** Service enables us to connect, monitor, and manage IoT devices securely.

**Azure Pipelines:** A service that automates your builds and deployments. 

To implement this solution, you will create a release pipeline that deploys to QA devices, and smoke tests the edge runtime in a containerized device. The design will run an instance of the [azure-iot-edge-device-container](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftoolboc%2Fazure-iot-edge-device-container&data=02|01|xshi%40microsoft.com|0102337c9ada4f3ef10d08d812fcc9c1|72f988bf86f141af91ab2d7cd011db47|1|0|637280224216554921&sdata=dpn9cmudy%2FqQT6ifznms7KplLrUDrwIYbulqrTB7IdE%3D&reserved=0), which is configured as a QA device. The tests will probe the IoT Hub to ensure that the QA device receives the desired deployment configuration and can run all configured modules successfully. 

The script for the smoke test implements the following:

- Test for the existence of the device(s) 
- Test if the device connected to IoT hub
- Test if the device applied new deployment manifest
- The modules that specified in the deployment manifest are running successfully

The steps involved are: 

1. Creating Azure Resources

2. Setup Azure DevOps Services

3. Setting up Continuous Integration

4. Creating a release pipeline with a Smoke Test

5. Adding a scalable integration test to a release pipeline

6. Monitoring devices with App Insights