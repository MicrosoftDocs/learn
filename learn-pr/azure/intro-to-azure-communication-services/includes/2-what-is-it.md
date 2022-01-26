Let's start with an overview of Azure Communication Services(ACS).

TODO: add your topic sentences(s)

## What is Azure Communication Services?

ACS is a suite of services and products that enable you to create custom communication applications and solutions. These solutions are powered by the same technology that powers Skype and Microsoft Teams whilst also being within the Azure ecosystem allowing easy integration with several other Azure products to create communication solutions easily.

By combining its key products with other Azure offerings you'll be able to launch communication solutions in no time at all and without the pain of managing infrastructure of dealing with complicated setup or handling.

ACS main product areas are:

- Identity - Create and manage identities that can be linked to your non-ACS identity management platform and identify users within other features.
- Voice and Video Calling - Create custom voice and video calling solutions.
- Chat - Easily spin up chat threads between users.
- Telephony - Acquire telephone numbers and use them withing your communication applications to provide calls and other services to real phone numbers.
- SMS - Send receive and manage text messages.

ACS does have other product areas but the ones listed above are the main or larger items and features which this module will cover.

## How to solve our scenario?

ACS can solve our household appliance company's problem through integrating chat, video and voice calling into their existing applications.

By integrating ACSs into their existing applications they can enable communication features to solve their problems:

- Voice and Video Calling - Host customer voice and video calls to diagnose appliance issues and provide support to their customers
- Chat - Add live chat to their website providing instant help,support and sales to users looking at their products
- Telephony - Manage and automate incoming calls to the company's phone network providing a better quality service

TODO: Add your visual element

## Overview of key feature areas

Now we'll provide a more detailed overview of some of ACS's features so that you can understand how you might be able to use ACS within your project.

### Identity features

To use many of ACS' other core features, you need to create and manage ACS Identities. ACS identities are separate from your existing application's identity platform but can link identities from that platform to ACS. Once created these identities uniquely identify an ACS user within other features in ACS such as Calling, Chat etc.

TODO: Add visual diagram of ACS Identity

### Calling features

Calling at its core provides easy to use Voice and Video calling so that you can get your users talking to each other in no time but on top of this there are several additional features that may also be useful to you.

- Call recording - Record calls for later playback. Useful to provide a record of a meeting or call for those who were not there or to examine the call for quality or training scenarios.
- Call automation - Automate calls using services to provide automated messages, appointment reminders, phone menus etc.
- Teams interoperability - Allow external users to join and participate in Microsoft Teams calls and meetings.
- Screen sharing - Allow participants to share their screen to display documents, presentations and other items.
- Custom video streams - Allow participants to share a remove video stream.

### Chat features

At its core, Chat provides 1-1 and group chat threads and messages that allow users to chat to each other within Chat "Threads". With chat comes a number of other features including:

- Message History - Access the full chat history of a thread.
- Automation - Receive events from a Chat thread to process them using custom business logic such as updating a CRM.
- Notifications - Receive push notifications of new messages or events within a Chat Thread.
- Emojis and Metadata - Add emojis and Metadata to your chat messages.

### Telephony features

Telephony provides Calling(via PSTN). This allows you to reach, speak to and manage calling and messaging operations over regular telephone networks rather than digital ones such as offered by Calling. In addition to these basic features Telephony includes:

- Phone number management - Buy and manage real world phone numbers to use with your telephony systems. This includes Toll Free numbers.
- Direct routing - Route ACS numbers and calls to your on premises telephony systems.

### SMS features

Our SMS(Text messaging) let you interact with regular SMS messaging including:

- Send SMS - Send SMS messages to Phone numbers.
- Receive SMS - Receive SMS messages and process them through Event Grid.
- Delivery Reports - monitor who receives your SMS messages.
- Bulk messaging - Send large marketing or notification messages.
- Shortcodes - Use abbreviated phone numbers for marketing and services
