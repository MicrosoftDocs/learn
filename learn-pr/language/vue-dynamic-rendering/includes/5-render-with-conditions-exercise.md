Let's update your display to highlight items which are almost sold out, and show the appropriate buttons to book a trip. If the trip offers early bird, you will set the button text appropriately, otherwise prompt the user to book now. If there are fewer than 10 seats available you'll display a message saying the class is almost sold out.

## Add the code to update the display

1. Return to **Visual Studio Code**.
1. Open **index.html**.
1. Below the line which reads `More to come` add the following HTML:

    ```html
    <!-- More to come -->
    <button v-if="productClass.earlyBird" class="button">Book early bird!</button>
    <button v-else class="button">Book now!</button>

    <div v-show="productClass.seatsAvailable < 10">Almost sold out!</div>
    ```

## Test the display

1. Save all files.
1. Return to the browser. The display should now be updated; if not hit refresh. Your page should now look like the one below.

![Screenshot of updated display showing buttons and text.](./media/conditional.png)
