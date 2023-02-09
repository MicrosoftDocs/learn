Let's start with an overview of Azure Communication Services.

## What's Azure Communication Services?

Azure Communication Services is a platform of products and services that enable you to create custom communication applications and solutions. Microsoft has taken the same technologies that power Skype and Microsoft Teams and made it available to developers as an Azure product, allowing easy integration with other Microsoft developer services for additional functionality. Examples of this additional functionality are:

- Using Azure Event Grid to process SMS, Chat and Calling events through Event Grid endpoints such as Azure Functions and Webhooks to enhance functionality through things like automatic responses, bots, call routing, and more.
- Sending Diagnostic information on call quality, usage, and so on to Azure Monitor Log Analytics.
- Using Teams Interoperability to bring Azure Communication Services calls into your Microsoft Teams environment.
- Using Azure Logic Apps to process SMS messages for SMS Automation.

By combining Azure Communication Services with other Azure offerings, you'll be able to launch communication solutions in no time and without the pain of managing infrastructure or dealing with maintenance.

## Azure Communication Services' main features

Azure Communication Services' features are:

- **Identity**: Create and manage Azure Communication Services identities.
- **Voice and video calling**: Create custom voice- and video-calling solutions.
- **Chat**: Enable text-based conversations between users.
- **Telephony**: Acquire telephone numbers and use them within your communication applications to provide calls and other services to real phone numbers.
- **SMS**: Send receive and manage text messages.

Azure Communication Services does have additional features, but these are the main ones on which we'll be focusing for this module. For other features, you can find a link at the end of this module.

## How to solve our scenario?

Azure Communication Services can solve our household appliance company's problem through integrating chat, video, and voice calling into their existing applications.

By integrating Azure Communication Services into their existing business, they can enable communication features to solve their problems:

- **Voice and video calling**: Host customer voice and video calls to diagnose appliance issues and provide support to their customers.
- **Chat**: Add live chat to their website providing instant help, support, and sales to users looking at their products.
- **Telephony**: Manage and automate incoming calls to the company's phone network, thus providing a better quality service.
- **SMS**: Deliver and manage appointment reminders for call-outs to customers.

## Overview of key feature areas

To help you understand how you might use Azure Communication Services within your project, let's review Azure Communication Services features in more detail. The key feature information should also provide an idea of which areas you may need and which are safe to ignore. It's not required to use every single feature area; you can pick and choose.

### Identity features

To use many of Azure Communication Services' other core features, you need to create and manage Azure Communication Services Identities. Azure Communication Services identities are separate from your existing application's identity platform, but you can link identities from that platform to Azure Communication Services. Once created, these identities uniquely identify an Azure Communication Services user within other features in Azure Communication Services, such as Calling, Chat, and so on. They're used to provide a consistent identity within these experiences so that each instance of an application or experience knows who is who.

### Calling features

Calling provides easy to use voice and video calling so that you can get your users talking to each other and you. Both one-to-one calling and group-calls are possible.

On top of this there are several additional features that may also be useful to you.

- **Call recording**: Record calls for later playback. This is useful to provide a record of a meeting or call for those who weren't there or to examine the call for quality for training scenarios.
- **Call automation**: Automate calls using services to provide automated messages, appointment reminders, phone menus, and more.
- **Microsoft Teams interoperability**: Allow external users to join and participate in Microsoft Teams calls and meetings. This connects external customers to your Microsoft Teams-based operations.
- **Screen sharing**: Allow participants to share their screen to display documents, presentations, and other items.
- **Custom video streams**: Allow participants to share a remote video stream, which allows you to send custom video items from devices and programs.

You can read more about our calling features in the [Azure Communication Services documentation](/azure/communication-services/), which covers them in more detail.

:::image type="content" source="../media/calling.png" alt-text="Screenshot of an example Azure Communication Services calling application.":::

### Chat features

Chat provides one-to-one and group chat threads and messages that allow users to chat to each other. With chat comes a number of other features including:

- **Message history**: Access the full chat history of a thread.
- **Automation**: Receive events from a chat thread to process them using custom business logic, such as updating a Customer Relationship System(CRM).
- **Notifications**: Receive push notifications of new messages or events within a chat thread on a mobile device.
- **Emojis and Metadata**: Add emojis and Metadata to your chat messages.

You can read more about chat features in the [Azure Communication Services documentation](/azure/communication-services/), which covers them in more detail. Check out the Reference section at the end of the module for more information.

:::image type="content" source="../media/chat.jpg" alt-text="Screenshot of an example Azure Communication Services pop-up chat.":::

### Telephony features

Telephony provides calling over the Publicly Switched Telephone Network (PSTN). This allows you to reach, speak to, and manage calling and messaging operations over regular telephone networks rather than digital ones. In addition to these basic features, Telephony includes:

- **Phone number management**: Buy and manage real-world phone numbers to use with your telephony systems. This includes toll-free numbers.
- **Direct routing**: Route Azure Communication Services numbers and calls to your on premises telephony systems.

You can read more about telephony features in the [Azure Communication Services documentation](/azure/communication-services/), which covers them in more detail. Check out the Reference section at the end of the module for more information.

### SMS features

Short Messaging Service (SMS) features let you interact with regular SMS messaging, including:

- **Send SMS**: Send text messages to Phone numbers.
- **Receive SMS**: Receive text messages and process them through Event Grid.
- **Delivery Reports**: Monitor who receives and reads your text messages.
- **Bulk messaging**: Send large marketing or notification messages.
- **Shortcodes**: Use abbreviated phone numbers for marketing and services.

You can read more about SMS features in the [Azure Communication Services documentation](/azure/communication-services/), which covers them in more detail. Check out the Reference section at the end of the module for more information.

:::image type="content" source="../media/sms.png" alt-text="Marketing image of an example Azure Communication Services SMS.":::
