A remarkable thing happens when engineers make mistakes and feel safe providing details about them: they aren't only willing to be held accountable, but they're enthusiastic about helping the rest of the organization avoid the same error in the future.

## Engineers as experts in their errors

**Unique expertise:** Engineers who made mistakes are the most expert in their specific error. They understand:

- The context that made the action seem reasonable.
- The information they had (and didn't have) at the time.
- The pressures and constraints they were working under.
- The assumptions they made and why those assumptions seemed valid.
- The cascading effects they observed as the incident unfolded.

**Essential involvement in remediation:** Engineers should be heavily involved in developing remediation items. Their expertise makes them uniquely qualified to suggest improvements that will actually prevent recurrence rather than superficial changes that don't address root causes.

**Not off the hook:** Engineers aren't "off the hook" with a blameless post-mortem process. They're very much on the hook for helping the organization become safer and more resilient. Most engineers find this idea of making things better for others a worthwhile and meaningful exercise. It transforms failure from a source of shame into an opportunity for contribution.

## Principles for enabling Just Culture

Developing a Just Culture requires deliberate organizational practices and commitments:

### Encourage learning through blameless post-mortems

**Regular practice:** Conduct blameless post-mortems on outages and accidents as standard practice, not exceptional events.

**Understand how accidents could happen:** The goal is understanding **how** an accident could have happened to better equip ourselves to prevent it in the future. This differs from asking "who caused it" which doesn't improve safety.

**Focus on mechanisms, not culprits:** Investigate the mechanisms by which failures occur in the system. What conditions allowed the failure? What made the problematic action seem like the right choice at the time?

### Gather multiple perspectives without punishment

**Multiple viewpoints:** Gather details from multiple perspectives on failures. Different people have different information and observations. Combining these perspectives provides a complete picture.

**No punishment for mistakes:** Don't punish people for making honest mistakes. Punishment shuts down the information flow needed for learning.

**Give authority to improve:** Instead of punishing engineers, give them the authority to improve safety by providing detailed accounts of their contributions to failures. This empowers engineers to be part of the solution.

### Transform mistakes into organizational learning

**Educate others:** Enable and encourage people who made mistakes to educate the rest of the organization on how not to make them in the future.

**Documentation and sharing:** Document lessons learned in accessible formats. Share incident reviews widely so others can learn from experiences they weren't directly involved in.

**Training incorporation:** Incorporate real incident examples into training programs. Anonymized case studies from actual incidents are more valuable than hypothetical scenarios.

### Accept human discretion and decision-making

**Discretionary space always exists:** Accept that there's always a discretionary space where humans can decide to take actions or not. Procedures and automation don't eliminate human judgment. They constrain it but don't remove it.

**Judgment occurs in hindsight:** Accept that judgment of those decisions happens in hindsight. We assess decisions with information the person making the decision didn't have.

**Hindsight bias awareness:** Accept that [Hindsight Bias](http://en.wikipedia.org/wiki/Hindsight) will continue to cloud our assessment of past events. Work hard to eliminate it by asking "what made sense given what they knew then?" instead of "why didn't they do what we now know they should have done?"

### Focus on environmental factors

**Fundamental attribution error:** Accept that the [Fundamental Attribution Error](http://en.wikipedia.org/wiki/Fundamental_attribution_error) is difficult to escape. This cognitive bias leads us to attribute others' actions to their character rather than their circumstances.

**Environment and circumstances:** Focus on the environment and circumstances people were working in when investigating accidents. What pressures existed? What information was missing? What time constraints applied? What goals were they pursuing?

**System factors, not personal factors:** Ask what system factors contributed to the incident rather than what personal characteristics led to it.

### Bridge the gap between blunt end and sharp end

**Understand actual work:** Strive to ensure that the blunt end of the organization (management, leadership) understands how work is actually getting done on the sharp end (where engineers interact with systems).

**Not imagined work:** Actual work differs from how leadership imagines it's getting done via project plans, Gantt charts, and formal procedures. Procedures describe idealized work. Real work involves improvisation, workarounds, and adaptation.

**Regular communication:** Create channels for sharp end workers to inform leadership about actual working conditions, challenges, and risks without fear of criticism for deviating from official procedures.

### Define appropriate behavior collaboratively

**Sharp end defines boundaries:** The sharp end is relied upon to inform the organization about the line between appropriate and inappropriate behavior. It isn't something that the blunt end can come up with on its own.

**Ground truth:** Engineers working in systems daily have ground truth about what's realistically achievable, what shortcuts are necessary, and what risks are unavoidable given current constraints.

**Collaborative standards:** Develop behavioral standards and expectations collaboratively between sharp end and blunt end rather than imposing top-down rules that don't reflect operational reality.

## Understanding our reactions to failure

Failure happens in all complex systems. To understand how failures occur, we first must understand our **reactions** to failure.

### Two approaches to failure

**Option 1 - Blame and deterrence:** Assume the single cause is incompetence. Respond by screaming at engineers to "pay attention!" or "be more careful!" This approach assumes the problem is motivation or character and that fear will prevent future failures.

**Option 2 - Learning and respect:** Take a thorough look at how the accident happened. Treat the engineers involved with respect. Learn from the event by understanding the context and circumstances that made the actions seem reasonable at the time.

### Why learning works better than blame

**Blame provides false comfort:** Blame makes us feel like we've taken action. We identified the "cause" (the person) and addressed it (through punishment or training). This feels like problem-solving but doesn't improve system safety.

**Learning improves systems:** Learning requires more work but produces lasting improvements. By understanding how incidents happen, we can modify systems, processes, and environments to make different outcomes more likely.

**Respect enables honesty:** Treating engineers with respect encourages honest, detailed accounts. This honesty is essential for understanding failure mechanisms.

**Sustainable culture:** Learning-focused cultures are sustainable. Engineers remain engaged, psychologically safe, and willing to report issues early rather than hiding problems until they become critical.

## Implementing Just Culture in practice

**Start with leadership:** Just Culture must begin with leadership commitment. Leaders must demonstrate through actions that they value learning over blame.

**Train facilitators:** Train people to facilitate blameless post-mortem. This requires specific skills in asking questions that focus on circumstances rather than blame.

**Create psychological safety:** Build psychological safety gradually through consistent application of Just Culture principles. One punitive response can undo months of culture-building.

**Measure what matters:** Track metrics like time to detection, time to mitigation, and quality of post-mortem documentation rather than "who was responsible."

**Celebrate transparency:** Publicly recognize and appreciate engineers who provide transparent accounts of their actions during incidents. This reinforces that honesty is valued.

For more information, see also:

- [Brian Harry's Blog - A good incident postmortem](https://blogs.msdn.microsoft.com/bharry/2018/03/02/a-good-incident-postmortem/)
