Now update your application to add an event handler for a newly created button on your form. The button will toggle the `booking.completed` flag to update the display.

## Add the function

Start by adding to the Vue application:

1. In Visual Studio Code, open the *index.js* file.
1. On the line after the `TODO: Add methods` comment, add the following code to create the `bookCabin` function. This function is the event handler.

    ```javascript
    // TODO: Add methods
    methods: {
        bookCabin() {
            this.booking.completed = true;
        }
    }
    ```

    Notice that `this` is bound to your current application. It provides access to the `booking` object from the data.

## Add the button to the form

Now add the button to your form:

1. In Visual Studio Code, open the *index.html* file.
1. On the line after the `TODO: Add button later` comment, add the following HTML to create your button.

    ```html
    <!--TODO: Add button later -->
    <button class="button" type="button" @click="bookCabin">Book now!</button>
    ```

    Notice the `@click` attribute is bound to the `bookCabin` function you created earlier.

## Test the page

Now you get to test your updated page!

1. Save all files by selecting **File** > **Save all**.
1. Open the command palette by selecting Ctrl+Shift+P. On a Mac, select Cmd+Shift+P.
1. Ensure Live Server is running by typing *Live Server* and then selecting *Live Server: Open with Live Server*.
1. Open a browser and go to `http://localhost:5500`. The page now displays a button.
1. Fill out the form and select the button. Notice that the form disappears from the page.

You've now configured an event handler in Vue.
