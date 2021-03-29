By definition, a component is "a part or element of a larger whole." When you think about creating an application, you typically work with smaller parts and combine them into a larger whole: your application. Vue allows you to create components that you can then use to create a full application.

## Vue components

Although you can create components by using JavaScript files, the more common method is to create single-file components by using the Vue syntax inside a *.vue* file. Single-file components allow for a cleaner structure and a more self-contained setup. They even allow you to use various pre-processors, such as Pug or Stylus.

When you create components, you're essentially creating new tags that you can use in your application in a similar way to normal HTML tags. This form of semantic tags clarifies what's being displayed on a page. A tag like `<booking-form></booking-form>` would likely display a form for creating a booking, and `<booking-list></booking-list>` would likely display a list of bookings.

## Vue component structure

Vue components contain three main sections: `style`, `script`, and `template`.

### style

The `style` section can contain any valid CSS or the syntax of any pre-processor that you might be using. 

You can also *scope* your CSS to that specific component by using the `scoped` attribute. The styles will then apply to only that component, so you can create classes and other settings without worrying about accidentally modifying other parts of the page.

```html
<style>
.demo {
    font-family: Verdana
}
</style>
```

### script

The `script` section stores the script used for the component. As with a Vue JavaScript component, you can export the various Vue properties and methods, such as `data()`, `methods`, and `components`.

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

The `template` section houses the HTML template that you want to use to display information and allow the user to interact with the data. When you use a JavaScript-based component, `template` is typically inside the *.html* file or is a string literal in a JavaScript file. 

The HTML syntax used in `template` is the same as with JavaScript-based components, including using handlebars (`{{}}`) to display data.

```html
<template>
  <div id="product">
    <div>{{ product.name }}</div>
    <div>{{ product.description }}</div>
  </div>
</template>
```

> [!NOTE]
> Templates need to have one root element. That is, the `div` element with `product` as `id` can't have any siblings. It can have only child elements, as shown in the preceding code.

## Loading and components

As highlighted earlier, single-file components are saved with a *.vue* extension. You can load these components in a similar way to other modules by using the `import` statement. You can register them by using the `components` property. After the components are registered, they become available for use as a tag inside `template`.

> [!NOTE]
> When you're importing a library by using `import`, it's standard to use PascalCase for the name, where the first letter for each word is capitalized (for example, `PascalCase`). But in HTML, the convention is for tag names to use kebab-case with each word in lowercase letters and a dash (`-`) between them. Vue will automatically manage the two different conventions.

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

In the preceding code, the component `ProductDisplay` is imported and added to the `components` property. Then, when `ProductDisplay` is used in the template, Vue's compiler can tell that this component is something it needs to parse and not a regular HTML element.

## Separation of concerns

Placing the HTML, CSS, and JavaScript into one file might seem to be a departure from the best practice of creating separate files for each type. In practice, switching between these files can cause development to slow because of interdependencies between them. There's also a cognitive load associated with having to switch between files.

Single-file components allow you to create separate files for your `script` and `style` sections by using the `src` attribute.

```html
<template>
    <div>Hello, world</div>
</template>
<script src="./hello.js"></script>
<style src="./style.css"></style>
```
