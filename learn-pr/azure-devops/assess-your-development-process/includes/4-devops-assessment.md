Creating a Value Stream Map (VSM) helps you analyze your current release cycle process. The purpose of a VSM is to provide optimum value to the customer through the creation process with minimum waste. Let's see how Tailspin measures up.

Mara, who is new to the team, is going to create a quick value stream map so she can reflect on the existing processes. Creating this map will provide you with a greater understanding of where you fit in the DevOps maturity model. More mature teams typically release faster, with greater confidence, and with fewer bugs than less mature teams.

Being new to the team, Mara knows she doesn't understand everything so she's going to create a temporary VSM that will have some gaps and questions on the whiteboard in a conference room. She will share this with the team later. With the map in place, everyone on the team has a common starting point for identifying the first steps towards improving how Tailspin develops and releases their games.

Let's take a look at her map.

## Understand the current process

Mara gathers the team in the conference room to present her value stream map.

(Whiteboard of current process here with numbers to correlate with narrative)

**Mara:** A value stream map helps to measure where a process has value and where it is spending time with no value. Our map begins on the upper left with the functional specification for the software. We will follow just one feature through the process to see how it moves through the process currently. After that, we can create a value stream map of our ideal process.

*Eyes roll, but Mara presses on.*

Creating a new feature currently means creating a label in source control and starting from there. Currently we have one person that can do this, Andy. We request a label using an email and Andy waits until all code is checked in and stable to create the label. Once it is created, we get an email saying we can begin work. This process takes up to 3 days and has no value to the customer. Things with no value to the customer should take as little time as possible.

Coding a feature takes about 4 days for one person if we can get access to all the files we need. We need to be on the corporate network and not be blocked by source control. This time has value to the customer. They want this feature.

Once we decide that we have a stable build we update a spreadsheet to tell Amita that there is a build ready for testing and where to find it.

She manually tests the build. This process gets longer as the code grows. For now, let's say 3 days. She then emails Andy with bug reports.

Andy has to take time to triage the bugs and assign work.

Meanwhile, Tim gets an email from Andy at some point with the requirements for the servers. Tim waits for hardware to be approved and ordered, and then begins setting up the servers. Say this takes 15 days. And I have no idea what to put here for scaling it out. Maybe Tim can speak to that later.

Leadership needs to approve a release before it can be deployed. This happens in a meeting.

Eventually, Tim will deploy our feature and it will make it to the customer here on the upper right.

### Calculate the value

So now we can look at the key performance metrics and see how we measure up. 

Total lead time is the time it takes for a feature to make it to the customer. Process time is the time spent on the feature that has value to the customer. Activity ratio is process time divided by the lead time. This is our efficiency. As you can see, we have a lot of room for improvement.

(some grumbling from the team)

**Tim:** So how does this help us? 

## What is the ideal process?

**Mara:** It helps to see where we are now so that we can minimize the waste. That is, the time we spend that has no value to the customer.

Over on the other whiteboard, I created an *ideal* VSM using DevOps. This is where we want to be eventually. Here, processes are fast and automated where it makes sense.

(Whiteboard with ideal process and calculations)

*The team's eyes get wide and the grumbling continues.*

Don't panic. I'm not suggesting we drop our current processes and adopt all of this. But I think we can work toward it in small increments without disrupting what we have in place.

**Tim:** I don't like the way the operations side looks at all. I will never agree to this.

**Amita:** I'm with Tim. There is no way QA can be automated. I need to have control of it.

**Andy:** And just how do you expect us to get builds out that fast? Can't be done. 

*Mara looks at the team.* I understand your concerns. Let's just continue where we are now, but keep this in mind as you work through Irwin's request. I think eventually you will see how we can improve a little here and there by incorporating DevOps in our processes.
