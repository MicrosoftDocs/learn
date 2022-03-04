The module twins for the **IoT Edge hub** and **IoT Edge agent** modules (the two IoT Edge Runtime modules) provide properties that can be used manage module communication and lifecycle.

Each module twin includes:

 -  **Desired properties**. The solution backend can set desired properties, and the module can read them. The module can also receive notifications of changes in the desired properties. Desired properties are used along with reported properties to synchronize module configuration or conditions.
 -  **Reported properties**. The module can set reported properties, and the solution backend can read and query them. Reported properties are used along with desired properties to synchronize module configuration or conditions.

## EdgeAgent desired properties

The module twin for the IoT Edge agent is called `$edgeAgent` and coordinates the communications between the IoT Edge agent running on a device and IoT Hub. The desired properties are set when applying a deployment manifest on a specific device as part of a single-device or at-scale deployment.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Required**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    schemaVersion
  :::column-end:::
  :::column:::
    Either "1.0" or "1.1". Version 1.1 was introduced with IoT Edge version 1.0.10, and is recommended.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    runtime.type
  :::column-end:::
  :::column:::
    Has to be "docker".
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    runtime.settings.minDockerVersion
  :::column-end:::
  :::column:::
    Set to the minimum Docker version required by this deployment manifest.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    runtime.settings.loggingOptions
  :::column-end:::
  :::column:::
    A stringified JSON containing the logging options for the IoT Edge agent container.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    runtime.settings.registryCredentials
.\{registryId\}.username
  :::column-end:::
  :::column:::
    The username of the container registry. For Azure Container Registry, the username is usually the registry name.

Registry credentials are necessary for any module images that are not public.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    runtime.settings.registryCredentials
.\{registryId\}.password
  :::column-end:::
  :::column:::
    The password for the container registry.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    runtime.settings.registryCredentials
.\{registryId\}.address
  :::column-end:::
  :::column:::
    The address of the container registry. For Azure Container Registry, the address is usually \{registry name\}.azurecr.io.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeAgent.type
  :::column-end:::
  :::column:::
    Has to be "docker".
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeAgent.settings.image
  :::column-end:::
  :::column:::
    The URI of the image of the IoT Edge agent. Currently, the IoT Edge agent is not able to update itself.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeAgent.settings
.createOptions
  :::column-end:::
  :::column:::
    A stringified JSON containing the options for the creation of the IoT Edge agent container.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeAgent.configuration.id
  :::column-end:::
  :::column:::
    The ID of the deployment that deployed this module.
  :::column-end:::
  :::column:::
    IoT Hub sets this property when the manifest is applied using a deployment. Not part of a deployment manifest.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.type
  :::column-end:::
  :::column:::
    Has to be "docker".
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.status
  :::column-end:::
  :::column:::
    Has to be "running".
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.restartPolicy
  :::column-end:::
  :::column:::
    Has to be "always".
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.startupOrder
  :::column-end:::
  :::column:::
    An integer value for which spot a module has in the startup order. 0 is first and max integer (4294967295) is last. If a value isn't provided, the default is max integer.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.settings.image
  :::column-end:::
  :::column:::
    The URI of the image of the IoT Edge hub.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.settings
.createOptions
  :::column-end:::
  :::column:::
    A stringified JSON containing the options for the creation of the IoT Edge hub container.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.configuration.id
  :::column-end:::
  :::column:::
    The ID of the deployment that deployed this module.
  :::column-end:::
  :::column:::
    IoT Hub sets this property when the manifest is applied using a deployment. Not part of a deployment manifest.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.version
  :::column-end:::
  :::column:::
    A user-defined string representing the version of this module.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.type
  :::column-end:::
  :::column:::
    Has to be "docker".
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.status
  :::column-end:::
  :::column:::
    \{"running" \| "stopped"\}
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.restartPolicy
  :::column-end:::
  :::column:::
    \{"never" \| "on-failure" \| "on-unhealthy" \| "always"\}
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.startupOrder
  :::column-end:::
  :::column:::
    An integer value for which spot a module has in the startup order. 0 is first and max integer (4294967295) is last. If a value isn't provided, the default is max integer.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.imagePullPolicy
  :::column-end:::
  :::column:::
    \{"on-create" \| "never"\}
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.settings.image
  :::column-end:::
  :::column:::
    The URI to the module image.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.settings.createOptions
  :::column-end:::
  :::column:::
    A stringified JSON containing the options for the creation of the module container.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.configuration.id
  :::column-end:::
  :::column:::
    The ID of the deployment that deployed this module.
  :::column-end:::
  :::column:::
    IoT Hub sets this property when the manifest is applied using a deployment. Not part of a deployment manifest.
  :::column-end:::
:::row-end:::


## EdgeAgent reported properties

The IoT Edge agent reported properties include three main pieces of information:

 -  The status of the application of the last-seen desired properties;
 -  The status of the modules currently running on the device, as reported by the IoT Edge agent; and
 -  A copy of the desired properties currently running on the device.

This last piece of information, a copy of the current desired properties, is useful to tell whether the device has applied the latest desired properties or is still running a previous deployment manifest.

> [!NOTE]
> The reported properties of the IoT Edge agent are useful as they can be queried with the IoT Hub query language to investigate the status of deployments at scale.

The following table does not include the information that is copied from the desired properties.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    lastDesiredVersion
  :::column-end:::
  :::column:::
    This integer refers to the last version of the desired properties processed by the IoT Edge agent.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    lastDesiredStatus.code
  :::column-end:::
  :::column:::
    This status code refers to the last desired properties seen by the IoT Edge agent. Allowed values: 200 - Success, 400 - Invalid configuration, 412 - Invalid schema version, 417 - the desired properties are empty, 500 - Failed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    lastDesiredStatus.description
  :::column-end:::
  :::column:::
    Text description of the status.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    configurationHealth.\{deploymentId\}.health
  :::column-end:::
  :::column:::
    Healthy if the runtime status of all modules set by the deployment \{deploymentId\} is either running or stopped, unhealthy otherwise.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    runtime.platform.OS
  :::column-end:::
  :::column:::
    Reporting the OS running on the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    runtime.platform.architecture
  :::column-end:::
  :::column:::
    Reporting the architecture of the CPU on the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeAgent.runtimeStatus
  :::column-end:::
  :::column:::
    The reported status of IoT Edge agent: \{"running" \| "unhealthy"\}
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeAgent.statusDescription
  :::column-end:::
  :::column:::
    Text description of the reported status of the IoT Edge agent.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.runtimeStatus
  :::column-end:::
  :::column:::
    Status of IoT Edge hub: \{ "running" \| "stopped" \| "failed" \| "backoff" \| "unhealthy" \}
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.statusDescription
  :::column-end:::
  :::column:::
    Text description of the status of IoT Edge hub if unhealthy.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.exitCode
  :::column-end:::
  :::column:::
    The exit code reported by the IoT Edge hub container if the container exits.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.startTimeUtc
  :::column-end:::
  :::column:::
    Time when IoT Edge hub was last started.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.lastExitTimeUtc
  :::column-end:::
  :::column:::
    Time when IoT Edge hub last exited.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.lastRestartTimeUtc
  :::column-end:::
  :::column:::
    Time when IoT Edge hub was last restarted.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    systemModules.edgeHub.restartCount
  :::column-end:::
  :::column:::
    Number of times this module was restarted as part of the restart policy.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.runtimeStatus
  :::column-end:::
  :::column:::
    Status of the module: \{ "running" \| "stopped" \| "failed" \| "backoff" \| "unhealthy" \}
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.statusDescription
  :::column-end:::
  :::column:::
    Text description of the status of the module if unhealthy.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.exitCode
  :::column-end:::
  :::column:::
    The exit code reported by the module container if the container exits.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.startTimeUtc
  :::column-end:::
  :::column:::
    Time when the module was last started.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.lastExitTimeUtc
  :::column-end:::
  :::column:::
    Time when the module last exited.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.lastRestartTimeUtc
  :::column-end:::
  :::column:::
    Time when the module was last restarted.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    modules.\{moduleId\}.restartCount
  :::column-end:::
  :::column:::
    Number of times this module was restarted as part of the restart policy.
  :::column-end:::
:::row-end:::


## EdgeHub desired properties

The module twin for the IoT Edge hub is called `$edgeHub` and coordinates the communications between the IoT Edge hub running on a device and IoT Hub. The desired properties are set when applying a deployment manifest on a specific device as part of a single-device or at-scale deployment.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Required in the deployment manifest**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    schemaVersion
  :::column-end:::
  :::column:::
    Either "1.0" or "1.1". Version 1.1 was introduced with IoT Edge version 1.0.10, and is recommended.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    routes.\{routeName\}
  :::column-end:::
  :::column:::
    A string representing an IoT Edge hub route.
  :::column-end:::
  :::column:::
    The routes element can be present but empty.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    storeAndForwardConfiguration.timeToLiveSecs
  :::column-end:::
  :::column:::
    The time in seconds that IoT Edge hub keeps messages if disconnected from routing endpoints, whether IoT Hub or a local module. The value can be any positive integer.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::


## EdgeHub reported properties

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    lastDesiredVersion
  :::column-end:::
  :::column:::
    This integer refers to the last version of the desired properties processed by the IoT Edge hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    lastDesiredStatus.code
  :::column-end:::
  :::column:::
    The status code referring to last desired properties seen by the IoT Edge hub. Allowed values: 200 Success, 400 Invalid configuration, 500 Failed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    lastDesiredStatus.description
  :::column-end:::
  :::column:::
    Text description of the status.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    clients.\{device or moduleId\}.status
  :::column-end:::
  :::column:::
    The connectivity status of this device or module. Possible values \{"connected" \| "disconnected"\}. Only module identities can be in disconnected state. Downstream devices connecting to IoT Edge hub appear only when connected.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    clients.\{device or moduleId\}.lastConnectTime
  :::column-end:::
  :::column:::
    Last time the device or module connected.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    clients.\{device or moduleId\}.lastDisconnectTime
  :::column-end:::
  :::column:::
    Last time the device or module disconnected.
  :::column-end:::
:::row-end:::
