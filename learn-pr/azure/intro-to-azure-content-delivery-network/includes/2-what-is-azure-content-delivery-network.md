Azure Content Delivery Network is a distributed network of servers that's used to cache and store content that can be accessed by computers requesting it around the world. Geographic distance between a website user and the server hosting the website can be a major contributor to latency. Azure Content Delivery Network servers are in locations that are close to end users to minimize latency. Instead of the lag required to retrieve a large file from a single location that might be on another continent or in another hemisphere, Azure Content Delivery Network allows a client requesting such content to retrieve it from the location to which they have the lowest latency and highest bandwidth connection. The server locations that host content repositories are referred to as *point-of-presence (POP)* locations. The use of a content delivery network is transparent to users of your website.

Azure Content Delivery Network can also accelerate dynamic content that can’t be cached by using various network optimizations using content delivery network POPs, such as route optimization to bypass Border Gateway Protocol (BGP).

The benefits of using Azure Content Delivery Network to deliver website assets include:

- Better performance and improved end-user experience, especially when using applications in which multiple round trips are required to load content.
- Large scaling to better handle instantaneous high loads, such as the start of a product launch event.
- Distribution of user requests and serving content directly from edge servers so that less traffic is sent to the origin server.

Azure Content Delivery Network offers the following features:

- **Dynamic site acceleration**: Speed up the delivery of dynamic files.
- **HTTPS custom domain support**: Enable encrypted connections to custom domains, such as `https://www.adatum.com`.
- **Azure diagnostics logs**: View core analytic information and send the data to an Azure Storage account, Azure Event Hubs, or a Log Analytics Workspace.
- **File compression**: Increase performance by reducing the number of bytes in transit.
- **Geo-filtering**: Create rules on your Content Delivery Network endpoint that use specific paths to allow or block content in select countries or regions.
