If you've managed service principals or app registrations, you've seen these problems before: a secret that nobody remembers creating, a Contributor role assigned at a scope nobody can justify, an identity with no listed owner. These problems are common across all workload identities, not just AI workloads.

What changes with AI workloads is how hard these mistakes are to fix and how much damage they cause while they persist. AI workloads operate continuously, authenticate without interactive sign-in controls, and act at machine speed. A misconfigured user identity is limited by the human's working hours and session timeouts. A misconfigured AI workload identity runs 24 hours a day with whatever access it was granted.

## Why set up decisions persist after production

Once an AI workload is running in production, every identity choice becomes the baseline that teams are reluctant to change:

- Switching a credential type requires coordinated updates to the workload, the app registration, and whatever automation deploys the workload.
- Narrowing permissions risks breaking the workload if someone removes access the workload actually uses.
- Assigning an owner requires finding someone who understands what the identity does and is willing to accept accountability for it.

Each change requires deliberate intervention that competes with other priorities. Setup decisions made in five minutes during initial configuration persist for the life of the workload.

## Why these risks don't surface on their own

A workload with a stored secret, broad permissions, no owner, and no validation functions identically to one that's set up correctly. Sign-in succeeds. API calls return data. Nothing in the workload's behavior signals that the identity configuration is wrong.

These configuration gaps surface only during incident response or an access review. At that point, someone needs a clear record of what was granted, why, and whether it's still justified. But the setup decisions have been in production for months, the person who made them might have moved on, and the documentation that would explain the reasoning was never created.

## How set up decisions compound each other

A weak credential is worse when permissions are broad. Broad permissions are worse when no one owns the identity. Missing ownership is worse when there's no validation to catch the gaps. The risk isn't any single decision. It's the combination, and the combination is what this module addresses one decision at a time.
