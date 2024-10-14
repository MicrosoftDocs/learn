Now that you're aware of some of the common pitfalls that can sabotage or at
least limit the value you can get from your post-incident reviews, the next
logical question is "what should you do instead?"

In this unit, you'll learn about four helpful practices that can improve
the post-incident analysis process.

## Practice 1: Run a facilitated post-incident review

You already know that a post-incident review isn't a document or
report—it's ideally a conversation—so it follows that just having a
single person write up a "postmortem" of what happened without any
discussion doesn't make for a helpful post-incident review. No matter how
knowledgeable or how deeply involved in the incident that person might be,
not much will be learned if everything comes from a single viewpoint.

Getting those who were involved in the incident together at the same time
is the first step. It's often helpful to have a facilitator at that
meeting who can help guide the discussion. Ideally, that facilitator should
be someone "neutral" who didn't actually participate in the incident
themselves. Everyone will learn more if the facilitator doesn't appear to have any preconceived ideas or a personal agenda in telling the story of
the incident.

The exact format for the meeting will depend on your team, scheduling, and
the nature of the incident, but here are some basic guidelines:

- **Meetings, not marathons**: The meetings don't have to be long. Generally,
    60 to 90 minutes is the maximum length of time most people can fully
    concentrate and participate effectively, so limit the meeting to not
    more than an hour and a half.
- **Pre-meeting prep**: To make better use of the meeting time, it can be
    helpful for the facilitator to prepare by conducting one-to-one
    interviews with some of the members of the responding team to get an
    overview of the incident and ideas about which topics to discuss in
    the meeting. Individual interviews can be reported back to the group if there's concern about interpersonal issues or personalities making the
    meeting difficult (or if individuals are uncomfortable presenting in
    front of the room for any reason).
- **Not required for every incident**: This is a learning process, and you're
    "learning to learn," so start small. You don't have to do this for
    every incident. You can pick and choose. You might want to start with
    smaller incidents or start with a review meeting only once per month.

The post-incident review meeting is an opportunity to find out what went
wrong, what was done right, and how you can better handle failures in the
future. The ultimate goal is to improve reliability.

## Practice 2: Ask better questions

You already know that language matters, and in the post-incident review,
this applies especially to the questions you ask. Objective questions will
usually elicit more useful answers.

_In particular, it's better to ask people "how" or "what" instead of
"why."_

When people are asked to explain "why" they did something or "why"
something happened, it tends to put them on the defensive. Beginning a
question with "why" often comes across as a judgment, criticism, or
accusation. It forces people to justify their actions, and people don't
always know why they did something or why something happened as a result
of their actions. It can also lead people to jump directly to a problem
cause or a conclusion, skipping over a wealth of information that could be
discussed. For example, if you ask "why did the system stop working?" the
answer could be "Because the disk filled up." This skips right over
important questions like "how did you notice there was a problem with the
disk?" or even "what was the first thing you checked on the system what led
you to check it?"

This doesn't mean you can't explore the contributing factors for the
incident or the reasoning a person used to decide what to do in response to
them, it just means you should pay attention to how you word those
questions:

Don't ask "why did you do that?"

Instead, ask "_what factored into your decision to make that change?_"

Don't ask "why wasn't this caught in canary?"

Instead, ask "_how effective is canary at catching this sort of issue,
usually?_"

Remember that the post-incident review is about learning. Each participant
in the incident is likely to have a slightly different view of the
events. You'll learn more if you ask questions that expose these multiple
views and interpretations.

You'll often learn as much by asking about how work "normally" happens as
you will by asking about the specific incident.

To learn more about how to ask better questions, check out this resource:

[The Etsy Debriefing Facilitation Guide](https://extfiles.etsy.com/DebriefingFacilitationGuide.pdf)

## Practice 3: Ask how things went right

When you think about learning from failure, you may forget that even within
a major outage or other incident, in addition to the things that go wrong,
there are also things that go right. Far from our view of incidents as
one-offs or products of extreme conditions, in most complex systems things
go wrong for many of the same reasons they go right.

It's human nature to focus your questions on the negative side of the
equation. However, also asking about how things went right will provide you
with insights that you would not have gotten otherwise.

Don't just ask how the outage happened, _ask about how you recovered, too._

You will want to know what insights, tools, skills, and people helped in
the recovery effort. These are things you want to be able to reproduce, so
this information is valuable in planning what to do going forward.

In this context, you want to ask how people came to know what they knew and
on what basis they made the decisions they made. Was there a critical
moment when someone shared a piece of information that helped unlock the
puzzle of what was happening? How did they know to do that? Where did the
information come from?

Look for themes and patterns. Finally, as part of recognizing what went
right, ask "What do you know now that you didn't know previously?" If
learning resulted from the incident and from the incident response and
review processes, that's another thing that went right.

This comes back to an earlier point: we have as much to learn about how to
improve our ability to respond, as we do about how to prevent outages.

## Practice 4: Keep review and planning meetings separate

After you've resolved the immediate incident, you're naturally going to
want to talk about repair items and future mitigation (and you should), but these topics _shouldn't_ be a part of your post-incident review
meeting. Your post-incident review meeting has a purpose, and allowing the
discussion of repair items into that meeting distracts from that
purpose.

The best plan is to discuss repair items and planning issues in a separate
meeting a day or two after your post-incident review. You might want to do
this with a smaller group.

This will help in two ways:

- It will help you in the post-incident review. It's easier to avoid
    jumping to conclusions if you're not focused on how to fix it.
- Allowing a day or two of soak time will help you to identify the most
    "energy-efficient" repair items; minimum energy for maximum impact.
    Your subconscious can help you; you just need to give it time.
