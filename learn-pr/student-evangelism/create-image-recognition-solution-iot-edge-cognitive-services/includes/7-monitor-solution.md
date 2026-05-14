
Once the solution is deployed to IoT Edge, the system operates to tell you the scanned items. 

## Monitor the solution on the IoT Edge device

Once the solution has been deployed, you can monitor it on the IoT Edge device using the **iotedge list** command. On most Linux IoT Edge devices, this command requires elevated privileges.

```
sudo iotedge list
```

If your device is configured to allow your user account to run IoT Edge commands without **sudo**, you can run **iotedge list** directly.

:::image type="content" source="../media/module-status.png" alt-text="The illustration shows the module status." lightbox="../media/module-status.png":::

The **iotedge list** command shows the runtime status of IoT Edge modules, such as whether each module is running, stopped, or restarting. It doesn't fully verify module health. To view local console output and errors from the modules, check the module logs on the device:

```
sudo iotedge logs camera-capture
sudo iotedge logs image-classifier-service
```

These logs show container output on the edge device. For the unmodified linked sample, use these local module logs together with module runtime status and module details in the portal to verify behavior. The sample camera callback primarily prints locally and doesn't send messages to the routed `output1` unless you change the sample code to send messages upstream.

For troubleshooting and diagnostics beyond runtime status and logs, run **iotedge check** on the device:

```
sudo iotedge check
```

The **iotedge check** command runs configuration, connection, and production-readiness checks for common IoT Edge issues.

For official troubleshooting guidance, see [Troubleshoot your IoT Edge device](/azure/iot-edge/troubleshoot).

## Monitoring the solution from IoT Hub in the Azure portal

You can monitor and troubleshoot the IoT Edge device from your IoT hub in the Azure portal.

In the Azure portal, open your IoT hub, then select **Device management** > **Devices**. Select the IoT Edge device, then review the module list for runtime status or open a module to view module details. Select **Troubleshoot** from the IoT Edge device details page or from a module details page to retrieve and filter module logs or restart a module remotely.

For the portal troubleshooting workflow, see [Troubleshoot IoT Edge devices from the Azure portal](/azure/iot-edge/troubleshoot-in-portal).

:::image type="content" source="../media/module-status-hub.png" alt-text="The illustration shows the module status from IoT Hub." lightbox="../media/module-status-hub.png":::

Use the Azure portal module status, module details, and troubleshooting views to check whether modules are deployed, running, restarting, or reporting errors. If you cannot connect to the device directly, you can retrieve IoT Edge logs remotely from the portal troubleshooting page or by invoking IoT Edge agent direct methods such as `GetModuleLogs`, `UploadModuleLogs`, or `UploadSupportBundle` from the portal or Azure CLI. Method names are case-sensitive.

When you use `UploadModuleLogs` or `UploadSupportBundle`, provide a scoped Azure Blob Storage container SAS URL with write permission only to the diagnostic upload destination and with the shortest practical expiry. Limit uploaded data with the filters each method supports: `UploadModuleLogs` accepts module log filters such as `tail`, `since`, and `until`, while `UploadSupportBundle` accepts `since`, `until`, and `edgeRuntimeOnly`. Unbounded uploads can be large, slow, or costly. These upload methods run asynchronously and return a `correlationId`; call `GetTaskStatus` with that ID until the task status is `Completed`, `Failed`, or `Cancelled`. Treat uploaded logs and support bundles as sensitive data because they can include host names, device and module names, application output, configuration details, and personally identifiable information. Delete uploaded diagnostic blobs and revoke the SAS if it is backed by a stored access policy, or let short-lived ad hoc SAS URLs expire, when troubleshooting is complete.

For supported remote log retrieval direct methods and payload details, see [Retrieve logs from IoT Edge deployments](/azure/iot-edge/how-to-retrieve-iot-edge-logs).

## Optional: Monitor upstream IoT Hub messages from Azure Cloud Shell

Use this optional step only for deployments that send device-to-cloud messages to IoT Hub through an upstream route.

1. You will need to know the name of the Azure IoT Hub you created. You can get the name from the Azure web portal.

2. Open the Azure Cloud Shell

3. In the Cloud Shell, run the az extension add command with `--upgrade` to install or update the Microsoft Azure IoT Extension in your CLI shell. The IoT Extension adds IoT Hub, IoT Edge, and IoT Device Provisioning Service (DPS) specific commands to Azure CLI.

   ```
   az extension add --upgrade --name azure-iot
   ```

4. If your deployment sends upstream messages, start the IoT Hub Events Monitor with the following command. Be sure to use your IoT Hub name.
 
   ```
   az iot hub monitor-events --hub-name <iot-hub-name>
   ```
 
5. Observe upstream device-to-cloud messages in the cloud. The **az iot hub monitor-events** command displays device-to-cloud messages that devices or IoT Edge modules send upstream to IoT Hub through deployment routes, such as routes ending in `$upstream`. It does not display local console output or module logs.

   For command syntax and options, see the Azure CLI reference for [`az iot hub monitor-events`](/cli/azure/iot/hub).

   The linked sample deployment template contains a route from the `camera-capture` module's `output1` to IoT Hub, but the unmodified sample callback doesn't actually send messages to `output1`. Unless you update the sample code to send messages upstream, **az iot hub monitor-events** may show no events even when **sudo iotedge list** and the portal show that the modules are running.

6. Use Ctrl+C to stop the event monitor. 

## Clean up lab resources

When you're finished, either reuse the lab resources for another exercise or delete them to avoid unwanted charges and background services.

- If you created a dedicated Azure resource group for this lab, delete the resource group only after you confirm it doesn't contain anything you need:

  ```azurecli
  az group delete --name <resource-group-name>
  ```

  Deleting a resource group deletes all resources in it, such as the IoT hub, IoT Edge device identity, Foundry resource for Speech, storage accounts or containers used for diagnostic uploads, and any Azure Container Registry you created for remote images.

- If you reused a shared resource group or shared IoT hub, don't delete the whole group. Instead, remove only the lab-specific resources you no longer need, such as the IoT Edge device identity, the lab IoT hub or Speech resource, uploaded diagnostic blobs, and any temporary registry or storage resources. Keep resources that are shared with other workloads.

- On the Linux computer where you started the lab-only local registry with `--restart=always`, stop and remove that registry container when you no longer need it:

  ```bash
  docker stop registry
  docker rm registry
  ```

- Optionally remove lab images from the development computer to recover disk space. First list the image names and tags, then remove only images you recognize as lab artifacts:

  ```bash
  docker image ls --filter "reference=localhost:5000/*"
  docker image rm <image-name:tag>
  ```
