Let's update a fictitious application for allowing people to book cruises into space. You will add a form to allow someone to book a trip to the moon.

## Clone the starter repository and explore the code

You've been provided a starter repository for this module. This will allow you to focus on the concepts you will explore in this module. You will need [Git](https://git-scm.com/?azure-portal=true) and [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true) installed, and the [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer/?azure-portal=true) extension added to Visual Studio Code.

1. Clone the starter repository and open the folder in [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true) by executing the following code

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-vue/
    cd mslearn-vue/code/3-forms-events
    code .
    ```

    The starter application already contains the core data model we will use. The `product` has information about the cruise itself, including the list of available `cabins`. The `booking` object is what we will use to store the options the user selects for their reservation. You can see the setup inside **index.js**.

## Create the form

Let's create the form the user will use to set up their reservation.

1. Inside Visual Studio Code, open *index.html*
1. Below the comment which reads `TODO: Add booking form`, add the following HTML

    ```html
    <!-- TODO: Add booking form -->
    <form v-show="!booking.completed">
        <h2>Book now!</h2>
        <div class="row">
            <label for="product-cabin">Select class:</label>
            <select id="product-cabin" v-model="booking.cabinIndex">
                <option v-for="(cabin, index) in product.cabins" :value="index">
                    {{ cabin.name }} $ {{ cabin.price.toLocaleString('en-US') }}
                </option>
            </select>
        </div>
        <div class="row">
            <label for="notes">Notes:</label>
            <textarea v-model="booking.notes" rows="3"></textarea>
        </div>
        <div class="row">
            <!--TODO: Add button later -->


        </div>
    </form>
    ```

## Breaking down the code

Let's walk through HTML code you added to the page.

### The form element

```html
<form v-show="!booking.completed">
```

The `form` element is a normal HTML form element. The key attribute you've added is `v-show`, which allows you to toggle the display of an item in Vue.js. If `booking.completed` is false we will display the form (making note of the `!` at the beginning of our string), otherwise we will hide it.

### The select element for cabin

```html
<select id="product-cabin" v-model="booking.cabinIndex">
    <option v-for="(cabin, index) in product.cabins" :value="index">
        {{ cabin.name }} $ {{ cabin.price.toLocaleString('en-US') }}
    </option>
</select>
```

You display the list of available cabins by using a `select` element. You want to bind the selected value, which will be the index, to `booking.cabinIndex`. The list of available cabins is in `product.cabins`, so you use `v-for` to create the list of options for the dropdown. You set the `value` of each one to the `index`, and create a display of the `name` of the cabin and its `price`.

### The textarea element for notes

```html
<textarea v-model="booking.notes" rows="3"></textarea>
```

You bind the `booking.notes` option to a `textarea`. You set the size by setting the `rows` attribute to *3*.

### The todo comment

You'll notice you've added a `TODO` comment for yourself to add in a button. You will see how to create event handlers a little later in this module. You want to make sure you know where to place it when the time comes.

> [!NOTE]
> `TODO` comments are a great way to make notes in your code of tasks you need to complete in the future.

## Test the results

Let's see your updated page!

1. Save all files by selecting **File** > **Save all**.
1. Launch **Live Server** is running by pressing *Ctl-Shift-P* (or *Cmd-Shift-P* on a Mac), typing *Live Server* in the command pallet, and selecting *Live Server: Open with Live Server*
1. Open your browser and navigate to `http://localhost:5500`.
1. The page now displays:

    ![Screenshot of the newly created form.](media/form-created.png)

You have now bound Vue data to a form.
