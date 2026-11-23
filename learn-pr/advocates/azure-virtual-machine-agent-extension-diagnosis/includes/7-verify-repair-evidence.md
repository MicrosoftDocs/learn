Before closing the incident, gather enough evidence for another operator to answer two questions: Did the change fix the reported problem, and does the workload still behave as expected? The support packet records those answers alongside anything that remains unexplained.

Verification has four layers. The original operation must succeed. Check that the component reports success for the operation you just retried. For an extension, match the handler's status report to the retry's sequence number. The guest must remain healthy. The workload must still produce its expected result through an independent channel. A green extension status alone doesn't satisfy all four.

:::image type="content" source="../media/repair-evidence-comparison.svg" alt-text="Diagram that shows successful retry evidence alongside unchanged guest health and an independent workload probe.":::

Compare configuration rather than relying on memory. In the Contoso ticket, only the submitted command and its execution records should differ. Compare the VM size, disks, network configuration, agent installation, and unrelated extensions before and after the change.

Use this template for a support handoff or completed incident record. Keep the originals private. Redact a separate copy and use the same alias (for example, `affected-vm-1`) wherever it refers to the same VM. Distinguish direct observations from inferences or a previous operator's report. If evidence is missing, record what would resolve the question and who will collect it.

```text
Case: [incident ID, evidence sources]
Resource: [private full VM ID, shared stable alias, region]
Versions: [OS, kernel/build, CLI, platform agent, extension handler]
Original operation: [intended contract and sanitized command]
Timeline: [UTC submission, receipt, sequence, command completion, observation]
Impact: [affected operation and separately verified workload status]
Available channels: [tested path, dependencies, test time]
Evidence: [current instance view, service state, narrow logs, exit code]
Hypotheses: [support, contradiction, next test, confidence]
Correction: [single change, approval, reversal, actor alias]
Verification: [new sequence, exit 0, expected stdout, guest probe]
Unchanged: [disks, network, agent install, unrelated extensions]
Unresolved: [missing evidence, limitations, next owner]
Escalation question: [specific unresolved component or dependency]
Retention: [secure location, redaction, expiry, cleanup status]
```

For the Contoso ticket, a closing note after a successful retry could read: “The submitted command forced exit 23 after the report printed. We removed the forced exit. On sequence [retry sequence], the command exited 0 and printed `report-ready os=ubuntu`. A separate SSH run returned the same output and exit code.” Use the sequence you observed. If you have only the SSH result, leave the extension retry unconfirmed for the next shift.

A useful escalation question is “Why did handler sequence 8 fail before command launch despite successful package download and available disk space?” Include the Azure correlation ID if available: it links related management events in the Activity Log. Unlike the handler sequence number, it doesn't identify the command output inside the guest. Exclude credentials, protected settings, access tokens, certificates, and customer data.

If collection itself fails, record the attempted command, channel, error, and timestamp. A missing log might mean the handler never ran, the wrong version directory was selected, or collection lacked permission. Mark the evidence unavailable rather than filling the gap with a presumed cause.
