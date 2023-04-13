Azure CDN provides Adatum with many features that'll ensure that the services can scale globally to meet emergency services demand during monitored natural disasters. Azure CDN helps Adatum meet its needs in the following way:

Azure CDN assists with large scaling to better handle instantaneous high loads. This functionality is useful for Adatum because it'll ensure that emergency services are able to access imagery as a disaster unfolds, and it'll minimize the chance that Adatum's services become unavailable during a disaster.

You can deploy Azure CDN resources in locations close to new customers as those customers subscribe to the service. Instead of deploying new IaaS VMs to host catastrophe imagery around the world, Adatum can configure a new POP in a location close to where the new customers are.

Azure CDN allows content to be delivered to POPs that are close to where customers need to access that data. Adatum can ensure that a POP in Australia is populated with imagery related to an unfolding catastrophe in Australia, while a separate POP in South American can be populated with imagery related to events unfolding there. The traffic related to each region's POP can also be geo-filtered to ensure that data at the Australian POP isn't accessible to clients from outside the region, reducing the likelihood that demand will make the service unavailable.

## When not to use Azure CDN

CDNs are typically best suited to technologies that employ many large static files, such as photographic imagery. CDNs are most useful where you need the ability to serve files to a large number of simultaneous users worldwide, which is appropriate for Adatum because natural disasters don't occur according to predictable patterns. If Adatum's content was more dynamic, such as providing a service where satellite video was being streamed directly from Adatum servers, Azure CDN wouldn't provide significant advantages. This is because real-time live streaming doesn't benefit substantially from being cached in locations around the world in the way that static files, including pre-recorded video files, would.
