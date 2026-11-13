---
no_index_ks: true
---

"Analyze this threat report" might mean extracting the reported indicators and behaviors or assessing how the threat affects the organization. Before handing the work to Perception, clarify what the team needs to know. That request guides both the playbook you choose and the checks you make when the findings are ready.

## Follow the work from request to result

Keep the work focused on the team's request, from selecting a playbook through handing off the findings. You don't need to direct every agent action.

Define the needed answer → select and start suitable work → monitor and intervene when needed → judge the result → hand off the next action

The request tells you what the team needs. For an incident, that might be an explanation of what happened and which systems were affected. For a posture review, it might be a list of fixes to prioritize.

A playbook specifies the work Perception can run. Choose one that addresses the request and accepts the input you have. It can use a single agent or coordinate several agents.

When you run the playbook, Perception creates a session. The session shows the inputs, agent progress and messages, requests for your response, and any output files produced. Return to it to follow progress, respond to requests, or review the outputs.

As work progresses, keep checking it against the request. If the team asked about one incident, confirm that the right incident is being analyzed. If an agent proposes additional work, consider whether it is needed and authorized. Once the findings are ready, check whether they answer the team's question and show enough evidence to rely on.

## Check what a completed session establishes

When the status changes to Completed, the agents have finished their work. The report can still contain an unsupported claim or leave part of the question unanswered.

An investigation might produce a useful timeline while lacking evidence from one device. That timeline can help the team, provided the missing device evidence is clear and the conclusions don't extend beyond what was examined.

Keep the session files and leave a short note explaining:

- What the team asked for.
- Which findings were checked and can be used.
- Which findings remain uncertain or unsupported.
- What happens next and who owns that action.

For a threat report, the same review starts with the team's question. If it needs the reported indicators and behaviors, check those findings against the source before passing them on.
