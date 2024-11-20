Organizations today benefit from the accessibility, efficiency, and convenience of the cloud, but they face many challenges as they undergo a digital transformation that involves moving parts of their business onto cloud services.

Some of the common challenges that you might be facing in your organization include:

- Increased number of service disruptions
- No effective method of tracking and responding to incidents (everything is ad hoc and reactionary)
- Unacceptable time to resolution
- Time to resolution is not improving or is getting worse
- Information and status are difficult to find
- Recurrence of the same problems and mistakes

To meet these challenges, you need a well-defined incident response plan that's built on a solid foundation.

## Foundations and pillars

The purpose of a foundation is to hold up and hold together the structure above it. In a separate intro module to this learning path, we discussed the idea that reliability work is built on the foundational level of monitoring and that incident response rests just above that in the hierarchy.

Incident response also has a foundation itself. There are three pillars that support a good incident response plan:

- Rosters
- Roles
- Rotations

In this unit, you'll find out what each of these pillars is and what parts they play in designing an incident response strategy that moves you further along the path toward your reliability goals.

## Rosters

It's essential to have a good plan, but a plan is useless without people to execute it. Thus, the best place to start is by determining who's expected to respond to problems and how to let them know when their response is required.

The best way to address this challenge is to design a roster. A roster is a list of people who are assigned to the on-call team. This team should be made up of multiple engineers. These team members should have the knowledge and skills to address the type of problems that can occur in your environment, as well as training in incident response.

A list of names, however, is not enough. You need to build a framework around who's on call at any given point, and what each person is to do. That's where roles come in.

## Roles

Roles bring order to what would be a chaotic—or at best an ad hoc—response. It does this by defining the specific functions to be assumed by each person in a particular situation, and the place of each in the "chain of command." Roles may vary by organization or even by incident type, but the following roles should generally be part of an organized incident response team:

- **Primary responder**: This is the "point person" who's usually the first person on the scene; that is, the first on-call engineer who's called when an incident occurs.
- **Secondary responder**: This is someone who acts as a backup and can step in if the primary responder isn't available or if a second pair of eyes is needed.
- **Subject matter experts (SMEs)**: These are people who have in-depth knowledge about a particular facet of your operations. They're there if the primary and secondary responders need to escalate the problem to someone with more expertise. They're not on call all the time, but are available when their specialized skills are needed. You should maintain a list of SMEs in various subjects (for example, database, front-end, network infrastructure, web apps, cybersecurity, and so on).
- **Incident commander**: This is an important role in a large-scale incident or outage that impacts many different components and/or requires coordination across many different teams and systems. An incident commander will be the person who coordinates a lot of the conversation and the effort regarding the response and remediation activities. The incident commander keeps an eye on the "big picture"; they keep tabs on what's going on and who's doing what. An incident commander is great for making sure that engineers stay focused and that they're working on their own remediation efforts without stepping on or undoing each other's work.
- **Scribe**: The scribe's role is to document the conversation around the incident in as much detail as possible. Teams commonly use phone bridges, conference calls, or video chat to get everyone together and try to understand what's going on, which can certainly help create space for the conversation. However, it's difficult for us to go through and understand in detail what the engineers were saying and doing unless it's transcribed. As a result, a scribe is the person who can help us document as much as possible to review later. The scribe captures all the data possible; not just what team members are doing, but also what they're saying and even what they're feeling or experiencing.
- **Communication coordinator**: Think of this person as the "public relations manager" for the incident. The communication coordinator works in conjunction with the incident commander to share information about the incident with those who aren't involved in actively working to address and recover from the incident. This could include customers, sales and marketing teams, customer support, and any other stakeholders within or outside the organization who need to be made aware of what's taking place and the status of how the response and remediation are progressing.

## Rotations

Now you have your roster of response team personnel and have assigned the appropriate roles. The next and last step is to create a rotation, which is a schedule that assigns the shifts for which each person is on call.

There are many different ways of dividing up shifts. Shift scheduling can be a complex strategic process. Shifts shouldn't be assigned randomly; you should put some thought into scheduling to make it as effective—and as pleasant for team members—as possible.

Some methods for scheduling shifts include:

- **24 x 7**: This is a rotation in which team members are on call for several days in a row. This is a simple way to allocate shift coverage, but you must be careful to limit the duration. Shift rotations longer than three to four days can be detrimental to the overall health of the engineering staff, and thus reduces the reliability of the entire system.
- **Follow the sun shifts**: This is a shift model in which the engineers schedule their on-call shifts only during their normal working hours and then hand off their on-call responsibility at the end of their workday to another colleague located in a different time zone.

These are only a few examples of ways shifts can be assigned. The important point is to divide up shifts in a way that works best for the individuals on your response team. There are many ways to customize shifts, especially for weekends, when engineers need more flexibility. Engineers should be able to easily hand off the role to someone when non-work-related conflicts arise.
