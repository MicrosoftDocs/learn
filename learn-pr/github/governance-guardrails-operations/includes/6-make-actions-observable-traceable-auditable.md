As agents begin to operate within these boundaries, visibility becomes critical. Being able to see what happened, why it happened, and who approved it makes it much easier to debug issues and build trust in the system. Every meaningful action should leave behind enough evidence to understand and verify it.

In this unit, you’ll learn:

- How GitHub artifacts make agent actions visible and traceable
- Why observability is required for trust and system reliability

## How observability works in GitHub

GitHub enables observability by capturing agent activity directly within the development workflow through pull requests, workflows, logs, and artifacts.

### Observability model

Every meaningful action must produce:

- PR + commit history
- workflow results (job logs, time, actor)
- uploaded artifacts (plan, test results, execution report)
- approval and merge events
- environment approval record (for production)

A useful rule is that every meaningful action must leave a trace that a reviewer can inspect.

### Observability as a design requirement

Without durable evidence, you can't:

- debug failures reliably
- investigate incidents
- prove compliance
- trust autonomous changes over time

Example: upload artifact

```yml
- name: Upload execution report
  uses: actions/upload-artifact@v4
  with:
    name: execution-report
    path: report.json
```

Decision guidance: Artifacts should be directly accessible and retained long enough for audits and incident response.

### Evidence-first workflows

Each critical workflow should output evidence such as:

- test results
- scan reports
- plan.json (machine-readable)
- execution-report (machine-readable summary)

>[!Important]
>Treat missing evidence as a failure. If a change can't be audited, it shouldn't be merged.

## Why observability matters

Without clear, durable evidence of what happened, systems quickly become difficult to operate and trust. When actions aren't visible or traceable:

- debugging becomes slow and reactive because there is no reliable record of events
- compliance can't be demonstrated because decisions and approvals aren't auditable
- trust breaks down because changes can't be explained or validated

A practical rule is: missing evidence = failure. If a system can't show what happened and why, it can't be safely operated at scale.

## Key takeaway

Observability enables accountability and trust by making every action visible, traceable, and explainable. It ensures systems remain debuggable, auditable, and reliable as they grow in complexity.

Governance isn't static. Next, you'll learn how to detect drift and maintain reliability over time
