It's critical that your apps respond rapidly to user requests. When a website is slow, visitors get frustrated quickly and will leave your site, perhaps to visit your competitors. How can you create an app that responds fast, even when a complex set of data is requested? One way to accelerate your app is to use a cache.

Imagine you work for an outdoor equipment retailer. Your new web app is in development and several microservices are approaching their first release, but some pages load too slowly. You want to find a way to increase their performance.

In this unit, you'll learn how caching can help to boost the speed of a web app.

## What is Redis?

Redis is an open source in-memory information store. Its name is short for **Remote Dictionary Server**. Perhaps the most important feature of Redis is its low latency for both read and write operations, which it achieves by virtue of its design and the fact that it holds all information in memory. Redis includes database and message broker functionality but is widely recognized as a caching system.

### How a cache improves performance

Caches can be used to improve the performance of many systems that take time to construct responses to their users. Consider, for example, an e-commerce web site, constructed from microservices. When a user wants to know what items are in their shopping basket, the system might:

1. Receive the request in the web app microservice.
1. Call the authentication microservice to check the users' identity if they're logged in.
1. Call the shopping basket microservice to find out what items and what quantities are in the basket.
1. Call the product catalog microservice to obtain full details of each product.
1. Call the images microservice to obtain image blobs for each product.
1. Call the stock taking microservice to check stock levels.
1. Call the shipping microservice to calculate shipping costs for the user's location and preferences.

The precise steps may differ depending on your design and business functionality but you can see that the process may be complex and involve many separate microservices and backing services. Although each microservice should be configured and resourced to perform well, the construction of the response inevitably consumes some time.

Now imagine that the user refreshes the page. Instead of reconstructing the entire HTML response from scratch, if the page or portions of it had been stored in a cache, it can be returned to the user much faster than the original request. This rapid response helps to make a web app more responsive and welcoming for users.

### Cache considerations

When you use caching, a key design decision is how long to cache a particular piece of content for. In the shopping basket, for example, if you cached the completed basket page for an hour, during which other orders are likely to be placed, then the cached page will sometimes report out-of-date stock levels and users may have to wait longer than expected for delivery. If you cache the page for only one minute, you can be more confident that stock levels will be accurate but you may see little to no improvement in performance. Therefore, when you choose how long to cache information for, consider:

- How often does the information change? For example, stock levels may change multiple time in an hour but new products may only appear in the catalog every few months.
- How important is it that users see the up-to-date information? For example, stock levels may be fundamental but you may consider new product reviews less time critical.
- How often are you likely to receive requests for the information? Caching popular information yields a higher performance improvement because the system can serve it from the cache multiple times.

## Using Redis in .NET Aspire apps

Redis is a popular choice for caching in a cloud-native application. .NET Aspire provides three components that you can use to interact with a Redis service:

- **.NET Aspire StackExchange Redis component**: Use this component to interact directly with a Redis server. For example, you can use it to save and retrieve values in Redis database or subscribe to messages sent to a channel. Since this component isn't focused on caching, we won't consider it further in this module.
- **.NET Aspire StackExchange Redis output caching component**: Use this component to cache complete HTTP responses. 
- **.NET Aspire StackExchange Redis distributed caching component**: Use this caching component to store and retrieve data from a distributed cache. Distributed caching describes an architecture where multiple microservices or other client services share a single cache. 

## Learn more

- [Overview of caching in ASP.NET Core](/aspnet/core/performance/caching/overview)
- [Tutorial: Implement caching with .NET Aspire components](/dotnet/aspire/caching/caching-components)
- [StackExchange.Redis Basic Usage](https://stackexchange.github.io/StackExchange.Redis/Basics)
