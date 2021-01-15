In many situations, it's important to know the status codes that are sent back by a RESTful API. What if there's a server error? What if there's no data to be sent back? What if there's an authentication error? In any of these cases, it's useful to watch for codes so that you can tell the front-end user that there's a problem.

## Try a query

Try, for example, this query in your browser: `https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.periods.getList&access_token=xxxxx&page=1&per_page=100`.

The API will return a code of `400`: this is a "bad request" error. It's caused by an invalid access token in the URL.

## Understand status codes

Common access codes you might come across include:

- 200 – OK. The request was successful.
- 204 – No Content.
- 301 – Moved Permanently.
- 400 – Bad Request.
- 401 – Unauthorized.
- 403 – Forbidden.
- 404 – Not Found.
- 500 – Internal Server Error.

It's useful to learn about [status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes?azure-portal=true) so that you can handle them well in your client-side code. Normally, a `200` code means "all is well" and that you can continue to display the query results. It's also useful to be able to triage errors and display appropriate messages to handle them.

> [!Tip] 
> [HTTP Cats](https://http.cat?azure-portal=true) by Tomomi Imura is a memorable way to match status codes with errors. You'll never forget that `200` means OK!
