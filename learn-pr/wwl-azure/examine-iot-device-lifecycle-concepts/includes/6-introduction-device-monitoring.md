Device monitoring is used to track the overall device collection *health*, the *status* of ongoing operations, and to alert operators to issues that might require their attention. You can program devices to update their device twins and report real-time operating conditions and status of update operations. Powerful back-end dashboard reports can also be generated to surface the most immediate issues by using device twin queries.

Device twin desired and reported properties can be used to monitor a target condition, target content, or device metrics.

 -  The target condition defines the scope of device twins to be updated. The target condition is specified as a query on twin tags and/or reported properties.
 -  The target content defines the desired properties to be added or updated in the targeted device twins. The content includes a path to the section of desired properties to be changed.
 -  The metrics define the summary counts of various configuration states such as Success, In Progress, and Error.

> [!NOTE]
> Monitoring the Azure IoT Hub service is a separate activity. Monitoring IoT Hub involves other Azure services and could include monitoring IoT Hub metrics such as device connections or the number of device messages received.
