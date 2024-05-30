When you have identified potential harms, developed a way to measure their presence, and implemented mitigations for them in your solution, you can get ready to release your solution. Before you do so, there are some considerations that help you ensure a successful release and subsequent operations.

## Complete prerelease reviews

Before releasing a generative AI solution, identify the various compliance requirements in your organization and industry and ensure the appropriate teams are given the opportunity to review the system and its documentation. Common compliance reviews include:

- Legal
- Privacy
- Security
- Accessibility

## Release and operate the solution

A successful release requires some planning and preparation. Consider the following guidelines:

- Devise a *phased delivery plan* that enables you to release the solution initially to restricted group of users. This approach enables you to gather feedback and identify problems before releasing to a wider audience.
- Create an *incident response plan* that includes estimates of the time taken to respond to unanticipated incidents.
- Create a *rollback plan* that defines the steps to revert the solution to a previous state in the event of an incident.
- Implement the capability to immediately block harmful system responses when they're discovered.
- Implement a capability to block specific users, applications, or client IP addresses in the event of system misuse.
- Implement a way for users to provide feedback and report issues. In particular, enable users to report generated content as "inaccurate", "incomplete", "harmful", "offensive", or otherwise problematic.
- Track telemetry data that enables you to determine user satisfaction and identify functional gaps or usability challenges. Telemetry collected should comply with privacy laws and your own organization's policies and commitments to user privacy.

## Utilize Azure AI Content Safety

Several Azure AI resources provide built-in analysis of the content they are working with, including Language, Vision, and Azure OpenAI by using content filters.

Azure AI Content Safety provides additional features focusing on keeping AI and copilots safe from risk. This includes detecting inappropriate or offensive language, both from input or generated, as well as detecting risky inputs.

Features in Azure AI Content Safety include:

|Feature|Functionality|
|---|---|
|Prompt shields|Scans for the risk of user input attacks on language models|
|Groundedness detection|Detects if text responses are grounded in a user's source content|
|Protected material detection|Scans for known copyrighted content|
|Custom categories|Define custom categories for any new or emerging patterns|

Details and quickstarts for using Azure AI Content Safety can be found on the [documentation pages](/azure/ai-services/content-safety/overview) for the service.
