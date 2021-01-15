Before any API is deployed to the cloud, it's probably developed locally by a developer like you. You can create an API right on your local computer. (Of course, nobody external will be able to use it, but that's not its purpose.)

## Set up a REST API server

Run this command on a command line or in a terminal:

```npm install -g json-server```

This package, [JSON Server](https://github.com/typicode/json-server?azure-portal=true), creates a "full fake REST API" server and is useful for prototyping and learning.

Next, by using a text editor or Visual Studio Code, create a file on your local computer called `db.json`:

```json
{
  "objects": [
    { "id": 1, "item": "Lise with a Parasol", "artist": "Pierre Auguste Renoir", "collection":"Museum Folkwang, Essen, Germany", "date":"1867"},
    { "id": 2, "item": "The Theatre Box", "artist": "Pierre Auguste Renoir", "collection":"Courtauld Gallery, London, England", "date":"1874"},
    { "id": 3, "item": "Dance in the City", "artist": "Pierre Auguste Renoir", "collection":"Musée d'Orsay, Paris, France", "date":"1883"},
    { "id": 4, "item": "Dance in the Country", "artist": "Pierre Auguste Renoir", "collection":"Musée d'Orsay, Paris, France", "date":"1883"}
  ]
}
```

This JSON file is a mock version of a database. You can use `json-server` to query this data.

## Query a database

In a terminal, go to the location where you added `db.json` and enter `json-server --watch db.json`. The server will run on port 3000. You can query it via a specially formatted URL. 

Try entering `http://localhost:3000/objects` in a browser's URL box. You'll see all the objects in your database, listed in neat JSON format.

Try using the URL to query this dataset: `http://localhost:3000/objects/1` will display the item with ID `1`. 

## Understand a REST API call

You might have noticed that your API call consists of a few parts. The four major parts of a REST API call are the endpoint, the method, the headers, and the data (or body).

The *endpoint* is the route that the data will take to travel to and from your web page. It takes the form of a URL, like the URL you used earlier to query your dataset.

The *method* is the HTTP-based action that your query is designed to do. It can take the form of a GET, a POST, a DELETE, or another keyword. A GET method fetches data via an endpoint. A POST method passes data from your web page through an endpoint and to a server. A DELETE method deletes resources from a server. 

The *headers* specify the authorization and authentication needed to complete the type of action specified by the method. They might include API keys that help authorize a user.

The *data* includes the object that your API sends to a server. It's often in JSON format.

You can also search by an item name: `http://localhost:3000/objects?item=Lise%20with%20a%20Parasol`. 

This type of query demonstrates two things: 
- You need to format queries that pass through a URL with special characters to handle the spaces in the title. 
- You're using a query string to query the object's data by using the format `objects?item=`. This format is a standard REST API format for queries. 

Use your browser's developer tools to see how your web page sends and receives data. You can find them by right-clicking a web page and selecting **Inspect**, or by selecting **F12**. These tools are useful for all areas of web development. But when you're using REST API calls, you can drill into the network tab to watch how the API you built is behaving. If you refresh your browser, you can see that behind the scenes you're using GET to retrieve data to be shown in the browser.

In our call, you called an endpoint via a URL: `http://localhost:3000/objects`. 

The method used is GET. 

You don't need any headers in the call for now. (You'll learn more about headers soon.) 

The data that's returned is the same as the data stored in your `db.json` file, filtered by the query.
