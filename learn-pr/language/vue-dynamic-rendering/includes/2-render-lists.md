Working with data often involves arrays or other types of collections. You ordinarily iterate through all items in a collection by using some form of loop. Vue.js supports loops through a directive called `v-for`.

## Introducing the v-for directive

To display all items in a list, you can use the directive `v-for`. `v-for` behaves much like a `for...of` loop in JavaScript. It iterates through a collection, providing access to each item via the variable you declare.

The syntax for `v-for` looks like:

```html
v-for="itemName in collectionName"
```

`collectionName` is the name of the array in your data object. For each iteration, `itemName` assumes the identity of your current item. To use `v-for` in a template, you add the directive inside an element declaration. Doing so repeats the HTML element as many times as there are items in the array.

> [!NOTE]
> If you're creating an unordered list (`ul`), you would *not* add `v-for` to the `ul` element. You add it to the `li` element, because the `li` element is what will be repeated.

### Use v-for in an app

To use the `v-for` directive in an app, you need to do two things:

- **Expose an array** via your data object. To use the `v-for` directive, ensure that there's data of type array that your `data()` method is returning.
- **Add the `v-for` directive to an element**. Add the `v-for` directive to an HTML element. To display data from the array, use double braces ({{&nbsp;}}) syntax. 

Let's say you want to expose an array of names in your data object:

```javascript
Vue.createApp({
    data() {
        return {
            names: ['Susan', 'Peter', 'Bill' ]
        }
    }
}).mount('#demo');
```

If you want to display the items, you could use the following code:

```html
<ul id="demo">
    <li v-for="name in names">{{ name }}</li>
</ul>
```

When the code is rendered, all the names in the array are displayed:

- Susan
- Peter
- Bill

## Keys and state

If the data is modified, Vue.js needs to be able to refresh the appropriate parts of the display. When you're working with a list, it's best to update the individual item rather than the entire list. To allow Vue.js to find an individual item, give each displayed item a key. You don't have to add the key to your data object; you can generate it by using the **index** of the array.

You can obtain the index by updating the `v-for` declaration, as shown in the following code:

```html
<ul id="demo">
    <li v-for="(name, index) in names" :key="index">{{ name }}</li>
</ul>
```

`index` is incremented for each item in the array. The `:key` directive stores the key for Vue.js, which allows it to update the individual item as changes occur.
