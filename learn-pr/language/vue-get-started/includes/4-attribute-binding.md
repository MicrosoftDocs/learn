You explored how you can display data on a page through the use of handlebars (`{{}}`). However, text on the page is not the only part you may need to make dynamic. A large part of the values you set on a page, are done through attributes. Fortunately, Vue.js allows you to bind to attributes through directives.

## Directives

Directives are attributes recognized by Vue.js, and allow you to dynamically set the values of HTML attributes. All directives start with `v-`.

## v-bind

The core directive is `v-bind`, which allows you to bind a data value to an attribute. This could be used to dynamically set the name of a class, the source for an image, or a style.

To use `v-bind`, you place it in front of the attribute you wish to set with a `:`. So to set the `src` attribute for an image, you would use `v-bind:src="value"`. The attribute value is then evaluated much in the same way as you would use `{{ }}`.

The following code would generate the HTML element `<img src="./media/sample.jpg">`

```html
<div id="app">
    <img v-bind:src="imageSource" />
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    Vue.createApp({
        data() {
            return {
                imageSource: './media/sample.jpg'
            }
        }
    }).mount('app');
</script>
```

The `imageSource` property is made available to the template by it being returned from the `data()` method. Then it's bound to the `src` attribute of the image element.

> [!NOTE]
> You do not have to maintain a reference to the object you use for your app, but you can call `createApp` immediately followed by `mount` as demonstrated above.

## Binding shorthand

You've seen so far how you can use the `v-bind` directive to bind data, in your Vue app, to an attribute. There's a shorthand, a shortened way to type this directive. Instead of typing `v-bind:attribute`, you can type `:attribute` and thereby save a few characters. Let's revisit the example with the bound image source. Instead of typing:

```html
<div id="app">
    <img v-bind:src="imageSource" />
</div>
```

you can now type:

```html
<div id="app">
    <img :src="imageSource" />
</div>
```

> [!TIP] It's considered a good practice to use `:attribute` over `v-bind:attribute`.

## Class and style

One of the most common attributes you may wish to set for an HTML element is its `class` or `style`. To bind to these attributes, you can use the `v-bind:class` and `v-bind:style` or `:class` and `:style`, if you're using the shorthand notation.

### Class objects

Let's say we have an application with two classes - `centered` and `active`. Using HTML, you can uses these classes by using the following HTML:

```html
<div class='centered active'>Hello, Vue!</div>
```

The example above is static though. If you want to be able to change the data, you can use a binding. However Vue not only accepts a string to bind to, but can also take an object. You can now switch out the the static value `centered active` for a property of your choosing like so:

```html
<div id="app">
    <div :class="classObject">Hello, Vue!</div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    Vue.createApp({
        data() {
            return {
                classObject: {
                    centered: true,
                    active: true
                }
            }
        }
    }).mount('app');
</script>
```

The data property `classObject` has two properties where their values are booleans. The boolean values allows you to *enable* or *disable* specific classes. Setting `centered` to `false` would render `<div class="active">`, as `active` would be the only property that's still `true`.

> [!NOTE]
> When creating a class object, JavaScript naming rules apply. If you have a class name which uses a dash, such as `center-text`, you will have to place the name in quotes (`'center-text': true`) when adding the property.

### Style objects

Setting styles in CSS involves creating different collections of key/value pairs. This is relatively natural to represent with a JavaScript object. You can create objects which Vue.js that you can use to set the style through style objects.

If you wanted to set the background color (`background-color`) of an HTML element's style, you could do this with the following code:

```html
<div id="app">
    <div :style="styleObject">Hello, Vue!</div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    Vue.createApp({
        data() {
            return {
                styleObject: {
                    'background-color': 'red'
                }
            }
        }
    }).mount('app');
</script>
```
