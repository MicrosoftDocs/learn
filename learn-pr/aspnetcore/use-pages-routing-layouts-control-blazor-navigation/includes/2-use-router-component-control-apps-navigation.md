Blazor's routing system provides flexible options that you can use to ensure that user requests reach a component that can handle them and return information that the user wants. 

Suppose you're working on the pizza delivery company's website. You want to set up the site so that requests for pizza details and custom-topping details are both handled by the same component. You've completed this phase, but your testing shows that the topping requests are receiving an error message. You need to fix this problem.

Here, you'll learn how to configure routes in Blazor by using the `@page` directive. 

> [NOTE!]
> The code blocks in this unit are illustrative examples. You'll write your own code in the next unit.

## Using route templates

When the user makes a request for a page from your web app, they can specify what they want to see with information in the URI. For example:

`http://www.contoso.com/pizzas/margherita?extratopping=pineapple`

After the protocol and website address, this URI indicates that the user wants to know about margherita pizzas. Also, the query string after the question mark shows that they're interested in an extra topping of pineapple. In Blazor, you use routing to ensure that each request is sent to the best component and that the component has all the information it needs to display what the user wants. In this case, you might want the request to be sent to the **Pizzas** component and for that component to display a margherita pizza with information about adding pineapple to it.

Blazor routes requests with a specialized component called the **Router** component. It's configured in **App.razor** like this:

```razor
<Router AppAssembly="@typeof(Program).Assembly">
	<Found Context="routeData">
		<RouteView RouteData="@routeData" DefaultLayout="@typeof(MainLayout)" />
	</Found>
	<NotFound>
		<p>Sorry, we haven't found any pizzas here.</p>
	</NotFound>
</Router>
```

When the app starts, Blazor checks the `AppAssembly` attribute to find out which assembly it should scan. It scans that assembly for components that have the **RouteAttribute** present. Using these values, Blazor compiles a **RouteData** object that specifies how requests are routed to components. When you code the app, you use the `@page` directive in each component to fix the **RouteAttribute**.

In the preceding code, the `<Found>` tag specifies the component that handles the routing at runtime: the **RouteView** component. This component receives the **RouteData** object and any parameters from the URI or query string. It then renders the specified component and its layout. You can use the `<Found>` tag to specify a default layout, which will be used when the selected component doesn't specify a layout with the `@layout` directive. You'll learn more about layouts later in this module.

In the `<Router>` component, you can also specify what is returned to the user when there isn't a matching route, by using the `<NotFound>` tag. The preceding example returns a single `<p>` paragraph, but you can render more complex HTML. For example, it might include a link to the home page or a contact page for site administrators.

## Using the @page directive

In a Blazor component, the `@page` directive specifies that the component should handle requests directly. You can specify a **RouteAttribute** in the `@page` directive by passing it as a string. For example, this attribute to specifies that the page handles requests to the **/Pizzas** route:

```razor
@page "/Pizzas"
```

If you want to specify more than one route to the component, use two or more `@page` directives, like in this example:

```razor
@page "/Pizzas"
@page "/CustomPizzas"
```

## Obtaining location information and navigating with NavigationManager

Suppose you write a component to handle URIs that the user requests, such as `http://www.contoso.com/pizzas/margherita/?extratopping=pineapple`.

When you write a component, you might need access to navigation information like:

- The current full URI, such as `http://www.contoso.com/pizzas/margherita?extratopping=pineapple`.
- The base URI, such as `http://www.contoso.com/`.
- The base relative path, such as `pizzas/margherita`.
- The query string, such as `?extratopping=pineapple`.

You can use a `NavigationManager` object to obtain all these values. You must inject the object into the component and then you can access its properties. This code uses the `NavigationManager` object to obtain the website's base URI and then uses it to set a link to the home page:

```razor
@page "/pizzas"
@inject NavigationManager NavManager

<h1>Buy a Pizza</h1>

<p>I want to order a: @PizzaName</p>

<a href=@HomePageURI>Home Page</a>

@code {
	[Parameter]
	public string PizzaName { get; set; }
	
	public string HomePageURI { get; set; }
	
	protected override void OnInitialized()
	{
		HomePageURI = NavManager.BaseUri;
	}
}
```

To access the query string, you must parse the full URI. Use the `QueryHelpers` class from the `Microsoft.AspNetCore.WebUtilities` assembly to execute this parse:

```razor
@page "/pizzas"
@using Microsoft.AspNetCore.WebUtilities
@inject NavigationManager NavManager

<h1>Buy a Pizza</h1>

<p>I want to order a: @PizzaName</p>

<p>I want to add this topping: @ToppingName</p>

@code {
	[Parameter]
	public string PizzaName { get; set; }
	
	private string ToppingName { get; set; }
	
	protected override void OnInitialized()
	{
		var uri = NavManager.ToAbsoluteUri(NavManager.Uri);
		if (QueryHelpers.ParseQuery(uri.Query).TryGetValue("extratopping", out var extraTopping))
		{
			ToppingName = System.Convert.ToString(extraTopping);
		}
	}
}
```

With the preceding component deployed, if a user requested the URI `http://www.contoso.com/pizzas?extratopping=Pineapple`, they would see the message "I want to add this topping: Pineapple" in the rendered page.

You can also use the `NavigationManager` object to send your users to another component in code by calling the `NavigationManager.NavigateTo()` method:

```razor
@page "/pizzas/{pizzaname}"
@inject NavigationManager NavManager

<h1>Buy a Pizza</h1>

<p>I want to order a: @PizzaName</p>

<button class="btn" @onclick="NavigateToPaymentPage">
	Buy this pizza!
</button>

@code {
	[Parameter]
	public string PizzaName { get; set; }
	
	private void NavigateToPaymentPage()
	{
		NavManager.NavigateTo("buypizza");
	}
}
```

> [!NOTE]
> The string that you pass to the `NavigateTo()` method is the absolute or relative URI where you want to send the user. Make sure that you have a component set up at that address. For the preceding code, a component with the `@page "/buypizza"` directive will handle this route.

## Use NavLink components

In one of the previous examples, code was used to obtain the `NavigationManager.BaseUri` value and use it to set the `href` attribute of an `<a>` tag to the home page. In Blazor, use the **NavLink** component to render `<a>` tags because it toggles an `active` CSS class when the link's `href` attribute matches the current URL. By styling the `active` class, you can make it clear to the user which navigation link is for the current page.

When you use **NavLink**, the home page link example looks like the following code:

```razor
@page "/pizzas"
@inject NavigationManager NavManager

<h1>Buy a Pizza</h1>

<p>I want to order a: @PizzaName</p>

<NavLink href=@HomePageURI Match="NavLinkMatch.All">Home Page</NavLink>

@code {
	[Parameter]
	public string PizzaName { get; set; }
	
	public string HomePageURI { get; set; }
	
	protected override void OnInitialized()
	{
		HomePageURI = NavManager.BaseUri;
	}
}
```

The `Match` attribute in the **NavLink** component is used to manage when the link is highlighted. There are two options:

- **NavLinkMatch.All**: When you use this value, the link is only highlighted as the active link when its `href` matches the entire current URL.
- **NavLinkMatch.Prefix**: When you use this value, the link is highlighted as active when its `href` matches the first part of the current URL. Suppose, for example, that you had the link `<NavLink href="pizzas" Match="NavLinkMatch.Prefix">`. This link would be highlighted as active when the current URL was `http://www.contoso.com/pizzas` and for any location within that URL, such as `http://www.contoso.com/pizzas/formaggio`. This behavior can help the user understand which section of the website they're currently viewing.
