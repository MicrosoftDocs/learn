The Azure CLI commands can be used to accomplish many of the tasks associated with managing devices and the Azure IoT Hub service.

## The Azure CLI commands for IoT Hub

The Azure CLI commands for the IoT Hub service include commands that work directly on the hub, and commands that work on a subgroup of the hub.

### Hub commands

The following commands can be used to complete a task associated with an IoT Hub.

:::row:::
  :::column:::
    **IoT Hub Commands**
  :::column-end:::
  :::column:::
    **Command Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    create
  :::column-end:::
  :::column:::
    Create an Azure IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    delete
  :::column-end:::
  :::column:::
    Delete an IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    generate-sas-token
  :::column-end:::
  :::column:::
    Generate a SAS token for a target IoT Hub, device, or module.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    invoke-device-method
  :::column-end:::
  :::column:::
    Invoke a device method.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    invoke-module-method
  :::column-end:::
  :::column:::
    Invoke an IoT Edge module method.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    list
  :::column-end:::
  :::column:::
    List IoT Hubs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    list-skus
  :::column-end:::
  :::column:::
    List available pricing tiers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    manual-failover
  :::column-end:::
  :::column:::
    Initiate a manual failover for the IoT Hub to the geo-paired disaster recovery region.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    monitor-events
  :::column-end:::
  :::column:::
    Monitor device telemetry &amp; messages sent to an IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    monitor-feedback
  :::column-end:::
  :::column:::
    Monitor feedback sent by devices to acknowledge cloud-to-device (C2D) messages.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    query
  :::column-end:::
  :::column:::
    Query an IoT Hub using a powerful SQL-like language.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    show
  :::column-end:::
  :::column:::
    Get the details of an IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    show-connection-string
  :::column-end:::
  :::column:::
    Show the connection strings for an IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    show-quota-metrics
  :::column-end:::
  :::column:::
    Get the quota metrics for an IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    show-stats
  :::column-end:::
  :::column:::
    Get the statistics for an IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    update
  :::column-end:::
  :::column:::
    Update metadata for an IoT Hub.
  :::column-end:::
:::row-end:::


#### Command usage

For usage and help content for any command, append the `--help` parameter to the name of the command as follows:

```cmd
az iot hub <command name> --help

```

For example, to see the usage instruction for the `create` command, enter the following code:

```cmd
az iot hub create --help

```

When you run the previous command, you will see a message displayed that is similar to the following information:

```text
Command
    az iot hub create : Create an Azure IoT hub.
        For an introduction to Azure IoT Hub, see https://docs.microsoft.com/azure/iot-hub/.

Arguments
    --name -n                              [Required] : IoT Hub name.
    --resource-group -g                    [Required] : Name of resource group. You can configure
                                                        the default group using `az configure
                                                        --defaults group=<name>`.
    --c2d-max-delivery-count --cdd                    : The number of times the IoT hub will
                                                        attempt to deliver a cloud-to-device
                                                        message to a device, between 1 and 100.
                                                        Default: 10.
    --c2d-ttl --ct                                    : The amount of time a message is available
                                                        for the device to consume before it is
                                                        expired by IoT Hub, between 1 and 48 hours.
                                                        Default: 1.
    --fc --fileupload-storage-container-name          : The name of the root container where you
                                                        upload files. The container need not exist
                                                        but should be creatable using the
                                                        connectionString specified.
    --fcs --fileupload-storage-connectionstring        : The connection string for the Azure Storage
                                                        account to which files are uploaded.
    --fd --feedback-max-delivery-count                : The number of times the IoT hub attempts to
                                                        deliver a message on the feedback queue,
                                                        between 1 and 100.  Default: 10.
    --feedback-lock-duration --fld                    : The lock duration for the feedback queue,
                                                        between 5 and 300 seconds.  Default: 5.
    --feedback-ttl --ft                                : The period of time for which the IoT hub
                                                        will maintain the feedback for expiration
                                                        or delivery of cloud-to-device messages,
                                                        between 1 and 48 hours.  Default: 1.
    --fileupload-notification-max-delivery-count --fnd : The number of times the IoT hub will
                                                        attempt to deliver a file notification
                                                        message, between 1 and 100.  Default: 10.
    --fileupload-notification-ttl --fnt                : The amount of time a file upload
                                                        notification is available for the service
                                                        to consume before it is expired by IoT Hub,
                                                        between 1 and 48 hours.  Default: 1.
    --fileupload-notifications --fn                    : A boolean indicating whether to log
                                                        information about uploaded files to the
                                                        messages/servicebound/filenotifications IoT
                                                        Hub endpoint.  Allowed values: false, true.
    --fileupload-sas-ttl --fst                        : The amount of time a SAS URI generated by
                                                        IoT Hub is valid before it expires, between
                                                        1 and 24 hours.  Default: 1.
    --location -l                                      : Location of your IoT Hub. Default is the
                                                        location of target resource group.
    --partition-count                                  : The number of partitions of the backing
                                                        Event Hubs for device-to-cloud messages.
                                                        Default: 2.
    --rd --retention-day                              : Specifies how long this IoT hub will
                                                        maintain device-to-cloud events, between 1
                                                        and 7 days.  Default: 1.
    --sku                                              : Pricing tier for Azure IoT Hub. Default
                                                        value is F1, which is free. Only
                                                        one free IoT hub instance is allowed in
                                                        each subscription. Exception will be thrown
                                                        if free instances exceed one.  Allowed
                                                        values: B1, B2, B3, F1, S1, S2, S3.
                                                        Default: F1.
    --unit                                            : Units in your IoT Hub.  Default: 1.

Global Arguments
    --debug                                            : Increase logging verbosity to show all
                                                        debug logs.
    --help -h                                          : Show this help message and exit.
    --output -o                                        : Output format.  Allowed values: json,
                                                        jsonc, none, table, tsv, yaml.  Default:
                                                        json.
    --query                                            : JMESPath query string. See
                                                        http://jmespath.org/ for more information
                                                        and examples.
    --subscription                                    : Name or ID of subscription. You can
                                                        configure the default subscription using
                                                        `az account set -s NAME_OR_ID`.
    --verbose                                          : Increase logging verbosity. Use --debug for
                                                        full debug logs.

Examples
    Create an IoT Hub with the free pricing tier F1, in the region of the resource group.
        az iot hub create --resource-group MyResourceGroup --name MyIotHub


    Create an IoT Hub with the standard pricing tier S1 and 4 partitions, in the 'westus' region.
        az iot hub create --resource-group MyResourceGroup --name MyIotHub --sku S1 --location
        westus --partition-count 4

For more specific examples, use: az find "az iot hub create"

```

### IoT hub subgroups

The following IoT Hub subgroups can be used to complete tasks that are associated with the subgroup.

:::row:::
  :::column:::
    **IoT Hub Subgroups**
  :::column-end:::
  :::column:::
    **Subgroup Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    certificate
  :::column-end:::
  :::column:::
    Manage IoT Hub certificates.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    configuration
  :::column-end:::
  :::column:::
    Manage IoT device configurations at scale.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    consumer-group
  :::column-end:::
  :::column:::
    Manage the Event Hubs consumer groups of an IoT hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    device-identity
  :::column-end:::
  :::column:::
    Manage IoT devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    device-twin
  :::column-end:::
  :::column:::
    Manage IoT device twin configuration.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    devicestream
  :::column-end:::
  :::column:::
    Manage device streams of an IoT hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    distributed-tracing \[Preview\]
  :::column-end:::
  :::column:::
    Manage distributed settings per-device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    job
  :::column-end:::
  :::column:::
    Manage jobs in an IoT hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    message-enrichment
  :::column-end:::
  :::column:::
    Manage message enrichments for endpoints of an IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    module-identity
  :::column-end:::
  :::column:::
    Manage IoT device modules.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    module-twin
  :::column-end:::
  :::column:::
    Manage IoT device module twin configuration.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    policy
  :::column-end:::
  :::column:::
    Manage shared access policies of an IoT hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    route
  :::column-end:::
  :::column:::
    Manage routes of an IoT hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    routing-endpoint
  :::column-end:::
  :::column:::
    Manage custom endpoints of an IoT hub.
  :::column-end:::
:::row-end:::


The commands available by accessing each of these subgroup categories can be viewed by running a command that appends `--help` to the subgroup name as follows:

`az iot hub <subgroup name> --help`

For example, if you run the previous command for the `device-identity` subgroup, you will see a message displayed that is similar to the following information:

```
    az iot hub device-identity : Manage IoT devices.

Commands:
    add-children          : Add specified comma-separated list of non-edge device ids as children
                            of specified edge device.
    create                : Create a device in an IoT Hub.
    delete                : Delete an IoT Hub device.
    export                : Export all device identities from an IoT Hub to an Azure Storage blob
                            container.
    get-parent            : Get the parent device of the specified device.
    import                : Import device identities to an IoT Hub from a blob.
    list                  : List devices in an IoT Hub.
    list-children          : Print comma-separated list of assigned child devices.
    remove-children        : Remove non edge devices as children from specified edge device.
    set-parent            : Set the parent device of the specified non-edge device.
    show                  : Get the details of an IoT Hub device.
    show-connection-string : Show a given IoT Hub device connection string.
    update                : Update an IoT Hub device.

```
