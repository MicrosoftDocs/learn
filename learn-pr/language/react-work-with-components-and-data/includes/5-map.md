You will often find yourself working with collections of data stored in an array. Although working with array data is similar to working with any other object, you do need the ability to loop through the data and display it to the user. As you might suspect, you do this in JSX by using JavaScript code. In particular, you use the `map` function.

`map` allows you to create a modified copy of an array. This is useful when you need to convert the values of an array for display purposes. To display values to a user, you take the value and embed it inside an HTML element. This is a perfect job for `map`. With `map`, you can create a new array that consists of HTML containing individual values in the array for display.

## Use `map`

`map` behaves similarly to a `for...of` loop or the `forEach` method. It runs once for each item in the array. The key difference is that it generates a new array with the values returned by the function passed into `map`.

Let's explore `map` by seeing how you can create a new array from an existing one with the numbers squared. Start by creating an array of numbers.

```javascript
const numbers = [2, 5, 8];
```

Then use `map`. `map` accepts a function with a single parameter. The parameter will be set to the value of each number in the original array. You'll create an anonymous function for this purpose by using the `=>` or fat arrow syntax.

```javascript
const squared = numbers.map((number) => {
    return number * number;
});
```

`squared` is a new array that contains our original numbers squared. If you displayed them by using `console.log`, you would see the following:

```javascript
console.log(squared);
// Output: [4, 25, 64]
```

## Access the index to generate a key

When you display lists in React, set a key for each item. This allows both React and you to refer to individual items currently being displayed, and relate them back to the bound data. The most common way to generate a key is to use the index of the item in the array.

When you use a `for` loop, you inherently generate an index as part of the syntax. When you use `map`, you can access the index by using a second parameter in the delegate function. The second parameter is automatically set to the current index.

```javascript
const squared = numbers.map((number, index) => {
    console.log(`Processing item ${index + 1}`);
    return number * number;
});
```

## map with React

As highlighted in an earlier example, you might commonly use `map` to display a list of items. The key difference is that rather than returning numbers (as in the example), you return JSX. React has a guideline that all items displayed should have a key. If the items you are displaying don't have a natural key, it's common to use the index. For example, if you want to display your squared numbers in `div` elements, you can use the following:

```javascript
const squared = numbers.map((number, index) => {
    return (
        <div key={index}>{ number * number }</div>
    );
});
```

You can use `squared` in the same fashion as other variables in JSX. If you added `{ squared }` to JSX elsewhere, it would render the collection of `div` elements with your updated numbers.
