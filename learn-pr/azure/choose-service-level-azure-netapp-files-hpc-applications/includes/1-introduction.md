<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: orient the learner to the area covered in this module

    Heading: do not add an H1 or H2 title here, the auto-generated H1 will appear above this content automatically

    Example: "Azure Logic Apps let you automate your business processes and run them in the cloud."

    Recommended: visual like an image, table, list, etc. that supports the topic sentence(s)

    [Introduction unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-module-introduction-format)
-->

# Introduction

Azure NetApp Files is widely used as the underlying shared file-storage service in various scenarios, including High Performance Compute (HPC) infrastructure. Azure NetApp Files supports three service levels: Ultra, Premium, and Standard, which are differentiated by allowed maximum throughput. 

<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: describe the real-world scenario this module will use to illustrate the concepts

    Heading: use the H2 "Example scenario"

    Example: "Suppose you work at an athletic shoe company on the marketing team. You're launching a new basketball shoe created by a celebrity athlete. Previous launches resulted in a social media frenzy as people shared stories and photos of themselves wearing their new shoes. The marketing team wants to monitor hundreds of social media sites, blogs, and websites to determine consumer reaction. There will be more data than you can process manually. You would like a cloud-hosted system that automates monitoring, text analytics, database storage, and email notifications."

    Recommended: an image that visualizes the scenario, use the image markdown extension (https://review.docs.microsoft.com/help/contribute/markdown-reference?branch=master#images)

    Optional: a "scenario video" that visualizes the scenario

    [Scenario guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-scenarios)
    [Scenario video guidance](TBD)
 -->

## Scenario

Suppose you are a member of a semiconductor company, tasked with designing their IC Chips which needs a lot of EDA (Electronic Design Automation) simulation. You do not have sufficient capacity on premises for this project and so will be using Azure for those HPC simulation needs. Management would like this project to be completed in a timely and cost-effective manner. You choose Azure NetApp Files as the back-end storage solution as it provides an on-premises-like experience and performance. You will need to figure out the most optimal and cost-effective way of building and running your HPC applications in Azure.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do in this content. This differs from the title and the learning objectives. The title and the learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: use the H2 "What will we be doing?"

    Example: "Here, you'll create a business workflow using Azure Logic Apps to automate the processing of tweets:
                * **Launch**: when a new tweet is available
                * **Process**: determine if the sentiment of the tweet is positive or negative
                * **Route**: branch based on the sentiment score"

 -->

## What will we be doing?

In this module, you will examine the decision criteria that determines Azure NetApp Files performance. Then you will map your throughput or IOPS requirements to choose the best cost-effectiveness service level.

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: This is a restatement of the module title into a complete sentence. You have more room here to convey the main goal than in a space-limited title. Make it outcome-focused so it describes the main skill the learner will acquire as a result of this training. In other words, it should answer the question: "what is the key thing the learner will be able to do as a result of consuming this training?"

    Heading: use the H2 "What is the main goal?"

    Example: "By the end of this session, you'll be able to create workflows which route and process data using Azure Logic Apps and its built-in connectors."

 -->

## Learning objectives

By the end of this module, you will be able to: 

- Describe the factors that determine throughput limits of Azure NetApp Files volume.
- Choose the best Service Level of Azure NetApp Files for HPC applications.

## Prerequisites

- Learner should understand the concepts of storage hierarchy of Azure NetApp Files, including NetApp accounts, Capacity Pool and Volumes.
- Ability to set up Azure NetApp Files and create a Volume.

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->