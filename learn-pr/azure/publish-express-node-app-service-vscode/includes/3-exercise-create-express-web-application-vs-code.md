With Node.js and Express.js, you can create a webapp very quickly. 

Suppose you've been asked to start building the website to promote the new video game launch. You've decided to use Node.js to run server-side code and, to make the development as quick as possible, you're going to use the Express.js framework for webapps. You want to create a quick, proof-of-concept webapp that displays a countdown to the launch date.

Here, you'll install the necessary software and then use Visual Studio Code to create and test a website.

> [!NOTE]
> You must have [Visual Studio Code](https://code.visualstudio.com) and [Node.js](https://nodejs.org) installed on your computer before you begin this exercise.

## Create an app folder

You can use VS Code to run all the commands and edit all the code for your webapp. Here, you'll use its integrated terminal to set up a folder with Express.js installed:

1. Start VS Code. 
1. On the **View** menu, click **Terminal**.
1. To create a new folder, type the following commands:

    ```console
    cd ~
    mkdir countdownExpressApp
    cd countdownExpressApp
    ```

1. On the **File** menu, select **Open folder** and then browse to the **countdownExpressApp** folder.

## Scaffold an Express.js application

You can use the Express Generator tool to create all the components of an Express.js boiler-plate webapp:

1. In the VS Code Explorer window, notice that the **countdownExpressApp** folder is empty.
1. If the integrated terminal is not visible, on the **View** menu, click **Terminal**.
1. To run the Express Generator, execute this command in the terminal:

    ```console
    npx express-generator
    ```

1. Examine the contents of the Explorer window to see the files the generator has created.

    :::image type="content" source="../media/3-express-generator-files.png" alt-text="Express generated files." loc-scope="vs-code":::

## Calculate the countdown

You now have a functional webapp that Node.js can run. Let's modify its code to display the countdown:

1. In the VS Code Explorer window, expand **routes**, and then select **index.js**. This JavaScript file defines routes for the app's homepage. We can add our code to calculate the countdown here.
1. Add the following code, immediately after the `var router = express.Router();` line. In the first line of the inserted code, specify your own date around a month in the future, in `MM/DD/YYYY HH:MM` format (this example uses `12/29/2019 10:00`):

    ```JavaScript
    var launchTime = new Date("12/29/2019 10:00").getTime();
    ```

1. Locate this line of code:

    ```JavaScript
    res.render('index', { title: 'Express' });
    ```

1. Replace that single line with the following three lines of code:

    ```JavaScript
    var currentTime = new Date().getTime();
    var numberOfMilliseconds = parseInt(launchTime - currentTime);
    res.render('index', { title: 'Countdown to Launch', countDown: numberOfMilliseconds });
    ```

1. On the **File** menu, select **Save**, then close the **index.js** file.

> [!NOTE]
> For this initial version, you're happy to display the countdown in milliseconds. Later, we'll update the code to display a whole number of days, which is what a user might expect.

## Render the countdown 

Now, modify the default homepage for the webapp to display the countdown:

1. In the VS Code Explorer window, expand **views**, and then select **index.jade**. This file defines a view for the app's homepage. We can add code to display the countdown here.
1. Locate the following line of code:

    ```jade
    p Welcome to #{title}
    ```

1. Replace that line with this code:
  
    ```jade
    p Only a few days left until our new game launch!
    ```

1. Add this new line of code at the end of the file:

    ```jade
    p Countdown: #{countDown} milliseconds
    ```

1. On the **File** menu, select **Save** and then close the **index.jade** file.

## Run the webapp

Now the app is complete, let's run it on your local computer and see if it shows the countdown:

1. The Express Generator creates a webapp that depends on several other Node.js packages. You must ensure these are installed before you can run the webapp. In the Code integrated terminal, to install the webapp's dependencies, run this command:

    ```console
    npm install
    ```

   > [!NOTE]
   > You may see warnings in the output from this command about vulnerabilities. It's not necessary to fix these vulnerabilities for our purposes right now.

1. To run the webapp on your local computer, run the following command in the terminal:

    ```console
    npm start
    ```

    This command tells `npm` to run the command in the package's `scripts.start` property. The Express Generator sets this property to start Node.js in the /bin/www folder. This starts the webapp locally.

1. Open a web browser and navigate to the address `http://localhost:3000`.

    :::image type="content" source="../media/3-complete-webapp.png" alt-text="Browse the completed webapp." loc-scope="other":::

1. Close the web browser. In the Code integrated terminal, press <kbd>CTRL-C</kbd> to stop the webapp. If the prompt displays `Terminate batch job (Y/N)?`, type <kbd>Y</kbd> and press <kbd>Enter</kbd>.
