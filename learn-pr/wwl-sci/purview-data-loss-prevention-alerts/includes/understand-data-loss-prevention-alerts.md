Data loss prevention (DLP) alerts fire when someone's action matches a condition in a DLP policy. To investigate one effectively, you need to know what triggered it, where it shows up, and which tool to open first. Staying on top of alerts is how you spot risky activity early, respond before small issues escalate, and figure out which policies need tuning.

## What is a DLP alert?

DLP alerts are notifications that get triggered when someone's actions match a condition in a DLP policy. These actions can involve sharing sensitive information like credit card numbers, Social Security numbers, or financial records in ways that could put data at risk.

Some alerts are triggered by a single event, like someone emailing a document containing sensitive data to a personal account. Other alerts are triggered when multiple small events add up over time. For example, sending several emails with one credit card number each within a day could trigger an alert, even if no single email violated the policy on its own.

Alerts don't automatically mean something malicious happened. They just tell you that something met the criteria to be flagged. Your job is to figure out whether the alert is something that needs action or something that indicates a policy needs to be fine-tuned.

## Where do DLP alerts show up?

DLP alerts appear in two tools. Both show the same alerts, but they serve different purposes:

- **Microsoft Defender XDR** is used for security investigations. It consolidates incidents so you can see everything related to a potential threat in one place. If DLP alerts are part of a bigger security issue, like someone exfiltrating data while also turning off antivirus settings, Defender XDR is where you correlate those signals.
  
- **Microsoft Purview** is used for compliance. It focuses more on the policy itself: what triggered the alert, what rules were involved, and whether those rules are working as expected. If the alert came from a false positive, Purview is where you'd go to adjust the policy so it doesn't happen again.

## How alerts help during investigations

Let's say you have a DLP policy that blocks sharing credit card numbers through email. An alert comes in showing that someone in the finance department triggered this policy. You open the alert in Microsoft Purview and see it was caused by a monthly report being emailed to an external contractor. After reviewing the file, you realize it included masked credit card numbers, not real ones. This might be a false positive, so you decide to adjust the policy to ignore numbers formatted like that.

But at the same time, you check Defender XDR. You notice that the same user also downloaded many files from SharePoint earlier that morning, and there's a second alert showing they tried to upload a file to a personal Dropbox account. That gives you a more complete picture. Maybe this wasn't a false positive after all. Now you know to follow up.
