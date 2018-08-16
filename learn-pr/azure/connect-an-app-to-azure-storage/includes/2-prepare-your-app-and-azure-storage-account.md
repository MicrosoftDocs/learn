## Motivation

So you have an idea for an application and you know you need to utilise a form of storage to store your application data. Like any good developer, you need to ensure you have made the right design considerations when choosing what form of storage to use.

You want something that is easy to use, applicable to your choice of language, reliable, fast and requires the least amount of complexity as possible.

## Design considerations

Azure Storage exposes functionality using a HTTP endpoint over the internet. What if that internet connectivity has problems? In addition, do I need to write code to create a request, communicate to the endpoint, and parse any response?

## Connectivity and Networking Issues

In an ideal world, a network is available 100% of the time and is always reliable, however this is not a realistic expectation. Since storage forms a core part of almost all applications, and Azure Storage APIs are exposed over the network, you will need to consider the impact of a network outage to your App. Following are some of the considerations to make when deciding on whether Azure Storage is well suited to your needs:

* Does your application expect that it can always maintain web connectivity?

If you are creating a web application, there is a often an assumption that web connectivity is always available, certainly at least to access the application in the first place. Assuming this fact certainly makes it easier to write applications as less code and complexity is required to handle offline scenarios. Non-web applications such as those installed on a desktop or mobile device, may not be able to make such assumptions and this is something to assess when designing your application. Those apps with assumed constant web connectivity should at least be able to deal with connectivity errors from time to time, such as network dropouts.

* Will your applications design and implementation support a degraded feature set if there is no web connectivity?

If your application is expected to be disconnected regularly, or at least operate in a disconnected state, will the application degrade gracefully without simply crashing or reporting an error and being unusable? This is an important consideration as there is a significant amount of effort and complexity in handling disconnected scenarios. You may be able to store certain parts of needed data locally on the device to allow offline operation. Will certain elements of the application need to be disabled until connectivity is restored? These considerations are very specific to the application and it is important to include this in the design and implementation early due to the effort involved in catering for this scenario.

## Communicating wth Azure Storage

When writing your application you typically do not want to overly concern yourself with writing code that deals with low level elements such as formatting data to send to services for processing. Often, libraries for clients to communicate with services such as Azure Storage are created to make this task considerably easier. However, not all languages have client libraries to support this.

* Is there an available client library for your technology stack of choice?

If not, are you content to create your own service endpoint access methods which usually involves a lot more effort?

If libraries are available, ensure that there is one available for your technology stack. If using more popular technology stacks such as .Net or Java, usually client libraries are available however if using less mainstream technology stacks such as Haskel or Scala this may not be the case. The amount of extra effort required when not using a provided client library can often be significant and needs to be factored into design and implementation of your application.

For the purposes of the rest of this module and to aid in simplicity, we will assume that we are creating a .NET Core console application that will always have internet connectivity, and is not designed for graceful degradation of functionality without it.
