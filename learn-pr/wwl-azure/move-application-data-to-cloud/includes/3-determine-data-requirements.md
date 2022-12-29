When it comes to data, there's no one-size-fits-all in terms of the type of storage you may need. For example, an online retail website has many distinct data sets that are all used to run the business: product catalog data, media files like photos and videos, and financial business data. Each data set has different requirements, and it's your job to figure out which storage solution is best. The key factors to consider in deciding on the optimal storage solution are: how to classify your data, how your data will be used, and how you can get the best performance for your application.

Let's look at these different types of storage. It will be up to you to classify your data but you'll learn what types Azure supports so you can optimize the storage needs for your situation.

## Structured data

Structured data, sometimes referred to as relational data, is data that adheres to a strict schema, so all of the data has the same fields or properties. The shared schema allows this type of data to be easily searched with query languages such as SQL (Structured Query Language). This capability makes this data style perfect for applications such as CRM systems, reservations, and inventory management. Structured data is often stored in database tables with rows and columns, and with key columns to indicate how one row in a table relates to data in another row of another table.

## Semi-structured data

Semi-structured data is less organized than structured data, and isn't stored in a relational format, as the fields don't neatly fit into tables, rows, and columns. Semi-structured data contains tags that make the organization and hierarchy of the data apparent - for example, key/value pairs. Semi-structured data is also referred to as non-relational or NoSQL data. The expression and structure of the data in this style is defined by a serialization language.

For software developers, data serialization languages are important because they can be used to write data stored in memory to a file, sent to another system, parsed and read. The sender and receiver don’t need to know details about the other system, as long as the same serialization language is used, the data can be understood by both systems. Examples of semi-structured data are XML, JSON, and YAML. This type of data can be useful when building a shopping cart as an example.

## Unstructured data

The organization of unstructured data is ambiguous. Unstructured data is often delivered in files, such as photos or videos. The video file itself may have an overall structure and come with semi-structured metadata, but the data that comprises the video itself is unstructured. Therefore, photos, videos, and other similar files are classified as unstructured data.

Examples of unstructured data include:

- Media files, such as photos, videos, and audio files
- Office files, such as Word documents
- Text files
- Log files

Once you've identified the kind of data you're dealing with (structured, semi-structured, or unstructured), the next step is to determine how you'll use the data. For example, as an online retailer you know customers need quick access to product data, and business users need to run complex analytical queries. As you work through these requirements, taking your data classification into account, you can start to plan and optimize your data storage solutions.
