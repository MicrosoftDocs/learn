The data returned by the `data()` function in a Vue app or component is generically referred to as *state*. State is any information your application needs to track to perform the necessary operations. Users typically modify state through HTML forms. Vue.js allows you to bind data to a form so users can update state.

## v-model

The `v-model` directive creates a *two-way* binding between an HTML control and the associated data. So whenever the value is updated in the form, it's updated inside your application's state. The `v-model` directive supports binding to any form control, including checkboxes, textboxes, and drop-down lists.

> [!NOTE]
> The `v-bind` directive creates a one-way binding. So any changes the user makes in the form aren't stored in state.

For all examples in this unit, you'll use the following Vue application.

```javascript
Vue.createApp({
    data() {
        return {
            name: 'Cheryl',
            status: -1,
            active: true,
            benefitsSelected: 'yes',
            statusList: [
                'full-time',
                'part-time',
                'contractor'
            ]
        }
    }
})
```

## Binding to textboxes

To bind to a textbox, you use the `v-model` directive.

```html
<input type="text" v-model="name" />
```

The `name` property is updated whenever the textbox value changes. If you want to use `textarea` instead, the syntax is the same; you use `v-model="name"` like before.

## Binding to checkboxes

Typically, Boolean values are bound to checkboxes. Checkboxes allow the option to be toggled. To bind the `active` option, you can use `v-model` as you've done before.

```html
<input type="checkbox" v-model="active" /> Is active
```

Occasionally, the toggle isn't a Boolean value. Instead, you might have two choices, such as *yes* and *no*. In this case, you can use `true-value` and `false-value` to indicate the associated value for the checkbox that's selected (true) or unselected (false).

```html
<input type="checkbox" v-model="benefitsSelected" true-value="yes" false-value="no"> Benefits selected: {{ benefitsSelected }}
```

## Drop-down lists

In HTML, you create drop-down lists in two parts. You use `select` to create the list and `option` to add options. The `select` tag stores the selected value of the drop-down list, so you use it to bind to your model.

In Vue, you need to:

- **Create a list of options**. To create the list of `option` elements, use `v-for` to loop through and create an option element for each item in the array.
- **Identify the value**. For each option you create, you need to identify the value. If your list is just an array of strings, for example, you should either store the string or the selected index as value. Here's an example:

   ```html
   <select v-model="selectedIndex">
     <option v-for="(stringItem, index) in arrayOfStrings" :value="index"> 
     {{}}
     </option>
   </select>
   ```

   If your list stores an array of objects, point out the display property and where to find the value.

   ```html
   <select v-model="selectedValue">
     <option v-for="item in items" :value="item.value">
     {{ item.displayProperty }}
     </option>
   </select>  
   ```

- **Keep track of the selected value**. You can bind the selected value to the `select` tag by using `v-model`. Here you can keep track of either the index or the value of the item. It's up to you.

To create the list of options, use `v-for` to loop through the list. Then choose to set the value as the index of the item in the array. You use `v-for(status, index) in statusList` to provide the index for each item. You then set the `:value` of each option to `index`, and you display `status` as the option for the user.

```html
<select v-model="statusIndex">
    <!-- Create a message to select one -->
    <option disabled value="">Please select one</option>
    <!-- Use v-for to create the list of options -->
    <option v-for="(status, index) in statusList" :value="index">
        {{ status }}
    </option>
</select>
```

Finally, you add `v-model="statusIndex"` to ensure that when a user selects an item, the value of the `statusIndex` data property is updated to the selected index.
