Anyone who has worked with technology at any scale is familiar with failure. Failure disregards the architecture designs you create, the code you write and review, or the alerts and metrics you carefully monitor. Failure happens regardless of preparation and effort.

Failure is inevitable when working with complex systems. But what about failures resulting from individuals' actions or inactions? What do you do with the humans who caused everyone a difficult day?

## The traditional blame-focused approach

**Common reactive responses:** Traditional organizations often respond to human error with punishment:

- Fire the person responsible.
- Prevent them from accessing critical systems.
- Mandate additional training as remediation.

**Bad Apple Theory:** This traditional view of "human error" focuses on individual characteristics. Remove the "bad apples" and you eliminate human error. The approach seems simple and intuitive.

**Why organizations are changing:** Organizations pioneering DevOps practices are moving away from this traditional view. Instead, these organizations view mistakes, slips, and lapses from a learning perspective. Having blameless post-mortems on outages and accidents is a fundamental part of this shift.

## What blameless retrospectives mean

**Clarifying the concept:** Does "blameless" mean everyone gets off the hook for making mistakes? Not exactly. It depends on what "gets off the hook" means.

**Just Culture foundation:** Having a **Just Culture** means balancing safety **and** accountability. By investigating mistakes and focusing on the situational aspects of a failure's mechanism and the decision-making process of individuals involved in the failure, organizations become safer than they would be if they had simply punished the people involved.

**The blameless process:** Having a blameless retrospective process means that engineers whose actions contributed to an incident can give a detailed account of:

- What actions they took at what time.
- What effects they observed.
- What expectations they had.
- What assumptions they had made.
- Their understanding of the timeline of events as they occurred.

**Critical safety component:** Engineers can give this detailed account **without fear of punishment or retribution.**

## Why punishment prevents learning

**Information loss through fear:** If engineers fear being blamed, they won't provide the necessary details to understand the failure's mechanism, pathology, and operation. They'll protect themselves instead of helping the organization learn.

**Guaranteed repetition:** Lack of understanding about how an incident occurred guarantees it **will** be repeated. If not with the original engineer, then with another engineer in the future facing similar circumstances.

**Flawed deterrence model:** Using blame as the predominant approach implicitly accepts that **deterrence** is how organizations become safer. This assumption is founded on several problematic beliefs:

- Individuals, not situations, cause errors.
- Fear of punishment motivates people to act correctly.
- Punishment prevents future mistakes.

**Research contradicts deterrence:** Decades of research in safety science, human factors, and organizational psychology demonstrate that deterrence-based approaches don't improve safety in complex systems.

## The cycle of blame and its consequences

The name/blame/shame cycle operates like this:

1. **Engineer acts and contributes to a failure or incident.**
2. **Engineer is punished, shamed, blamed, or retrained.**
3. **Reduced trust develops** between engineers on the ground (the "sharp end") and management (the "blunt end") looking for someone to blame.
4. **Engineers become silent** about details regarding actions, situations, and observations, resulting in "Cover-Your-Mistake" engineering driven by fear of punishment.
5. **Management becomes less aware** of how work is actually being performed daily. Engineers become less informed about lurking or latent conditions for failure because of the silence.
6. **Errors become more likely** and latent conditions can't be identified because of reduced communication and learning.
7. **Repeat step 1.**

**Breaking the cycle:** We must avoid this destructive cycle. We need the engineer who made an error to explain why (either explicitly or implicitly) they did what they did and why the action made sense to them at the time.

## Understanding human decision-making in context

**Actions made sense at the time:** Understanding the pathology of failure requires recognizing that the action made sense to the person when they took it. If it hadn't made sense, they wouldn't have taken the action in the first place.

**Local rationality:** People make decisions based on:

- Information available to them at the time.
- Their understanding of the system state.
- Their goals and priorities at that moment.
- Time pressures and competing demands.
- Their training and past experiences.

**What looks obvious in hindsight was not obvious before:** After an incident, with complete information and no time pressure, the "correct" action seems obvious. But the person making the decision didn't have this luxury. They worked with incomplete information, uncertainty, and time constraints.

## Fundamental principle from safety science

[Erik Hollnagel](http://www.erikhollnagel.com/), a leading researcher in safety science, explains:

_We must strive to understand that accidents don't happen because people gamble and lose._

_Accidents happen because the person believes that:_

_…what is about to happen isn't possible,_

_…or what is about to happen has no connection to what they're doing,_

_…or that the possibility of getting the intended outcome is worth whatever risk there is._

**Implications for retrospectives:** This principle fundamentally changes how we conduct incident reviews:

**Not asking "who made a mistake":** Instead, ask "what made sense to do at the time given the information, goals, and pressures the person was experiencing?"

**Not assuming recklessness:** Assume people were trying to do their jobs well. Understand the context that made their actions seem reasonable.

**Not focusing on individual blame:** Focus on the system conditions that contributed to the incident. What can we change in the system to make different outcomes more likely?

## What blameless doesn't mean

**Not accountability-free:** Blameless doesn't mean there's no accountability. Organizations still maintain standards and expectations. However, accountability focuses on learning and improvement rather than punishment.

**Not ignoring malicious actions:** Blameless retrospectives address honest mistakes, not intentional harm, sabotage, or violations of ethics. These situations require different responses.

**Not preventing consequences:** Blameless doesn't mean incidents have no consequences. It means consequences focus on system improvement rather than individual punishment. The organization might reassign responsibilities, change processes, add safeguards, or improve training based on what's learned.

## Building psychological safety

**Essential for blameless retrospectives:** Engineers must feel psychologically safe to share details without fear of punishment. Building this safety requires:

**Leadership commitment:** Management must demonstrate through actions, not just words, that honest mistakes won't result in punishment.

**Consistent application:** Apply blameless principles consistently, not selectively based on the incident's visibility or impact.

**Focus on learning:** Frame every incident review as a learning opportunity. What can the organization learn to improve?

**Celebrate transparency:** Recognize and appreciate when people are transparent about their actions and mistakes. This transparency is valuable for organizational learning.

**No subtle punishment:** Avoid subtle forms of punishment like reduced opportunities, damaged reputation, or diminished trust. These undermine psychological safety as effectively as overt punishment.
