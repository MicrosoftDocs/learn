Let's update your application to add an event handler for a newly created button on your form. The button will toggle the `booking.completed` flag, which will update our display.

## Add the function

You will start by adding to the Vue application.

1. Inside Visual Studio Code, open *index.js*.
1. Below the comment which reads `TODO: Add methods`, add the following code to create the `bookCabin` function, which will be our event handler:

    ```javascript
    // TODO: Add methods
    methods: {
        bookCabin() {
            this.booking.completed = true;
        }
    }
    ```

    Notice how `this` is bound to your current application and provides access to the `booking` object from our data.

## Add the button to the form

Let's add the button to your form.

1. Inside Visual Studio Code, open *index.html*.
1. Below the comment which reads `TODO: Add button later`, add the following HTML to create your button:

    ```html
    <!--TODO: Add button later -->
    <button class="button" type="button" @click="bookCabin">Book now!</button>
    ```

    Notice the `@click` attribute is bound to the `bookCabin` function we created earlier.

## Test the page

Let's test your updated page!

1. Save all files by clicking **File** > **Save all**.
1. Ensure *Live Server* is running by pressing *Ctl-Shift-P* (or *Cmd-Shift-P* on a Mac), typing *Live Server* in the command pallet, and selecting *Live Server: Open with Live Server*.
1. Open your browser and navigate to `http://localhost:5500`.
1. The page now displays with the button.
1. Fill out the form and click the button.
1. Notice the form disappears from the page.

You have now configured an event handler in Vue.
