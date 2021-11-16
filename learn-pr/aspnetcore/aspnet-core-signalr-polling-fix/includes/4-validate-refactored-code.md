In this unit, you'll validate that the refactoring was a success by running the code with the applied changes. Now that you're on the `signalr` branch and you've learned what the various refactorings included, you should expect the app to function as it did before.

> [!IMPORTANT]
> You may have noticed that there were additional changes introduced in the `signalr` branch. These changes are beyond the scope of the module, and they're to help further emulate an ordering system.

## Run the application

Now that you're familiar with what code was refactored, and you're on the `signalr` branch &mdash; you'll build and run the application again to verify that it's functionally equivalent. From the .NET CLI use the `dotnet run` command:

# [Linux](#tab/linux)

```dotnetcli
dotnet run --project ./BlazingPizza.Server/BlazingPizza.Server.csproj
```

# [Windows](#tab/windows)

```dotnetcli
dotnet run --project .\BlazingPizza.Server\BlazingPizza.Server.csproj
```

---

This application is for learning purposes, and its authentication allows users to register any email address. When actively developing the app, you can complete the registration process by clicking a link to confirm your account - without actually validating the email address. For more information, see [Blazor Workshop: register a user and log in](https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr/blob/07b51750ac733cee3976a54b3316050849d38a0a/blazor-workshop/docs/06-authentication-and-authorization.md#register-a-user-and-log-in).

## Place a pizza order

:::image type="content" source="../media/add-to-order.png" lightbox="../media/add-to-order.png" alt-text="Blazing Pizza: Add pizza(s) to order.":::

After adding pizza(s) to the order, place the order by selecting the **Order >** button.

:::image type="content" source="../media/place-order.png" lightbox="../media/place-order.png" alt-text="Blazing Pizza: Place order.":::

Immediately following the order creation, the app redirects to the order status page. This displays the various order status details from **Preparing** to **Out for delivery**, and finally **Delivered**. While the order is **Out for delivery** the live map will update incrementally emulating the delivery driver's location.

Consider the following series of screen captures that show the gradual progression from the starting location to the ending location:

**Preparing order**
:::image type="content" source="../media/preparing-order.png" lightbox="../media/preparing-order.png" alt-text="Blazing Pizza: Order status, preparing order.":::

**Out for delivery 1**
:::image type="content" source="../media/out-for-delivery-1.png" lightbox="../media/out-for-delivery-1.png" alt-text="Blazing Pizza: Order status, driver just leaving, out for delivery.":::

**Out for delivery 2**
:::image type="content" source="../media/out-for-delivery-2.png" lightbox="../media/out-for-delivery-2.png" alt-text="Blazing Pizza: Order status, driver a quarter of the way there, out for delivery.":::

**Out for delivery 3**
:::image type="content" source="../media/out-for-delivery-3.png" lightbox="../media/out-for-delivery-3.png" alt-text="Blazing Pizza: Order status, driver halfway there, out for delivery.":::

**Out for delivery 4**
:::image type="content" source="../media/out-for-delivery-4.png" lightbox="../media/out-for-delivery-4.png" alt-text="Blazing Pizza: Order status, driver three quarters of the way there, out for delivery.":::

**Out for delivery 5**
:::image type="content" source="../media/out-for-delivery-5.png" lightbox="../media/out-for-delivery-5.png" alt-text="Blazing Pizza: Order status, driver arriving at destination, out for delivery.":::

Finally, the order status page reflects the **Delivered** order status:

:::image type="content" source="../media/delivered-order.png" lightbox="../media/delivered-order.png" alt-text="Blazing Pizza: Order status, driver delivered order.":::

## Stop the application

The console should output various logs, letting you know that the app has successfully built and that it's serving content at <https://localhost:5001/>. To stop the application, close the browser, and from the command line session press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the application.

## Refactor knowledge check
