Here, let's discuss how Azure Communication Services works behind the scenes. You'll learn about the pieces of Azure Communication Services and how they work together to solve your communication problems. 

We'll be covering:

* Azure Resources
* Azure Communication Services SDKs for Client-based tasks
* Azure Communication Services SDKs for Server-based tasks

## Azure resources

The first element is making Azure Communication Services work is an Azure resource, which you can create in the Azure portal. Once you create a resource in the Azure portal, it becomes the central hub for managing many Azure Communication Services tasks and administration.

The Azure resource within the portal is where you can:

* Manage and view the billing charges for your Azure Communication Services usage.
* Purchase and manage phone numbers.
* Manage security keys.
* Create event handlers for Azure Communication Services events.

With a properly configured resource in the Azure portal, you and your team can continue building and creating Azure Communication Services solutions for your customers.

## Server SDKs

With an Azure resource setup, another component is some form of server-side management. You can create this with server focused SDKs.

To perform server-side programming, you download these SDKs and write small amounts of code that interact with Azure Communication Services. There are a few features and parts of Azure Communication Services that needs this:

* For voice/video calling and chat, you need to link an Azure Communication Services identity to your application's identity systems so that when your users make calls or chat with each other, you can link them back to your application's identity platform
* For event handling of incoming calls or Short Messaging Service (SMS) messages
* For processing chat messages
* For receiving and routing incoming calls

Not all parts of Azure Communications Services will need it, but it's good to be aware of so you know what to expect.

Azure Communication Services has Server SDKs available for:

* JavaScript
* .NET
* Java Server Edition (SE)
* Python

You can find a link to all of the SDKs in the *References* section at the end of this module.

## Client SDKs

The last component of how Azure Communication Services works is also the most important, because it provides the gateway for your customers to use Azure Communication Services products.

Client SDKs are downloaded and then integrated into your existing applications and products. When a customer makes a video call or talks using chat, it's the Client SDKs that connect you to the call and receive/transmit the audio and video.

Azure Communication Services has Client SDKs available for:

* JavaScript
* .NET (C#)
* iOS (Swift)
* Android

You can find a link to all of the SDKs in the *References* section at the end of this module.

## Tying it all together

With the Azure resource, server, and client parts of Azure Communication Services working together, you have everything you need to piece together a communication solution for your product or service.
