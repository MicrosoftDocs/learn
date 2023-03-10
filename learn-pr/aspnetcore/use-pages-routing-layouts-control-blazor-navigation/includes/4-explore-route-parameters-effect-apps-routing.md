You've seen how, in Blazor, you can use parts of the URI to route requests to the right component. You can also intercept other parts of the URI and access them in your code by using *route parameters*.

Suppose you're working on the pizza delivery company's website and you've routed pizza requests to the **Pizzas.razor** component. Now, you want to get the user's favorite pizza from the URI and use it to display information about other pizzas they might like.

Here, you'll learn how to use route parameters to specify parts of the URL to process in your code.

> [NOTE!]
> The code blocks in this unit are illustrative examples. You'll write your own code in the next unit.

## Route parameters

Earlier in this module, you learned how parts of the URI that the user requests can be used to route the request to the right component. You often want to use other parts of the URI as a value in your rendered page. For example, suppose the user requests:

`http://www.contoso.com/favoritepizza/hawaiian`

By using the `@page` directive, you've learned how to route this request to, for example, the **FavoritePizza.razor** component. Now you want to make use of the value **hawaiian** in your component. To obtain this value, you can declare it as a route parameter.

Use the `@page` directive to specify parts of the URI that will be passed to the component as route parameters. In your component's code, you can obtain the value of a route parameter in the same way as you would obtain the value of a component parameter:

```razor
@page "/FavoritePizzas/{favorite}"

<h1>Choose a Pizza</h1>

<p>Your favorite pizza is: @Favorite</p>

@code {
	[Parameter]
	public string Favorite { get; set; }
}
```

The preceding code uses braces in the `@page` directive to specify the route parameter and give it a name.

> [!NOTE]
> Component parameters are values sent from a parent component to a child component. In the parent, you specify the component parameter value as an attribute of the child component's tag. Route parameters are specified differently. They're specified as part of the URI. Behind the scenes, the Blazor router intercepts these values and sends them to the component as component values, which is why you can access them in the same way. Route parameters are case insensitive and are forwarded to a component parameter with the same name.

## Optional route parameters

In the preceding example, the `{favorite}` parameter is required. To make the route parameter optional, use a question mark:

```razor
@page "/FavoritePizzas/{favorite?}"

<h1>Choose a Pizza</h1>

<p>Your favorite pizza is: @Favorite</p>

@code {
	[Parameter]
	public string Favorite { get; set; }
	
	protected override void OnInitialized()
	{
		Favorite ??= "Fiorentina";
	}
}
```

It's a good idea to set a default value for the optional parameter. In the preceding example, the default value for the `Favorite` parameter is set in the `OnInitialized` method.

> [!NOTE]
> The `OnInitialized` method runs when users request the page for the first time. It doesn't run if they request the same page with a different routing parameter. For example, if you expect users to go from `http://www.contoso.com/favoritepizza/hawaiian` to `http://www.contoso.com/favoritepizza`, set the default value in the `OnParametersSet()` method instead.

## Route constraints

In the previous examples, the consequence of requesting the URI `http://www.contoso.com/favoritepizza/2` is the nonsensical message "Your favorite pizza is: 2". In other cases, type mismatches like that one might cause an exception and display an error to the user. Consider specifying a type for the route parameter:

```razor
@page "/FavoritePizza/{preferredsize:int}"

<h1>Choose a Pizza</h1>

<p>Your favorite pizza size is: @FavoriteSize inches.</p>

@code {
	[Parameter]
	public int FavoriteSize { get; set; }
}
```

In this example, if the user requests `http://www.contoso.com/favoritepizza/margherita`, there's no match with the preceding component. As a result, the request is routed elsewhere. If the user requests `http://www.contoso.com/favoritepizza/12`, there's a route match and the component displays the message "Your favorite pizza size is: 12 inches." A specific type for the route parameter like this one is called a *route constraint*. You can use these other types in a constraint:

| Constraint | Example | Example matches |
| --- | --- | --- |
| bool | {vegan:bool} | `http://www.contoso.com/pizzas/true` |
| datetime | {birthdate:datetime} | `http://www.contoso.com/customers/1995-12-12` |
| decimal | {maxprice:decimal} | `http://www.contoso.com/pizzas/15.00` |
| double | {weight:double} | `http://www.contoso.com/pizzas/1.234` |
| float | {weight:float} | `http://www.contoso.com/pizzas/1.564` |
| guid | {pizza id:guid} | `http://www.contoso.com/pizzas/CD2C1638-1638-72D5-1638-DEADBEEF1638` |
| long | {totals ales:long} | `http://www.contoso.com/pizzas/568192454` |

## Set a catch-all route parameter

Consider the following component from earlier in this unit:

```razor
@page "/FavoritePizza/{favorite}"

<h1>Choose a Pizza</h1>

<p>Your favorite pizza is: @Favorite</p>

@code {
	[Parameter]
	public string Favorite { get; set; }
}
```

Now suppose the user tried to specify two favorites by requesting the URI `http://www.contoso.com/favoritepizza/margherita/hawaiian`. The page displays the message "Your favorite pizza is: margherita" and ignores the subfolder **hawaiian**. You can change this behavior by using a *catch-all route parameter*, which captures paths across multiple URI folder boundaries (forward slashes). Prefix an asterisk (`*`) to the route parameter name to make the route parameter catch-all:

```razor
@page "/FavoritePizza/{*favorites}"

<h1>Choose a Pizza</h1>

<p>Your favorite pizzas are: @Favorites</p>

@code {
	[Parameter]
	public string Favorites { get; set; }
}
```

With the same request URI, the page now displays the message "Your favorite pizzas are: margherita/hawaiian".
