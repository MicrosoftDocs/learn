An online retail business has different types of data. Each type of data may benefit from a different storage solution. 

Application data can be classified in one of three ways: structured, semi-structured, and unstructured. Here, you'll learn how to classify your data so that you can choose the appropriate storage solution.

#### Approaches to storing data in the cloud

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEuY]

## Structured data

Structured data is data that adheres to a schema, so all of the data has the same fields or properties. Structured data can be stored in a database table with rows and columns. Structured data relies on keys to indicate how one row in a table relates to data in another row of another table. Structured data is also referred to as relational data, as the data's schema defines the table of data, the fields in the table, and the clear relationship between the two.

Structured data is straightforward in that it's easy to enter, query, and analyze. All of the data follows the same format.

Examples of structured data include:

- Sensor data
- Financial data

## Semi-structured data

Semi-structured data is less organized than structured data, and is not stored in a relational format, as the fields do not neatly fit into tables, rows, and columns. Semi-structured data contains tags that make the organization and hierarchy of the data apparent. Semi-structured data is also referred to as non-relational or NoSQL data.

#### What is NoSQL?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEvd]

Examples of semi-structured data include:

- Key / Value pairs
- Graph data
- JSON files
- XML files

## Unstructured data

The organization of unstructured data is generally ambiguous. Unstructured data is often delivered in files, such as photos or videos. The video file itself may have an overall structure and come with semi-structured metadata, but the data that comprises the video itself is unstructured. Therefore, photos, videos, and other similar files are classified as unstructured data.

Examples of unstructured data include:

- Media files, such as photos, videos, and audio files
- Office files, such as Word documents
- Text files
- Log files

Now that you know the differences between each kind of data, let's look at the data sets used in an online retail business, and classify them.

## Product catalog data

Product catalog data for an online retail business is fairly structured in nature, as each product has a product SKU, a description, a quantity, a price, size options, color options, a photo, and possibly a video. So, this data appears relational to start with, as it all has the same structure. However, as you introduce new products or different kinds of products, you may want to add different fields as time goes on. For example, new tennis shoes you're carrying are Bluetooth-enabled, to relay sensor data from the shoe to a fitness app on the user’s phone. This appears to be a growing trend, and you want to enable customers to filter on "Bluetooth-enabled" shoes in the future. You don't want to go back and update all your existing shoe data with a Bluetooth-enabled property, you simply want to add it to new shoes.

With the addition of the Bluetooth-enabled property, your shoe data is no longer homogenous, as you've introduced differences in the schema. If this is the only exception you expect to encounter, you can go back and normalize the existing data so that all products included a "Bluetooth-enabled" field to maintain a structured, relational organization. However, if this is just one of many specialty fields that you envision supporting in the future, then the classification of the data is semi-structured. The data is organized by tags, but each product in the catalog can contain unique fields.

Data classification: **Semi-structured**

## Photos and videos

The photos and videos displayed on product pages are unstructured data. Although the media file may contain metadata, the body of the media file is unstructured.

Data classification: **Unstructured**

## Business data

Business analysts want to implement business intelligence to perform inventory pipeline evaluations and sales data reviews. In order to perform these operations, data from multiple months needs to be aggregated together, and then queried. Because of the need to aggregate similar data, this data must be structured, so that one month can be compared against the next.

Data classification: **Structured**

## Summary

Data may be classified in one of three ways: structured, semi-structured, and unstructured. Understanding the differences so that you can classify your own data will help you choose the correct storage solution. 

To recap, structured data is organized data that neatly fits into rows and columns in tables. Semi-structured data is still organized and has clear properties and values, but there's variety to the data. Unstructured data doesn't fit neatly into tables, nor does it have a schema.