## Overview

This unit equips solution architects with a detailed, structured process for designing, governing, and recommending how organizations add knowledge sources to inapp help and guidance for Dynamics 365 Finance or Dynamics 365 Supply Chain Management apps.<br>

The goal is to ensure that help and guidance is enriched with accurate, secure, roleappropriate knowledge to improve user productivity, reduce support load, and enhance task completion confidence.

You will learn how knowledge sources feed Copilot behaviors, how content must be prepared and validated, and how to orchestrate the full lifecycle—from content ingestion to publication.

## Architectural Context How Knowledge Powers InApp Help

Dynamics 365 uses Copilot capabilities to surface inapp help based on curated knowledge sources. These sources combine:

* Product documentation

* Custom organizational knowledge

* Knowledge articles, process guides, structured files, and operational documents

* Generative responses (when enabled)

## Knowledge Source Types to Recommend

Solution architects must identify which knowledge sources are appropriate and supportable:

### Supported Examples

* PDF, RTF, and Word files containing validated business processes

* Knowledge articles related to Finance or Supply Chain workflows

* Task guides describing system steps

* Policy documents directly connected to operational tasks

### Not Recommended or Unsupported

* Dataverse virtual entities published from Finance & Operations

* Content unrelated to product usage (can contaminate help results)

* Content containing sensitive, unclassified data

## Recommended EndtoEnd Process for Adding Knowledge Sources

### Step 1 Prepare the Knowledge

Before ingestion:

* Validate accuracy and alignment to business processes.

* Ensure the content is strictly connected to Finance or Supply Chain tasks.

* Apply consistent terminology and style (Microsoft style).

* Apply required sensitivity labels.

### Step 2 Ingest Knowledge Through Copilot Studio

* Open Copilot Studio and select the environment associated with Finance or Supply Chain Management.

* Navigate to **Agents**, then open the agent for the application.

* Select the **Knowledge** tab and choose **Add knowledge**.

* Upload the prepared files.

* Monitor processing status until the knowledge source shows **Ready**.

### Step 3 Test Knowledge Behavior

#### Testing is essential for solution architects

* Perform scenariobased questioning.

* Validate that responses reflect the intended source content.

* Confirm that unrelated knowledge does not influence the results.

* Adjust content and reprocess as needed.

### Step 4 Publish Knowledge to Production

#### After successful testing

* Select **Publish** to make the new help content available to end users.

* Close open Copilot sessions and reopen to ensure refreshed knowledge is active.

* Review initial user feedback during early usage.

### Step 5 Govern and Maintain Knowledge

#### Solution architects define ongoing governance

* Version control: update or retire outdated content.

* Security: maintain labeling and DLP compliance.

* Review cadence: quarterly or aligned to app updates.

* Testing: validate after each Dynamics 365 release wave.

## Enabling or Restricting General Knowledge

Solution architects decide whether to enable general knowledge (LLMbased, external):

### Enable only when

* Business scenarios benefit from expanded natural language explanations.

* Risks are assessed and mitigated.

### Restrict when

* Precision is critical for regulatory or financial workflows.

* Only controlled, validated knowledge should influence help responses.

## Solution Architect Recommendations Framework

Use this structure when advising customers:

### Recommendation Areas

* **Knowledge scope**: Define what is allowed and prohibited.

* **Data governance**: Ensure labeling, role access, and content classification.

* **Operational workflows**: Ensure content owners maintain accuracy.

* **Risk mitigation**: Address generative AI reliability and guardrails.

* **Success metrics**: Content usage, reduced support calls, improved task completion.

## References

[Generative help and guidance with Copilot - Finance & Operations | Dynamics 365 | Microsoft Learn](/dynamics365/fin-ops-core/fin-ops/copilot/copilot-generative-help)<br>[https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/copilot/extend-copilot-generative-help](/dynamics365/fin-ops-core/dev-itpro/copilot/extend-copilot-generative-help)