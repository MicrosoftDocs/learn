When you work with data-driven applications, you ordinarily need to be able to update the display based on certain values. You might need to change the color to indicate a warning, deactivate an unavailable option, or not display a control. Vue.js offers several directives to control whether and how items are displayed.

## Toggle visibility

You can control an item that's being displayed by using the `v-show` directive. `v-show` examines a Boolean value or expression and then determines whether a component should be displayed. As you might expect, `true` means it will be displayed, and `false` means it won't be displayed.

Using `v-show` with an expression that evaluates to `true` or `false` is shown in the following example:

```html
<div v-show="new Date().getMonth() < 3">It is the first quarter</div>
```

> [!NOTE]
> You can use valid JavaScript in any directive or inside the double braces ({{&nbsp;}}).

## Boolean logic

Vue.js supports three directives for implementing Boolean logic: `v-if`, `v-else-if`, and `v-else`. As you might expect, these directives align perfectly with the traditional `if`, `else if`, and `else` statements.

```html
<div v-if="new Date().getMonth() < 3">It is the first quarter</div>
<div v-else-if="new Date().getMonth() < 6">It is the second quarter</div>
<div v-else-if="new Date().getMonth() < 9">It is the third quarter</div>
<div v-else>It is the fourth quarter</div>
```

The preceding examples work because the `if` directives behave the same as `if` blocks in JavaScript. When a `true` value is detected, the block is exited. So, if the month returned is `2` for March (counting of calendar months starts with 0), it would test as `true` on the first line and skip the evaluations of the next three.

