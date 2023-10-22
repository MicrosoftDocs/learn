<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
Your network diagram allows you to determine the devices and subnets to monitor based on your overall monitoring goals for your automotive manufacturing organization. 
Using the diagram you can determine:

- What network segments should you monitor (subnets/VLANs)?
- Where should you connect?
- 
- What devices are there and how do they communicate? 
- What are the security and operational risks and the most interesting traffic for those risks?
- 
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

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## H2 Purdue Model
The Purdue Reference Model for Industrial Control System (ICS)/OT network segmentation divides a network into different OT and IT and layers. They include:

|Name|Description|
|---------|---------|
|**Level 0**: </br>Cell and area| The wide variety of sensors, actuators, and devices involved in the basic manufacturing process. These devices perform the basic functions of the industrial automation and control system, like driving a motor or key functions like welding and bending.|
|**Level 1:** </br>Process control| Embedded controllers that communicate with Level 0 devices and control and manipulate the manufacturing process. In discrete manufacturing, those devices are programmable logic controllers (PLCs) or remote telemetry units (RTUs). In process manufacturing, the basic controller is called a distributed control system (DCS).|
| **Level 2:** </br>Supervisory|The systems and functions connected to the runtime supervision and operation of an area of a production facility which communicate with the Level 1 controllers and sometimes with the site or enterprise (Level 4 and 5). These can include human-machine interfaces (HMIs), alerting systems, and control room workstations, among other systems.|
| **Levels 3 and 3.5:** </br>Site-level and industrial perimeter network| Manages the site-wide industrial automation and control functions like production scheduling, site level operations management, file server, and Active Directory. These systems communicate with the production zone and share data with Level 4 and 5 systems and applications. Levels through level 3 are considered critical to site operations.|
| **Levels 4 and 5:** </br>Business and enterprise networks|The site or enterprise network where the centralized IT systems and functions exist. They are managed by the IT organization directly at these levels.|

### Network Diagram

You can see the division between OT and IT in the following sample diagram:

:::image type="content" source="../media/2-purdue-only.png" alt-text="Purdue model diagram" border="false":::


<!-- Pattern for complex chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)


Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->