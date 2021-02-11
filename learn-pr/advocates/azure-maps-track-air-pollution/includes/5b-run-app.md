In this unit, you'll run the app and view it on the webpage you created. Then, take a look at troubleshooting common experiences.

## Run the app

You can set up Visual Studio Code to run and debug a Flask app. Then, use your browser to see the app in action.

In Visual Studio Code, be sure that the <i>app.py</i> file is open in the editor. (Debug options vary based on the file you have open.) In the Activity Bar, select the **Run** icon. Under the **Run and Debug** button, select the **create and launch.json file** link. In the selection drop-down, choose the **Flask** link.

:::image type="content" source="../media/run-app-combined.png" alt-text="Screenshot that shows the steps to take to debug a Flask app.":::

> [!NOTE]
> If you don’t see a new file named *launch.json* in the *.vscode* folder in your application code folder, you can manually create the configuration file.
>
> To create the config file, to the right of the **Run** view, select the gear icon.
>
> A new *launch.json* file  opens in the *.vscode* folder, and the text in the **Run** view changes to *Python:Flask*.
>

To debug the Flask app:

1. When *Python:Flask* shows in the **Run** view, select the green arrow to run the application.

    :::image type="content" source="../media/run-flask-app.png" alt-text="Screenshot that shows the green arrow selected to run Flask.":::

    The app starts. The code output shows the local URL the app is running on:

    ```output
     * Serving Flask app "app.py"
     * Environment: development
     * Debug mode: off
     * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
    ```

1. In the terminal output, position your cursor on the IP address link. Select Ctrl+Click to open the app in your web browser. If you give the browser permission to get your location, it centers on your current location. Otherwise, the app centers on the Microsoft headquarters in Redmond, Washington, USA.

    :::image type="content" source="../media/map-in-edge.png" alt-text="Screenshot of the map running in the Microsoft Edge web browser." lightbox="../media/map-in-edge-large.png"::: 

   Try moving around the map by dragging, using the mouse wheel, or pinching to zoom in and out, depending on your device input options.

   When you're finished exploring, stop the app by selecting the stop button on the debug toolbar in Visual Studio Code.

   :::image type="content" source="../media/stop-button.png" alt-text="Screenshot that shows the debug stop button in Visual Studio Code.":::

## Troubleshooting

Let's look at some issues you might encounter when you run your app and how to resolve them.

### Exception has occurred: KeyError

If your app stops as soon as it runs and shows an exception and the message `Exception has occurred: KeyError`, your Azure Maps key hasn't been added to the *.env* file.

:::image type="content" source="../media/key-error.png" alt-text="Screenshot that shows an example of the key error exception message.":::

Verify that these requirements are met:

* A file called *.env* is in the root folder of your application.
* The *.env* file contains a key/value pair in the format `key=value`. The key must be `MAP_KEY`, and the value must be your primary key copied from the Azure Maps account.

### No data on the map

If you don't see any data on the map, but you do see the Microsoft logo, you aren't using a valid key for the map control. Check the value in the *.env* file to ensure that it's correct. The value shouldn't include quotation marks.

### 500 Internal Server Error

If a `500 Internal Server Error` is returned, check the logs in the Visual Studio Code terminal. The following output example indicates that the *home.html* file isn't in the correct location:

```output
jinja2.exceptions.TemplateNotFound: home.html
```

The *home.html* file should be in the *templates* folder. Move the file and reopen the app.

In this unit, you viewed the app in your webpage and had a chance to try out its functionality. Next, let's learn about the GeoJSON format for spatial data.