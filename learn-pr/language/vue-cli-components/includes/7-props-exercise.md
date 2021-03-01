Let's continue building our application by creating a component, to display the current list of bookings. You will add in a form the user can use, to add bookings, so for the time being you will create a static array.

## Create the component

You will start by creating your component.

1. Inside Visual Studio Code, create a new file inside *src/components* named *BookingList.vue*.
1. Inside *BookingList.vue*, type `vue`, and select *\<vue\> with default.vue* from the snippets menu.

    ![Screenshot of the snippets menu with \<vue\> with default.vue selected.](./images/vue-create.png)

    The default structure will be created by the snippet.

## Register the props and computed value

You're expecting an `Array` of information about bookings, so we will declare our prop as type `Array`. Because you're creating a component, you can also take advantage of computed properties to automatically calculate values for you. You will add a computed property to add the total price and return a display value you can use.

1. Open *src/components/BookingList.vue* if not already open.
1. Inside the curly braces (`{ }`) for `export default`, add the following code to add the following code to create a prop named `bookings` and the `computed` property:

    ```javascript
    props: {
        bookings: Array
    },
    computed: {
        totalDisplay() {
            let totalCost = 0;
            if (this.bookings && this.bookings.length > 0) {
                totalCost = 
                    this.bookings.map(b => b.price)
                                .reduce((a, b) => a + b);
            }
            return '$ ' + totalCost.toLocaleString('en-US');
        }
    }
    ```

    Notice how `totalDisplay` is able to access the `bookings` prop by using `this`, which is how we would be able to access data or other properties declared as part of our component. We create the code to calculate the total of all prices listed in our `bookings`, and create a string display.

## Add the template for display

Let's add the template to display the information for our bookings. You will use `v-for` to loop through all bookings, and the `totalDisplay` computed property we created earlier.

1. Open *src/components/BookingList.vue* if not already open.
1. Inside the `<template>` element, add the following HTML:

    ```html
    <section>
    <h2>
        Here's your current bookings:
    </h2>

    <div class="row" v-for="(booking, index) in bookings" :key="index">
        <div>{{ booking.cabin }} </div>
    </div>

    <h3 class="row">
        Total: {{ totalDisplay }}
    </h3>
    </section>
    ```

    Our code iterates through all bookings with `v-for` and displays the `cabin`. We then call `totalDisplay` to display the total cost of all bookings.

## Add our component to the main page

Let's use your component, and pass in a list of bookings.

1. Open *src/components/Host.vue*.
1. Add a new line below the opening `<script>` tag and before `export default`.
1. Add the following code (including the comment) to import the `BookingList` component you created:

    ```javascript
    import BookingList from './BookingList.vue';
    // TODO: Register next component
    ```

1. Register the component by adding the following code (including the comment) below the comment which reads `TODO: Add components`:

    ```javascript
    components: {
        BookingList,
        // TODO: Add next component

    },
    ```

    > [!IMPORTANT]
    > The two commas are required as we will be adding more values in the future.

## Use the component

With your component registered, we will call it in our page. We will use the `bookings` array we created earlier to seed the list of bookings on the page.

1. Open *src/components/Host.vue* if not already open.
1. Below the comment which reads `TODO: Add booking-list`, add the following code to use the `booking-list` component:

    ```html
    <booking-list :bookings="bookings"></booking-list>
    ```

## Test the page

With your component registered and configured, let's test the page!

1. Save all files by clicking *File* > *Save all*.
1. Return to your browser window with `http://localhost:8080` and hit refresh.
1. The page will now display the sample booking.

    ![Screenshot of updated page showing sample booking displayed on right side.](./images/booking-list.png)

Congratulations! You have created a component with props.
