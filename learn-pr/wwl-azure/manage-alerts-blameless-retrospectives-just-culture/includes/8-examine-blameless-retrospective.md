## What does it mean to have a blameless retrospective?

Anyone who has worked with technology at any scale is familiar with failure.

Failure cares not about the architecture designs you drudge over, the code you write and review, or the alerts and metrics you meticulously pore through. So, failure happens.

It's a foregone conclusion when working with complex systems. But what about those failures that have resulted from individuals' actions (or lack of action, in some cases)? What do you do with those careless humans who caused everyone a bad day?

Maybe they should be fired. Or perhaps they need to be prevented from touching the dangerous bits again. Or they need more training. It's the traditional view of "human error," which focuses on the individual's characteristics. Also called the "Bad Apple Theory" – get rid of the bad apples and the human error.

It seems simple, right? Organizations that have pioneered DevOps are shying away from this traditional view. Instead, these DevOps-practicing organizations want to view mistakes, slips, lapses, etc., from a learning perspective. Having a blameless Post-mortem on outages and accidents is part of it.

What does it mean to have a 'blameless' retrospective? Does it mean everyone gets off the hook for making mistakes? No.

Well, maybe. It depends on what "gets off the hook" means. Let me explain.

Having a **Just Culture** means that you're making an effort to balance safety **and** accountability. It means that by investigating mistakes, focusing on the situational aspects of a failure's mechanism.

In the decision-making process of individuals proximate to the failure, an organization can come out safer than it would usually be if it had punished the actors involved as remediation.

Having a "blameless" retrospective process means that engineers whose actions have contributed to an accident can give a detailed account of:

 -  What actions do they take at what time?
 -  What effects do they observe?
 -  Expectations they had.
 -  Assumptions they had made.
 -  Their understanding of the timeline of events as they occurred.

**And** that they can give this detailed account **without fear of punishment or retribution.**

Why shouldn't engineers be punished or reprimanded? Because if they fear being blamed, they might not provide the necessary details to understand the failure's mechanism, pathology, and operation.

This lack of understanding of the accident's occurrence guarantees that it ***will*** be repeated. If not with the original engineer, another one in the future.

If we use "blame" as the predominant approach, we implicitly accept that *deterrence* is how organizations become safer.

This is founded on the belief that individuals, not situations, cause errors.

It's also aligned with the idea there must be some fear that **not doing** one's job correctly could lead to punishment because the fear of punishment will motivate people to act correctly in the future. Right?

This cycle of name/blame/shame can be looked at like this:

 -  Engineer acts and contributes to a failure or incident.
 -  Engineer is punished, shamed, blamed, or retrained.
 -  Reduced trust between engineers on the ground (the "sharp end") and management (the "blunt end") looking for someone to scapegoat.
 -  Engineers become silent on details about actions/situations/observations, resulting in "Cover-Your-Mistake" engineering (from fear of punishment)
 -  Management becomes less aware and informed on how work is being performed daily. Engineers become less educated on lurking or latent conditions for failure because of the silence mentioned in the previous four.
 -  Errors are more likely, and latent conditions can't be identified because of the previous five.
 -  Repeat the first step.

We need to avoid this cycle. We want the engineer who has made an error to explain why (either explicitly or implicitly) they did what they did and why the action made sense to them then.

It's paramount to understand the pathology of the failure. The action made sense to the person when they took it because if it had not made sense, they ***wouldn't have taken action in the first place.***

The base fundamental here's something [Erik Hollnagel](http://www.erikhollnagel.com/) has said:

*We must strive to understand that accidents don't happen because people gamble and lose.*<br>*Accidents happen because the person believes that:*<br>*…what is about to happen isn't possible,*<br>*…or what is about to happen has no connection to what they're doing,*<br>*…or that the possibility of getting the intended outcome is worth whatever risk there is.*
