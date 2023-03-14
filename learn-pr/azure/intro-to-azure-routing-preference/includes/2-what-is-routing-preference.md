
As the lead Network Engineer for the traffic cost savings project for the Singapore factory, your first step is to understand what routing preference is and it's core features. This overview should help you decide if routing preference in Azure is a good fit for the factory cost savings project.

Routing preference in Azure gives you the ability to determine the path of your traffic between Azure and the Internet. You have the option to route your traffic through either the Microsoft network or the public internet (ISP network). These options are known as "cold potato routing" and "hot potato routing" respectively. The cost of egress data transfer will vary based on your routing choice. You can select your routing preference (Microsoft network or Internet) when creating a public IP address. Public IP addresses are associated with resources such as virtual machines, virtual machine scale sets, and internet-facing load balancers. You can also set the routing preference for Azure storage resources such as blobs, files, web, and Azure DataLake. By default, all Azure services will have their traffic routed through the Microsoft global network.

The Routing Preference Unmetered service is available for Content Delivery Network (CDN) providers who have their customers' origin content hosted on Azure. This service enables CDN providers to establish a direct peering connection with Microsoft's global network edge routers at various locations.

## Routing Preference - Microsoft network

By default, all traffic Azure service traffic is routed through the Microsoft global network. By routing your traffic through the Microsoft global network, you are utilizing one of the largest networks in the world, which spans over 160,000 miles of fiber and has over 165 edge Point of Presence (POP) locations. The network is equipped with multiple redundant fiber paths to guarantee exceptional reliability and availability. The traffic engineering is managed by a software-defined WAN controller, which ensures that your traffic takes the lowest latency path and provides premium network performance. Ingress and egress traffic stays on the Microsoft global network whenever possible.

### Incoming (Ingress) traffic

The incoming data path uses **_cold potato routing_**. Cold potato routing means that traffic enters the Microsoft network that is closest to the user initiating the connection.

For example, if a user in Singapore accesses Azure resources hosted in the Central US region the traffic would enter the Edge POP closest to Singapore. The traffic would then travel across the Microsoft backbone network to the service hosted in the Central US region.

### Outgoing (Egress) traffic

The outgoing traffic follows the same principle as the incoming traffic. Traffic traverses the Microsoft network and exits closest to the user's location.

For example, if traffic from the Central US region is destined to user in Singapore, the traffic travels the Microsoft network and exits the Edge POP closest to Singapore.




## What is (concept)?
TODO: Add your lead sentence
TODO: Add your additional text
TODO: Add your visual element

<!-- 3. Define the product -------------------------------------------------------------

    Goal:
        Give a formal and precise definition of the product.

    Heading:
        "## (product) definition"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "(product) is..." (ensure this is a definition, do not give use cases like "(product) lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "Azure Logic Apps definition"
        Lead sentence: "Azure Logic Apps is a cloud service that automates the execution of your business processes."
-->
## (product) definition
TODO: Add your lead sentence
TODO: Add your additional text
TODO: Add your visual element

<!-- 4. Solve the scenario -------------------------------------------------------------

    Goal:
        At a high level, describe how the (product) solves one of the customer tasks in your (scenario).
        Avoid teaching how to actually do the work (you're not teaching how-to-use in this module).

    Heading:
        "## How to (solve scenario)"

    Pattern:
        1. H2 heading.
        2. Lead sentence that summarizes how the (product) solved the (scenario).
        3. Additional text as needed (typically 1-2 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "How to implement a Twitter monitor"
        Lead sentence: "To implement a Twitter monitor, you map each task to a Logic Apps component and connect them with conditional logic."
-->
## How to (solve scenario)
TODO: Add your lead sentence
TODO: Add your additional text
TODO: Add your visual element

<!-- 5. Additional content (optional, as needed) ------------------------------------------------

    Goal:
        The section is a catch-all for any information not covered in the sections above.
        Repeat the pattern here as many times as needed.

    Possible topics:
        - Key feature(s).
        - Example use case in addition to the scenario.
        - High-level of how practitioners use the product (e.g. there's an API and a web UI to support multiple use cases).
        - Business value (e.g. it lets you do something that would be difficult to achieve without (product)).

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote (image preferred).

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list, code sample, blockquote)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->