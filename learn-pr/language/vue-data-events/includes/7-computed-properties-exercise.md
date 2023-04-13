Now you'll create a computed property to display information about the selected cabin. You'll also add the necessary HTML to display the selection on the page.

## Add the computed property

Add the computed property to display a string for the selected cabin:

1. In Visual Studio Code, open the *index.js* file.
1. On the line after the `TODO: Add computed values` comment, add the following JavaScript code to create the computed value.

    ```javascript
    // TODO: Add computed values
    computed: {
        bookingCabinDisplay() {
            const cabin = this.product.cabins[this.booking.cabinIndex];
            return `${cabin.name}: $ ${cabin.price.toLocaleString('en-US')}`
        }
    },
    ```

Notice that you can use `this` to access `product.cabins`. You use `booking.cabinIndex` to find the cabin the user selected. You then create the display string by using the ECMAScript template.

## Add the display to the page

Now add the display to the page:

1. In Visual Studio Code, open the *index.html* file.
1. On the line after the `TODO: Add success display` comment, add the following HTML to display the booking.

    ```html
    <!-- TODO: Add success display -->
    <div v-show="booking.completed">
        <h2 class="row">
            You are on your way!
        </h2>
        <div class="row">
            <div>Booking details:</div>
            <div>{{ bookingCabinDisplay }} </div>
            <div>Notes: {{ booking.notes }}</div>
        </div>
    </div>
    ```

Notice that you're using `v-show` to display content when `booking.completed` is set to `true`. You set up this behavior earlier for the button. Also notice that you can read `bookingCabinDisplay` like you would any other string value inside Vue to display it to the user.

## Test the page

Now check out the page in action!

1. Save all files by selecting **File** > **Save all**.
1. Open the command palette by selecting Ctrl+Shift+P. On a Mac, select Cmd+Shift+P.
1. Ensure Live Server is running by typing *Live Server* and then selecting *Live Server: Open with Live Server*.
1. Open a browser and go to `http://localhost:5500`. The page appears.
1. Fill out the form.

    :::image type="content" source="../media/form-completed.png" alt-text="Screenshot of the completed form showing business class selected, and a request entered in the Notes field.":::

1. Select the button and notice the display.

    :::image type="content" source="../media/booking-display.png" alt-text="Screenshot of the updated display showing the Booking details, indicating Business class, the price, and a note requesting a window seat.":::

You've now added a computed property to a Vue application.
