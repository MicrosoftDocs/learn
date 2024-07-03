
Often, users want to search for items associated with a geographical location. For example, they might want to find the nearest coffee shop to their location. To help you compare locations on the Earth's surface, AI Search includes geo-spatial functions that you can call in queries.

Here, you'll learn how to search for things that are near a physical point or within a bounded area.

## What are geo-spatial functions?

In previous units in this module, you saw how users might locate a hotel by specifying fields to search, such as `Description` and `Category`:

`search=(Description:luxury OR Category:luxury)&$select=HotelId, HotelName, Category, Tags, Description&$count=true`

An important consideration when you're booking a hotel is its geographical location. For example, if you're booking a trip to see the Eiffel Tower, you'll want a hotel located near it.

To ask AI Search to return results based on their location information, you can use two functions in your query:

- `geo.distance`. This function returns the distance in a straight line across the Earth's surface from the point you specify to the location of the search result.
- `geo.intersects`. This function returns `true` if the location of a search result is inside a polygon that you specify.

To use these functions, make sure that your index includes the location for results. Location fields should have the datatype `Edm.GeographyPoint` and store the latitude and longitude.

## Use the geo.distance function

`geo.distance` is a function that takes two points as parameters and returns the distance between them in kilometers.

Suppose you're looking for a hotel near the Eiffel Tower. You can modify the above query, adding a new filter:

`search=(Description:luxury OR Category:luxury)$filter=geo.distance(location, geography'POINT(-122.131577 47.678581)') le 5&$select=HotelId, HotelName, Category, Tags, Description&$count=true`

This query returns all the luxury hotels in the index within five kilometers of the Eiffel Tower. In the query:

- `Location` is the name of the field that stores the hotel's location.
- `geography'POINT(2.294481 48.858370)'` is the location of the Eiffel Tower as a longitude and latitude.
- `le 5` specifies that hotels should be included in the results if the `geo.distance` function returns a number less than or equal to five kilometers.

> [!IMPORTANT]
> When you use `geo.distance` in a filter, the equal to (`eq`) and not equal to (`ne`) operators are not supported. Instead, use `lt`, `le`, `gt`, or `ge`.

Because `geo.distance` returns several kilometers, you can also use it in an `orderby` clause. For example, this query returns all luxury hotels in the index, but those closest to the Eiffel Tower are listed first:

`search=(Description:luxury OR Category:luxury)&orderby=geo.distance(Location, geography'POINT(2.294481 48.858370)') asc&$select=HotelId, HotelName, Category, Tags, Description&$count=true`

In this query, `asc` specifies that the luxury hotels are returned in the ascending order of their distance from the Eiffel Tower.

## Use the geo.intersects function

Suppose you've decided that you want to stay within the seventh arrondissement of Paris for your trip to the Eiffel Tower. When you search for a hotel, you'd like to specify this area as precisely as possible. You can formulate such a query by using the `geo.intersects` function.

The `geo.intersects` function compares a location with a polygon on the Earth's surface, which you specify with three or more points. By using a polygon, you can create a shape that closely matches an area, such as an arrondissement. Use this polygon to add a geographical filter to your query:

`search=(Description:luxury OR Category:luxury) AND geo.intersects(Location, geography'POLYGON((2.32 48.91, 2.27 48.91, 2.27 48.60, 2.32 48.60, 2.32 48.91))')&$select=HotelId, HotelName, Category, Tags, Description&$count=true`

This query returns all luxury hotels within a square around the Eiffel Tower. You can use more than four points to create a more precise area.

> [!IMPORTANT]
> In polygons, you must specify the points in counterclockwise order and the polygon must be closed, which means that the first and last points specified must be the same.

`geo.intersects` returns a boolean value, so it's not possible to use it in an `orderby` clause.

