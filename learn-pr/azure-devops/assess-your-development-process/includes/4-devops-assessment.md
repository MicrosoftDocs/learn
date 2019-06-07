Creating a Value Stream Map (VSM) helps you analyze your current release cycle process. The purpose of a VSM is to provide optimum value to the customer through the creation process with minimum waste. Let's see how Tailspin measures up.

Mara, who is new to the team, is going to create a quick value stream map so she can reflect on the existing processes. Creating this map will provide you with a greater understanding of where you fit in the DevOps maturity model. More mature teams typically release faster, with greater confidence, and with fewer bugs than less mature teams.

Being new to the team, Mara knows she doesn't understand everything so she's going to create a temporary VSM that will have some gaps and questions on the whiteboard in a conference room. She will share this with the team later. With the map in place, everyone on the team has a common starting point for identifying the first steps towards improving how Tailspin develops and releases their games.

Let's take a look at her map.

## Understand the current process

Mara gathers the team in the conference room to present her value stream map.

(Whiteboard of current process here with numbers to correlate with narrative)

**Mara:** A value stream map helps to measure where a process has value and where it is spending time with no value. Our map begins on the upper left with the functional specification for the software. We will follow just one feature through the process to see how it moves through the process currently. After that, we can create a value stream map of our ideal process.

*Eyes roll, but Mara presses on.*

### Development processes

Creating a new feature currently means creating a label in source control and starting from there. Currently we have one person that can do this, Andy. We request a label using an email and Andy waits until all code is checked in and stable to create the label. Once it is created, we get an email saying we can begin work. This process takes up to three days and has no value to the customer. Things with no value to the customer should take as little time as possible.

Coding a feature takes about four days for one person if we can get access to all the files we need. We need to be on the corporate network and not be blocked by source control. This time has value to the customer. They want this feature.

### Test processes

Once we decide that we have a stable build we update a spreadsheet to tell Amita that there is a build ready for testing and where to find it.

She manually tests the build. This process gets longer as the code grows. For now, let's say three days. She then emails Andy with bug reports.

Andy has to take time to triage the bugs and assign work.

### Operations processes

When Amita approves of a build, she hands it off to Tim. Tim needs to deploy this build to the pre-production servers for beta testers. Often, the test servers and pre-production servers are out of sync with the latest patches and installs that are needed to run the web site. It takes Tim about two days to deploy to pro-production.

Once a build is deemed ready for production, leadership needs to approve the release before it can be deployed. This happens in a meeting.

Eventually, Tim will deploy our feature and it will make it to the customer here on the upper right. Once again, the production server will have drifted out od sync with pre-production, so this will take Tim one day.

### Calculate the customer value metrics

So now we can look at the key performance metrics and see how we measure up. 

*Total lead time* is the time it takes for a feature to make it to the customer. *Process time* is the time spent on the feature that has value to the customer. *Activity ratio* is process time divided by the lead time. This is our **efficiency**. As you can see, we have a lot of room for improvement.

(some grumbling from the team)

**Tim:** So how does this help us? 

## Where do we go from here?

**Mara:** It helps to see where we are now so that we can minimize the waste. That is, the time we spend that has no value to the customer. I believe we can improve this number greatly by adopting a DevOps approach. We can automate a lot of this and cut down on the waste.

I'm not suggesting we drop our current processes, but I think we can work toward a more efficient process in small increments without disrupting what we have in place.

Let's look at just a couple of places where we can improve.

**Andy:** Might as well start at the beginning. It takes me a long time to get a label on the code so we can start the new feature. I have to literally walk around to the developers and beg them to check in what they have so we can build and test. If you can figure out how to speed that up you might have my attention.

Also, I noticed that you don't have time in there for the build itself. That is taking half a day right now. It would be nice to see that time improve.

**Amita:** And dev doesn't always update the spreadsheet to let me know there is a new build that needs testing. It would save time if there was some way to ensure that part gets done.

**Mara:** Great! I think DevOps can help us out with all of these concerns.

**Andy:** We don't have time to change the process now. You heard Irwin. We are in crisis mode here!

**Mara:** I understand your hesitation. Let's continue on the way we are for now. But think about your part in the process and we can revisit this in small steps along side our current processes. That will let us see if DevOps will help us without disrupting what we have. I'll keep this map and the performance metrics we have now. If we end up adopting DevOps practices we can come back to the numbers.
 