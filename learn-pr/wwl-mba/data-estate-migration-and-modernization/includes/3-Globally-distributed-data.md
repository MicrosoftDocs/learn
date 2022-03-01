### What is globally distributed data? 

Businesses need applications that are available to customers wherever they are around the world. With globally distributed data, applications can transparently replicate data anywhere in the world, enabling a fast response time and high availability.

Azure Cosmos DB (Microsoft’s NoSQL database) is a database for building fast, scalable applications with native support for NoSQL.

Azure Cosmos DB was built from the ground up with **global distribution** and **horizontal scale** at its core. It offers turnkey global distribution across any number of Azure regions by transparently scaling and replicating data wherever the users are. Organizations pay for what they use, and are supported by comprehensive service level agreements.

> [!TIP]
> Horizontal scaling refers to adding or removing databases in order to adjust capacity or overall performance, also called “scaling out.”

### How does globally distributed data work?

:::row:::
![Icon indicating play video](../media/video-icon.png)

:::column:::
Watch this video to learn more about globally distributed data and Azure Cosmos DB.

:::column-end:::
:::row-end:::

</br>

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RWqJBc]

### What does a globally distributed data architecture look like?

This diagram illustrates a typical global data architecture. High-availability and low-latency capabilities built into Microsoft global data centers enable access to users all over the world.

![Architecture diagram illustrating a typical global data architecture](../media/ic-gm05-diagram-5.png)

Now that you’ve learned how data flows in a typical global architecture, take a look at how Azure Cosmos DB is used.

### How is Azure Cosmos DB being used?

:::row:::
![Icon indicating play video](../media/video-icon.png)

:::column:::
Watch this video to learn how e-commerce retailer ASOS is using Azure Cosmos DB to enable new cloud applications.

:::column-end:::
:::row-end:::

</br>

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RWrrJr ]

To keep up with global growth and deliver the best possible online experience, ASOS transformed its e-commerce platform to run in the cloud.

### The ASOS recommendations engine

The ASOS recommendations engine supports offline training and scoring of a range of machine learning models. These models are used to calculate a product’s relevancy in real-time and determine the likelihood of a customer viewing, saving, adding to their cart, and ultimately buying a product.

The following diagram illustrates how the ASOS recommendations platform works.

![Architecture diagram of the ASOS solution](../media/ic-gm05-diagram-4.png)

Now that you have seen an application of globally distributed data through the example of ASOS, let’s move to our next topic: cloud scale analytics.
