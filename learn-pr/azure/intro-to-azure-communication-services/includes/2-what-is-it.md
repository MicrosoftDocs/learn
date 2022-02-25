Let's start with an overview of Azure Communication Services(ACS).

## What is Azure Communication Services?

ACS is a platform of products and services that enable you to create custom communication applications and solutions. Microsoft has taken the same technologies that power Skype and Microsoft Teams and made it available to developers as an Azure product and allowing easy integration with other Microsoft developer services for additional functionality. Examples of this additional functionality are:

- [Using Azure Event Grid to process SMS, Chat and Calling events](https://docs.microsoft.com/azure/event-grid/event-schema-communication-services) through Event Grid endpoints such as Azure Functions and Webhooks to enhance functionality through things like automatic responses, bots, call routing etc.
- [Sending Diagnostic information on call quality, usage etc to Azure Monitor Log Analytics](https://docs.microsoft.com/azure/communication-services/concepts/analytics/enable-logging).
- Using [Teams Interoperability](https://docs.microsoft.com/azure/communication-services/concepts/teams-interop) to bring ACS calls into your Microsoft Teams environment.
- Use [Azure Logic Apps](https://docs.microsoft.com/azure/communication-services/quickstarts/sms/logic-app) to process SMS messages for SMS Automation.

By combining ACS with other Azure offerings, you'll be able to launch communication solutions in no time and without the pain of managing infrastructure or dealing with maintenance.

## ACS' main product areas

ACS main product areas are:

- Identity - Create and manage ACS identities.
- Voice and video calling - Create custom voice and video calling solutions.
- Chat - Enable text-based conversations between users.
- Telephony - Acquire telephone numbers and use them within your communication applications to provide calls and other services to real phone numbers.
- SMS - Send receive and manage text messages.

We'll provide additional details on these main areas throughout this module. 

ACS does have [additional product areas](https://docs.microsoft.com/azure/communication-services/overview) but these are the main ones, which we will be focusing on for this module.

## How to solve our scenario?

ACS can solve our household appliance company's problem through integrating chat, video and voice calling into their existing applications.

By integrating ACSs into their existing business, they can enable communication features to solve their problems:

- Voice and video calling - Host customer voice and video calls to diagnose appliance issues and provide support to their customers.
- Chat - Add live chat to their website providing instant help, support, and sales to users looking at their products.
- Telephony - Manage and automate incoming calls to the company's phone network providing a better quality service.
- SMS - Deliver and manage appointment reminders for call outs to customers.

## Overview of key feature areas

To help you understand how you might use ACS within your project, let's review ACS features in more detail. The key feature information should also provide an idea of which areas you may need and which are safe to ignore. It is not required to use every single feature area, you can pick and choose.

### Identity features

To use many of ACS' other core features, you need to create and manage ACS Identities. ACS identities are separate from your existing application's identity platform but can link identities from that platform to ACS. Once created these identities uniquely identify an ACS user within other features in ACS such as Calling, Chat etc. They're used to provide a consistent identity withing these experiences such that each instance of an application or experience knows who is who.

### Calling features

Calling provides easy to use voice and video calling so that you can get your users talking to each other and you. Both one-to-one calling and group-calls are possible.

On top of this there are several additional features that may also be useful to you.

- Call recording - Record calls for later playback. Useful to provide a record of a meeting or call for those who weren't there or to examine the call for quality or training scenarios.
- Call automation - Automate calls using services to provide automated messages, appointment reminders, phone menus etc.
- Microsoft Teams interoperability - Allow external users to join and participate in Microsoft Teams calls and meetings. This connects external customers to your Microsoft Teams based operations.
- Screen sharing - Allow participants to share their screen to display documents, presentations and other items.
- Custom video streams - Allow participants to share a remote video stream which allows you to send custom video items from devices and programs.

You can read more about our calling features within our [documentation](https://docs.microsoft.com/azure/communication-services/concepts/voice-video-calling/calling-sdk-features) which covers them in more detail.

:::image type="content" source="../media/calling.png" alt-text="Example ACS calling application.":::

### Chat features

Chat provides one-to-one and group chat threads and messages that allow users to chat to each other. With chat comes a number of other features including:

- Message history - Access the full chat history of a thread.
- Automation - Receive events from a chat thread to process them using custom business logic such as updating a Customer Relationship System(CRM).
- Notifications - Receive push notifications of new messages or events within a chat thread on a mobile device.
- Emojis and Metadata - Add emojis and Metadata to your chat messages.

You can read more about our chat features within our [documentation](https://docs.microsoft.com/azure/communication-services/concepts/chat/sdk-features) which covers them in more detail.

:::image type="content" source="../media/chat.jpg" alt-text="Example ACS pop-up chat.":::

### Telephony features

Telephony provides calling over the Publicly Switched Telephone Network(PSTN). This allows you to reach, speak to and manage calling and messaging operations over regular telephone networks rather than digital ones. In addition to these basic features Telephony includes:

- Phone number management - Buy and manage real-world phone numbers to use with your telephony systems. This includes Toll Free numbers.
- Direct routing - Route ACS numbers and calls to your on premises telephony systems.

You can read more about our telephony features within our [documentation](https://docs.microsoft.com/azure/communication-services/concepts/telephony/telephony-concept) which covers them in more detail.

### SMS features

Our Short Messaging Service(SMS) features let you interact with regular SMS messaging including:

- Send SMS - Send text messages to Phone numbers.
- Receive SMS - Receive text messages and process them through Event Grid.
- Delivery Reports - monitor who receives and reads your text messages.
- Bulk messaging - Send large marketing or notification messages.
- Shortcodes - Use abbreviated phone numbers for marketing and services.

You can read more about our SMS features within our [documentation](https://docs.microsoft.com/azure/communication-services/concepts/telephony/telephony-concept) which covers them in more detail.

:::image type="content" source="../media/sms.png" alt-text="Example ACS SMS.":::
