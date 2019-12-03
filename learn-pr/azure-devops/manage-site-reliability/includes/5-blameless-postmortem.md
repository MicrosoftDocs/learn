copied from ILT

## A Blameless Post Mortem

Anyone who’s worked with technology at any scale is familiar with failure. Failure cares not about the architecture designs you slave over, the code you write and review, or the alerts and metrics you meticulously pore through. So: failure happens. This is a foregone conclusion when working with complex systems. But what about those failures that have resulted due to the actions (or lack of action, in some cases) of individuals? What do you do with those careless humans who caused everyone to have a bad day?

Maybe they should be fired. Or maybe they need to be prevented from touching the dangerous bits again. Or maybe they need more training.

This is the traditional view of “human error”, which focuses on the characteristics of the individuals involved. This is called the “Bad Apple Theory” – get rid of the bad apples, and you’ll get rid of the human error. Seems simple, right? Organizations that have pioneered DevOps are shying away from this traditional view. These DevOps practising organizations instead want to view mistakes, errors, slips, lapses, etc. with a perspective of learning. Having blameless Post-Mortems on outages and accidents are part of that.

A Blameless Post-Mortem

What does it mean to have a ‘blameless’ Post-Mortem?
Does it mean everyone gets off the hook for making mistakes? No.

Well, maybe. It depends on what “gets off the hook” means. Let me explain.

Having a Just Culture means that you’re making effort to balance safety **and**accountability. It means that by investigating mistakes in a way that focuses on the situational aspects of a failure’s mechanism and the decision-making process of individuals proximate to the failure, an organization can come out safer than it would normally be if it had simply punished the actors involved as a remediation.

Having a “blameless” Post-Mortem process means that engineers whose actions have contributed to an accident can give a detailed account of:

what actions they took at what time,
what effects they observed,
expectations they had,
assumptions they had made,
and their understanding of timeline of events as they occurred.
…and that they can give this detailed account without fear of punishment or retribution.

Why shouldn’t they be punished or reprimanded? Because an engineer who thinks they’re going to be reprimanded are disincentivized to give the details necessary to get an understanding of the mechanism, pathology, and operation of the failure. This lack of understanding of how the accident occurred all but guarantees that it will repeat. If not with the original engineer, another one in the future.

If we go with “blame” as the predominant approach, then we’re implicitly accepting that deterrence is how organizations become safer. This is founded in the belief that individuals, not situations, cause errors. It’s also aligned with the idea there has to be some fear that not doing one’s job correctly could lead to punishment. Because the fear of punishment will motivate people to act correctly in the future. Right?

This cycle of name/blame/shame can be looked at like this:

Engineer takes action and contributes to a failure or incident.
Engineer is punished, shamed, blamed, or retrained.
Reduced trust between engineers on the ground (the “sharp end”) and management (the “blunt end”) looking for someone to scapegoat
Engineers become silent on details about actions/situations/observations, resulting in “Cover-Your-Mistake” engineering (from fear of punishment)
Management becomes less aware and informed on how work is being performed day to day, and engineers become less educated on lurking or latent conditions for failure due to silence mentioned in #4, above
Errors more likely, latent conditions can’t be identified due to #5, above
Repeat from step 1
We need to avoid this cycle. We want the engineer who has made an error give details about why (either explicitly or implicitly) he or she did what they did; why the action made sense to them at the time. This is paramount to understanding the pathology of the failure. The action made sense to the person at the time they took it, because if it hadn’t made sense to them at the time, they wouldn’t have taken the action in the first place.

The base fundamental here is something Erik Hollnagel has said:

We must strive to understand that accidents don’t happen because people gamble and lose.
Accidents happen because the person believes that:
…what is about to happen is not possible,
…or what is about to happen has no connection to what they are doing,
…or that the possibility of getting the intended outcome is well worth whatever risk there is.

## Allowing Engineers to Own Their Own Stories

A funny thing happens when engineers make mistakes and feel safe when giving details about it: they are not only willing to be held accountable, they are also enthusiastic in helping the rest of the company avoid the same error in the future. They are, after all, the most expert in their own error. They ought to be heavily involved in coming up with remediation items.

So technically, engineers are not at all “off the hook” with a blameless PostMortem process. They are very much on the hook for helping become safer and more resilient, in the end. And lo and behold: most engineers I know find this idea of making things better for others a worthwhile exercise.

So what do we do to enable a “Just Culture”?

Encourage learning by having these blameless Post-Mortems on outages and accidents.
The goal is to understand **how **an accident could have happened, in order to better equip ourselves from it happening in the future
Gather details from multiple perspectives on failures, and don’t punish people for making mistakes.
Instead of punishing engineers, we instead give them the requisite authority to improve safety by allowing them to give detailed accounts of their contributions to failures.
Enable and encourage people who do make mistakes to be the experts on educating the rest of the organization how not to make them in the future.
Accept that there is always a discretionary space where humans can decide to make actions or not, and that the judgement of those decisions lie in hindsight.
Accept that the Hindsight Bias will continue to cloud our assessment of past events, and work hard to eliminate it.
Accept that the Fundamental Attribution Error is also difficult to escape, so we focus on the environment and circumstances people are working in when investigating accidents.
Strive to make sure that the blunt end of the organization understands how work is actually getting done (as opposed to how they imagine it’s getting done, via Gantt charts and procedures) on the sharp end.
The sharp end is relied upon to inform the organization where the line is between appropriate and inappropriate behavior. This isn’t something that the blunt end can come up with on its own.
Failure happens. In order to understand how failures happen, we first have to understand our reactions to failure.

One option is to assume the single cause is incompetence and scream at engineers to make them “pay attention!” or “be more careful!”
Another option is to take a hard look at how the accident actually happened, treat the engineers involved with respect, and learn from the event.

https://blogs.msdn.microsoft.com/bharry/2018/03/02/a-good-incident-postmortem/

https://stories.visualstudio.com/devops/
