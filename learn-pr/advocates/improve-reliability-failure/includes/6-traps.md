The roadmap we've discussed to help you get started with the post-incident
review process is helpful, but it can also be useful to know about some of
the obstacles you might encounter on this journey.

In this unit, you'll find out about some common traps that others have
fallen into during the post-incident review process and how to avoid them.

## Trap 1: Attribution to "human error"

You might recall that "pilot error" (also known as "human error") was the
conclusion the initial investigators reached in the B-17 story we started
in the module introduction. Let's return to that story.

In that intro, we suggested that the conclusions reached might be
dissatisfying to you. They were definitely dissatisfying to Alphonse
Chapanis, a military psychologist who was asked by the US Air Force to
investigate these incidents. He noticed, among other things, that these
accidents were unique to the B- 17 and a small amount of other aircraft.
There were thousands of C-47 transport aircraft in use in Western Europe at
the same time, yet no C-47 had ever experienced a similar incident.

So he interviewed pilots, and based on what he heard from them, he
went and looked at the B-17 cockpits. What he saw there were two switches:
the gears switch and the flaps switch. The switches were about 3 inches
apart from one another in the cockpit. Their mode of operation was
identical. They were simply too easy to confuse for one another, and that's
what had happened in these incidents. If you've just landed a plane, your
flaps are going to be extended, and before you park, you're going to
retract them. And so Chapanis tried something different.

He glued a little rubber wheel to the switch for the gear, and a hard
angular "flap" to the switch for the flaps, and sure enough the accidents
stopped happening.

He's now known as one of the founders of the field of ergonomics—the study
of design factors in human performance—and he had a simple
observation: the design of the cockpit could affect the likelihood of
human error. This approach has gone on to inform the design of all modern
aircraft. The two switches in current airplanes are now very distinct, as
mandated by federal law in the US.

So, why did we tell you this story?

Humans make mistakes. However, _human error_ isn't a cause; it's a
symptom. When human error is deemed to be the reason for a failure, people
stop there instead of further analyzing the incident.

System design, organizational context, and personal context all affect
when, how, and with what impact people make mistakes. "Human error" is a
label that causes you to quit investigating at precisely the moment when
you're about to discover something interesting about your system.

The problem with the "human error" conclusion in investigations is that it
causes you to lose sight of the fact that what the humans did made sense to
them at the time. Mistakes, by definition, aren't deliberate, so they
didn't intend to make a mistake.

When we see or hear "human error," it's a signal that we need to look
deeper. If we want to learn, we must not stop investigating when we find a
human error, as we so often do. As the story of the B-17s demonstrates,
just beyond the human error is where we learn interesting things about our
system.

## Trap 2: Counterfactual reasoning

_Counterfactual_ means "contrary to facts," and _counterfactual reasoning_
refers to telling a story about events that didn't happen in order to
explain the events that did. This doesn't make much sense, even though
people have a tendency to do it all the time.

You can identify counterfactual statements by key phrases:

- Could have
- Should have
- Would have
- Failed to
- Didn't
- If only

Some examples of counterfactual statements related to post-incident
reviews:

"The monitoring system failed to detect the problem."

"The engineer didn't check the validity of the configuration before
enacting it."

"This could have been picked up in the canary environment."

The problem with this type of reasoning in a post-incident review is that
you're talking about things that didn't happen instead of taking the time
to understand how what did happen, happened. You don't learn anything from
this speculation.

## Trap 3: Normative language

_Normative language_ often implies that there was an "obviously correct"
course of action that operators should have taken, and judges the actions of
those operators with the benefit of hindsight.

Normative language can usually be identified by adverbs such as
"inadequately," "carelessly," "hastily", and so forth.

Normative thinking leads you to judge decisions based on their outcomes.
This way of speaking isn't logical, because the outcome is the _only piece
of information that wasn't available_ to those who made the decisions and
judgments.

Normative language can also be used in the opposite sense. People can
praise operators for having acted "appropriately," for example. But again,
often this judgment is made with the benefit of information the people in
question didn't have.

The problem with normative language is similar to the problem with
counterfactual reasoning: if we make judgments after the fact using
information that was unavailable to the humans involved during the
incident, we neglect to understand how the actions of the operators
made sense to them at the time.

## Trap 4: Mechanistic reasoning

_Mechanistic reasoning_ refers to the concept that a particular outcome can
be inferred from intervention. It's sometimes called the _meddling kids
syndrome_ (coined by Jessica DeVita) based on the premise that "Our system
would have worked fine...if it hadn't been for those meddling kids."

When you use mechanistic reasoning in your post-incident review, you build
your conclusions on the fallacy that the systems you work with and within
are basically working correctly, and if only those "meddling kids" hadn't
done whatever they did, the failure wouldn't have occurred.

However, that's not how systems work.

To illustrate this point, imagine the following scenario: You work on a
production service. Now you're told that you aren't allowed to touch or do
anything to that service. Everything outside your team continues as before: customers continue to use the service, external dependencies continue to
change, the Internet functions normally.

But you can't make any changes to the code or configuration. No
deployments, no control plane operations, nothing.

Do you think your service would still be running as expected after a day?
After a week? After a month? After a year? How long could you realistically
expect your service to keep running without human intervention? In the vast
majority of cases, it wouldn't.

This thought exercise leads us to an important conclusion:

_Human adaptive capacity is necessary to keep our systems up and running_.

The only reason your systems remain up and running in the first place is
because of the actions of humans in the control loop. It's only through
human action and ability to adapt to changing circumstances that the system
continues to work.

Therefore, it's erroneous to conclude the system was "basically working...if it hadn't been for those meddling kids." In fact, the reliability of
your service isn't independent of the humans who work on it. Instead, it's
a direct result of the work that the humans do on it every day.

The problem with mechanistic reasoning is that it leads you down a path
where you believe that finding the faulty human is equivalent to finding
the problem. However, that same faulty human has been improvising and
adapting to keep the system running for weeks and months. Perhaps this role
is important enough to reflect on in your post-incident review.

Now that you know some things to avoid during a post-incident review, we
can move on to the next unit where we explore some of the helpful practices
for those reviews.
