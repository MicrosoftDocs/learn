You will often find yourself working with collections of data stored in an array. While working with array data is similar to any other object, we do need the ability to loop through the data and display it to the user. As you might suspect, we do this in JSX by using JavaScript code. In particular, we will use the `map` function.

`map` allows you to create a modified copy of an array. This is useful when we need to convert the values of an array for display purposes. When we think about displaying values to a user, we want to take the value and embed it inside an HTML element. This is a perfect job for `map`. With `map` we can create a new array consisting of HTML containing individual values in the array for display.

## Use `map`

`map` behaves similarly to a `for...of` loop or the `forEach` method. It executes once for each item in the array. The key difference is it generates a new array with the values returned by the function passed into `map`.

Let's explore `map` by seeing how we could create a new array from an existing one with the numbers squared. We start by creating an array of numbers.

```javascript
const numbers = [2, 5, 8];
```

Then we use `map`. `map` accepts a function with a single parameter. The parameter will be set to the value of each number in the original array. We will create an anonymous function for this purpose by using the `=>` or fat arrow syntax.

```javascript
const squared = numbers.map((number) => {
    return number * number;
});
```

`squared` is a new array containing our original numbers squared. If you displayed them by using `console.log` you would see the following:

```javascript
console.log(squared);
// Output: [4, 25, 64]
```

## Access the index to generate a key

When displaying lists in React, it is a best practice to set a key for each item. This allows both React and you to refer to individual items currently being displayed, and relate them back to the bound data. The most common way to generate a key is to use the index of the item in the array.

When using a `for` loop you inherently generate an index as part of the syntax. When using `map`, you can access the index by using a second parameter in the delegate function. The second parameter will automatically be set to the current index.

```javascript
const squared = numbers.map((number, index) => {
    console.log(`Processing item ${index + 1}`);
    return number * number;
});
```

## map with React

As highlighted earlier, `map` is frequently used to display a list of items. The key difference is rather than returning numbers (as we did in our example) we return JSX. React has a soft requirement saying all items displayed should have a key. If the items you are displaying don't have a natural key, it's common to use the index. If we wanted to display our squared numbers in `div` elements, we could use the following:

```javascript
const squared = numbers.map((number, index) => {
    return (
        <div key={index}>{ number * number }</div>
    );
});
```

`squared` could be used in the same fashion as other variables in JSX. If we added `{ squared }` to JSX elsewhere it would render the collection of `div` elements with our updated numbers.
