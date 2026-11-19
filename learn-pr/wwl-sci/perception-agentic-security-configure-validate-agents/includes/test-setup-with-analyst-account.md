---
no_index_ks: true
---

Test whether the agent's configuration supports the approved security task. Use a known input and agreed acceptance criteria to check access, required actions, and the resulting output.

## Test with the account used for security work

Confirm the required services, agent permissions, and security practitioner access before the test. Use the security practitioner's own account to follow the work from its input to its result, rather than only checking whether the workflow opens.

The security practitioner performs the security work and judges its findings. If someone else runs the test, observe it or obtain confirmation tied to the session and report. If you both configure and use the agent, test with the access you use for that security work. A successful test with setup privileges doesn't establish what an account without those privileges can do.

### Example: validate threat-intelligence extraction

For Extract threat intelligence, use the approved article and source facts agreed with a threat-intelligence security practitioner:

- Verify workflow access. Ask the security practitioner to sign in and open Perception > Playbooks > Extract threat intelligence. Check that the playbook lists the Threat Intelligence Agent and accepts the selected input.
- Verify session start.
  - Ask the security practitioner to select New session, provide the selected article, and select Start session.
  - Have them open the session from Sessions. Check that Inputs matches the agreed source.
- Verify plan response.
  - Have the security practitioner locate the initial plan in the conversation when the status is Waiting for input.
  - The security practitioner checks the plan against the approved task and uses Approve, Deny and redirect, or Ask a question, as appropriate.
  - Verify that they can respond and that work proceeds after they approve a suitable plan.
- Verify source and data access. Review Contents > Tasks with the security practitioner. Check which required tasks ran and whether access errors or missing data blocked the work.
- Verify output access and usability.
  - Ask the security practitioner to open the report in Outputs and use Download. Check that both actions succeed.
  - Have the security practitioner compare the report with the agreed source facts and supporting references, then check any required enrichment. Retain their assessment of whether those checks passed.
- Assess the result. Mark each acceptance criterion Passed, Failed, or Not tested. Leave failed or untested criteria open for follow-up and retest.

In session views labeled Progress and Artifacts, review agent activity under Progress and generated reports under Artifacts. See [Work with a session](/security/agentic-security/agentic-security-session-details?azure-portal=true) for the session layout and controls.

## Record evidence that answers the readiness question

Under Validation session, report, and results, retain the following evidence. Link supporting files instead of copying every session message:

| Check | Evidence to retain |
| --- | --- |
| Security practitioner access | The tested account, session reference, and results of opening the workflow and starting the session. |
| Supervision access | The session reference and results of any required plan response or other interaction. |
| Agent and data access | Task results, access errors, and missing required data. Keep these separate from grant and service-availability confirmations. |
| Usable output | The report reference, opening and download results, and the security practitioner's findings about the expected facts, references, and enrichment. |
| Test result | Passed, failed, and untested criteria, with any follow-up needed. |

Different runs can vary in wording, report order, or emphasis. Record the security practitioner's assessment against the task and known evidence, not whether the output matches an earlier report word for word.

For the extraction example, reviewing a generated hunting query doesn't require running it. Keep the test within the approved analysis and review task.

## Separate readiness from security conclusions

Even after a successful test, security practitioners still need to review each session's findings and the evidence supporting any security conclusions.

If the security practitioner reports missing facts or inadequate evidence, keep the affected criteria open. Check the task record for data-processing or access failures, and retain the evidence for follow-up. Change permissions only when the evidence identifies an access issue.
