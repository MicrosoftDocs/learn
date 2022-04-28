You've published a containerized DeepStream Graph Composer workload to your container registry and provisioned your NVIDIA Jetson embedded device with the IoT Edge runtime. Now, you're ready to create a deployment specification in your hub to run the workload as an IoT Edge module.

1. In the Azure portal, go to the IoT hub that you created at the beginning of this module. In the left menu, under **Automatic Device Management**, select **IoT Edge**. Look for your registered device.

   :::image type="content" source="../media/iot-hub-iot-edge.png" alt-text="Screenshot that shows the IoT Edge Devices tab in the Azure portal." lightbox="../media/iot-hub-iot-edge.png":::

1. To see details about the current configuration, select the name of the device:

   :::image type="content" source="../media/iot-hub-device-overview.png" alt-text="Screenshot that shows an overview of the IoT Edge device." lightbox="../media/iot-hub-device-overview.png":::

1. Select the **Set modules** tab to open the modules editor:

   :::image type="content" source="../media/iot-hub-module-editor.png" alt-text="Screenshot that shows the Modules pane." lightbox="../media/iot-hub-module-editor.png":::

    You must supply appropriate Container Registry credentials, so your NVIDIA embedded device can pull container workloads from your container registry.

1. In a separate browser window, go to your container registry in the Azure portal:

   :::image type="content" source="../media/overview.png" alt-text="Screenshot that shows an overview of your Azure Container Registry instance." lightbox="../media/overview.png":::

1. In the left menu, under **Settings**, select **Access keys**. In **Access keys**, note the values for **Login server**, **Username**, and **password**. You'll use these values in the next step.

   :::image type="content" source="../media/access-keys.png" alt-text="Screenshot that shows credentials for the container registry." lightbox="../media/access-keys.png":::

1. Return to the browser window that's open to **Set modules**. In **Container Registry Credentials**, enter the values from the container registry **Access keys**. Using these credentials, any device that applies this module specification can securely pull container workloads from your container registry in Azure.

   :::image type="content" source="../media/iot-hub-credentials.png" alt-text="Screenshot that shows entering container registry credentials in Azure IoT Hub." lightbox="../media/iot-hub-credentials.png":::

1. Next, you'll configure a custom IoT Edge module as part of your deployment specification. In the **IoT Edge Modules** section of the **Modules** pane, select **Add** > **IoT Edge Module**:

   :::image type="content" source="../media/iot-hub-add-module.png" alt-text="Screenshot that shows adding an IoT Edge module." lightbox="../media/iot-hub-add-module.png":::

1. In **Add IoT Edge Module**, in **IoT Edge Module Name**, enter the module name **deepstream_test4_jetson**. In **Image URI**, enter **\<Login Server\>/deepstream_test4_jetson:v1**. For **\<Login Server\>**, use the URL of your container registry.

   :::image type="content" source="../media/iot-hub-add-module-uri.png" alt-text="Screenshot that shows entering a name and image U R I for the IoT Edge module." lightbox="../media/iot-hub-add-module-uri.png":::

1. Next, select the **Container Create Options** tab to enable support for GPU acceleration and also to provide access to the X11 socket to allow for rendering video output from the container by adding the following:

    ```Output
    {
    "NetworkingConfig": {
        "EndpointsConfig": {
            "host": {}
        }
    },
    "HostConfig": {
        "DeviceRequests": [
            {
                "Count": -1,
                "Capabilities": [
                    [
                        "gpu"
                    ]
                ]
            }
        ],
        "NetworkMode": "host",
        "Binds": [
            "/tmp/.X11-unix/:/tmp/.X11-unix/",
            "/tmp/argus_socket:/tmp/argus_socket"
        ]
    }
    }
    ```

    When you're finished, select **Update**:

    :::image type="content" source="../media/iot-hub-container-create-options.png" alt-text="Screenshot that shows the Container Create options in the Modules pane." lightbox="../media/iot-hub-container-create-options.png":::



1. You will return to the **Set Modules on device page**, once there select **Review + create**:

   :::image type="content" source="../media/iot-hub-module-review.png" alt-text="Screenshot that shows the Review plus create button highlighted on the Modules pane." lightbox="../media/iot-hub-module-review.png":::

1. The **Deployment** text box displays the deployment specification you're about to submit to your device. Verify that the contents look similar to this example:

    ```Output
    {
    "modulesContent": {
        "$edgeAgent": {
            "properties.desired": {
                "modules": {
                    "deepstream_test4_jetson": {
                        "settings": {
                            "image": "<Login Server>.azurecr.io/deepstream_test4_jetson:v1",
                            "createOptions": "{\"NetworkingConfig\":{\"EndpointsConfig\":{\"host\":{}}},\"HostConfig\":{\"DeviceRequests\":[{\"Count\":-1,\"Capabilities\":[[\"gpu\"]]}],\"NetworkMode\":\"host\",\"Binds\":[\"/tmp/.X11-unix/:/tmp/.X11-unix/\",\"/tmp/argus_socket:/tmp/argus_socket\"]}}"
                        },
                        "type": "docker",
                        "version": "1.0",
                        "env": {
                            "DISPLAY": {
                                "value": ":0"
                            }
                        },
                        "status": "running",
                        "restartPolicy": "always"
                    }
                },
                "runtime": {
                    "settings": {
                        "minDockerVersion": "v1.25",
                        "registryCredentials": {
                            "<Your Registry Name>": {
                                "address": "<Login Server>.azurecr.io",
                                "password": "<Your Password>",
                                "username": "<Your Username>"
                            }
                        }
                    },
                    "type": "docker"
                },
                "schemaVersion": "1.1",
                "systemModules": {
                    "edgeAgent": {
                        "settings": {
                            "image": "mcr.microsoft.com/azureiotedge-agent:1.1",
                            "createOptions": ""
                        },
                        "type": "docker"
                    },
                    "edgeHub": {
                        "settings": {
                            "image": "mcr.microsoft.com/azureiotedge-hub:1.1",
                            "createOptions": "{\"HostConfig\":{\"PortBindings\":{\"5671/tcp\":[{\"HostPort\":\"5671\"}],\"8883/tcp\":[{\"HostPort\":\"8883\"}],\"443/tcp\":[{\"HostPort\":\"443\"}]}}}"
                        },
                        "type": "docker",
                        "status": "running",
                        "restartPolicy": "always"
                    }
                }
            }
        },
        "$edgeHub": {
            "properties.desired": {
                "routes": {
                    "route": "FROM /messages/* INTO $upstream"
                },
                "schemaVersion": "1.1",
                "storeAndForwardConfiguration": {
                    "timeToLiveSecs": 7200
                }
            }
        },
        "deepstream_test4_jetson": {
            "properties.desired": {}
        }
    }
    }
    ```

1. Verify that the deployment configuration is correct, and then select **Create** to start the deployment process:

   :::image type="content" source="../media/iot-hub-deployment-create.png" alt-text="Screenshot that shows the Deployment text box and the Create button." lightbox="../media/iot-hub-deployment-create.png":::

1. To verify that the deployment was successful, run the following commands in a terminal on the NVIDIA embedded device:

    ```bash
    sudo iotedge list
    ```

1. Verify that the output shows a status of `running` for the `edgeAgent`, `edgeHub`, and `deepstream_test4_jetson` modules.

    If your device is connected to a display, you should be able to see the visualized output of the DeepStream Graph Composer application, like in this example:

    :::image type="content" source="../media/jetson-edge-module-running.png" alt-text="Screenshot that shows the IoT Edge module running on Jetson hardware." lightbox="../media/jetson-edge-module-running.png":::

1. Monitor the output of the `deepstream_test4_jetson` module by running the following command in a terminal on the NVIDIA Jetson embedded device:

    ```bash
    sudo docker logs -f deepstream_test4_jetson
    ```

   Every few seconds, your device sends telemetry to its registered hub in Azure IoT Hub. A message that looks like the following example appears:

    ```Output
    Message sent : {
      "version" : "4.0",
      "id" : 1440,
      "@timestamp" : "2021-09-21T03:08:51.161Z",
      "sensorId" : "sensor-0",
      "objects" : [
        "-1|570|478.37|609|507.717|Vehicle|#|sedan|Bugatti|M|blue|XX1234|CA|-0.1"
      ]
    }
    ```

1. You can confirm the status of the running modules in the Azure portal by returning to the device overview for your IoT Edge device. You should see the following modules and associated statuses listed for your device:

   :::image type="content" source="../media/iot-hub-device-overview-status.png" alt-text="Screenshot that shows an overview of the IoT Edge device with runtime status." lightbox="../media/iot-hub-device-overview-status.png":::
  
1. You also can confirm in your IoT Hub overview pane that messages are arriving in your hub from your device. You should notice an increase in messages:

   :::image type="content" source="../media/iot-hub-messages.png" alt-text="Screenshot that shows charts that depict received messages in the IoT Hub Usage pane." lightbox="../media/iot-hub-messages.png":::

Congratulations!  You have successfully developed a production-grade edge deployment of a DeepStream Graph Composer workload and deployed it to a real device by using Azure IoT Edge!

### Try this

Using strategies described in this module, how might you modify an existing DeepStream reference graph to support a wildlife conservation solution that counts unique instances of endangered species by using live camera feeds? Which components would you need to modify to support this solution? Would you need to make any modifications to the overall deployment strategy?
