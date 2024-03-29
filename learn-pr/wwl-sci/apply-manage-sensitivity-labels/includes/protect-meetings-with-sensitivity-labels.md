As our global consultancy firm moves forward with our AI-powered service launch, securing sensitive virtual meetings becomes crucial. These meetings, involving financial discussions and strategic plans, are important for our worldwide team and diverse client base. Sensitivity labels in Microsoft Purview help us in this security effort, ensuring that our virtual discussions via Outlook and Teams are accessible only to authorized participants.

Consider, for example, a key strategy meeting to finalize our service offerings. The organizer uses a _Highly Confidential_ sensitivity label to the Teams invite. This action encrypts the invite and applies strict access controls like preventing forwarding and restricting chats. This careful application of sensitivity labels shows our firm's commitment to protecting sensitive information, allowing secure, global collaboration.

This unit guides you on how to:

- **Ensure secure communication**: Demonstrate how to use sensitivity labels through Outlook or Teams to control meeting access and enforce encryption.
- **Protect meeting integrity**: Apply sensitivity labels to maintain data protection standards across meeting settings.
- **Uphold compliance**: Explain the role of sensitivity label visibility during meetings in ensuring compliance with security protocols.

Configuring and applying these labels in the Microsoft Purview compliance portal improves our meeting security and shows our dedication to data protection and client trust.

## Prepare for secure meetings with sensitivity label settings

To improve our meeting security, it's important to know how sensitivity labels affect certain settings. These settings help keep our discussions safe and private. Here are the settings sensitivity labels can adjust for better security:

- Who can bypass the lobby
- Who can present
- Who can record
- Encryption for meeting video and audio
- Option to automatically record
- Video watermark for screen sharing and camera streams
- Chat content copying restrictions

The sensitivity label doesn't extend to related meeting items, such as recordings, transcripts, whiteboard, and tasks.

Sensitivity labels can be applied to meeting invites in Outlook and Teams across [supported versions](/purview/sensitivity-labels-meetings#requirements) on Windows, macOS, iOS, and Android. This feature allows for the application, modification, and viewing of labels, with encrypted invites accessible similarly to encrypted emails for incompatible clients. Teams supports these actions directly within its platform.

Here's an example showing a Teams meeting invite that has the label **Highly confidential**, and the label applies encryption settings that prevent the invite from being forwarded:

:::image type="content" source="../media/example-protected-teams-invite.png" alt-text="Screenshot showing a labeled Teams meeting invite that prevents the invite from being forwarded." lightbox="../media/example-protected-teams-invite.png":::

Keep in mind there are limitations when using sensitivity labels for meetings, such as encryption restrictions, mailbox and calendar requirements, and specific behaviors for shared calendars. For more information these limitations, see the [Limitations](/purview/sensitivity-labels-meetings#limitations) section of **Use sensitivity labels to protect calendar items, Teams meetings, and chat**.

## Configure a sensitivity label to protect calendar items, Teams meetings, and chat

1. Navigate to the Microsoft Purview compliance portal and create or edit a sensitivity label. Select **Items** along with **Files**, **Emails**, and **Meetings** for full protection.

   All three options are needed from the Items scope and can't be selected individually because of their interdependency. A meeting consists of a calendar event, the invitation and responses, related attachments, related emails, and the actual Teams meeting. As a result, all these items need the same sensitivity label applied to protect the meeting.

1. On the **Choose protection settings for labeled items** page, select protection settings for encryption, content marking, and Teams meeting/chat protection.
1. On the next few pages, configure the desired settings, for encryption, content marking, and Teams settings according to your organization's needs.
1. Complete the label configuration and then create or configure other sensitivity labels if you need different settings for other labels.

Make sure the label is published to meeting organizers and participants.

Label policy settings for calendar items, Teams meetings, and chat include applying default labels to new and updated calendar events in Outlook and new events in Teams. Existing unlabeled meetings in Teams aren't automatically relabeled. Policies can also require users to label their meetings and events. These settings function independently from email label policies, meaning choices for emails don't affect meetings or events.

## Configure and apply a label for channel meetings

To apply a sensitivity label to a Teams channel, start by making sure the label is associated with a container label for the channel. This approach ensures all channel meetings and chats inherit your label settings, preventing any user changes. You do this by editing a label previously configured for groups and sites. You can then select a sensitivity label configured to protect calendar items, Teams meetings, and chat.

:::image type="content" source="../media/sensitivity-label-default-channel-meeting.png" alt-text="Screenshot of the option to configure a default sensitivity label to protect channel meetings and chat." lightbox="../media/sensitivity-label-default-channel-meeting.png":::

## Help protect calender events, meetings, and chats with Microsoft Purview Information Protection interactive guide

Use the **Help protect calender events, meetings, and chats with Microsoft Purview Information Protection interactive guide** interactive guide for a walkthrough on configuring and applying sensitivity labels for meetings and calendar events.

[:::image type="content" source="../media/interactive-guide-protect-meetings-calendar-purview.png" alt-text="Cover illustration for an interactive guide that says Help protect calender events, meetings, and chats with Microsoft Purview Information Protection interactive guide." border="false":::](https://mslearn.cloudguides.com/guides/Help%20protect%20calendar%20events,%20meetings,%20and%20chats%20with%20Microsoft%20Purview%20Information%20Protection?azure-portal=true)
