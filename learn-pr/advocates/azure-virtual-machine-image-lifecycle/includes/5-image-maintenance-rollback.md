Each software update gives the team a new release decision. A scheduled build lets Contoso test a patched image without changing what the next class receives. If a test fails, the team needs to know whether to reject a candidate, restore the previous release, or repair VMs already in use.

Contoso has approved gallery version `1.0.1` for its 48 classroom VMs. To apply an Ubuntu security update, the team builds a **new image revision**, `1.0.2`. The application stays at `4.7.2` because the update changes Ubuntu, not `vmops-release`. The team doesn't modify `1.0.1` or point classroom deployments at `latest`.

## Schedule the update workflow

Contoso runs Ubuntu classes regularly and needs to keep the classroom image current with updates and patches without interrupting lessons or delaying the next class. A scheduled pipeline checks for security fixes even when the image template hasn't changed and builds a new revision when needed. Classes in session keep their existing VMs while the team tests the revision. Once the release owner approves it, new classes use the updated image.

Keep the Image Builder template, customizer, validator, and approved package list in version control. In Azure Pipelines, create a YAML pipeline from that repository. Add this schedule to the main pipeline file to check for updates every Monday at 03:00 UTC, even if nobody has changed the repository:

```yaml
schedules:
- cron: '0 3 * * 1'
  displayName: Check classroom image updates
  branches:
    include:
    - main
  always: true
```

The schedule starts the check; it doesn't install updates or authorize a release. Configure the following stages so an urgent security update can use the same workflow on demand:

1. **Select the updates**: Check Canonical's Ubuntu security notices and the team's approved package repository for fixes that apply to the image. Compare the selected base version, package versions, and recipe commit with the active revision's manifest. If nothing changed, record that result and stop. Otherwise, pin the exact inputs and repository snapshot for this run. An unavailable feed is a failed check, not evidence that the image is current.
1. **Build a candidate**: Reserve the next unused gallery version and a distinct template name. In the Ubuntu customizer, `apt-get update` refreshes the package index; it doesn't install fixes. For an installed package such as OpenSSL, `sudo apt-get install -y --only-upgrade "openssl=$approvedVersion"` applies the exact version selected from the pinned repository. Record the full gallery version ID, source commit, base version, and package list in the candidate manifest.
1. **Test the revision**: Compare the installed versions reported by `dpkg-query` with the approved list. Run the application validator and block distribution on failure. After publication and replication, deploy one canary in each promised region using the candidate's exact ID. Use a test identity restricted to the test resource group for VM creation; classroom deployments still require approval. Reboot each canary, confirm the updated OS and packages are active, and run the independent learner-access check and first lesson without elevation.
1. **Promote only on approval**: Give the build identity permission to publish candidates, not to change the active classroom release. Protect the promotion stage with an Azure Pipelines environment approval. Send the release owner the package changes, canary results, and regional status. A failed or overdue run should alert the owner and leave the active version unchanged.

:::image type="content" source="../media/5-classroom-image-update-pipeline.svg" alt-text="Diagram that shows how Contoso selects updates, builds a candidate, tests it in both regions, and requires approval before changing the active image.":::

## Select a revision and roll back safely

A new image can pass pre-release tests and still fail during a lesson. Keeping a tested, still-supported version ready in both regions lets Contoso stop deploying the faulty revision and provision the next class without waiting for a fix or a rebuild.

Keep a protected deployment record with two full gallery **version** IDs: `activeVersionId` for new classroom VMs and `previousKnownGoodVersionId` for recovery. Keep the previous image and its regional replicas for the agreed rollback window. Give the release-control record a revision that changes on every promotion, rollback, pause, withdrawal, or reauthorization affecting deployment. Record the revision reviewed by the approver together with the candidate's full ID and the intended change.

On promotion, save the old active ID as the previous known-good ID and set the active ID to the approved candidate. Commit both IDs and the decision state together, conditionally on the reviewed record revision still being current. Use a server-enforced conditional write or transaction, not a read followed by an unconditional overwrite. An **ETag** is a store-issued identifier for a particular revision; a release store backed by one Azure blob can use its ETag with an `If-Match` write. A transactional store can instead compare an incrementing revision.

If that condition fails, stop promotion and obtain a fresh decision against the current record. Don't reread the revision and silently retry under the old approval. Keep the state that can invalidate a promotion in the same authoritative transaction or conditional record, and check that the candidate remains approved and permitted. The deployment workflow must still read and enforce the current release decision for every request.

Comparing only `activeVersionId` is insufficient. A delayed run can see `1.0.1`, miss a promotion to `1.0.2` followed by a rollback to `1.0.1`, and mistake the restored ID for an unchanged decision. A record revision distinguishes those decisions even when the active image ID is the same.

Suppose the updated image boots, but a learner can't start the first lesson. The response depends on when the failure is found:

| When the test fails | What Contoso does |
|---|---|
| During the build or on a canary, before promotion | Reject `1.0.2`, save the failed test output, and leave `1.0.1` active. If a canary found the problem, `1.0.2` already exists in the gallery; block classroom use rather than assuming it wasn't published. No rollback is needed because the active revision never changed. |
| After `1.0.2` became active | Pause new deployments and mark `1.0.2` withdrawn. Confirm `1.0.1` is still supported, permitted by security policy, and ready in both regions. With the owner's approval, restore its full ID as active. Commit the rollback as a new release-control revision, invalidating pending promotions approved against an earlier revision. Verify the image ID and lesson on a fresh VM before resuming classroom deployments. If no safe fallback exists, keep deployments paused and build a corrected revision. |
| On a classroom VM already created from `1.0.2` | Changing the active ID doesn't change that VM's disk. Identify affected VMs by their image reference, preserve learners' work, and repair or replace only those VMs through the approved change process. |

Record the reason, affected version IDs, decision maker, and recovery result. Give the next corrected candidate a new number, such as `1.0.3`; never reuse the failed revision's number or overwrite its evidence.
