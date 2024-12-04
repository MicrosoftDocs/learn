When an incident occurs, your first reaction probably isn't, "Hurray, a
learning opportunity!" Your immediate priority is figuring out what went
wrong and fixing it as quickly as possible, to reduce the impact on your
customers and end users, as it should be. This is the incident-response
process we discussed in another module in this learning path.

However, once the incident is resolved, it's important to follow up
and benefit from the experience. If we don't take the time to learn from
the incident, then it remains just a loss of time, money, reputation, and so on; but if that incident can be a source of information (in the way no other
source can) we can actually derive some benefit from it.

The post-incident review is part of the analysis phase of the incident-response lifecycle. Not all post-incident reviews are created equal. There
are different ways to approach the process, and too much focus on certain
aspects of the problem or framing questions in the wrong way can reduce the
value of the review.

In this unit, you'll start thinking about not only why, but also how you can
best learn from incidents. We'll expand on the "how" in subsequent
units.

## Complex systems fail

You must "learn to learn" from failure not in case your systems fail, but
because it's a certainty that your systems _will_ fail.

In the modern world, the majority of systems we work with today—especially in a cloud environment—are complex. They're composed of many
interconnecting parts that have to work together, and the overall system behavior comes from the interaction of those parts as much as from
the individual parts themselves.

_Reliability_ is the thread that runs throughout this learning path, but
complex systems are never one hundred percent reliable. Such systems behave
in interesting and counterintuitive ways. They're composed of many parts,
and often the system's behavior comes from the interactions among
those parts as much as from the parts themselves.

For a more in-depth discussion of this topic, a good resource is the paper
titled
[How Complex Systems Fail](https://how.complexsystems.fail/)
by Dr. Richard I. Cook. He's an anesthesiologist and researcher who's
spent decades working on safety in complex systems, specifically patient
safety in the healthcare system. In this paper, he explains what's common
to complex systems in all fields from healthcare to software operations.

Some of his key points are particularly relevant to the incident analysis
and post-incident review process:

- Complex systems contain changing mixtures of failure latent within
    them. It's impossible for your systems to run without multiple flaws
    being present. The failures change constantly because of changing
    technology, work organization, and efforts to eradicate failure. Your
    system is never functioning perfectly.
- Complex systems run in degraded mode. Complex systems are always
    running as "broken" systems. They keep "working" in that state because
    they contain many redundancies, and people can keep them functioning
    despite the presence of many flaws. System operations are dynamic, with
    components continually failing and being replaced.
- Catastrophe is always just around the corner. The complexity of these
    systems means major system failures are—in the long term—unavoidable. Complex systems always possess the potential for
    catastrophic failure, and it can happen at any time. It'ss impossible
    to eliminate this potential because it's part of the inherent nature of
    the system.

## Prevention and response

In your efforts to achieve your desired level of reliability for your
systems and services, you do everything possible to prevent incidents from
occurring. However, due to the complexity of those systems, as explained
previously, prevention isn't always possible.

Because of this realization, we have to take a two-pronged approach to
failure: prevention, and when that isn't possible, preparation to respond quickly and effectively.

Prevention and response are interlinked. You might have experienced this when
your organization deployed a sophisticated piece of automation that worked
most of the time. It was great that it worked most of the time, but when it
failed, it probably failed spectacularly, and made it harder for operators
to understand what had gone wrong.

The systems you work on are made up of more than the technology. In fact,
you don't work "on" or "with" a system; you work _in_ the system. You're
part of the system. Complex systems include both technical components
(hardware, software) and human components (people and their
personalities, training, and knowledge). Our systems are systems that
include humans, and how the humans respond when things go wrong is _as_
important as preventing things from going wrong in the first place.

## Language

Language matters. You'll learn in this module that we'll be very specific
about what terms we use and what ones we intentionally don't use.

The words we use affect how we think about what happened in an incident,
and can drastically change what and how much we learn. This finding comes
from research in safety-critical industries such as aviation,
medicine, search and rescue, firefighting, and more.

Collectively, this field of research has become known as _Resilience
Engineering_ (RE).

We have a lot to learn about Resilience Engineering in the tech sector.
Later in this module, we'll share some really useful stuff we've
learned from the RE literature, including four of the most common traps
people fall into when attempting to learn from failure; but first, we need
to define some terms.
