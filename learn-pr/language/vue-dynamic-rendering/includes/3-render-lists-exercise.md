Before users decide to book a cruise, they will want to know what options are available and how much they cost. Let's display the cabins available to the users.

## Clone the starter repository and explore the code

You've been provided a starter repository for this module.

1. Clone the starter repository, and open the folder in [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true) by executing the following code.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-vue-dynamic-render/
    cd mslearn-vue-dynamic-render/2-dynamic-render
    code .
    ```

1. Open the *index.js* file. Note the array of `productClasses`. Each `productClass` has `name`, `price`, `seatsAvailable`, and `earlyBird` properties.

## Display the list of products and prices

Let's update the HTML code to display the list of all products and their prices.

1. Open the *index.html* file.
1. Below the line that reads `TODO: Add code to display classes`, add the following HTML code:

    ```html
    <div v-for="(productClass, index) in productClasses" :key="index" class="row">
        <div class="column">
            {{ productClass.name }}
        </div>
        <div class="column">
            $ {{ productClass.price.toLocaleString('en-US') }}
        </div>
        <!-- More to come -->

    </div>
    ```

### Explore the code

Note the `v-for` directive. It creates a new `div` element for each `productClass` item. You also generate the `index` for each item, which you use as the `:key` for the display. Finally, you see the appropriate code to display the `name` and `price`, for each `productClass` item.

> [!NOTE]
> Note the call to `toLocalString`. Because you're working inside the double braces (`{{ }}`), you can call any valid JavaScript. Also, while the locale string is set to **en-US**, you can update it to your particular region.

## Launch the page in Live Server

The [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer/?azure-portal=true) extension for Visual Studio Code creates a development web server that automatically refreshes the page as changes are detected. After you install the extension, you can use it to host your page.

1. Save all files.
1. In Visual Studio Code, open the Command Palette by selecting Ctrl+Shift+P (or Cmd+Shift+P on a Mac).
1. Enter <kbd>Live Server: Open with Live Server</kbd>.

    A message at the lower right informs you that your page is now being hosted on `http://localhost:5500`.

1. Open a browser, and go to `http://localhost:5500`.

You should now see the page you created.

![Screenshot of page displaying list of classes.](../media/lists.png)
