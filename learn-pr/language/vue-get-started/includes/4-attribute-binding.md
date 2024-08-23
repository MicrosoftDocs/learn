You already explored how to display data on a page by using handlebars (`{{}}`). But the text on the page isn't the only part that might need to be dynamic. 

You set many of the values on a page by using attributes. Fortunately, Vue.js allows you to bind to attributes through directives.

## Directives

Directives are attributes that Vue.js recognizes. They allow you to dynamically set the values of HTML attributes. All directives start with `v-`.

## v-bind

The core directive is `v-bind`. It allows you to bind a data value to an attribute. You could use it to dynamically set the name of a class, the source for an image, or a style.

To use the directive, place `v-bind` and a colon (`:`) in front of the attribute you want to set. So to set the `src` attribute for an image, you would use `v-bind:src="value"`. The attribute value is then evaluated similarly to how it's evaluated when you use the `{{ }}` syntax.

The following code generates the HTML element `<img src="./media/sample.jpg">`.

```html
<div id="app">
    <img v-bind:src="imageSource" />
</div>

<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script>
    Vue.createApp({
        data() {
            return {
                imageSource: './media/sample.jpg'
            }
        }
    }).mount('#app');
</script>
```

The `imageSource` property is available to the template because it's returned from the `data()` method. Then it's bound to the `src` attribute of the image element.

> [!NOTE]
> You don't have to maintain a reference to the object you use for your app. But you can call `createApp` immediately, followed by `mount`, as you saw previously.

## Binding shorthand

You've now seen how to use the `v-bind` directive in your Vue app to bind data to an attribute. You can also type this directive in shorthand. For example, instead of typing `v-bind:attribute`, you can type `:attribute`. This shorthand saves you a few characters. 

In the example of the bound image source, you can use shorthand in the following way.

```html
<div id="app">
    <img v-bind:src="imageSource" />
</div>
```

Now you can type the following code.

```html
<div id="app">
    <img :src="imageSource" />
</div>
```

> [!TIP]
> Using the shorthand `:attribute` is generally considered a better practice than using `v-bind:attribute`.

## Class and style

One of the most common attributes you might want to set for an HTML element is its `class` or `style`. To bind to these attributes, you can use `v-bind:class` and `v-bind:style`. Or in shorthand, you can use `:class` and `:style`.

### Class objects

Let's say you have an application that has two classes: `centered` and `active`. In HTML, here's how you can use these classes.

```html
<div class='centered active'>Hello, Vue!</div>
```

This example is static though. If you want the ability to change the data, you can use a binding. Vue allows binding not only for a string but also for an object. 

Here's how you can switch out the static value `centered active` for a different property:

```html
<div id="app">
    <div :class="classObject">Hello, Vue!</div>
</div>

<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
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
    }).mount('#app');
</script>
```

The data property `classObject` has two properties whose values are Boolean. The Boolean values allow you to *enable* or *disable* specific classes. Setting `centered` to `false` would render `<div class="active">` because `active` would be the only property that's still `true`.

> [!NOTE]
> JavaScript naming rules apply to class objects. So if your class name uses a dash, such as in `center-text`, place the name in quotation marks (`'center-text': true`) when you add the property.

### Style objects

Setting styles in CSS involves creating collections of key/value pairs. Representing style by using a JavaScript object is relatively natural. In Vue.js, you can create style objects to set the style.

For example, to set the background color (`background-color`) of an HTML element's style, you can use the following code.

```html
<div id="app">
    <div :style="styleObject">Hello, Vue!</div>
</div>

<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script>
    Vue.createApp({
        data() {
            return {
                styleObject: {
                    'background-color': 'red'
                }
            }
        }
    }).mount('#app');
</script>
```
