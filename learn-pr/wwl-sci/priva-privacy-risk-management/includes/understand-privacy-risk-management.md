Personal data in your Microsoft 365 environment is constantly being created, saved, and shared across Exchange, SharePoint, OneDrive, and Teams. Two of those movements are what Privacy Risk Management is built to catch:

- **Overexposure**: content sits in a location where too many people can open it. A SharePoint site opened to Everyone, a OneDrive file shared with an Anyone-with-the-link URL, or an old permissions setting that never gets reviewed.
- **Transfers**: personal data moves across a boundary you care about. Outside the organization, between geographic regions, or between departments that shouldn't share it.

Privacy Risk Management detects those events and acts on them without watching every user every day.

## From risk to observable event

A **policy** is what tells Privacy Risk Management where to look and what counts as a risk. You configure a policy with four inputs: the personal data you care about, the sources to search, the users in scope, and the conditions that count as risky.

When a policy finds content that fits its conditions, that content is a **match**. Matches feed two channels:

- **Alerts** go to admins. The policy combines matches into alerts using frequency, threshold, and severity settings. Admins see meaningful risk instead of every individual match.
- **Notifications** reach users in the moment, so they can course-correct before an admin needs to get involved.

For Data transfer policies, the notification is a Teams tip. It appears when a user's action would create a match, with a link to your privacy training so the user can rethink the action on their own. Selecting **Ignore and send** captures a business justification and generates a second alert to admins, so the override is on the record even when the user proceeds.

Admins triage interesting alerts into **issues**, which are structured investigations that group related matches, hold notes and collaborators, and track the fix. From an issue, admins take **remediation actions** on the content itself: Notify owner, Make private, Apply a sensitivity or retention label, or Mark as not a match when it's a false positive.

**Reports** close the loop. They show what personal data lives in your environment, how much overexposure and transfer activity your policies are catching, and where the trends are moving. That visibility lets you tune policies instead of leaving them at their initial configuration.

## The lifecycle you're managing

Once policies are running, the work settles into a repeating cycle:

1. Define the personal data you care about and where it lives.
1. Create policies that turn that definition into detection.
1. Run policies in test mode to see what they'd catch without generating alerts.
1. Activate policies, triage alerts into issues, and remediate content.
1. Read reports, adjust conditions and thresholds, and repeat.

For the healthcare team from the scenario, this cycle applies directly. They start with the classifications and locations where patient data and employee records live. They build policies to catch overexposed medical histories and unauthorized cross-region transfers. They test before turning on policies, then use reports to confirm the policies keep pace with how the organization handles data.

## Who does what

Different lifecycle stages call for different access. An analyst triaging overexposed medical records doesn't necessarily need to see the record itself, while a viewer watching report trends doesn't need to touch policies at all. Priva uses role-based access control to keep those distinctions in place, and ships five role groups for Privacy Risk Management:

| Role group | What members can do | Fits when |
| --- | --- | --- |
| Privacy Management | All Privacy Risk Management work: settings, policies, investigations, remediation, and reports. | The same small team handles the full lifecycle. |
| Privacy Management Administrators | Configure settings, create and edit policies, and view cases. | Someone owns setup and policy tuning while investigation happens on a separate team. |
| Privacy Management Analysts | Investigate policy matches, view file metadata, and take remediation actions. Can't open content items. | Reviewers need to act on matches without seeing the underlying data, for example triaging overexposed medical records they aren't cleared to read. |
| Privacy Management Investigators | Investigate policy matches, view file content, and take remediation actions. | Investigating a match requires seeing the content itself. |
| Privacy Management Viewer | View reports, insights, and policy trends. No policy changes, no investigations. | Auditors and stakeholders need visibility into trends without operational access. |

Assign the least-privileged role that fits the work. Global Administrator covers all these tasks too, but Microsoft recommends keeping that role for emergency scenarios.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
