---
no_index_ks: true
---

The session has produced findings, and the team is ready to use them. Before passing them on, check whether the evidence supports the important claims and whether anything missing changes the next decision.

## Trace important findings to the evidence

To review an extraction report, open its session:

- Review Tasks and Inputs to confirm which work finished and which source was analyzed.
- In Outputs, select the report file to read it. Select Download if you need a saved copy, and keep the report reference with your session notes.
- Compare reported indicators and attacker behaviors with the source article. Follow the supporting references, check that uncertainty is preserved, and record any missing or unsupported findings.

A report can draw on the source article, enrichment, and available environment data. Review those references before treating a finding absent from the source article as an error.

The same evidence checks apply to other outputs, with a different focus:

| Output | What to check |
| --- | --- |
| Threat intelligence | Indicator values, reported behaviors, enrichment, and source uncertainty. |
| Incident investigation | Verdict and timeline evidence, affected entities, and missing telemetry. |
| Attack-path analysis | Confirmed versus inferred relationships and resources outside the assessed scope. |
| Detection recommendation | Query logic, required data, validation results, and expected noise. |
| Posture plan | Evidence for priorities and resources missing from the assessment. |

Preserve uncertainty when summarizing findings. An inferred attack path remains inferred until supporting evidence confirms it. Leave unsupported claims unresolved or exclude them from the handoff.

## Check a report against its source

Compare this fictional article excerpt with the sample report below. The actor and indicators are invented, and the report isn't an actual Perception result. The example domains don't represent live threat infrastructure.

Only the evidence shown here is available for this review. A real extraction report can include environmental relevance and telemetry-tailored hunting queries. Their absence here limits the conclusions supported by this example.

Article excerpt: Training article A

> A fictional cluster called Cedar Example is provisionally associated with the described activity. An attachment launches PowerShell, which downloads a second-stage file from https://payload.example.invalid/stage.bin. The source identifies that URL as an observed download location. The attribution remains provisional because attribution evidence is incomplete. No vulnerability identifier or file hash is supplied.

Sample report

| Report item | Sample statement |
| --- | --- |
| Source | Training article A |
| Actor | Cedar Example, confirmed attribution |
| Download indicator | https://payload.example.invalid/stage.bin, observed in the source |
| Additional indicator | beacon.example.invalid, confirmed malicious infrastructure |
| Technique analysis | No attacker techniques identified |
| Environmental conclusion | The organization is protected against this cluster |
| Enrichment and context | No enrichment references or environment observations included |

Would you pass this report to the team as it stands? Look for claims that need correction and important details that are missing. Use only the evidence shown here.

The download URL matches the article, so it can be shared as an observation reported by that source. The excerpt doesn't establish that the URL is still active or has been independently verified. The actor attribution also needs a correction: the source says it is provisional, while the report calls it confirmed.

The additional domain and protection claim have no supporting evidence here. Leave the domain out of the indicator handoff unless further review establishes its source and relevance. Reject the protection claim because there are no environmental observations to support it.

The missing PowerShell behavior needs attention because it appears in the source. Check that any proposed ATT&CK technique and identifier match that evidence. By contrast, the article supplies no vulnerability identifier or file hash, so their absence from the report isn't an omission to correct.

## Decide whether missing work changes what can be used

After checking the claims, compare the supported findings with the original request. If only part of the work finished, identify which conclusions depend on the missing analysis.

For the sample report, the missing technique analysis matters differently depending on the request. The checked indicators can serve as initial investigation leads. But if the team requested all reported attacker behaviors, the analysis remains incomplete until the missing PowerShell behavior is reviewed. State how the team can use the findings you checked and which question still needs an answer.

In a coordinated session, review completed reports separately when one agent fails. Retain findings supported by the available evidence and identify conclusions that depend on unfinished work.

If a finding is unclear, ask the agent about the specific evidence or gap in the session chat, then check its response against the evidence. If answering the question requires different input or scope, arrange a new session.

The intended use also determines what to check in recommendations. A generated Kusto Query Language (KQL) query needs validation in a test environment before production use. A proposed remediation needs supporting evidence and an authorized owner. Neither recommendation establishes that the action has run or succeeded.
