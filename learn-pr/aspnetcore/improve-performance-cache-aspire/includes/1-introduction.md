Rapid responses to users are essential for any successful web application because users can't be expected to wait for longer than a few seconds. Regardless of the complexity of a request, if your site responds slowly, visitors are likely to click away, perhaps to your competitors' sites. Since responses often have common elements, one way to increase the performance of your app is to cache data or completed web pages. The app can satisfy subsequent requests by retrieving data from the cache instead of reconstructing it from scratch. Redis is an in-memory data structure with many capabilities. Its cache is popular for web applications and frequently used in cloud-native apps. 

Imagine you work for an outdoor clothing retailer. Your new public-facing ecommerce site, which is built from microservices and uses .NET Aspire, is approaching completion but you're not happy with its responsiveness. You want to investigate whether a Redis cache may solve this problem and remove the need to upgrade hardware or deploy extra containers.

In this module, you'll learn how .NET Aspire components make it simple to connect to a Redis system for caching data and output.

## Learning objectives

By the end of this module, you'll be able to:

- Choose a type of Redis caching for a specific performance optimization requirement.
- Use a Redis distributed cache to increase performance in a .NET Aspire app.
- Use a Redis output cache to store complete HTML responses in a .NET Aspire app.
