Let's say you want to display an image of the space cruise for your customers. Because each type of cruise adventure will have a different image, and maybe a different style, you want to add the image properties to the data object for your application.

## Add the properties to the data object

In the previous exercise, you created a `data()` method inside the `App` object. Now add the properties for the image.

1. Open the *index.js* file.
1. Immediately after the line `// additional properties later`, add the following code.

    ```javascript
    productImage: 'assets/cruise.jpg',
    productImageDescription: 'An astronaut floats outside the window while you sit in comfort',
    productImageStyle: {
        'border-radius': '15px'
    }
    ```

The *index.js* file now contains the following code.

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

Now update the HTML to include the image. You'll set the attributes and style by using attribute binding.

1. Open the *index.html* file.
1. Immediately after the line `<div>{{ productDescription }}</div>`, add the following HTML.

    ```html
    <img :src="productImage" :alt="productImageDescription" :style="productImageStyle" />
    ```

    The entire `div` element for the app should now look like the following code.

    ```html
    <div id="app">
        <h2>{{ productName }}</h2>
        <div>{{ productDescription }}</div>
        <img :src="productImage" :alt="productImageDescription" :style="productImageStyle" />
    </div>
    ```

    Notice how the shorthand notation `:attribute` is used on all the attributes. This usage makes the code easier to read than the longer `v-bind:attribute` format.

## Test the results

1. Save all files.
1. In the browser, you should now see the image displayed on the page. If you don't see it, refresh the page.

    :::image type="content" source="../media/attribute-binding.png" alt-text="Screenshot of the updated page showing the image of the cruise.":::

1. Right-click the image and then select **Inspect** or **Inspect source**. Notice the developer tools in the browser and the HTML. In the HTML, notice that both `src` and `alt` are set to the values from the Vue data.

    ```html
    <img src="assets/cruise.jpg" alt="An astronaut floats outside the window while you sit in comfort">
    ```

## Explore the options

You now have a fully functional Vue.js application. If you change some of the values and properties, you can see the changes reflected on your page.

Feel free to change the styles and classes to the CSS file. Also explore the available binding options.
