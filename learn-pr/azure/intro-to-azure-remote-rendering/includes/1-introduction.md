<!--
Editors: The use of visual and viewing is acceptable IMO as a non sighted person cannot use this technology. We're also using a tool which is specifically designed to enable a visual through a device which is designed for a sighted person. Global across all units. 

-->
Standalone computing devices (sometimes referred to as untethered devices) have limited compute processing power. This limitation can affect your ability to render complex visual models. One possible solution is to reduce the required complexity. However, this also reduces visual fidelity. For many applications, reducing the visual fidelity is not acceptable because high detail is required. 

Remote Rendering enables you to address this dilemma. You can use cloud-based processing to render complex models to the desired visual fidelity without compromise. Azure Remote Rendering is a Mixed Reality Azure service that enables you to render high quality, interactive 3D content in Azure. You can then stream this rendered content to devices, such as HoloLens 2, in real time.

<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly orient the learner to the subject area covered in this module
    
    Heading: do not add an H1 or H2 title here, the auto-generated H1 will appear above this content automatically
    
    Example: "Implementing a business process can be challenging because you typically need to make diverse services work together. Think about everything your company uses to store and process data: Salesforce, Microsoft 365, Oracle, Twitter, YouTube, Dropbox, Google services, Azure Cognitive Services, and so on. How do you integrate all these products? Azure Logic Apps gives you pre-built components to connect to hundreds of services. You use a graphical design tool to put the pieces together in any combination you need and Logic Apps will run your process automatically in the cloud."
    
    Recommended: visual like an image (preferred), table, list, etc. that supports the topic sentence(s)

-->

## Example scenario

Let's suppose you work for an automotive manufacturer. You have a very complex 3D model that you need to be able to view in HoloLens. You've learned that the computing resource available in your local device is insufficient to render the model to the desired detail quickly enough. You must either scale down the detail, or increase the available compute resources. By using Azure Remote Rendering, you can render the model to the desired detail level for display on your device.

:::image type="content" source="../media/arr-engine.png" alt-text="A graphic depicting an internal combustion engine. The engine internal detail is exposed.":::

<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: Describe the real-world scenario this module will use to illustrate the concepts. Your scenario should have 2-3 customer tasks that together represent the most-common use cases for the product.
    
    Heading: use the H2 "Example scenario"
    
    Example: "Suppose you work at an athletic shoe company that is launching a new product. You sell the shoes on your website, manage your cloud-hosted advertising videos, and monitor social media to gauge reactions to the launch. The following illustration shows these processes. Notice how the tasks include both customer-facing processes like direct sales and administrative tasks like auto-archiving old videos. Here, you'll see how Logic Apps automates these types of business processes."
    
    Recommended: an image that visualizes the scenario

-->

## What will we be doing?

By the end of this module, you'll be able to:

- Describe how Azure Remote Rendering can render images, encode them, and stream them to target devices. 
- Evaluate whether Azure Remote Rendering, a cloud-hosted service, can help you complete complex rendering workloads.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do in this content. This differs from the title and the learning objectives. The title and the learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.
    
    Heading: use the H2 "What will we be doing?"
    
    Example: "We’ll analyze the capabilities of Logic Apps to help you decide when to use them:
                * **Launch**: what conditions can you set to launch your app?
                * **Connect**: which services can you connect to?
                * **Branch**: what types of business logic can you add to your app?"

 -->

## What is the main goal?

The main goal is to determine how Azure Remote Rendering can help you render and live stream complex models to the desired visual fidelity without compromise.

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: The title of an "Introduction to..." tells our customers that this is a good place to start their learning. This helps our customers find the right content quickly. The trade-off is that the title does not reflect the terminal learning objective of the module. The "goal" section of the introduction is your chance to provide the terminal learning objective. Write a statement that is outcome-focused so it describes the main skill the learner will acquire as a result of this training. In other words, it should answer the question: "what is the key thing the learner will be able to do as a result of consuming this training?"
    
    Heading: use the H2 "What is the main goal?"
    
    Example: "By the end of this session, you'll be able to decide whether Logic Apps is a good choice to automate your business processes."

-->

