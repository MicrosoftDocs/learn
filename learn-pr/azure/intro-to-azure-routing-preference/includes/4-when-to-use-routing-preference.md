When considering the use of routing preference in Azure, you should first analyze your scenario. As the network engineer in charge of the traffic cost savings project, you've learned what routing preference is and how it works. You suspect that changing the routing preference of the public IP address of the application in the Central US region might alleviate some of the cost of data transfer between the car factory in Singapore and the application in Azure.

Here, well discuss how you can decide whether changing the routing preference of the application is Azure fulfills the goal of the traffic cost savings project. We'll list some criteria that indicates whether routing preference will meet your cost savings goal.

* Cost savings

* Performance

## Decision criteria

Routing preference helps alleviate network traffic costs in your subscription. The routing preference of "Internet" will minimize traffic on the Microsoft network by routing traffic to services hosted in Azure across the public Internet. Adjusting the routing preference to "Internet" might not be necessary for small organizations with a limited number of global locations or if network cost isn't an issue. Performance of network transfer must also be considered. The routing of traffic across the public Internet might perform slower than the "Microsoft" network option. Here's a discussion of each of these factors.

|     |     |
| --- | --- |
| **Criteria** | **Analysis**|
| **Cost savings** | Will changing the routing preference to "Internet" result in network traffic cost savings? </br> Ingress and egress traffic with "Internet" routing preference is cheaper than the routing preference of "Microsoft network". |
| **Performance** | Does performance of the network traffic a concern? Traffic routed over the public Internet has performance comparable to other cloud providers. The optimal performance will always be with the default routing preference of "Microsoft network". |




<!-- 4. Apply-the-criteria introduction --------------------------------------------------------------------------------

    Goal: Lead-in to the example applications of the criteria.

    Pattern:
        1 paragraph consisting of 3 sentences
            Sentence 1: summarizing the criteria from a positive view ("when to use").
            Sentence 2: Acknowledge that there are cases for which (product) won't work and/or there are edge cases that are difficult to decide.
            Sentence 3: transition/lead-in to the detailed discussion.

    Heading: "## Apply the criteria"

    Example:
        "Apply the criteria"
         "Logic Apps works best when you're integrating multiple services with some added control logic. The decision is often a judgment call though. Let's think about how to apply these criteria to our example processes."
-->
## Apply the criteria
TODO: add your 3 lead-in sentences

<!-- 5. Apply the criteria examples -----------------------------------------------------------------------------

    Goal: Apply the criteria to the 2-3 customer tasks in the scenario described in your introduction unit.

    Pattern:
        For each customer task, repeat this pattern:
            1. "### Should (scenario subtask) use (product)?".
            2. 1-3 paragraphs of discussion/analysis (first sentence should answer yes/no about whether the product is suitable).
            3. Visual like an image, table, list, code sample, or blockquote.

    Example:
        H3: "Should the video-archive utility use Logic Apps?"
        Prose: "The video archive task is a good fit for Logic Apps even though it doesn't integrate multiple systems. Logic Apps has a built-in timer trigger and an Azure blob connector that are perfect to implement this process...."
        Visual: (image preferred)
-->
