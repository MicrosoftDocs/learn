The break phase is where you use the data-flow diagram to find potential threats against your system. The process uses a threat modeling framework to help you find the most common threats and ways to protect against them.

## Goals

- Choose between "protecting the system" or "understanding the attacker" focused approaches
- Use the STRIDE framework to identify common threats (described below)

> [!IMPORTANT]
> If you don't complete this phase, you won't find potential threats in your system, which can lead to future breaches.

## Focus your approach

Start by choosing whether you want to find ways to protect your system or understand all you can about an attacker and their motives. Examples include:

|Focus|Example of what you can find|
|---------------|----------------------------|
|System|You find an issue with an unencrypted connection between the user and the system.|
|Attacker|You find out more about means, motivation, and ways to harden the system entry points.|
|Asset| You identify critical assets based on things like classified data handling and focus mostly on protecting those assets.|

> [!NOTE]
> Microsoft product engineers mostly focus on protecting the system. Penetration testing teams focus on both.

## Select a threat framework

Next, select a framework to help generate potential threats in your system. Microsoft traditionally uses STRIDE, an acronym for the six main threat categories to provide an extensive, but not exhaustive, list of threats.

The framework helps you ask a few important questions about your system:

|Threat|Definition|Question|Threat example|
|------|----------|--------|--------------|
|Spoofing|Attacker pretends to be someone or something else|Are both sides of the communication authenticated?|Sending an email to users from an account that seems legitimate with malicious links and attachments to capture their credentials, data, and device access.|
|Tampering|Attacker changes data without authorization|How do I know someone can't change data in transit, in use, or at rest?|Modifying memory through weak API call handling to cause crashes and disclosure of sensitive error messages.|
|Repudiation|Attacker claims to not have done something|Can every action be tied to an identity?|Claiming to not have deleted database records.|
|Information Disclosure|Attacker sees data they aren't supposed to see|How do I know someone can't see data in transit, in use, or at rest?|Accessing unauthorized documents and folders with weak security controls.
|Denial of Service|Attacker brings your system down|Are there areas in the system where resource is limited?|Flooding the network with requests.|
|Elevation of Privilege|Attacker has unauthorized access to data|How do I know someone is allowed to take this action?|Extracting data by exploiting weaknesses in input handling logic or memory.|
