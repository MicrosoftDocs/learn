You can use the Effect Hook to keep an eye on the state of your application and run code in response to updates. We register the function we want to run in response to changes by using `useEffect`.

## Scenario

Our application allows the user to tap individual items to mark them as prepared. If some items aren't prepared yet, we want to display the message **Just keep chopping.** When all items are finished, we want to display **Prep work done!** 

We'll set up this behavior by adding a new state object. We'll update the object from our Effect Hook.

> [!IMPORTANT]
> In our example, we modify state inside `useEffect`. By default, `useEffect` runs whenever *any* stateful object is modified. This behavior can create an endless loop. In this loop, we modify state and the Hook is run, which modifies state, which runs the Hook, and so on.
>
> To avoid the endless loop, we can use the dependency parameter on `useEffect` to look at only one object. We'll do this when we create our code.

## Add the new state property

1. Open the *App.jsx* file.
1. To add the new state property, insert the following code below the line that reads, `TODO: Add new state property`.

    ```javascript
    // TODO: Add new state property
    const [ prepared, setPrepared ] = useState(false);
    ```

## Add the Effect Hook listener

To add the Effect Hook listener, insert the following code below the line that reads, `TODO: Add the effect hook`.

```javascript
// TODO: Add the effect hook
useEffect(() => {
    setPrepared(recipe.ingredients.every(i => i.prepared));
}, [recipe]);
```

The code uses `setPrepared` to update `prepared`. It uses the [every](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/every/?azure-portal=true) method, which returns a Boolean value based on every item that matches the criteria we specify. In our case, we're checking whether every item is prepared. If not, the method returns false.

The second parameter on `useEffect` is set to `[recipe]`. This setting provides the dependency to ensure our code runs *only* when the `recipe` object changes.

## Add the display

Now display the message to the user if the preparation work is done. To do so, add the following code below the line that reads, `TODO: Add the prep work display`.

```javascript
{/* TODO: Add the prep work display */}
{ prepared ? <h2>Prep work done!</h2> : <h2>Just keep chopping.</h2>}
```

We look at the `prepared` object. If it's true, we display **Prep work done!** Otherwise, we display **Just keep chopping.**

## Test the page

1. Save all of the files.
1. Return to your browser and refresh the page. 
1. Select the ingredients to mark them all prepared. (They should all be crossed off the list.) The text is updated at the bottom of the page.
