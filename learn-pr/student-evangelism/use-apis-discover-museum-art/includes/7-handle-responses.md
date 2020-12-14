In many situations, it's important to know the status codes that are sent back by a RESTful API. What if there's a server error? What if there's no data to be sent back? What if there's an authentication error? In any of these cases, it's useful to watch for codes, so that you can tell the front-end user that there's a problem.

## Try a query

Try, for example, a query like this in your browser: `https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.periods.getList&access_token=xxxxx&page=1&per_page=100`.

The API will return a code of `400`: this is a 'bad request' error as the access token in the above URL is invalid.

## Understand status codes

Common access codes you might encounter include:

- 200 – OK. The request was successful.
- 204 – No Content.
- 301 – Moved Permanently.
- 400 – Bad Request.
- 401 – Unauthorized.
- 403 – Forbidden.
- 404 – Not Found.
- 500 – Internal Server Error.

It is useful to learn about the [various status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes?azure-portal=true) so that you can handle them well in your client-side code. Normally a `200` code means 'all is well' and you can continue to display the query results. It's just as useful to be able to triage errors and display appropriate message handling them.

>[!Tip] 
>A memorable way of looking at errors is [http.cat](https://http.cat?azure-portal=true) by Tomomi Imuri. You'll never forget that `200` means 'ok'!
