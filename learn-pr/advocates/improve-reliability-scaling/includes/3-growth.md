You’ve probably heard the saying that _preparation is the key to success._
This is especially true in relation to smooth, successful, reliable growth.

One of the biggest advantages of cloud computing is the ability to scale.
This has led some to the erroneous assumption that there is no need for to
prepare or plan for growth in the cloud because it has infinite scale.

It’s true that there are most likely more than enough resources in the
cloud to meet your application’s demands. However, it is still important
for you to understand your capacity needs. There are a couple of reasons
for this:

-   Although there are probably plenty of resources in the cloud to meet
    your needs, not all of the services you consume scale automatically or
    are inherently scalable. Thus, you will need to be aware of service
    limits and know when you’re going to need to scale things up.

-   Whereas cloud resources might be unlimited, your budget probably isn’t.
    You have to consider cost, and your friends in the Finance department
    will want to know your forecasted cloud spend.

## Plan for organic growth

_Organic growth_ in the business world refers to the process by which
organizations expand their own capacity, relying on intrinsic resources and
skills to fuel a slower, more natural growth.

The first thing you should do when looking to plan for capacity in the
cloud as your business grows organically is to map out the current resource
requirements for the larger components in your application.

## SCENARIO: Organic Growth

Let’s return to the architecture we saw early in this module. Tailwind
Traders is about to launch an innovative new product and is anticipating
dramatic growth as a result. Just to remind you, here's what their
architecture diagram looks like:

PLACEHOLDER slide 22

To begin capacity planning, you need to identify the larger components. In
this example, that would include:

-   The Azure Kubernetes Service cluster

-   The Rewards app running in Azure App Service

-   Various databases, such as Cosmos DB, Azure SQL and the like.

For each of these large components, you need to understand what the current
resource usage is, to help you plan for future usage. Let’s walk through
one of these as an example.

### Measure capacity in Cosmos DB

In Cosmos DB, storage is measured in gigabytes and scales automatically,
although you will still need to be aware of the measurements for cost
reasons.

Throughput is pre-provisioned, and you use a metric called _Request Units_
to measure this. Request Units (RUs) are a mixture of memory, CPU and IOPS.
This gives you a single metric by which you can plan capacity. You
provision request units in increments of 100 request units per second.

Every DB operation is measured in RU/s. Reads are simple: 1KB read is a
single Request unit. Other operations are calculated based on a number of
factors, such as item size, data consistency, query patterns, and so forth.

When profiling your application, every response from Cosmos DB contains the
request charge header, telling you exactly how many Request units that
request used. You can compare the number of request units being used to the
number that are provisioned to verify that you have more than enough
current capacity.

It's good to correlate your resource usage to a business metric such as
monthly active users or revenues. This helps you plan for capacity based on
how you expect the business to grow. You can retrieve these capacity
metrics in Azure Monitor. Understanding the system’s resource usage helps
you know when you will need to scale up as well as what your costs will be
over time.

So let's get concrete and look at the data from Tailwind Traders use of
CosmosDB. Here is a graph of their usage:

PLACEHOLDER slide 28

In this example, Tailwind traders are growing at an average of 2,500
monthly active users (MAUs) with a current user base of 10,000.

If we look at storage:

PLACEHOLDER slide 29

We can see their database is using 300GB of 5TB available (6%) It is
growing at 1% or 50GB/Month.

From a throughput perspective, it is sitting at 300/1000 and growing at
10%/month:

PLACEHOLDER slide 30

Understanding our systems resource metrics, means we know when we're likely
going to have to scale our throughput. And also what our costs will be over
time.

So this allows us to produce a graph that helps us with capacity planning:

PLACEHOLDER slide 31

So now we know that in June we're going to reach capacity of RUs on our
database. so we'll need to scale before then. One other interesting insight
is that they could maybe even scale down their CosmosDB database right now
as they aren’t using anywhere near the pre-provisioned capacity.

### Plan for inorganic growth

In the example above, you were planning for organic growth. _Inorganic
growth_ arises from external factors rather than an increase in the
company’s own business activities. Instead of being a natural progression,
it tends to involve a more sudden and larger increase in usage.

Sometimes, you really don’t know ahead of time about an increase in
traffic, users, etc. In anticipation of such cases, you need to build your
system to be as scalable as possible automatically and to fail gracefully
when that isn’t possible. We will address that later in this module.

But other time, as with a big upcoming product launch, you may experience
inorganic growth for which you can plan and prepare. If your teams work
together across engineering, product, marketing and finance, and more,
given your resource usage and growth patterns that you now know how to
obtain, you can make a reasonable effort to predict the impact of these
events on your resource requirements and implement change accordingly.

Getting this right will likely be specific to your organization and the
particular event. You may not always get it right but being as prepared as
you can be will give you a head start.

### SCENARIO: Inorganic Growth

Let’s look at another hypothetical situation as an example of planning for
inorganic growth: There is an upcoming marketing event for the launch of a
high-profile innovative new product at Tailwind Traders. They are expecting
that to drive five thousand more users to their sales site.

If you use the data from the previous example of organic growth, and
correlate that (hopefully with causation) to a business metric you have
obtained from your product/marketing teams – number of users – you can
start to plan for inorganic growth.

You know from the previous scenario that per twenty-five hundred users,
that’s approx. 50GB of storage and 100 Request Units. You can now use that
data and determine whether you’re ready for this event. If we can expect
5000 users, that's going to require 100GB storage and 200RU/s.

PLACEHOLDER slide 34

We can see that their storage capacities are more than sufficient for the
growth expected in the event. These scale automatically for you, so there's
no worry here except for understanding the new costs, which will be
addressed later.

You can also predict that their Request Units will only reach 50% capacity
following the event, so they have no worries in terms of Cosmos DB capacity
for this event.

There will, however, be an impact on cost.

PLACEHOLDER slide 36

You can see that the 100GB of extra storage is going to cost an additional
$25/month. The throughput price stays the same as customers pay for provisioned
request units, and they already have more than enough. Bottom line: this
marketing event is likely to increase their CosmosDB bill by $25
USD.
