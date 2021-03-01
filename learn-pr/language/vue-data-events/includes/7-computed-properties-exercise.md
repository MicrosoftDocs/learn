Let's create a computed property to display out the information about the selected cabin. You will also add in the necessary HTML to display it on the page.

## Add the computed property

Let's add the computed property to create a string to be displayed for the selected cabin.

1. Inside Visual Studio Code, open *index.js*
1. Below the comment which reads `TODO: Add computed values`, add the following JavaScript to create the computed value

    ```javascript
    // TODO: Add completed values
    computed: {
        bookingCabinDisplay() {
            const cabin = this.product.cabins[this.booking.cabinIndex];
            return `${cabin.name}: $ ${cabin.price.toLocaleString('en-US')}`
        }
    },
    ```

    Notice how you're able to use `this` to access the `product.cabins`, and `booking.cabinIndex` to find the cabin the user selected. We then create the display string by using the ECMAScript template.

## Add the display to the page

Let's add the display to our page.

1. Inside Visual Studio Code, open *index.html*.
1. Below the line which reads `TODO: Add success display`, add the following HTML to display the booking:

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

    Notice how you're using `v-show` to display when `booking.completed` is set to `true`, which you setup earlier with our button. Also notice how we are able to read `bookingCabinDisplay` like you would any other string value inside Vue to display it to the user.

## Test the page

Let's see our page in action!

1. Save all files by clicking *File* > *Save all*
1. Ensure *Live Server* is running by pressing *Ctl-Shift-P* (or *Cmd-Shift-P* on a Mac), typing *Live Server* in the command pallet, and selecting *Live Server: Open with Live Server*
1. Open your browser and navigate to `http://localhost:5500`.
1. The page now displays.
1. Fill out the form.

    ![The form completed with business class selected and window seat please as the text.](media/form-completed.png)

1. Click the button and notice the display.

    ![The display updated with business class and the price, and the note of window seat please.](media/booking-display.png)

You have now added a computed property to a Vue application.
