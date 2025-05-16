Understanding insider risk management concepts is easier when applied to real-world scenarios. This case study demonstrates how Microsoft Purview Insider Risk Management can help organizations detect and respond to potential risks effectively, ensuring sensitive information remains secure.

## Scenario

A project manager notifies their supervisor of their resignation. Shortly after, they download several files labeled "Confidential" from a team SharePoint site. This activity raises concerns about potential data theft, as the files contain sensitive product designs.

## How the organization responds

1. **Policy detection and alert review**: The organization previously created a **Data theft by departing users** policy to detect risky activities, like large downloads or file transfers by departing employees. This policy is designed to flag potential data exfiltration attempts.

   The project manager's download activity triggers an alert in Microsoft Purview Insider Risk Management, appearing in the **Alerts dashboard** as high priority. The reviewer notes the unusual volume and timing of the downloads, raising concerns about potential data theft.

1. **Investigation**: Using **Content explorer**, the investigator examines the downloaded files. These include product roadmaps and client presentations marked with a "Confidential" [sensitivity label](/purview/sensitivity-labels?azure-portal=true).

   The investigator also uses **User activity reports** to confirm that the downloads occurred outside the project manager's normal working hours, adding to the concern.

1. **Action taken**: The organization takes the following steps:

   - **Notification**: The project manager receives a notice reminding them of company policies on handling sensitive information.
   - **Escalation**: The case is escalated to the legal team using eDiscovery (Premium) to ensure compliance with regulatory requirements and organizational policies.
   - **Policy refinement**: Based on the incident, the organization updates its "Departing Users" policy to flag downloads of labeled files during non-business hours.

The organization prevents potential data exfiltration without accusing the project manager unfairly. By using Microsoft Purview Insider Risk Management, they balance protecting sensitive information with maintaining employee trust and respecting privacy.
