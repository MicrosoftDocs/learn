In Microsoft Teams, data loss prevention (DLP) policies protect chats and file sharing by blocking the unauthorized sharing of sensitive information.

## Use the default DLP policy as a template

- First-time users of Purview get a default [DLP policy for Teams](/purview/dlp-teams-default-policy#what-does-the-default-policy-do) to simplify onboarding. Change the sensitive information types and users is a great way to get this process started.

- See the [DLP policy scoping table for Microsoft Teams entities](/purview/dlp-microsoft-teams#scope-of-dlp-protection) to understand how protection applies in different scenarios. When a DLP policy is scoped to Microsoft 365 groups, protection applies to group members using the standard and shared channels associated with those groups. It also applies to all 1:1 and group chats for those members. The only exception is when optical character recognition (OCR) is configured for Teams chat and channel messages.

## Protect chat and channel messages

- If someone tries to share sensitive information with external users in a Teams chat or channel, and a DLP policy is in place, the messages are automatically deleted. Deletion happens within seconds, based on your policy settings.

- DLP for Microsoft Teams blocks sensitive content when shared with Microsoft Teams users who have:

  1. **[Guest access](/MicrosoftTeams/guest-access)** in teams and channels, or

  1. **[External access](/microsoftteams/trusted-organizations-external-meetings-chat?tabs=organization-settings)** in meetings and chat sessions.

- DLP for external chat sessions will only work if both the sender and the receiver are in Teams Only mode and using **[Microsoft Teams native federation](/microsoftteams/trusted-organizations-external-meetings-chat?tabs=organization-settings)**. DLP for Teams doesn't block messages in **[interop](/microsoftteams/teams-and-skypeforbusiness-coexistence-and-interoperability#interoperability-of-teams-and-skype-for-business)** with Skype or non-native federated chat sessions.

- People from different Microsoft 365 organizations who are all using the external access feature can all join the same chat session. Each user is subject to the DLP policies of their own organization. For instance, say that UserA, UserB and UserC, all from Contoso, and UserX, UserY, and UserZ, all from Fabrikam, are in the same Teams chat. Contoso's DLP policies for sharing information in Teams apply to UserA, UserB and UserC, while Fabrikam's DLP policies apply to UserX, UserY, and UserZ.

## Protect shared documents

- If a document containing sensitive information is shared with guests in a Microsoft Teams channel or chat, and a DLP policy is set to prevent this, the document won't be accessible to those users. For protection to apply, the DLP policy must include both SharePoint and OneDrive.
