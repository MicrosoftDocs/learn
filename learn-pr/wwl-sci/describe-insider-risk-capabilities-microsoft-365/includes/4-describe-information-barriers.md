
> [!NOTE]
> Microsoft 365 compliance is now called Microsoft Purview and the solutions within the compliance area have been rebranded. Microsoft 365 Information Barriers is now Microsoft Purview Information Barriers. For more information about Microsoft Purview, see the [blog announcement](https://www.microsoft.com/security/blog/2022/04/19/the-future-of-compliance-and-data-governance-is-here-introducing-microsoft-purview/)

Microsoft 365 provides organizations with powerful communication and collaboration capabilities. However, an organization might want to restrict communications between some groups to avoid a conflict of interest from occurring in the organization, or to restrict communications between certain people to safeguard internal information. With information barriers, the organization can restrict communications among specific groups of users.

Microsoft Purview Information Barriers is supported in Microsoft Teams, SharePoint Online, and OneDrive for Business.

Information barriers are policies that admins can configure to prevent individuals or groups from communicating with each other. When information barrier policies are in place, people who shouldn't communicate with other specific users can't find, select, chat, or call those users. With information barriers, checks are in place to prevent unauthorized communication.

> [!NOTE]
> It's important to note that information barriers *only support two-way restrictions*.  One-way restrictions, such as marketing, can communicate with day traders but day traders who can't communicate with marketing are *not supported*.

Here are some examples of how information barriers can be applied:

- **Education**: Students in one school can't look up contact details for students of other schools.
- **Legal**: Maintaining confidentiality of data obtained by the lawyer of one client from being accessed by a lawyer for the same firm representing a different client.
- **Professional services**: A group of people in a company is only able to chat with a client or specific customer via federation or guest access during a customer engagement.

## Information barriers in Microsoft Teams

In Microsoft Teams, information barrier policies determine and prevent the following kinds of unauthorized communications:

- Searching for a user
- Adding a member to a team
- Starting a chat session with someone
- Starting a group chat
- Inviting someone to join a meeting
- Sharing a screen
- Placing a call
- Sharing a file with another user
- Access to file through sharing link

If the people involved are included in an information barrier policy to prevent the activity, they can't continue. Potentially, everyone included in an information barrier policy can be blocked from communicating with others in Microsoft Teams. When people affected by information barrier policies are part of the same team or group chat, they might be removed from those chat sessions and further communication with the group might not be allowed.

To learn more about the user experience with information barriers, see [information barriers in Microsoft Teams](/MicrosoftTeams/information-barriers-in-teams).
