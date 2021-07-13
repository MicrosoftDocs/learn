The security operations team has informed us that we need to conform to the company policy of only allowing authorized services to communicate on production devices.  This team watches everything that happens on the company network and could potentially block our access to the network if we do not adhere to their policies.

[![Operations.](../media/ops.png)](../media/ops.png#lightbox)

To meet this requirement, we can employ firewall settings that explicitly authorize pre-determined ports for data transmission then block everything else.  This strategy will ensure that our IoT Edge Gateway is locked down and running only the services that we have granted permission to.  

In this unit, you'll configure the Network Security Group (NSG) that secures access to the Azure IoT Edge Gateway from the Internet. The necessary ports for MQTT, AMQP, and HTTPS communications need to be opened so the downstream IoT device(s) can communicate with the gateway.

## Open IoT Edge Gateway device ports for communication with downstream devices

For the Azure IoT Edge Gateway to function, at least one of the IoT Edge hub's supported protocols must be open for inbound traffic from downstream devices. The supported protocols are MQTT, AMQP, and HTTPS.

The IoT communication protocols supported by Azure IoT Edge have the following port mappings:

| Protocol  | Port Number  |
|---|---|
| MQTT |  8883 |
| AMQP  |  5671 |
| HTTPS <br> MQTT + WS <br> AMQP + WS | 443


The IoT communication protocol chosen for your devices will need to have the corresponding port opened for the firewall that secures the IoT Edge Gateway device. In this unit, an Azure Network Security Group (NSG) is used to secure the IoT Edge Gateway, so Inbound security rules for the NSG will be opened on these ports.

In a production scenario, you will only want to open the minimum number of ports for your devices to communicate. If you are using MQTT, then only open port 8883 for inbound communications. Opening additional ports will introduce addition security attack vectors that attackers could take exploit. It is a security best practice to only open the minimum number of ports necessary for your solution.

1. If necessary, log in to your Azure portal using your Azure account credentials.

    If you've got more than one Azure account, ensure that you're signed in with the account for the subscription you intend to use for this course

1. Navigate to the Resource Group that contains the Azure IoT Edge Gateway Virtual Machine.

1. On the Resource Group blade, click on the Network Security Group (NSG) resource.

1. On the Network security group blade, click on **Inbound security rules** under the Settings section.

1. On the **Inbound security rules** pane, click the **Add** button.

1. On the **Add inbound security rule** pane, change the **Destination port ranges** to `8883` then set the **Name** to `MQTT`. This entry will define an inbound security rule that will allow communication for the MQTT protocol to the IoT Edge Gateway.

1. Click **Add** to save the new security rule.

1. To open ports for **AMQP** and **HTTPS** communication protocols, add two more rules with the following values:

    | Destination port ranges | Name |
    |------|------|
    | 5671 | AMQP |
    | 443 | HTTPS |

1. With these three ports open on the Network Security Group (NSG), the downstream devices will be able to connect to the IoT Edge Gateway using either MQTT, AMQP, or HTTPS protocols.

Congratulations, that's the end of the unit! In the next unit, we will create a downstream device identity in IoT Hub.