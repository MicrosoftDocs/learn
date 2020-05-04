Imagine that a news story has just been published about your one of your organization's recent product announcements. The additional publicity from the news story will undoubtedly bring a large influx of traffic to your website. Will your website be able to handle this traffic increase, or will the additional load cause your site to be slow or unresponsive?

In this unit, you'll look at some of the basic principles of ensuring outstanding application performance using scaling and optimization principles that make up the performance efficiency pillar.

## What is performance efficiency?

Performance efficiency is matching the resources that are available to an application with the demand that it is receiving. Performance efficiency includes scaling resources, identifying and optimizing potential bottlenecks, and optimizing your application code for peak performance.

Let's take a look at some patterns and practices that can be leveraged to enhance the scalability and performance of your application.

### Leverage scaling up and scaling out

Compute resources can be scaled in two different directions:

- Scaling *up* is adding more resources to a single instance.

    ![An illustration showing scaling up by adding resources to a virtual machine.](../media/scale-up.png)

- Scaling *out* is adding more instances.

    ![An illustration showing scaling out by adding instances to increase performance.](../media/scale-out.png)

Scaling up is concerned with adding more resources, such as CPU or memory, to a single instance. This instance could be a virtual machine or a PaaS service. The act of adding more capacity to the instance increases the resources that are available to your application, but it does come with a limit. Virtual machines are limited to the capacity of the host they run on, and hosts themselves have physical limitations. Eventually, when you scale up an instance, you can run into these limits, which restrict your ability to add further resources to the instance.

Scaling out is concerned with adding additional instances to a service. These can be virtual machines or PaaS services, but instead of adding more capacity by making a single instance more powerful, we add capacity by increasing the overall total number of instances. The advantage of scaling out is that you can conceivably scale out forever if you have more machines to add to the architecture. Scaling out requires some type of load distribution. This could be in the form of a load balancer distributing requests across available servers, or a service discovery mechanism for identifying active servers to send requests to.

In both types of scaling, resources can be reduced, which brings cost optimization into the picture.

Autoscaling is the process of dynamically allocating resources to match performance requirements. As the volume of work grows, an application may need additional resources to maintain the desired performance levels and satisfy service-level agreements (SLAs). As demand slackens and the additional resources are no longer needed, they can be de-allocated to minimize costs. Autoscaling takes advantage of the elasticity of cloud-hosted environments while easing management overhead. It reduces the need for an operator to continually monitor the performance of a system and make decisions about adding or removing resources.

### Optimize network performance

When you're optimizing for performance, you'll look at network and storage performance to ensure that their levels are within acceptable limits, because their performance levels can impact the response time of your application. Selecting the right networking and storage technologies for your architecture will help you ensure that you're providing the best experience for your consumers.

Adding a messaging layer in between services can have a benefit to performance and scalability. Adding a messaging layer creates a buffer for requests between services so that requests can continue to flow in without error if the receiving application can't keep up. As the application works through the requests, they will be answered in the order in which they were received.

### Optimize storage performance

In many large-scale solutions, data is divided into separate partitions that can be managed and accessed separately. The partitioning strategy must be chosen carefully to maximize the benefits while minimizing adverse effects. Partitioning can help improve scalability, reduce contention, and optimize performance.

Use caching in your architecture can help improve performance. Caching is a mechanism to store frequently used data or assets (web pages, images) for faster retrieval. Caching can be used at different layers of your application. You can use caching between your application servers and a database in order to decrease data retrieval times. You could also use caching between your end users and your web servers, by placing static content closer to the user and decreasing the time it takes to return web pages to the end user. This also has a secondary effect of offloading requests from your database or web servers, increasing the performance for other requests.

### Identify performance bottlenecks in your application

Distributed applications and services running in the cloud are, by their nature, complex pieces of software that comprise many moving parts. In a production environment, it's important to be able to track the way in which users utilize your system, trace resource utilization, and generally monitor the health and performance of your system. You can use this information as a diagnostic aid to detect and correct issues, and also to help spot potential problems and prevent them from occurring.

Performance optimization will include understanding how the applications themselves are performing. Errors, poorly performing code, and bottlenecks in dependent systems can all be uncovered through an application performance management tool. Often, these issues may be hidden or obfuscated for end users, developers, and administrators, but can have adverse impact on the overall performance of your application.

Look across all layers of your application and identify and remediate performance bottlenecks in your application. These bottlenecks could be poor memory handling in your application, or even the process of adding indexes into your database. It may be an iterative process as you relieve one bottleneck and then uncover another that you were unaware of.

With a thorough approach to performance monitoring, you'll be able to determine the types of patterns and practices that your architecture will benefit from.
