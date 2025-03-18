In this unit, you clone the existing application's source code repository. By working with a local clone of the source, you can then familiarize yourself with the existing client-side polling functionality and evaluate how best to refactor the code.

## Clone the repository

Whether you use Visual Studio, Visual Studio Code, or some other integrated development environment (IDE), you indirectly use Git to clone the repo. This module builds upon the [Blazor workshop](https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr), which contains a pizza ordering application.

# [Linux](#tab/linux)

```bash
git clone https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr
```

# [Windows](#tab/windows)

```PowerShell
git clone https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr
```

---

After you successfully clone the repository, it's best to build and run the app. You need to change directories into the _blazor-workshop/src_ directory of the repo before you use the .NET CLI.

# [Linux](#tab/linux)

```bash
cd ./mslearn-blazing-pizza-signalr/blazing-pizza/src
```

# [Windows](#tab/windows)

```PowerShell
cd .\mslearn-blazing-pizza-signalr\blazor-workshop\src
```

---

### Run the application

You're free to use your IDE or the .NET CLI. From the CLI, use the `dotnet run` command:

# [Linux](#tab/linux)

```dotnetcli
dotnet run --project ./BlazingPizza.Server/BlazingPizza.Server.csproj
```

# [Windows](#tab/windows)

```dotnetcli
dotnet run --project .\BlazingPizza.Server\BlazingPizza.Server.csproj
```

---

This application is intended for learning purposes. When you're authenticated, you can register any email address. While you're actively developing the app, you can complete the registration process by selecting a link to confirm your account, without having to validate the email address. For more information, see [Blazor workshop: Register a user and log in](https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr/blob/07b51750ac733cee3976a54b3316050849d38a0a/blazor-workshop/docs/06-authentication-and-authorization.md#register-a-user-and-log-in).

### Place a pizza order

After you sign in, you can place an order for pizza. Select a pizza, choose the toppings, and add them to the order. As an example, consider the following image:

:::image type="content" source="../media/add-to-order.png" lightbox="../media/add-to-order.png" alt-text="Screenshot of the Blazing Pizza window for adding extra toppings to a pizza order.":::

After you add extra toppings to your order, place it by selecting the **Order** button.

:::image type="content" source="../media/place-order.png" lightbox="../media/place-order.png" alt-text="Screenshot of the Blazing Pizza window for placing order.":::

Immediately after you create the order, the app redirects to the order status page, **My Orders**. This page displays the various order status details sequentially, from **Preparing** to **Out for delivery** and, finally, **Delivered**. While the order is **Out for delivery**, the live map updates by incrementally changing and emulating the delivery driver's location.

Consider the following series of images, which display on the live map. A progression from the starting location to the ending location. Here are the statuses:

**Preparing**
:::image type="content" source="../media/preparing-order.png" lightbox="../media/preparing-order.png" alt-text="Screenshot of the Blazing Pizza 'My Orders' window with an order status of 'Preparing'.":::

**Out for delivery 1**
:::image type="content" source="../media/out-for-delivery-1.png" lightbox="../media/out-for-delivery-1.png" alt-text="Screenshot of the 'My Orders' window with an order status of 'Out for delivery'. The live map shows that the driver is just leaving.":::

**Out for delivery 2**
:::image type="content" source="../media/out-for-delivery-2.png" lightbox="../media/out-for-delivery-2.png" alt-text="Screenshot of the 'My Orders' window with an order status of 'Out for delivery'. The live map shows that the driver is about a quarter of the way to the delivery location.":::

**Out for delivery 3**
:::image type="content" source="../media/out-for-delivery-3.png" lightbox="../media/out-for-delivery-3.png" alt-text="Screenshot of the 'My Orders' window with an order status of 'Out for delivery'. The live map shows that the driver is about halfway to the delivery location.":::

**Out for delivery 4**
:::image type="content" source="../media/out-for-delivery-4.png" lightbox="../media/out-for-delivery-4.png" alt-text="Screenshot of the 'My Orders' window with an order status of 'Out for delivery'. The live map shows that the driver is about three quarters of the way to the delivery location.":::

**Out for delivery 5**
:::image type="content" source="../media/out-for-delivery-5.png" lightbox="../media/out-for-delivery-5.png" alt-text="Screenshot of the 'My Orders' window with an order status of 'Out for delivery'. The live map shows that the driver is at the delivery location.":::

Finally, the order status page reflects the **Delivered** order status:

:::image type="content" source="../media/delivered-order.png" lightbox="../media/delivered-order.png" alt-text="Screenshot of the 'My Orders' window with an order status of 'Delivered'. The live map shows that the driver is at the delivery location.":::

### Stop the application

The console should output various logs, letting you know that the app is successfully built and that it's serving content at `https://localhost:5001/`. To stop the application, close the browser and, from the command line session, select <kbd>Ctrl</kbd>+<kbd>C</kbd>.

## Familiarize yourself with the code

The primary focus for this module is refactoring the client-side polling to instead use ASP.NET Core SignalR. The process of ordering a pizza redirects users to the order details page. This page performs the client-side polling. Make sure that you understand the current implementation, so that you know what needs to be refactored. Consider the *OrderDetails.razor* file:

:::code language="razor" source="~/../blazing-pizza-main/blazor-workshop/src/BlazingPizza.Client/Pages/OrderDetails.razor":::

The preceding Razor markup performs the following tasks:

- It binds values from the `orderWithStatus` object as part of the component template.
  - The created time and the status text values are bound in the order title markup.
  - The `orderWithStatus.Order` is passed as an argument to the `OrderReview` component.
  - The map markers (which represent the markings on the live map) are passed to the `Map` component.
- When the `OrderId` parameter is set, the `PollForUpdates` is started.
  - This method makes an HTTP request to the server every four seconds.
  - The latest order status details are reassigned to the `orderWithStatus` variable.

> [!NOTE]
> The `PollForUpdates` method is `async void`, which means that it's "fire-and-forget." This can cause unexpected behavior and should be avoided if possible. It will be refactored as part of the changes.

Each time the order is received, it recalculates delivery status updates and corresponding map marker changes. This update is achieved by calculating properties on the `OrderWithStatus` object. Consider the following C# file *OrderWithStatus.cs*:

:::code language="csharp" source="~/../blazing-pizza-main/blazor-workshop/src/BlazingPizza.Shared/OrderWithStatus.cs":::

In the preceding C# code, `FromOrder` calculates a new order status based on the current time. Based on your understanding of the implementation, you should be able to reuse the `OrderWithStatus` object, and learn how the app was refactored.

## Fetch the refactored code

The refactored code is in a separate branch named [`signalr`](https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr/tree/signalr).

# [Linux](#tab/linux)

Use the `git remote` command to determine the name of the *`https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr`* repo:

```bash
git remote -v
```

The remote name that corresponds to the *`https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr`* repo is the name you need to use. Next, use the `git fetch` command to fetch the `signalr` branch. This command assumes that your remote is named `upstream`, although the name might be `origin`.

```bash
git fetch upstream signalr
```

Finally, use the `git checkout` command to context-switch into the refactored source:

```bash
git checkout signalr
```

# [Windows](#tab/windows)

Use the `git remote` command to determine the name of the *`https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr`* repo:

```PowerShell
git remote -v
```

The remote name that corresponds to the *`https://github.com/MicrosoftDocs/mslearn-blazing-pizza-signalr`* repo is the name you need to use. Next, use the `git fetch` command to fetch the `signalr` branch. This command assumes that your remote is named `upstream`.

```PowerShell
git fetch upstream signalr
```

Finally, use the `git checkout` command to context-switch into the refactored source:

```PowerShell
git checkout signalr
```

---
