::: zone pivot="nodeexpress"

When you have changes to deploy to the webapp, you can use the same tools in Visual Studio Code.

Suppose you want to make an improvement to the proof-of-concept website: Instead of displaying the count down in milliseconds, you want to display it in days. You want to make this change and deploy it to Azure before you display the page to stakeholders.

In this unit, you'll modify the code and redeploy the website.

## Modify the code to calculate the countdown in days

Let's start by modifying the code, so that it calculates a whole number of days:

1. Start Visual Studio Code if it is not already running.
1. If the **countdownExpressApp** folder is not already open, then on the **File** menu, select **Open Folder...** and then browse to the folder.
1. In the Visual Studio Code Explorer window, expand **routes**, and then select **index.js**.
1. Locate this line of code:

    ```JavaScript
    let numberOfMilliseconds = parseInt(launchTime - currentTime);
    ```

1. On the next line, type this new code:

    ```JavaScript
    let numberOfDays = parseInt(numberOfMilliseconds/(24 * 3600 * 1000));
    ```

1. Locate this line of code:

    ```JavaScript
    res.render('index', { title: 'Countdown to Launch', countDown: numberOfMilliseconds });
    ```

1. Replace that line with this line of code:

    ```JavaScript
    res.render('index', { title: 'Countdown to Launch', countDown: numberOfDays });
    ```

1. On the **File** menu, select **Save**, then close the **index.js** file.

## Modify the view to display the countdown in days

You must also alter the view slightly:

1. Using the Code Explorer window, open `/views/index.jade`.

1. Locate this line of code:

    ```jade
    p Countdown: #{countDown} milliseconds
    ```

1. Replace that line with this line of code:

    ```jade
    p Countdown: #{countDown} days
    ```

1. On the **File** menu, select **Save**, then close the **index.jade** file.

## Publish the new version

Your changes are complete. Let's deploy the finished website to Azure:

1. In Visual Studio Code, in the **Azure** Explorer, right-click the webapp you created, and then select **Deploy to Web App**.
1. Select the **countdownExpressApp** folder, and then select **Deploy**.
1. When the deployment is complete, select **Browse Website**, and then select **Open Link**. Then Azure website is displayed in your browser. Notice that the countdown is now displayed in days.

    :::image type="content" source="../media/7-deployed-webapp.png" alt-text="Express.js website hosted in Azure." loc-scope="other":::

::: zone-end

::: zone pivot="pythonflask"

When you have changes to deploy to the webapp, you can use the same tools in Visual Studio Code.

Suppose you want to make an improvement to the proof-of-concept website: Instead of displaying the count down in milliseconds, you want to display it in days. You want to make this change and deploy it to Azure before you display the page to stakeholders.

In this unit, you'll modify the code and redeploy the website.

## Modify the code to calculate the countdown in days

Let's start by modifying the code, so that it calculates a whole number of days:

1. Start Visual Studio Code if it is not already running.
1. If the **countdownExpressApp** folder is not already open, then in Windows on the **File** menu, select **Open Folder...** and then browse to the folder and select **Select Folder**.  Or in macOS, on the **File** menu, select **Open...** and browse to the folder, then select **Open**.
1. In the Visual Studio Code Explorer window, select **app.py**.
1. Locate this line of code:

    ```python
    numberOfMilliseconds = int(diff.total_seconds() * 1000)
    ```
1. Replace that line with this line of code:

    ```JavaScript
    numberOfDays = diff.days
    ```

1. Locate this line of code:

    ```python
    return render_template(
        "countdown.html",
        time=numberOfMilliseconds
    )
    ```

1. Update the code to use `numberOfDays` instead of `numberOfMilliseconds`:

    ```python
    return render_template(
        "countdown.html",
        time=numberOfDays
    )
    ```

1. On the **File** menu, select **Save**, then close the **app.py** file.

## Modify the view to display the countdown in days

You must also alter the view slightly:

1. Using the Explorer window, open `/templates/countdown.html`.

1. Locate this line of code:

    ```html
    <p>Countdown: {{ time }} milliseconds</p>
    ```

1. Replace that line with this line of code:

    ```html
    <p>Countdown: {{ time }} days</p>
    ```

1. On the **File** menu, select **Save**, then close the **countdown.html** file.
1. Re-test your changes by selecting **Terminal** and then **New Terminal**.
1. Make sure the prompt is prefixed with `(env)`, then start the development server.  In Windows, type the following at the command prompt:

```command
py -m flask run
```

In macOS, type the following at the command prompt:

```command
python3 -m flask run
```

1. Open a web browser to http://127.0.0.1:5000 and confirm that the changes function correctly.
1. In the Visual Studio Code Terminal, in Windows and Linux select <kbd>Ctrl+C</kbd> to quit the development server.  On macOS, select <kbd>Command+C</kbd> to quit the development server.

## Publish the new version

Your changes are complete. Let's deploy the finished website to Azure:

1. In Visual Studio Code, in the **Azure** Explorer, right-click the webapp you created, and then select **Deploy to Web App**.
1. Select the **countdownFlaskApp** folder, and then select **Deploy**.
1. When the deployment is complete, select **Browse Website**, and then select **Open Link**. Then Azure website is displayed in your browser. Notice that the countdown is now displayed in days.

    :::image type="content" source="../media/7-deployed-webapp.png" alt-text="Python website hosted in Azure." loc-scope="other":::

::: zone-end