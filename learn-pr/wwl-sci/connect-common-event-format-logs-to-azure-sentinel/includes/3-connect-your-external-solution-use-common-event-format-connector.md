You need to designate and configure a Linux machine to forward the logs from your security solution to your Microsoft Sentinel workspace. This machine can be physical or virtual in your on-premises environment, an Azure VM, or a VM in another cloud. Using the link provided, you'll run a script on the designated machine that performs the following tasks:

Installs the Log Analytics agent for Linux (also known as the OMS agent) and configures it for the following purposes:

- Listening for CEF messages from the built-in Linux Syslog daemon on TCP port 25226

- Sending the messages securely over TLS to your Microsoft Sentinel workspace, where they're parsed and enriched

Configures the built-in Linux Syslog daemon (rsyslog.d/syslog-ng) for the following purposes:

- Listening for Syslog messages from your security solutions on TCP port 514

- Forwarding only the messages it identifies as CEF to the Log Analytics agent on localhost using TCP port 25226

## Run the deployment script

To view the connector page:

1. Select Data connectors page.

1. Select Common Event Format (CEF).

1. select the Open connector page on the preview pane.

1. Verify that you have the appropriate permissions as described under Prerequisites.

1. Copy the "sudo wget …"  command and run with elevated permissions on the dedicated Linux VM.

:::image type="content" source="../media/common-event-format-connector.png" alt-text="Screenshot of the C E F Connector Page." lightbox="../media/common-event-format-connector.png":::

### Using the same machine to forward both plain Syslog and common event format messages

If you plan to use this log forwarder machine to forward Syslog messages as CEF, then to avoid the duplication of events to the Syslog and CommonSecurityLog tables:

On each source machine that sends logs to the forwarder in CEF format, you must edit the Syslog configuration file to remove the facilities used to send CEF messages.

