When working with data-driven applications, you typically need to be able to update the display based on certain values. You might need to change the color to indicate a warning, deactivate an unavailable option, or simply not display a control. Vue.js offers several directives to control how (or if) items are displayed.

## Toggle visibility

You can control an item being displayed by using the `v-show` directive. `v-show` will examine a boolean value or expression, and determine if a component should be displayed. As you might suspect, `true` means it will be displayed, and `false` means it won't.

Below is an example of using `v-show` with an expression that evaluates to `true` or `false`.

```html
<div v-show="new Date().getMonth() < 3">It is the first quarter</div>
```

> [!NOTE]
> Valid JavaScript can be used in any directive or inside `{{ }}`

## Boolean logic

Vue.js supports three directives for implementing boolean logic: `v-if`, `v-else-if`, and `v-else`. As you might expect, these align perfectly traditional `if`, `else if`, and `else` statements.

```html
<div v-if="new Date().getMonth() < 3">It is the first quarter</div>
<div v-else-if="new Date().getMonth() < 6">It is the second quarter</div>
<div v-else-if="new Date().getMonth() < 9">It is the third quarter</div>
<div v-else>It is the fourth quarter</div>
```

The reason the above examples works is the `if` directives behave the same as `if` blocks in JavaScript. Once a true value is detected the block is exited. So if the month returned was **2** for March (counting starts with 0), it would test as true on the first line, and skip the evaluations of the next three.
