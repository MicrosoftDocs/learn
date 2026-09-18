**Secure Score recommendation:** Restrict meeting presenters.

Teams meeting presenters can share content and use meeting controls that ordinary attendees don't need. Making every participant a presenter increases accidental disclosure, disruption, and misuse.

## Apply a restrictive default

Set **Who can present** to **Only organizers and co-organizers**. This keeps ordinary participants in the attendee role until the organizer promotes a trusted person.

Review related controls:

- Participants can give or request control.
- External participants can give or request control.
- Screen sharing mode.
- Content from camera.
- Collaborative annotations.
- Whiteboard.

Disable features that aren't required by the meeting scenario. Remote control deserves special scrutiny because it permits input on another participant's device.

## Configure the portal

To apply a restrictive default using the portal, performing the following steps:

1. In the Microsoft Teams admin center, select **Meetings** > **Meeting policies**.
1. Open the policy assigned to the target organizers.
1. Under **Content sharing**, set **Who can present** to **Only organizers and co-organizers**.
1. Review participant control settings.
1. Save the policy.
1. Review every custom policy.

## Configure PowerShell

To apply a restrictive default using PowerShell, performing the following steps:

Record the current value:

```powershell
$originalPresenterMode = (
    Get-CsTeamsMeetingPolicy -Identity $teamsPolicy
).DesignatedPresenterRoleMode

$originalPresenterMode
```

Apply the restrictive organizer-controlled default:

```powershell
Set-CsTeamsMeetingPolicy `
    -Identity $teamsPolicy `
    -DesignatedPresenterRoleMode OrganizerOnlyUserOverride
```

Verify with the following command:

```powershell
Get-CsTeamsMeetingPolicy -Identity $teamsPolicy |
    Select-Object Identity, DesignatedPresenterRoleMode
```

`OrganizerOnlyUserOverride` sets the restrictive default while permitting organizer override. Use a supported template or sensitivity label when the value must be enforced.

## Validate the meeting experience

To test the policy:

1. Create a new meeting with an organizer assigned the policy.
1. Join as an internal participant.
1. Join as a guest.
1. Confirm both enter as attendees.
1. Confirm they can't present before promotion.
1. Promote one trusted participant.
1. Confirm that participant can present.
1. Demote the participant.
1. Confirm presenter privileges are removed.

Test remote control separately. Presenter restriction doesn't prove that every content-sharing control is secure.

## Operate exceptions

Some meetings need multiple presenters. Let organizers promote named participants when the policy allows override. For recurring business scenarios, use a dedicated meeting policy or template rather than weakening the tenant default.
