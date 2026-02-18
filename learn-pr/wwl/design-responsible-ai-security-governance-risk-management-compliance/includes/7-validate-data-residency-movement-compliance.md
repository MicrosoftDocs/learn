## Overview

Validating data residency and movement compliance is a critical responsibility for solution architects designing AIpowered solutions across Microsoft 365, Dynamics 365, and Copilot Studio. Keeping data within approved geographic boundaries ensures that solutions follow regulatory, contractual, and organizational requirements. This unit explains how to evaluate data residency posture, control data movement, and apply data governance policies that align with cloud compliance expectations.

Solution architects must know where data is stored, how it moves across services, and which components participate in inference, logging, processing, or retention. This includes understanding the behavior of generative AI features, how Copilot Studio handles data, and how Microsoft Purview enforces datahandling compliance.

## Learning Objectives

- After completing this unit, learners will be able to:

- Identify required data residency and sovereignty requirements for AI workloads.

- Validate how Copilot Studio manages customer data, logs, and model interactions.

- Assess and restrict data movement across regions for generative AI capabilities.

- Apply Purview capabilities to strengthen compliance controls for Microsoft 365 Copilot.

- Recommend architectural controls that ensure compliant endtoend data handling.

## Key Concepts for Data Residency Compliance

### 1. Understanding Data Residency Boundaries

Data residency defines the physical or geographic location where customer data is stored and processed. 

#### AI solutions use multiple services and toolchains, so architects must understand:

- Where user prompts, context, and model inputs are processed.

- Which services store logs, conversations, or telemetry.

- Whether data used by generative AI stays within the designated region.

- How multitenant cloud services distribute workloads.

### 2. Copilot Studio Data Residency Behavior

Copilot Studio enforces regional boundaries depending on the environment configuration. 

#### Architects should validate:

- Where prompt data and agent interactions are processed.

- Whether unpublished agents and preview features follow different residency rules.

- How data is stored when agents use connectors or custom plugins.

- Whether crossregion interactions occur during inference or orchestration.

### 3. Data Movement Controls for Generative AI

Generative AI features may require movement of data for model evaluation, orchestration, or enrichment. 

#### To validate compliance:

- Determine which components may transmit data outside the region.

- Confirm whether data movement is necessary or optional.

- Review environment settings that allow or restrict crossgeographic model operations.

- Apply configuration policies that block crossregion routing for sensitive workloads.

### 4. Purview Controls for Microsoft 365 Copilot

Microsoft Purview provides governance, labeling, and monitoring necessary to validate compliant data handling. 

#### Solution architects should:

- Apply sensitivity labels that restrict crosstenant or crossregion transmission.

- Use data loss prevention (DLP) rules to prevent sensitive data from being used in AI prompts or outputs.

- Review auditing, policy insights, and compliance documentation for Copilot solutions.

- Validate that Copilot interaction logs follow organizational residency rules.

### 5. Designing a Compliant AI Architecture

Strong architectural governance ensures safe and compliant deployment. 

#### Recommended practices include:

- Selecting tenant regions that align with regulatory frameworks.

- Configuring Copilot Studio environments to enforce residency policies.

- Ensuring custom connectors do not bypass regional data boundaries.

- Documenting all data flows, including logs, telemetry, and inference outputs.

- Validating that backup, recovery, and logging systems maintain compliance.

## References

- [https://learn.microsoft.com/en-us/training/modules/purview-ai-secure-copilot/](/training/modules/purview-ai-secure-copilot/)

- [https://learn.microsoft.com/en-us/microsoft-copilot-studio/geo-data-residency](/microsoft-copilot-studio/geo-data-residency)

- [https://learn.microsoft.com/en-us/dynamics365/faqs-copilot-data-security-privacy](/dynamics365/faqs-copilot-data-security-privacy)

- [https://learn.microsoft.com/en-us/microsoft-copilot-studio/manage-data-movement-outside-us](/microsoft-copilot-studio/manage-data-movement-outside-us)