As a final unit in this module, let’s talk about where to go from here if you're interested in exploring SRE. 

## Reading and watching

For more detailed information about SRE, the best source is a trio of books that have been published on the subject

1. [_Site Reliability Engineering: How Google Runs Production Systems_](https://shop.oreilly.com/product/0636920041528.do) (known as "The SRE Book")
1. [_The Site Reliability Workbook: Practical Ways to Implement SRE_](https://shop.oreilly.com/product/0636920132448.do) (known as "The SRE Workbook")
1. [_Seeking SRE: Conversations About Running Production Systems at Scale_](https://shop.oreilly.com/product/0636920063964.do)

(As a quick disclosure, the primary author of this module is the curator/editor of the third book)

Each of those books provides an important set of information:

- The SRE Book - provides a detailed explanation of how Google implemented SRE over the years.

- The SRE Workbook - a companion to The SRE Book that provides a more detailed explanation of not just the “what” of SRE at Google and a few other places, but the “how” and “why”.

- Seeking SRE - provides a more expansive view of the SRE world beyond its origin including information on how it has been implemented in other environments.

Make sure to read all three books with a critical eye. Not everything written in these books may apply to you and your organization. Take some time to identify the information that you're certain can provide some positive value. Think about which parts of your organization's culture and values can support SRE work as described and which might make it more challenging.

If you find you're more of a visual person, try watching the talk [Keys to SRE](https://www.usenix.org/conference/srecon14/technical-sessions/presentation/keys-sre) by Ben Treynor at the SREcon14 conference. Treynor provides a cogent explanation of what SRE (at least in the Google context) is. Other recorded talks on SRE from [this conference series](https://www.usenix.org/conferences/byname/925) and others can also be useful.

## Talk to other interested people

As important as reading up on SRE is, it can often be more important to talk about it with your peers. Having a discussion about your challenges, successes and failures around SRE can be crucial to gaining a nuanced understanding of the subject. 

There are many meetups and conferences that feature SRE content. Perhaps the most directly relevant is the globally distributed [SREcon conferences](https://www.usenix.org/conferences/byname/925) put on by USENIX (disclaimer: the primary author of this module is one of the cofounders of SREcon).

Even more SRE content is making its way to conferences like [Velocity](https://conferences.oreilly.com/velocity), [LISA](https://www.usenix.org/conferences/byname/5), and local DevOps conferences like [DevOps Days](https://www.devopsdays.org). Seek out this content and others interested in the subject  wherever you can find it.

## First steps at work

It's important to remember that SRE isn't an “all or nothing” proposition. If you want to start exploring how to bring SRE into your environment, you can begin to adopt SRE principles and practices in small steps.

Mikey Dickerson, is a well known SRE based on his work at what would become the United States Digital Service. They were responsible for saving healthcare.gov. He's proposed a hierarchy of reliability in homage to Maslow’s hierarchy of needs. It's quoted in the [Practices section](https://landing.google.com/sre/book/chapters/part3.html) of the first SRE book.

This hierarchy proposes that you must first get functional and trustworthy monitoring in your environment. Monitoring has to be a first step towards SRE for your environment as well. You can’t tell if something is reliable (or is getting better or worse) if you can’t measure it.

Once you have a monitoring platform you can trust, the next reachable step is to pick a service at work. Then, begin to have SLI and SLO conversations about it. Start simple. Create SLIs and SLOs for the service, implement them in your monitoring system and see what happens when you begin to pay attention to reliability using the SRE lens. These steps are a great place to start.
