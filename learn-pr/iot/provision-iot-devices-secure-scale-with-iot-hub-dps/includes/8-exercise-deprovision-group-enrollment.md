In this exercise, you deprovision the full enrollment group, including disenrolling the enrollment from Device Provisioning Service (DPS) and deregistering the devices from IoT Hub.

### Task 1: Disenroll the enrollment group from DPS

In this task, you disenroll your enrollment group from DPS, which disables the enrolled devices. If you want to temporarily disenroll the devices, you can disable the enrollment group. For a permanent disenrollment, delete the enrollment group.

1. In the Azure sandbox, either disable or delete your enrollment group.

   Disable:

     ```azurecli
     az iot dps enrollment-group update --dps-name dps-$suffix --enrollment-id enrollgroup-sensors --provisioning-status disabled
     ```

   Delete:

     ```azurecli
     az iot dps enrollment-group delete --dps-name dps-$suffix --enrollment-id enrollgroup-sensors
     ```

If you run the sensor-thl-001 simulated device now, you'll see an error message similar to what you saw with the disabled individual enrollment.

> [!NOTE]
> If you delete an enrollment group for a certificate, devices that have the certificate in their certificate chain might still be able to enroll if a different, enabled enrollment group still exists for the root certificate or another intermediate certificate higher up in their certificate chain.

### Task 2: Deregister the devices from the IoT Hub

Once the enrollment group is removed from the Device Provisioning Service (DPS), the device registration still exists within Azure IoT Hub. To fully deprovision the devices, you need to remove that registration as well.

1. In the Azure sandbox, delete the device from your IoT hub device registry.

   ```azurecli
   az iot hub device-identity delete --hub-name hub-$suffix --device-id sensor-thl-001
   ```

#### Task 3: Confirm that your devices are deprovisioned

With the group enrollment deleted from the Device Provisioning Service, and the device deleted from the Azure IoT Hub device registry, the device(s) are fully removed from the solution.

1. Switch to the Visual Studio Code window containing your sensor-thl-001-device code project.

1. Run the simulated device app, enter the following command:

    ```cmd/sh
    dotnet run
    ```

1. Notice the exceptions listed when the device attempts to provision.

   Now that the group enrollment and registered device are deleted, the simulated device can no longer be able to provision or connect. When the application attempts to use the configured X.509 certificate to connect to DPS, it returns a **ProvisioningTransportException** error message.

   ```txt
   Found certificate: AFF851ED016CA5AEB71E5749BCBE3415F8CF4F37 CN=sensor-thl-001; PrivateKey: True
   Using certificate AFF851ED016CA5AEB71E5749BCBE3415F8CF4F37 CN=sensor-thl-001
   RegistrationID = sensor-thl-001
   ProvisioningClient RegisterAsync . . . Unhandled exception. Microsoft.Azure.Devices.Provisioning.Client.ProvisioningTransportException: {"errorCode":401002,"trackingId":"df969401-c766-49a4-bab7-e769cd3cb585","message":"Unauthorized","timestampUtc":"2019-12-20T21:30:46.6730046Z"}
      at Microsoft.Azure.Devices.Provisioning.Client.Transport.ProvisioningTransportHandlerAmqp.ValidateOutcome(Outcome outcome)
      at Microsoft.Azure.Devices.Provisioning.Client.Transport.ProvisioningTransportHandlerAmqp.RegisterDeviceAsync(AmqpClientConnection client, String correlationId, DeviceRegistration deviceRegistration)
      at Microsoft.Azure.Devices.Provisioning.Client.Transport.ProvisioningTransportHandlerAmqp.RegisterAsync(ProvisioningTransportRegisterMessage message, CancellationToken cancellationToken)
   ```

You have completed the registration, configuration, and deprovisioning as part of the IoT devices lifecycle with Device Provisioning Service.

## Verify your work

1. Verify that the enrollment group was disabled or deleted from DPS.

   ```azurecli
   az iot dps enrollment-group show --dps-name dps-$suffix --enrollment-id enrollgroup-sensors
   ```

   If the enrollment group is disabled, you should see command output that the `provisioningStatus` is disabled:

   ```azurecli
   "provisioningStatus": "disabled"
   ```

   If the enrollment group is deleted, you should see a message similar to the following.

   ```azurecli
   {'code': 404204, 'message': 'Not Found.', 'trackingId': '3a1badb5-c1db-4dff-a001-69a5e6e252f4'}
   ```

1. Verify that device sensor-thl-001 was deregistered (deleted) from the IoT hub.

   ```azurecli
   az iot hub device-identity show --hub-name hub-$suffix --device-id sensor-thl-001
   ```

    You should see a `DeviceNotFound` error message similar to the following:

   ```azurecli
    {'Message': 'ErrorCode:DeviceNotFound;sensor-thl-001', 'ExceptionMessage': 'Tracking ID:06e0221675514160850421f0b3b787a9-G:0-TimeStamp:10/24/2023 16:57:00'}
    ```
