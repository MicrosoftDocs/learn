When you create a DLP policy using Microsoft Cloud App Security as a location in the Compliance Center, the matches will appear in the regular DLP reports.

When you create a file policy in MCAS the matched conditions and taken actions will instead be logged in MCAS.

For example, you created a file policy in MCAS to identify files including Tax Identification numbers which are shared with external users from OneDrive for Business or SharePoint Online and automatically move them into the trash folder and revoke external access. If you want to see any matches on this policy, open the Cloud app security portal and follow these steps:

1. Under Control, select **policies**.

1. Search for the policy you want to review.

1. Select **Open Matches** from the Count Column for the Policy you want to review.

1. You should see three tabs at the top of the page:

- Match now allows you to see currently existing matches for the file policy and use the filters at the top to refine the results.

- Quarantined allows you to see the files that have been quarantined because of a file policy governance action.

- History allows you to see former matches to the policy which have been resolved because of changes to the file or the policy itself.

Use this page to find patterns in your matches and decide if you need to take action. For example, you notice a high volume of matches, but they all originate from a single user. You should investigate the matches and identify if the user has a valid business reason to generate these matches.

