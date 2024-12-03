Of all of the units in this module, this is certainly one of the most important. In this unit, we're going to consider a few ideas that could change the way we frame our understanding of what's important to monitor and why. For some people, this can radically change everything about how they think about monitoring to improve their reliability.

:::image type="content" source="../media/diagram-whole.png" alt-text="Diagram with the word reliability in a circle in the middle connected to circles at the end of each spoke, each circle contains a word relating to reliability from a previous unit.":::

## Reframing #1: Reliability from the customer’s perspective

We previously discussed aspects of reliability we might want to consider monitoring, but that only seemed to expand possible set of things we might monitor. Here's one idea that can help you zero in on what you should monitor for improving your reliability:

*Reliability has to be measured from the customer's perspective, not the component perspective.*

That's really important. You may want to read it again because it is that important. In the past, people would advocate for "monitor all the things!" If we could read a counter from it, graph a statistic, or put it on a dashboard, we thought we should monitor it. "Measure from the customer's perspective" is a much more specific dictum.

Let's look at a brief scenario that both demonstrates the point and drives it home.

### Scenario

You're in charge of running the e-commerce website for your company. You have a web farm with 100 server instances. Suddenly, 14 of these 100 instances stop working due to an operating system failure, a software update, a power fluctuation, or some other unexpected event. These 14 instances are now totally out of commission.

To review: 86 server instances are operational, 14 server instances are non-operational.

Which of the following is true in this situation?

A: It’s no big deal. You can deal with the problem at some point when you have time to address it.

B: It’s a serious matter. You should stop whatever you’re doing and get those 14 server instances back into service as soon as possible.

C: It’s an existential crisis for the business. You should notify C-level executives and call everyone into work to take care of the situation as fast as possible, even if it means getting them out of bed in the middle of the night.

Take a moment to think through this scenario carefully before answer and then read further. Do you think it's A, B, or C?

The correct answer is neither A, B, nor C; it’s "it depends." Or more precisely, "it depends on how your customers are experiencing this outage."

If you have engineered the site in such a way that no customers even noticed the back ends going down and the other 86 server instances are shouldering the load with no problems, then there’s no crisis here. It could be a SEV-3 or SEV-4 incident, possibly even just a support ticket.

If the outage rendered your entire business dead in the water and you're losing serious amounts of money for every minute those servers are down, that’s probably a good reason to push the big red button and scramble everyone. There could also be a middle ground where the answer will be "B."

Again, reliability has to be measured from the customer’s perspective, not the component perspective. That’s why the component count of "14 machines down out of 100,” although entirely accurate, was not the most important piece of information in this scenario from a reliability standpoint.

This idea holds true even when we talk about more traditional component-based monitoring. If you find out that the database server is running at 50% CPU load, is that good or bad? If it goes up to 90%, is that better or worse? If the service is running fine and the users are happy, 90% might be great because it means you've considerably improved your resource utilization. But if the users are complaining about how slow your application was running at 50% CPU load, 90% isn't likely to be an improvement.

## Reframing #2: Appropriate levels of reliability

To set this idea up correctly, we should take a quick look at its origin. This idea comes from site reliability engineering (SRE). We can extract several useful ideas (including the one for this section) just by closely examining the definition of SRE:

> [!NOTE]
> Site Reliability Engineering is an engineering discipline devoted to helping organizations sustainably achieve the appropriate level of reliability in their systems, services, and products.

There are three important words in this definition:

- **Reliability**: We've talked a considerable amount about the importance of reliability in the introductory unit, so we won't belabor the point here.

- **Sustainably**: In this context, "sustainably" refers to the role of people in all of this. It's crucial we create a sustainable operations practice. Reliable systems, services, products are built by people. If we don't do things to make sure that our work is sustainable—if we wake our people up at 3:00 AM every night with a page, if we don't give them time with their family, if they don't have the opportunity to spend time taking care of themselves—then there's no way they're going to be able to build reliable systems. SRE thinks it's important that we implement an operations practice that is sustainable over time so that our people are able to bring their best to the job.

- **Appropriate**: This is the word that can be a game changer for some people. Once upon a time in the operations world, our goal was to make sure that everything was up 24/7. We tried to keep everything up all day long, all week long, all month long, and all year long. It was never acceptable for something to go down. One of the things that site reliability engineering brought to the operations discussion was a notion that we should strive for an *appropriate* level of reliability instead.

Let's dive into this idea. A key point here is that 100% reliable is almost never the right goal. Except for certain exceptions like medical devices or aviation, we don't really need things to be 100% reliable; and in fact, 100% reliable isn't often possible.

Here's an example of "not even possible:" These days, we're all running systems that have dependencies on other systems. Maybe you're running a piece of software that has to call out to a payment processor or has to call out to on authentication system. If the payment processor isn't 100% reliable or the authentication system isn't 100% reliable, it can be very difficult for your system to be 100% reliable.

The other tricky thing about a goal of 100% reliable is that it means zero downtime. It also means zero chance to make changes that you think might possibly create any downtime. You don't get any headroom, something you're probably going to want and need.

It's useful to start thinking about things from the perspective of "what’s the appropriate level of reliability?" for a particular thing that you're trying to operate. To bring this back to the topic at hand, our monitoring will need to support this goal.

With these two frames in mind, let's get practical and see some tools that will help us achieve our goals.
