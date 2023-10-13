In this exercise, you deprovision the full enrollment group. Again, this includes disenrolling the enrollment from Device Provisioning Service and deregistering the devices from IoT Hub.

### Task 1: Disenroll the enrollment group from the DPS

In this task, you disenroll your enrollment group, which removes the enrolled devices. If you want to temporarily disenroll the devices, you can disable the enrollment group. For a permanent disenrollment, delete the enrollment group.

1. In the Azure sandbox, either disable or delete your enrollment group.

   * Disable:

     ```azurecli
     az iot dps enrollment-group update --dps-name dps-$suffix --enrollment-id enrollgroup-sensors --provisioning-status disabled
     ``` 

   * Delete:

     ```azurecli
     az iot dps enrollment-group delete --dps-name dps-$suffix --enrollment-id enrollgroup-sensors
     ```

If you run the sensor-thl-001 simulated device now, you will see an error message similar to what you saw with the disabled individual enrollment.

> **Note**:  If you delete an enrollment group for a certificate, devices that have the certificate in their certificate chain might still be able to enroll if a different, enabled enrollment group still exists for the root certificate or another intermediate certificate higher up in their certificate chain.

### Task 2: Deregister the devices from the IoT Hub

Once the enrollment group has been removed from the Device Provisioning Service (DPS), the device registration will still exist within Azure IoT Hub. To fully deprovision the devices, you will need to remove that registration as well.

1. In the Azure sandbox, delete the device from your IoT hub device registry.

   ```azurecli
   az iot hub device-identity delete --hub-name hub-$suffix --device-id sensor-thl-001
   ```

#### Task 3: Confirm that your devices have been deprovisioned

With the group enrollment deleted from the Device Provisioning Service, and the device deleted from the Azure IoT Hub device registry, the device(s) have been fully removed from the solution.

1. Switch to the Visual Studio Code window containing your sensor-thl-001-device code project.

1. On the Visual Studio Code **View** menu, select **Terminal**.

1. Run the simulated device app, enter the following command:

    ```cmd/sh
    dotnet run
    ```

1. Notice the exceptions listed when the device attempts to provision.

   Now that the group enrollment and registered device have been deleted, the simulated device will no longer be able to provision or connect. When the application attempts to use the configured X.509 certificate to connect to DPS, it will return a **ProvisioningTransportException** error message.

   ```txt
   Found certificate: AFF851ED016CA5AEB71E5749BCBE3415F8CF4F37 CN=sensor-thl-001; PrivateKey: True
   Using certificate AFF851ED016CA5AEB71E5749BCBE3415F8CF4F37 CN=sensor-thl-001
   RegistrationID = sensor-thl-001
   ProvisioningClient RegisterAsync . . . Unhandled exception. Microsoft.Azure.Devices.Provisioning.Client.ProvisioningTransportException: {"errorCode":401002,"trackingId":"df969401-c766-49a4-bab7-e769cd3cb585","message":"Unauthorized","timestampUtc":"2019-12-20T21:30:46.6730046Z"}
      at Microsoft.Azure.Devices.Provisioning.Client.Transport.ProvisioningTransportHandlerAmqp.ValidateOutcome(Outcome outcome)
      at Microsoft.Azure.Devices.Provisioning.Client.Transport.ProvisioningTransportHandlerAmqp.RegisterDeviceAsync(AmqpClientConnection client, String correlationId, DeviceRegistration deviceRegistration)
      at Microsoft.Azure.Devices.Provisioning.Client.Transport.ProvisioningTransportHandlerAmqp.RegisterAsync(ProvisioningTransportRegisterMessage message, CancellationToken cancellationToken)
   ```

You have completed the registration, configuration, and deprovisioning as part of the IoT devices life cycle with Device Provisioning Service.
