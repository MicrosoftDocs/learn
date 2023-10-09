

When the Configuration Manager client installs on a device and successfully assigns it to a site, you see the device in the **Assets and Compliance** workspace in the **Devices** node. Once in here, the device is likely to join one or more collections from which to be actively managed from.

#### What is a Collection?

Collections are a way for Configuration Manager to represent devices or users that have some degree of commonality. This can be derived from a query, such as OS Type, exclusively placed together, or the same application present. Once in a collection, you can perform several tasks, such as target a deployment or run a report.

When a device is either in a collection or selected directly from the devices pane, there are many management actions that you can access from the right click context menu. Some options can be selected on a per collection basis or the individual object. Below outlines some of the more common options you can review.

| Client Action           | Description                                                                                              |
| ----------------------- | -------------------------------------------------------------------------------------------------------- |
| Start Resource Explorer | Review inventory information about a device, such as OS information, memory, and applications installed. |
| Start Policy Retrieval  | Execute some of the previous client actions locally, direct from the site server.                        |
| Add to a collection     | Add the client directly to a collection, such as an installation collection from the object itself.      |
| Client Settings RSOP    | Review current client setting for a given endpoint. |
