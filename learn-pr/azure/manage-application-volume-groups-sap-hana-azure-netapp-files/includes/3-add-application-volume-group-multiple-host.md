Building a multiple-host SAP HANA database always starts with creating a volume group for the first host. To begin, you must create the first host in an SAP HANA multiple-host setup. After that, you can add additional HANA hosts by following the steps in this unit.

### SAP HANA tab for adding a volume group

In the **SAP HANA** tab for adding a volume group, specify the following information:

- **SAP ID (SID)**: The three alphanumeric-character SAP HANA system identifier.
- **Group name**: The volume group name. For a multiple-host SAP HANA system, each host creates its own group. The group name uses the format `SAP-HANA-SID-{HostId}`, where `{HostId}` is replaced with the numeric host ID for each host you add. If `{HostId}` isn't specified, it is appended to the end of both the group name and description.
- **SAP node memory**: This value defines the size of the SAP HANA database on the host and is used to calculate the required volume size and throughput.
- **Capacity overhead (%)**: When you use snapshots for data protection, you need to plan for extra capacity. This field adds a size (%) for the data volume. You can estimate this value by using "change rate per day" × "number of days retention."
- **Multiple-host**: Select this option to add more hosts to a multiple-host HANA system.
- **First host ID**: Specify the number of the first host you want to add. This value is typically `2` if you're adding hosts for the first time.
- **Host count**: Specify the number of hosts you want to add to the multiple-host setup.

:::image type="content" source="../media/application-volume-group-multiple-host-creation-form.png" alt-text="Screenshot of the Create a volume group wizard SAP HANA tab showing multiple-host configuration options." border="true" lightbox="../media/application-volume-group-multiple-host-creation-form.png":::

You'll perform the complete steps in the Exercise unit of this module.
