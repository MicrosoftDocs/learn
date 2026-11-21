Contoso wants to distinguish installing IIS once from maintaining its required state. This conceptual walkthrough connects the Custom Script Extension example with Machine Configuration and explains how to interpret monitored drift and automatic correction. You can study the sequence and expected observations without executing the commands.

> [!IMPORTANT]
> The `ContosoIis` package and its implementation-specific compilation instructions aren't supplied. This walkthrough isn't a self-contained lab. Before executing package-dependent steps, obtain a maintained artifact that explicitly manages W3SVC's running state and has been tested on the target VM. The one-time IIS installation script isn't a replacement for that package.

## Prepare the baseline

If you execute this workflow with an approved package, use an isolated Windows Server 2025 VM in a dedicated resource group. Keep production machines outside the scope of the policy assignment. For the service-drift example below, the package must explicitly require W3SVC to be running. A package that only checks whether the Web-Server role is installed isn't suitable for this service-state test.

Prepare the baseline in this order:

1. Follow the Custom Script Extension unit to save `Install-Iis.ps1`, deliver it from a private blob, and install the IIS role. Complete any required restart separately, and inspect the extension's result.
1. Confirm role presence, service state, and the local HTTP response using the checks in that unit. Treat these as separate observations rather than proof of ongoing enforcement.
1. Follow the Machine Configuration unit to enable the VM identity and extension, prepare and test the approved package, and publish the exact ZIP to private storage.
1. Generate the initial policy with `Mode = 'ApplyAndMonitor'`, as shown in the configuration unit. Retain `$policyConfig`, the policy GUID, `$labSubscriptionId`, `$policyDefinitionName`, `$labDefinitionId`, and the policy assignment ID so you can update the same lab configuration later.
1. Assign the definition to the isolated resource group. Configure the policy-assignment identity and its deployment roles separately from the VM identity's blob-read permission. Keep the generated `EnableAutoRemediation` parameter at the string `"false"` for both phases of this comparison.
1. Create the initial remediation task for the existing VM when assigning the policy, or after evaluation. Let the task finish and diagnose any failed deployments. A task only targets resources that the policy evaluates as noncompliant, so its completion doesn't by itself prove the effective guest mode.

Open **Azure Policy > Compliance**, select the lab assignment, then the VM's **Resource compliance > Details > Last evaluated resource** to reach its guest results. Record the actual guest-assignment name and resource ID, package version, content URI and hash, effective assignment type, and actual setting values. Preserve any suffix added to the resource name by the generator.

### Confirm the monitored baseline

Use the effective assignment type and a fresh service result to decide whether the first deployment is ready:

1. If the assignment is still being provisioned, its type is null, or its report is `Pending`, wait for a usable result and read the type and service result again. A temporarily null type typically resolves within one hour, but this isn't a fixed completion guarantee. If progress doesn't resolve, or the result reports a download, execution, or prerequisite error, stop and diagnose that condition. If the type is unexpectedly `ApplyAndAutoCorrect`, resolve the mismatch before testing drift.
1. If the settled assignment is `ApplyAndMonitor`, W3SVC is running, and the fresh service result is compliant, the monitored baseline is ready. Skip the remaining baseline steps and proceed to **Observe and remediate monitored drift**. Don't stop the service merely to repeat initial application.
1. If the settled assignment is `Audit` and the service result is compliant, the initial remediation task can have no target. Only on the disposable VM, with the approved package confirmed to require W3SVC to run, use the reviewed script in the next section to stop that service. This interrupts the lab website. For either `Audit` or `ApplyAndMonitor`, if the service is already stopped and the report correctly identifies that drift, proceed without stopping it again.
1. On this recovery path, wait for a new guest result reporting this service as noncompliant and for Azure Policy to record the VM as noncompliant for the lab assignment. Create a fresh remediation task for that assignment and isolated scope. Confirm that the same guest assignment is now `ApplyAndMonitor`, W3SVC is running, and a fresh guest report is compliant.
1. If the expected type or state isn't reached, stop the comparison and investigate. Restore the service separately if needed, but don't count that manual restoration as successful package remediation. Once the baseline is confirmed, proceed to the monitored-drift test.

> [!NOTE]
> A compliant audit result and a compliant applying assignment can both look green. Confirm the effective guest-assignment type before comparing drift behavior. A policy evaluation request reads the latest reported state; it doesn't force an immediate in-guest evaluation.

Finish VM prerequisite changes before assigning the custom policy. Avoid VM-resource updates or competing configuration jobs during drift observation. With default Azure Policy enforcement, a qualifying VM resource update can trigger another deployment, independently of the guest's ordinary drift interval.

## Observe and remediate monitored drift

Use an approved guest access method, such as Action Run Command, to stop W3SVC on the disposable VM. Review the following script before running it:

```powershell
$ErrorActionPreference = 'Stop'
Stop-Service -Name 'W3SVC'
Get-Service -Name 'W3SVC'
```

Stopping this service interrupts the lab website. Only perform the action when the approved package explicitly manages the service's running state and no production workload depends on this VM.

Under `ApplyAndMonitor`, the next guest evaluation should report the managed setting as noncompliant without automatically restarting the service. Inspect the resource-level compliance reason and confirm that it matches the setting you changed. Allow for the separate guest-evaluation and Azure Policy reporting intervals.

After noncompliance is reported, trigger remediation for the lab policy assignment. Confirm that W3SVC returns to the required state and that the guest result becomes compliant. Check the HTTP response separately if website availability is an intended outcome.

## Observe automatic correction

The preceding remediation restores the VM to compliance. Changing the policy definition alone doesn't prove that its existing guest assignment will receive a new mode. Use the following controlled transition on the isolated VM:

1. Confirm the effective guest assignment is still `ApplyAndMonitor`. Stop W3SVC once more using the preceding script, only if the approved package manages its running state.
1. Wait for the guest result and the relevant Azure Policy compliance record to report the new noncompliance. Don't manually restart the service yet. This creates a known remediation target for delivering the new mode.
1. Before updating, confirm that the recorded definition belongs to this lab and isn't shared with another exercise. In the authoring session, reuse `$policyConfig`, including its policy GUID, package URI, and local ZIP, and the recorded subscription and definition identifiers. Regenerate and update that same definition using the following code. Don't create a second conflicting assignment.

```powershell
$policyConfig.Mode = 'ApplyAndAutoCorrect'
$policyConfig.PolicyVersion = '1.0.1'

$generatedPolicy = New-GuestConfigurationPolicy @policyConfig `
    -UseSystemAssignedIdentity `
    -ExcludeArcMachines

$policyFile = $generatedPolicy.Path

if (-not (Test-Path -LiteralPath $policyFile -PathType Leaf)) {
    throw 'Policy generation did not return an existing JSON file.'
}

$existing = Get-AzPolicyDefinition `
    -SubscriptionId $labSubscriptionId `
    -Name $policyDefinitionName `
    -ErrorAction Stop

if ($existing.Id -ne $labDefinitionId) {
    throw 'The target does not match the recorded lab definition ID.'
}

Update-AzPolicyDefinition `
    -SubscriptionId $labSubscriptionId `
    -Name $policyDefinitionName `
    -Policy $policyFile `
    -ErrorAction Stop
```

`Mode` is an input to `New-GuestConfigurationPolicy`, not a policy-assignment parameter to invent. Inspect the generated definition and update only parameters that it actually exposes. Preserve the existing assignment identity, scope, and deployment permissions.

The ID comparison checks the target identifier, not ownership or the absence of other assignments. Review those separately. `New-AzPolicyDefinition` supports intentional updates, but this example uses `Update-AzPolicyDefinition` so a missing definition is an error. For a lab created previously with another definition name, reuse its actual recorded name, ID, and scope rather than changing its name to a new GUID.

Record the tooling version used for your approved example because generated parameters can change. In GuestConfiguration 4.12.0, `EnableAutoRemediation` is a separate string parameter defaulting to `"false"`. Keep that default for both phases of this controlled manual-remediation comparison. It neither blocks a manually requested deployment of the generated applying configuration nor substitutes for changing `guestConfiguration.assignmentType`.

Deliver the updated mode before testing its behavior:

1. Request evaluation of the existing policy assignment if necessary, then wait for its current noncompliant record. An Azure Policy scan doesn't force an immediate in-guest check. Create a remediation task for this assignment and the isolated VM.
1. Inspect the deployment and the existing guest assignment. Confirm that `properties.guestConfiguration.assignmentType` is now `ApplyAndAutoCorrect`, the intended package is still assigned, and W3SVC has returned to its required state. Don't proceed if the mode is still `ApplyAndMonitor`.
1. Stop W3SVC again to test the newly delivered mode. This time, don't create another policy remediation task. Observe the actual service state and guest results after automatic correction.

> [!NOTE]
> A compliant assignment can satisfy a deploy-if-not-exists condition without another deployment. This isolated demonstration first creates monitored noncompliance, then uses remediation to deliver the updated assignment. A direct update of the existing guest assignment is another documented mechanism, but isn't an additional procedure in this module. Incrementing the policy metadata version records the revision but doesn't itself update the guest.

Compare these observations:

| Observation | Apply and monitor | Apply and autocorrect |
| --- | --- | --- |
| Actual managed setting after drift | Remains changed until remediation is triggered. | Returns to the required state during guest evaluation, unless remediation encounters an error. |
| Guest compliance result | Reports the noncompliant setting. | Might report only the corrected compliant state after automatic correction. |
| Further action for the drift event | Trigger remediation and inspect its result. | Investigate errors if correction fails. A new policy remediation task isn't required for every drift event. |

Don't require a transient noncompliant portal result as evidence of successful automatic correction. Compare the setting before and after the evaluation, and inspect the guest results. If the setting isn't restored, check the package contract, effective mode, resource errors, and assignment prerequisites instead of assuming that another deployment will fix it.

## Clean up the isolated environment

Remove only the recorded lab policy assignment and its guest resources when you're finished. Delete only the VM, storage artifacts, and other resources created for this walkthrough. Confirm a resource group contains no shared resources before deleting it. Remove the recorded lab policy definition only when it has no remaining assignments. A display name alone isn't a deletion target.

Removing an assignment doesn't automatically roll back every setting it previously applied. Use disposable resources or an explicit restoration plan.
