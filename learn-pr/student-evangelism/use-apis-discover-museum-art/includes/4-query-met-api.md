So far, you've built an API that works on your local machine to give you a good understanding of how APIs work. You'll now query your first API to search for objects in a real third-party API: New York's Metropolitan Museum API.

One wonderful thing about modern museum collections management is that the ongoing efforts to digitize collections and bring them online has also allowed the casual art lover to access their data. [The Smithsonian museums](https://www.si.edu/openaccess?azure-portal=true) in the US, the [Rijksmuseum](https://www.rijksmuseum.nl/en/api/-rijksmuseum-oai-api-instructions-for-use?azure-portal=true) in Amsterdam, and the [Chicago Art Institute](https://www.artic.edu/open-access/public-api?azure-portal=true) in the US are among many museums that are opening their collections to allow the public to access them virtually.

## Research the API

The first step when you're researching the use of a third-party API is to check out its documentation. 
Take a look at the [API documentation](https://metmuseum.github.io/) provided by the museum.

Another thing to consider is permissions. Read through the terms of use of all third-party APIs that you want to use to make sure that what you want to do is acceptable. The Met Museum's [Terms and Conditions page](https://www.metmuseum.org/information/terms-and-conditions?azure-portal=true) is a good place to start. Because the museum has adopted the [Creative Commons Zero](https://creativecommons.org/publicdomain/zero/1.0?azure-portal=true) license, there's no copyright on the dataset. That license makes working with the API easier for the casual user.

And you don't need an API key to use this API, so you can access many elements of its collections by using GET requests via well-formed URL queries. By visiting a given URL, you're using the Met Museum's API from within your browser. This method is the simplest way to use an API. In a later unit, you'll learn how to use code to call APIs.

## Query the API

The Met's endpoints, or the URLs that you'll use to query for objects, are Objects, Object (for a single object), Departments, and Search.

The design of this API indicates that users are expected to search the collection and then drill down into object groups and individual objects for more detail and information. The API is being built progressively. The choice of including a Department endpoint might be an indication of the way the data is structured and how users search for it.

Suppose you're interested in arms and armor. You could query the Departments endpoint to get the ID of that department:

`https://collectionapi.metmuseum.org/public/collection/v1/departments`

If you paste that link into a browser, you discover that the Arms and Armor department has department ID `4`. You now have some information that you can use to find interesting items in the collection. To do that, you can use the Search endpoint. 

Because this API is attempting to return controlled amounts of data, given its scope of 5,000 years of art history in an immense collection, a search by just departmentId won't succeed. Instead, you need to narrow your search by a keyword within that department.

This narrowing activity requires you to use a query parameter in your URL to access the endpoint. If you look at the documentation, you'll see that the expected format is to append `?q=keyword(s)` to the endpoint. So to find only arms and armor items in embossed silver, paste this string into your browser:  `https://collectionapi.metmuseum.org/public/collection/v1/search?departmentId=4&q=embossed%20silver`. Twenty-seven items are returned.

This query gives you the information to retrieve the objects that are returned. If you want to look at the first object in the group, you'd go to this endpoint: `https://collectionapi.metmuseum.org/public/collection/v1/objects/626019`. The data returned reveals a spectacular costume suit of armor from 1800, complete with a papier-mâché helmet. One can only imagine the party where it was worn!

:::image type="content" source="../media/costume-armor.png" alt-text="Photograph that shows costume armor from the Met.":::
> This costume helmet was acquired by the Metropolitan Museum in 1988 and currently resides in the Arms and Armor department.

## Summary

The Metropolitan Museum's well-organized and easy-to-access API is a great place to start imagining how you might use an API in your website. You can build a search by using the `search` endpoint and query parameters. You can query the `department` for a group of objectIds and loop over them to create a list of interesting objects. You can explore the collection in depth and in detail without ever touching or even understanding the database underlying it. That's the power of a great API!



