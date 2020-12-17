So far, you've built an API that works on your local machine to give you a good understanding of how APIs work. Query your first API to search for objects at a real third-party API: New York's Metropolitan Museum.

One wonderful thing about modern museum collections management is that the ongoing efforts to digitize collections and bring them online has also allowed the casual art lover to access this data. [The Smithsonian Museums](https://www.si.edu/openaccess?azure-portal=true) in the US, Amsterdam's [Rijksmuseum](https://www.rijksmuseum.nl/en/api/-rijksmuseum-oai-api-instructions-for-use?azure-portal=true), and the [Chicago Art Institute](https://aggregator-data.artic.edu/home?azure-portal=true) (US) are among many museums who are opening their collections to the public to access virtually.

## Research the API

The first step when researching the use of a third-party API is to check out its documentation. 
Take a look at the API documentation provided by the museum.

Another thing to consider is permissions. Read through the terms of use of all third-party APIs that you would like to use and make sure the way that you want to use it is acceptable. The Met Museum's [Terms and Conditions page](https://www.metmuseum.org/information/terms-and-conditions?azure-portal=true) is a good place to start. Since they have adopted the [Creative Commons Zero](https://creativecommons.org/publicdomain/zero/1.0?azure-portal=true) license, there is no copyright on their dataset, which is helpful for the casual user.

In addition, this API does not require an API key to use the service, so you can access many aspects of its collections by using 'GET' requests via a well-formed URL query. By visiting a given URL, you are using the Met Museum's API from right within your browser. This is the simplest of all ways to use an API. In a later unit, you will learn how to use code to call APIs.

## Query the API

The Met lists its endpoints, or the URL that you will use to query for objects, as including Objects, (one) Object, Departments, and Search.

The design of this API indicates that it expects users to do searches of the collection, and then drill into object groups and individual objects for more detail and information. The API is being built progressively, and the choice of including a Department endpoint may be an indication of the way the data is structured as well as how users search for it.

Suppose you are particularly interested in arms and armor. You could query the Departments endpoint to get the id of that department:

`https://collectionapi.metmuseum.org/public/collection/v1/departments`

By pasting that link into a browser, you can discover that the Arms and Armor department is department id `4`.That gives you some information that you can subsequently use to find interesting items in this collection. To do that, you can use the Search endpoint to find interesting items. 

Note, since this API is attempting to return controlled amounts of data, given its scope of 5000 years of art history in an immense collection, a search simply by departmentId will not succeed. Instead, you need to narrow your search by a keyword within that department.

This 'narrowing' activity requires you to use a query parameter in your URL to access the endpoint. Consulting the documentation, the expected format is to append `?q=keyword(s)` to the endpoint. So to find only those arms and armor items in embossed silver, paste the following string into the browser bar:  `https://collectionapi.metmuseum.org/public/collection/v1/search?departmentId=4&q=embossed%20silver`. 27 items are returned.

This query gives you the information to retrieve the objects that are returned. If you wanted to observe the first object in that group, you would visit this endpoint: `https://collectionapi.metmuseum.org/public/collection/v1/objects/626019`. The resultant data returned reveals a rather spectacular costume suit of armor from 1800 complete with a papier-mâché helmet. One can only imagine the party it was worn to!

:::image type="content" source="../media/costume-armor.png" alt-text="costume armor from the Met.":::
> This costume helmet was acquired by the Metropolitan Museum in 1988 and currently resides in the Arms and Armor department.

## Summary

The Metropolitan Museum's well-organized and easy-to-access API is a great place to start imagining how you might use an API in your web site. You could build a search by using the `search` endpoint using query parameters. You could query the `department` for a group of objectIds and loop over them to create a list of interesting objects. You can explore the collection in depth and in detail without ever touching or even understanding the database underlying it. That's the power of a great API!




