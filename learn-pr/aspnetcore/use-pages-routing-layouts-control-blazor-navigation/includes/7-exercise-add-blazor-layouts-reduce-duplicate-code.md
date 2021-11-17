As you've added pages to the Blazing Pizza app, you'll have noticed we've been copying the navigation HTML. Blazor has built in support to create this kind of page scaffolding in one place: Blazor layouts. 

We now have lots of duplicated HTML on several pages. Next, you'll create a layout for the whole app so that you can add navigation and company information in one single place. 

In this exercise you'll create a **MainLayout** component. You'll see how you can use this layout for specific pages and then make it the default layout for the whole app.

## Add a MainLayout component

1. In Visual Studio Code, in the menu, select **File**, then select **New File**.
1. Select C# as the language.
1. Create a layout component and copy the navigation HTML from any page.

    ```razor
    @inherits LayoutComponentBase
    
    <div id="app">
    
      <header class="top-bar">
        <a class="logo" href="">
          <img src="img/logo.svg" />
        </a>
    
        <NavLink href="" class="nav-tab" Match="NavLinkMatch.All">
          <img src="img/pizza-slice.svg" />
          <div>Get Pizza</div>
        </NavLink>
    
        <NavLink href="myorders" class="nav-tab">
          <img src="img/bike.svg" />
          <div>My Orders</div>
        </NavLink>
      </header>
    
      <div class="content">
        @Body
      </div>
    
      <footer>
        &copy; Blazing Pizza @DateTime.UtcNow.Year
      </footer>
    
    </div>
    ```

    This layout has used some of the markup in the **_Host.cshtml** - so we need to remove it from there.

1. Save your changes with <kbd>CTRL</kbd>+<kbd>S</kbd>.
1. For the filename use **MainLayout.razor**. Make sure you save the file in the **Shared** directory.
1. In the explorer, expand **Pages**, then select **_Host.cshtml**.
1. Change the elements surrounding the Blazor app component from this:

    ```razor
    <div id="app">
        <div class="content">
            <component type="typeof(App)" render-mode="ServerPrerendered" />
        </div>
    </div>
    ```

    To this:

    ```razor
    <component type="typeof(App)" render-mode="ServerPrerendered" />
    ```

## Use a Blazor layout on a page component

1. In the explorer, expand **Pages**, then select **Index.razor**.
1. Delete the `top-bar` div element and, under the `@page` directive, add a reference to the new layout.

    ```razor
    @layout MainLayout
    ```

1. Let's also delete the old `<h1>Blazing Pizzas</h1>` element, as this is no longer needed because we have our top bar in the layout.
1. In Visual Studio Code press <kbd>F5</kbd>, or in the **Run** menu select **Start Debugging**.

    :::image type="content" source="../media/webpage-using-blazor-main-layout.png" alt-text="Screenshot of the new home page using a Blazor layout.":::

    The new home page will have a copyright footer for this year that automatically updates. To see what a page not using this layout looks like, select **My Orders**, or navigate to an invalid page like [http://localhost:5000/help](http://localhost:5000/help). At the moment our **404 Page not found** isn't using any of our branding.

    :::image type="content" source="../media/page-not-found.png" alt-text="Screenshot of the sparse not found page.":::

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Update all pages to use the new layout

Now you could add the `@layout MainLayout` directive to all the pages in our app. Blazor has a better solution. First delete the layout directive just added to **Index.razor**.

1. In the **Index.razor** component delete `@layout MainLayout`.
1. In the explorer, expand **Pages**, then select **MyOrders.razor**.
1. Delete the `top-bar` div element.
1. In the explorer, expand **Pages**, then select **OrderDetail.razor**.
1. Delete the `top-bar` div element.
1. In the explorer, expand **Pages**, then select **Checkout.razor**.
1. Delete the `top-bar` div element.

The App.razor component is where we can change how pages are routed, but also tell Blazor to use a default layout.

1. In the explorer, then select **App.razor**.
1. Add the `DefaultLayout="typeof(MainLayout)"` declaration to the **RouteView** element.
1. Add `Layout="typeof(MainLayout)"` to the **LayoutView**.
1. **App.razor** should now look like this:

    ```razor
    <Router AppAssembly="typeof(Program).Assembly" Context="routeData">
        <Found>
            <RouteView RouteData="routeData" DefaultLayout="typeof(MainLayout)" />
        </Found>
        <NotFound>
            <LayoutView Layout="typeof(MainLayout)">
                <div class="main">Sorry, there's nothing at this address.</div>
            </LayoutView>
        </NotFound>
    </Router>
    ```

## Test the new layout

1. In Visual Studio Code press <kbd>F5</kbd>, or in the **Run** menu select **Start Debugging**.

    :::image type="content" source="../media/page-not-found-with-layout.png" alt-text="Screenshot showing the much improved page not found.":::

    The benefit of using a default layout is that you can apply it to all pages and use it for the LayoutView for not found pages.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

The work you needed to do for the app is finished in this module. If you like to see how to handle forms and validation, complete the next module in this learning path.
