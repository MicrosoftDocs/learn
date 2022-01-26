<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'describe' learning objective.

    Pattern:
        One paragraph of 2-3 sentences:
            Sentence 1: State that this unit addresses ("how it works").
            Sentence 2: State that this unit targets this learning objective: "Describe how (features) of (product) work to (solve problem)."
            Sentence 3-4 (optional): Give the rationale ("helps you decide if it will meet your needs").
        Table-of-contents as a bulleted list (do not simply list every heading you'll have on the page, group them into about 3 high-level areas).

    Heading: none

    Example: "Here, we'll discuss how Logic Apps works behind the scenes. You'll learn about all the pieces of Logic apps and see how they fit together into an app. This knowledge will help you decide whether Logic Apps will work for you without any customization. In cases where you do need to create custom components, you'll be able to determine how difficult it will be.
        * Connectors, triggers, actions
        * Control actions
        * Logic Apps Designer"
-->
Here we'll discuss how Azure Communication Services works behind the scenes. You'll learn about the pieces of Azure Communication Services and how they work together to solve your communication problems. 

We'll be covering:

* Azure Resources
* Azure Communication Services SDKs for Client-based tasks
* Azure Communication Services SDKs for Server-based tasks


<!-- 2. Chunked content-------------------------------------------------------------------------------------

    Goal:
        Cover the components of (product) and how they work.
        Repeat this pattern multiple times as needed.

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->
## Azure Resources

The first element is making Azure Communication Services work is an Azure resource which is created within the Azure Portal. Once an Azure Communication Services resource is created from the Azure portal it becomes the central hub for managing many Azure Communication Services tasks and administration.

The Azure resource within the portal is where you can:

* Manage and view the billing charges for your Azure Communication Services usage.
* Purchase and manage Phone Numbers.
* Manage security keys.
* Create event handlers for Azure Communication Services events.

With a properly configured resource within the Azure portal you and your team can continue building and creating Azure Communication Services solutions for your customers.

## Server SDKs

With an Azure resource setup, another component of your Azure Communication Services solution is some form of server side management for your communication needs, this is created with our Server Focused SDKs.

Server side programming is performed by downloading these SDKs and writing small amounts of code which interact with Azure Communication Services. There's a couple of features/parts of Azure Communication Services that needs this:

* For Voice/Video Calling and Chat it is needed to link an Azure Communication Services identity to your Applications identity systems. This linkage is needed so that when your users make calls, or chat with each other you can link them back to your application's identity platform.
* For event handling of incoming calls or SMS messages

Not all parts of Azure Communications Services will need it, but its good to be aware of so you know what to expect.

We have Server SDKs available for:

* JavaScript
* .NET
* Java SE
* Python

## Client SDKs

The last component of how Azure Communication Services works is also the most important as it provides the gateway for your customers to use Azure Communication Services products.

Our Client SDKs are downloaded and then integrated into your existing applications and products. When a user makes a video call or talks using Azure Communication Services' Chat it's the Client SDKs that are doing the heavy lifting for you.

We have Client SDKs available for:

* JavaScript
* .NET
* iOS(Swift)
* Android

## Tieing it all together

With the Resource, Server and Client parts of Azure Communication Services working together you have everything you need to piece together a communication solution for your product or service with Azure Communication Services.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->