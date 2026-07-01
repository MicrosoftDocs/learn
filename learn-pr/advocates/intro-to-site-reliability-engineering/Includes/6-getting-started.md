As a final unit in this module, let’s talk about where to go from here if you're interested in exploring SRE. 

## Reading and watching

For more detailed information about SRE, the best source is a set of books that have been published on the subject:

1. [_Site Reliability Engineering: How Google Runs Production Systems_](https://www.oreilly.com/library/view/site-reliability-engineering/9781491929117/) (known as "The SRE Book")
1. [_The Site Reliability Workbook: Practical Ways to Implement SRE_](https://www.oreilly.com/library/view/the-site-reliability/9781492029496/) (known as "The SRE Workbook")
1. [_Seeking SRE: Conversations About Running Production Systems at Scale_](https://www.oreilly.com/library/view/seeking-sre/9781491978856/)
1. [_Implementing Service Level Objectives_](https://www.oreilly.com/library/view/implementing-service-level/9781492076803/) by Alex Hidalgo — a focused, modern treatment of the SLI, SLO, and error budget material introduced earlier in this module.

(As a quick disclosure, the primary author of this module is the curator/editor of _Seeking SRE_.)

Each of those books provides an important set of information:

- **The SRE Book:** Provides a detailed explanation of how Google implemented SRE over the years.

- **The SRE Workbook:** A companion to The SRE Book that provides a more detailed explanation of not just the "what" of SRE at Google and a few other places, but the "how" and "why".

- **Seeking SRE:** Provides a more expansive view of the SRE world beyond its origin including information on how it has been implemented in other environments.

- **Implementing Service Level Objectives:** Goes deep on the practical work of defining, measuring, and acting on SLIs, SLOs, and error budgets.

Make sure to read these books with a critical eye. Not everything written in them may apply to you and your organization. Take some time to identify the information that you're certain can provide some positive value. Think about which parts of your organization's culture and values can support SRE work as described and which might make it more challenging.

If you find you're more of a visual person, try watching the talk [Keys to SRE](https://www.usenix.org/conference/srecon14/technical-sessions/presentation/keys-sre) by Ben Treynor at the SREcon14 conference. Treynor provides a cogent explanation of what SRE (at least in the Google context) is. Other recorded talks on SRE from [this conference series](https://www.usenix.org/conferences/byname/925) and others can also be useful.

## Talk to other interested people

As important as reading up on SRE is, it can often be more important to talk about it with your peers. Having a discussion about your challenges, successes, and failures around SRE can be crucial to gaining a nuanced understanding of the subject.

There are many meetups and conferences that feature SRE content. Perhaps the most directly relevant is the globally distributed [SREcon conferences](https://www.usenix.org/conferences/byname/925) put on by USENIX (disclaimer: the primary author of this module is one of the cofounders of SREcon).

Even more SRE content is making its way to conferences like [KubeCon + CloudNativeCon](https://www.cncf.io/kubecon-cloudnativecon-events/) and local DevOps conferences like [DevOpsDays](https://www.devopsdays.org). Seek out this content and others interested in the subject wherever you can find it.

## First steps at work

It's important to remember that SRE isn't an “all or nothing” proposition. If you want to start exploring how to bring SRE into your environment, you can begin to adopt SRE principles and practices in small steps.

Mikey Dickerson was part of the "tech surge" team that rescued HealthCare.gov in late 2013. That work led to the creation of the United States Digital Service (USDS), which Dickerson went on to lead. Dickerson, with other Google SREs, proposed a hierarchy of service reliability in homage to Maslow’s hierarchy of needs. It's quoted in the [Practices section](https://sre.google/sre-book/part-III-practices/) of the first SRE book.

This hierarchy proposes that you must first get functional and trustworthy monitoring in your environment. Monitoring has to be a first step towards SRE for your environment as well. You can’t tell if something is reliable (or is getting better or worse) if you can’t measure it.

Once you have a monitoring platform you can trust, the next reachable step is to pick a service at work. Then, begin to have SLI and SLO conversations about it. Start simple. Create SLIs and SLOs for the service, implement them in your monitoring system, and see what happens when you begin to pay attention to reliability using the SRE lens. These steps are a great place to start.

## Microsoft Learn next steps

If you want to continue with SRE on Microsoft Learn, consider:

- The [Manage site reliability](/training/modules/manage-site-reliability/) module, part of the [Develop a Site Reliability Engineering (SRE) strategy](/training/paths/az-400-develop-sre-strategy/) learning path, which goes deeper into operational ownership, monitoring with Azure Monitor Application Insights, and blameless postmortems.
- The [Reliability pillar](/azure/well-architected/reliability/) of the Azure Well-Architected Framework, which maps SRE-style reliability practices onto Azure workloads.
