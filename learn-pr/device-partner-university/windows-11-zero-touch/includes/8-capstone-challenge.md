At this point in the scenario, the rollout is largely complete—but real deployments are rarely perfect. This capstone challenge applies what you've learned to diagnose a problem.

A user reports that their new Windows 11 Pro device is usable, but something isn't right. The device enrolled successfully and the user can sign in, but required applications never appeared. Update status is unclear, and the device isn't marked as compliant.

In practice, issues like this often have more than one contributing factor. A device might be correctly enrolled but assigned to the wrong group, or policies may be correctly scoped but not yet evaluated.

The goal of this challenge is not to find a single correct answer, but to demonstrate a structured approach to diagnosis—one that allows IT to confidently determine when a device is ready to return to the user, reducing resolution time and improving support efficiency.

## Getting started

Real deployment issues rarely have a single cause. Before jumping to conclusions, work through a structured diagnostic sequence. Use the following three-phase framework to guide your investigation.

### Phase 1 — Confirm enrollment integrity

Before checking anything else, verify that the device completed enrollment correctly and landed in the right place.

| **Check** | **What to look for** | **What it tells you** |
| :---: | :---: | :---: |
| Enrollment status | Device appears in management portal, associated with the correct user | Confirms the provisioning flow completed |
| Group membership | Device is in the correct assignment group | Determines which policies and apps should apply |
| Last check-in time | Device has contacted management recently | Indicates whether the device is actively syncing |

**If the device is missing from the portal or assigned to the wrong group, stop here.** Downstream issues with apps, policies, and compliance are likely symptoms of this root cause.

### Phase 2 — Verify policy and application state

Once enrollment integrity is confirmed, check whether configuration and applications have been delivered.

| **Check** | **What to look for** | **What it tells you** |
| :---: | :---: | :---: |
| Configuration profiles | Profiles show as assigned and applied, with no errors | Settings are actively governing device behavior |
| Application assignments | Required apps show as installed, not pending or failed | Users have the tools they need from day one |
| Sync errors | No policy conflicts or assignment errors reported | Management is operating without interference |

**If profiles or apps show as pending or having errors, check whether the device has had enough time to sync.** Some states resolve after the next check-in cycle. If errors persist, examine assignment scope and group targeting.

### Phase 3 — Validate compliance and update status

With enrollment and policy confirmed, verify that the device meets organizational standards and is receiving updates.

| **Check** | **What to look for** | **What it tells you** |
| :---: | :---: | :---: |
| Compliance status | Device is marked compliant, not unknown or non-compliant | Baseline security controls are applied and evaluated |
| Update health | Quality updates received, no failed installations | Device is protected and current |
| Security controls | Encryption, threat protection, and sign-in policies are active | Security baseline has been enforced through policy |

**Compliance status of "Unknown" is a signal, not a verdict.** It often means the device hasn't completed its first compliance evaluation cycle, not that it has failed. Check whether a compliance policy is assigned and whether the device has checked in since enrollment.

### Apply the framework

With this structure in mind, return to the scenario. A user's device enrolled successfully, but required applications never appeared, update status is unclear, and the device is not marked as compliant.

Work through each phase in order. For each check, identify:

- **Where** you would look in your management platform
- **What signal** would confirm the issue is resolved
- **What action** you would take if the check fails

The challenge is complete when you can describe a clear path from the reported symptom to a confirmed, fully managed, compliant device—without requiring physical access to the hardware.
