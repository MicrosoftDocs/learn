Timely and clear sharing information is an essential element of effectively responding to incidents throughout the entire incident response lifecycle. Communication matters during every phase:

- **Detection**: Communicate to the proper people that an incident has occurred and the broad nature/severity of the incident and impact.
- **Response**: Communicate the details about the incident as the diagnostic process proceeds, what steps are needed to fix the problem, and who is to do what.
- **Remediation**: Communicate how and when service has been restored to normal operation and necessary follow-up actions.
- **Analysis**: Communicate the lessons learned from the incident and what can be done to prevent it from happening again.
- **Readiness**: Communicate changes (or required changes) to the incident response plan, our procedures, and our systems that resulted from the lessons learned from this incident.

## Prioritize for clear communication

Earlier in this module, we mentioned that elite/high-performing organizations take a proactive rather than reactive approach. Shifting your posture from reacting to effectively responding to incidents comes as a byproduct of prioritizing and enabling good, clear, accurate communication.

Keys to prioritizing for clear communication include:

- Make sure you are sharing information about what is going on at each step of the way.
- Document the information; put it in writing so that it's less likely to be misunderstood or forgotten.
- Place the information in a centralized location where it will be accessible to everyone who needs it.
- Use tools to increase the effectiveness of communications.

Even though we didn't call it out at the time, these are all behaviors we demonstrated in the last unit.

## Communication tools: ChatOps

Before you can talk about communication tools, you need to learn about ChatOps, which is not a specific tool, but a conversation-driven collaboration model. It's popular with developers for bringing together people, tools, processes and automation. ChatOps gives you a new and better way for teams to work, leveraging group chat rather than relying on older technologies such as email to collaborate.

In its advanced form, ChatOps can use customized bots and artificial intelligence to automate work. In the context of incident response, you can use ChatOps to bring group-chat tools into the conversation. Working this way can strongly incentivize engineers to get together in group chat and
collaborate on issues and incidents, as well as normal engineering efforts.

Group chat helps you share more about what's going on in your system in terms of institutional knowledge and gets that information out of people's heads and into chat so it can be shared and used by others.

This increases visibility and operational awareness across the team and helps others learn how to do what they're supposed to do. When you run commands and share what you're doing within chat, you're teaching others what to do and how to do it.

Learning is a byproduct of sharing more about what's happening within engineering. When you understand more about what your peers, coworkers, and leadership are doing and thinking—including how they make decisions—you're able to be more empathetic about what's taking place. All of this happens more naturally when you start moving your work into chat.

### Use Microsoft Teams in your ChatOps solution

You already learned how Microsoft Teams can be an important part of your communications toolkit during an incident. You can create a conversation bridge with channel devoted to the incident and even use Logic Apps to automate posting the incident details directly into the channel.

Because Microsoft Teams is a centralized place where we have many conversations about our engineering efforts, it's a good place to start in your ChatOps solution for providing status updates and additional context.

For example, you can use a webhook from Teams to update a status page. You can configure Teams to listen for a certain command in a chat, and if received, send out a request to another application. That simple application could be an Azure Function that updates a static HTML page stored in Azure Blob Storage with information about the incident in progress. The end result is that simple command in chat provides an update to additional stakeholders not in the chat. This one simple step saves time that might otherwise be spent updating those not involved in the response.

So far, we've largely spent our time looking at the phases before remediation. Let's now shift our focus to ways to improve that phase.
