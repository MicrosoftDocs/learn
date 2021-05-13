Now that you've discovered some interesting collections at the Metropolitan Museum, let's look at a different museum API: the Cooper Hewitt API. Cooper Hewitt is part of the Smithsonian. It's the US's National Design Museum. Its collection is devoted to interesting and notable design, from Dyson fans to antique shoes.

To access the API, you need either an access token or both an access token and an API key that acts as its authenticator. The API allows a user to visit an endpoint for individual visits by using a one-off access token. But to query the API with code, you need both elements.

## Create a token and a key

Go to the [API home page](https://collection.cooperhewitt.org/api?azure-portal=true) and create an account. After you create your account, you can create a key and an access token for yourself. Save the token that's generated in a text file somewhere safe on your local computer.

>[!NOTE] 
>Why create both an access token *and* a key? This API uses [OAuth 2](https://collection.cooperhewitt.org/api/oauth2?azure-portal=true), which requires tokens to monitor and limit access to the API. The API key works with the access token to ensure that you have the authority to access the API in the way that you have set up via the token.

After you create a token and authenticate it by using an API key, you can start sending the token in the URL of a test API call. Let's see what we can find in the Cooper Hewitt Design Museum!

## Query the API

Say you're interested in Art Nouveau, and you want to see what objects exist in the collection from that era. The API allows you to get an ID for the era and query it to get a URL with a collection specified for the era.

>[!NOTE] 
>For the following queries, get an access token as noted earlier and paste it into the query where specified.

To find the Art Nouveau objects, query the API like so: `https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.periods.getList&access_token=<your-token>&page=1&per_page=100`. This query specifies that you need to append the page you'll retrieve and the number of elements returned per page.

When you query the API, a URL is returned in the response with a list of Art Nouveau objects available for perusal (including some famous Mucha posters): `https://collection.cooperhewitt.org/periods/35417231/`. Take a look. What other eras can you discover by querying this API?