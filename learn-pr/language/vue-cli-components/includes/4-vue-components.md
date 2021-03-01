By definition, a component is "a part or element of a larger whole". When you think about creating an application, you typically work with smaller parts and combine them into a larger whole - your application. Vue allows you to create components which we can then use to create a full application.

## Vue components

While you can create components using JavaScript files, the more common method is to create single-file components by using the Vue syntax inside of a *.vue* file. Single-file components allow for a cleaner structure and a more self-contained setup. They even allow you to use various pre-processors, such as Pug or Stylus.

When creating components, you are essentially creating new tags you can use in your application in a similar fashion to normal HTML tags. This allows you to have a form of semantic tags, making it clearer what is actually being displayed on a page. A tag like `<booking-form></booking-form>` would likely display a form used to create a booking, and `<booking-list></booking-list>` would likely display a list of bookings.

## Vue component structure

Vue components contain three main sections, `template`, `script` and `style`. `style` contains any CSS or other style syntax and `script` contains any scripting code for the component. `template` contains the HTML used for the display of information. This allows for a logical breakdown of your component.

### style

`style` can contain any valid CSS or the syntax of any pre-processor you may be using. You can also *scope* your CSS to that specific component by using the `scoped` attribute. This means the styles will apply to only that component, which allows you to create classes and other settings without worrying about accidentally modifying other parts of the page.

```html
<style>
.demo {
    font-family: Verdana
}
</style>
```

### script

`script` stores the script used for the component. As with a Vue JavaScript component, you can export the various Vue properties and methods such as `data()`, `methods`, and `components`.

```html
<script>
export default {
    data() {
        return {
            product: {
                name: 'Cruise to the moon',
                description: 'A cool cruise to the moon!'
            }
        }
    }
}
</script>
```

### template

`template` houses the HTML template you wish to use to display information and allow the user to interact with the data. When using a JavaScript based component, this is typically inside the *.html* file or as a string literal in a JavaScript file. The HTML syntax used in `template` is the same as with JavaScript based components, including using handlebars (`{{}}`) to display data.

```html
<template>
  <div id="product">
    <div>{{ product.name }}</div>
    <div>{{ product.description }}</div>
  </div>
</template>
```

> [!NOTE]
> Templates needs to have one root element. That is, the `div` element with `product` as `id`, can't have any siblings, only child elements,as displayed above.

## Loading and components

As highlighted earlier, single-file components are saved with a *.vue* extension. You can load these in a similar fashion to other modules by using the `import` statement, and register them by using the `components` property. Once registered they become available for use as a tag inside of `template`.

> [!NOTE]
> When importing a library with `import`, it's standard to use PascalCase (or upper camel case) for the name, where the first letter for each word is capitalized, like `PascalCase`. However, in HTML, the convention is for tag names to use kebab-case with each word in lowercase letters and a dash (`-`) between them. Vue will automatically manage the two different conventions.

```html
<template>
<product-display></product-display>
</template>
<script>
import ProductDisplay from './ProductDisplay.vue'
export default {
    components: {
        ProductDisplay
    }
}
```

 In the code above, the component `ProductDisplay` is imported and added to the `components` property. What this will do, is to ensure that when `ProductDisplay` is used in the template, Vue's compiler is able to tell that this is something it needs to parse and not a regular HTML element

## Separation of concerns

Placing the HTML, CSS and JavaScript into one file may appear to be a departure from best practices where you typically create separate files for each of the different types. However, in practice, switching between these files can cause development to slow as there are invariably interdependencies between them. There's also a cognitive load associated with having to switch between files.

Single-file components does allow you to create separate files for your `script` and `style` sections by using the `src` attribute.

```html
<template>
    <div>Hello, world</div>
</template>
<script src="./hello.js"></script>
<style src="./style.css"></style>
```
