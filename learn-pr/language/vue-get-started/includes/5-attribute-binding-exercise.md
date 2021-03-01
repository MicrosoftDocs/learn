You would like to display an image of what the space cruise looks like for your customers. Because each type of adventure will have a different image, and potentially style, you want to add it to the data object for your application.

## Add the properties to the data object

In the previous exercise you created `data()` inside the `App` object. Let's add the properties for the image.

1. Open **index.js**.
1. Immediately below the line which reads `// additional properties later` add the following code:

    ```javascript
    productImage: 'assets/cruise.jpg',
    productImageDescription: 'An astronaut floats outside the window while you sit in comfort',
    productImageStyle: {
        'border-radius': '15px'
    }
    ```

The entire contents of **index.js** will now contain the following:

```javascript
const app = Vue.createApp({
    data() {
        return {
            productName: 'Book a Cruise to the Moon',
            productDescription: 'Cruise to the moon in our luxurious shuttle. Watch the astronauts working outside the International Space Station.',
            // additional properties later
            productImage: 'assets/cruise.jpg',
            productImageDescription: 'An astronaut floats outside the window while you sit in comfort',
            productImageStyle: {
                'border-radius': '15px'
            }
        }
    },
});
```

## Add the HTML

Let's update the HTML to include the image. You will set the attributes and style by using attribute binding.

1. Open **index.html**.
1. Add the following HTML below the line which reads `<div>{{ productDescription }}</div>`:

    ```html
    <img :src="productImage" :alt="productImageDescription" :style="productImageStyle" />
    ```

    The entire `div` element for the app should now look like the following:

    ```html
    <div id="app">
        <h2>{{ productName }}</h2>
        <div>{{ productDescription }}</div>
        <img :src="productImage" :alt="productImageDescription" :style="productImageStyle" />
    </div>
    ```

    Not how the shorthand notation `:attribute` is used on all the attributes and how this usage makes for an easier read over the longer `v-bind:attribute`.

## Test the results

1. Save all files.
1. Return to the browser. You should now see the image displayed on the page. If it doesn't, refresh the page. It should now resemble the following:

    ![Screenshot of the updated page with the image of the cruise](media/attribute-binding.png)

1. Right click on the newly displayed image and click **Inspect** or **Inspect source**. Notice the developer tools in the browser and the HTML. It should now resemble the following. Notice how both `src` and `alt` are set to the values from the Vue data.

    ```html
    <img src="assets/cruise.jpg" alt="An astronaut floats outside the window while you sit in comfort">
    ```

## Explore different options

You now have a fully functional Vue.js application. If you change different values and properties you can see the changes reflected in your page. Feel free to change the styles, classes to the CSS file, and explore the different binding options available to you.
