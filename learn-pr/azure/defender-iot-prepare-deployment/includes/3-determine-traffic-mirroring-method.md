<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
In the previous unit you determined the devices and subnets in your automotive manufacturing site to monitor. Now you'll determine the traffic mirroring methods to use for your site.

## Traffic Mirroring

Traffic mirroring allows you to mirror network traffic to a system that allows you to monitor and diagnose problems. Defender for IoT monitors traffic to your OT network sensor. You should configure traffic mirroring on a switch or a terminal access point (TAP) that includes only industrial ICS and SCADA traffic to ensure that Defender for IoT only analyzes the traffic you want to monitor. 

### Mirroring port scope

Configure traffic mirroring from all of your switch's ports, whether or not data is connected to them to prevent rogue devices from connecting undetected to an unmonitored port. For OT networks that use broadcast or multicast messaging, configure traffic mirroring only for RX (*Receive*) transmissions to prevent unneccessary bandwidth use.

## Traffic mirroring methods

You will need to determine what method to use based on your network configuration. Defender for IoT supports the following traffic mirroring methods:

|Method  |Description  |
|---------|---------|
|**Switch SPAN port**     |  Mirrors local traffic from interfaces on the switch to a different interface on the same switch. |  
|**Remote SPAN (RSPAN) port**     |  Mirrors traffic from multiple, distributed source ports into a dedicated remote virtual local area network (VLAN). The VLAN data is then delivered through trunked ports, across multiple switches to a specified switch that contains the physical destination port. |
|**Active or passive aggregation (TAP)**    |   Installs an active / passive aggregation TAP inline to your network cable, which duplicates traffic to the OT network sensor. The TAP hardware device allows network traffic to flow between ports without interruption and without compromising network integrity. Best method for forensic monitoring.|
|**Encapsulated remote switched port analyzer (ERSPAN)**     | Mirrors input interfaces to your OT sensor's monitoring interface. |
|**ESXi vSwitch**   |  Mirrors traffic using *Promiscuous mode* on an ESXi vSwitch. |
|**Hyper-V vSwitch**    |   Mirrors traffic using *Promiscuous mode* on a Hyper-V vSwitch.  |

Traffic mirroring methods: What and where are all the switch port types used in your organization and what connector media do you need? How should you deal with unmanaged switches? Is there rack space for a collector? Do you use broadcast or multicast messaging? Which traffic mirroring method best fits your switch port types? Choose a traffic mirroring method for each OT sensor, such as a SPAN port or TAP.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
TODO: add your scenario sub-task

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
TODO: write your prose table-of-contents

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
TODO: add a visual element

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## Traffic Monitoring

Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->