Let's verify that data is propagating from the IoT Edge Gateway into the Azure cloud! With data flowing, we can run hot-path operations on live data and meet cold-path requirements for storage.  Our operations team is already plugged in and waiting, let's make sure the data is live!

[![operation team member.](../media/operator.png)](../media/operator.png#lightbox)

In this unit, you'll use the Azure CLI to monitor events sent to Azure IoT Hub.  These events will come from the downstream IoT Device connected to the IoT Edge Gateway. These steps will validate that event flow from downstream device to IoT Edge Gateway and upstream to IoT Hub is working correctly.

## Verify event flow from Downstream Device through IoT Edge Gateway to IoT Hub

1. If necessary, sign in to your Azure portal using your Azure account credentials.

    If you've got more than one Azure account, ensure that you're signed in with the account for the subscription you intend to use for this course

1. Navigate to the Azure portal and click on the **Cloud Shell** icon to open up the **Azure Cloud Shell**. When the pane opens, choose the option for the **Bash** terminal within the Cloud Shell.

1. Within the **Cloud Shell**, run the following command to monitor the stream of events flowing to the Azure IoT Hub. This step will verify that events from the simulate device, being sent to the IoT Edge Gateway, are being received by the Azure IoT Hub.

    ```bash
    az extension add --name azure-iot
    az iot hub monitor-events -n <IoT-Hub-Name>
    ```

    Be sure to replace the `<IoT-Hub-Name>` placeholder for the `-n` parameter with the name of your Azure IoT Hub.

    The `az iot hub monitor-events` command enables you to monitor device telemetry & messages sent to an Azure IoT Hub.

1. With everything working correctly, the output from the `az iot hub monitor-events` command will look similar to the following output:

    ```bash
     az iot hub monitor-events -n AZ-220-HUB-1119
     Starting event monitor, use ctrl-c to stop...
     {
         "event": {
             "origin": "DownstreamDevice1",
             "payload": "{\"temperature\":30.931512529929872,\"humidity\":78.70672198883571}"
         }
     }
     {
         "event": {
             "origin": "DownstreamDevice1",
             "payload": "{\"temperature\":30.699204018199445,\"humidity\":78.04910910224966}"
         }
     }
     ```

    When you've completed this lab and verified the event flow, you may exit the console application with **CTRL+C**.

    >[!NOTE]
    > Due to the secure nature of the Azure Sandbox, you may not receive any data back when running the command above.  This is because the Gateway device requires that ports 8883, 5671, and 443 are opened in order to allow for communication back to the IoT Hub instance.  Even though we opened these ports in unit 6, the policy will not actually affect the machine.  If you wish to fully verify the results, you may need to deploy into a personal subscription which allows you to make these configuration changes.

## Next steps

To finish the module, complete the following knowledge check.
