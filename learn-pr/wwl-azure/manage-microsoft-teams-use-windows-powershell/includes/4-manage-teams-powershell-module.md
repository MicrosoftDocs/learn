Microsoft Teams is a collaboration tool. Within a Microsoft Team, you can create multiple channels to organize data and apps. When there are multiple channels, you can restrict access to channels based on the user. You can use the Microsoft Teams PowerShell module to create, configure, and manage teams, user settings, and channels.

## Creating teams

To create a new team, you use the **New-Team** cmdlet as depicted in the following example:

```powershell
New-Team -DisplayName "Marketing Team"
```

When you create a new team by using PowerShell, you can't specify a template unless you're an education customer. When you create a team from within the Microsoft Teams client, you can specify a template or copy an existing team. You have the same options when creating a team by using Graph API. To get a list of available templates, use the **Get-CsTeamTemplateList** cmdlet. You can also create your own templates.

> [!NOTE]
> You can convert an existing Microsoft 365 group to a team by using the *-GroupId* parameter when creating a new team.

If you don't specify an owner when you create a team, then by default you become the owner of the team. If your administrative user doesn't have a Microsoft Teams license, you need to specify an owner with a Microsoft Teams license. Otherwise, the team creation fails.

## Configuring teams

When you create a new team, a new Microsoft 365 group is created as part of the team. When you manage an existing team, you need to refer to the Microsoft 365 group ID as the unique identifier for the team. The group ID displays when you create the group. You can also obtain the group ID by using the **Get-Team** cmdlet.

You can modify team settings by using the **Set-Team** cmdlet. Some parameters that you can use are listed in the following table.

*Table 1: Parameters for modifying team settings*

| Parameter                    | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| -Description               | Provides a description of the team (1,024 characters or less) to make it easier for users to identify the team's purpose. |
| -MailNickName              | Specifies the alias for the associated Microsoft 365 group that's used when creating the **PrimarySmtpAddress**. |
| -Visibility                | Determines whether the team is public or private. Public teams are noticeable to everyone in the team gallery, and anyone can join without team owner approval. Whereas private teams can only be joined if the team owner adds someone to them. |
| -AllowAddRemoveApps        | Determines whether or not members (and not just owners) are allowed to add apps to the team. |
| -AllowCreateUpdateChannels | Determines whether or not members (and not just owners) are allowed to create channels. |
| -AllowUserEditMessages     | Determines whether or not users can edit messages that they've posted. |

You can also use these same parameters when you create the team. The following example depicts how to specify the mail nickname:

```powershell
Set-Team -GroupId 26be526d-201a-4af6-9918-2fdbf6306916 -MailNickName "MarketingTeam"
```

## Managing team members

After you create a team, you can manage team members by using the **Add-TeamUser** and **Remove-TeamUser** cmdlets. You can add users as members or owners. When you use these cmdlets, you need to specify the **GroupId** associated with the team as in the following example:

```powershell
Add-TeamUser -GroupId 26be526d-201a-4af6-9918-2fdbf6306916 -User AbbieP@adatum.com -Role Member
```

## Creating and configuring team channels

A team can have multiple channels that contain content. The following table depicts some of the cmdlets that you can use to create and manage channels.

*Table 2: Cmdlets for creating and managing channels*

| Cmdlet                   | Description                                             |
| ------------------------ | ------------------------------------------------------- |
| **New-TeamChannel**        | Creates a new channel in a team.                        |
| **Get-TeamChannel**        | Lists the channels in a set.                            |
| **Set-TeamChannel**        | Modifies the display name or description for a channel. |
| **Add-TeamChannelUser**    | Adds a user as a member or owner of a channel.          |
| **Remove-TeamChannelUser** | Removes a user from a channel.                          |

> [!NOTE]
> At the time of writing this learning path, the **Add-TeamChannelUser** and **Remove-TeamChannelUser** cmdlets are available only in the preview release of the Microsoft Teams module.
