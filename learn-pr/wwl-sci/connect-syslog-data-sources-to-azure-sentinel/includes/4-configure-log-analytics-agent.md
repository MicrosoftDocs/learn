The Data Collection Rule (DCR) only collects events with the facilities and severities that are specified in its Data sources configurations. For Syslog, you can modify the `Facility Minimum log level` and `Destination` in the **Add data source** page.

To configure the Syslog `Facility log level`and `Destination`:

1. Access the Data collection rule Data sources **Add data source** page:

    - Select **Configuration**, **Data sources**

    - Select **Linux Syslog**.

1. Select the **Minimum log level** drop-down menu to make changes for each `Facility`.

    :::image type="content" source="../media/04-linux-syslog-facilities-log-level.png" alt-text="Screenshot of Linux Syslog facilities selections and minimum log levels.":::

1. When completed select **Save**

    >[!NOTE]
    >The default is "LOG_DEBUG" for each Facility, and changes are automatically pushed to all configured resources.
