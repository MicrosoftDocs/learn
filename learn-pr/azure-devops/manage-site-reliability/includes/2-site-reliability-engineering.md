The Tailspin team is applying all of their DevOps skills to the delivery and deployment of their website. They're getting ready to move to the final stage and deploy to a production environment. The reliability of their web site is on their minds as they get ready to go live.

They'll use their CI/CD pipeline on Azure Pipelines to move their code to production, so they'll be publishing continuously. This means that there may be reliability issues. The web site needs constant monitoring and the team needs to be notified if there are problems.

Let's listen in as they discuss their concerns.

## The morning meeting

**Andy:** OK, folks, we're looking at a significant change coming up. We'll be making the production environment a part of our pipeline. There are many details to work out, but one issue I want to bring up is reliability. How do we make sure the production site is always reliable and always available?

**Tim:** I think one part of that question is who's going to be responsible. Someone needs to oversee the site on a daily basis and none of us has the time to do that. That's a job and it's called a site reliability engineer, or SRE.

That person is responsible for the site. They need to  oversee deployments, monitor overall performance, review error logs, troubleshoot problems, and respond to alerts.

**Andy:** I agree. In the interim, I think all of us will have to help out, but what we really need to do is hire someone. The real purpose of this meeting is to come up with a job description. What skills are we looking for? What tools should our SRE understand? What kinds of questions should we be asking?

## What is site reliability engineering?

The team is getting ready to hire an SRE. To hire the right person, they need to understand what SRE is.

Site reliability engineering (SRE) empowers software developers to own the ongoing daily operation of their applications in production. The goal is to bridge the gap between the development team that needs to ship continuously, and the operations team that's responsible for the reliability of the production environment. Site reliability engineering shifts the responsibility of production reliability to the SRE on the development team.

Site reliability engineers typically spend up to 50% of their time on the daily tasks that keep the application reliable and the rest of their time developing software.

A key skill of a software reliability engineer is that they have a deep understanding of the application. This includes knowledge of the code, how the application runs, how it is configured, and how it scales.

Some of the typical responsibilities of a site reliability engineer are to:

- Proactively monitor and review application performance.
- Handle on-call and emergency support.
- Ensure that the software has good logging and diagnostics.
- Create and maintain operational runbooks.
- Help triage escalated support tickets.
- Work on feature requests, defects, and other development tasks.
- Contribute to the overall product roadmap.
- Perform live site reviews and capture feedback for system outages.

## Site reliability engineering versus DevOps

DevOps builds a healthy working relationship between the operations staff and the development team. By breaking down the silos between the two, DevOps produces a more robust, reliable product.

Both SRE and DevOps are methodologies that address an organization's need for a way to manage the production environment. As you've seen in the previous modules, DevOps feedback systems can identify problems and alert the developers, who then solve the issue. With SRE, a person on the development team looks for issues with site reliability on a daily basis and is probably the person who solves those problems, as well. While DevOps teams would usually choose to leave the production environment untouched unless absolutely necessary, SREs will likely make changes.

## Site reliability engineering skills

The type of skills that are needed vary depending on the application, how and where it is deployed, and how it is monitored. For example, organizations that use serverless technologies won't need someone with in-depth knowledge of Windows or Linux systems management. However, these skills are critical to teams that use servers for deployments.

Other key skills for a good SRE focus on application monitoring and diagnostics. An SRE should have experience with application performance management tools like Application Insights. They should also understand application logging best practices and exception handling.

## The next step

**Andy:** OK, all of us are clear on what SRE is. Now, what skill set are we looking for?

**Tim:** Let's define that next. I have some ideas.
