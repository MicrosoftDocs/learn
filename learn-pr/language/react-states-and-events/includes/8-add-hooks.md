Keeping an eye on the state of your application, and executing code in response to updates, can be done by using the Effect Hook. We register the function we wish to execute in response to changes with `useEffect`.

## Scenario

Our application allows the user to tap on individual items to mark them as prepared. If there is still preparation to be completed we want to display the message "Just keep chopping"; upon completion we want to display "Prep work done!". We will do this by adding a new state object which we will update from our Effect Hook.

> [!IMPORTANT]
> In our example we are modifying state inside `useEffect`. Remember `useEffect` by default executes whenever **any** stateful object is modified. This can create an endless loop where we modify state, the hook is executed, which modifies state, which executes the hook...
>
> To avoid this we can use the dependency parameter on `useEffect` to only look at one particular object. We will do this when creating our code to avoid this endless loop.

## Add the new state property

1. Open **App.jsx**
1. Add the new state property by adding the following code below the line which reads `TODO: Add new state property`

    ```javascript
    // TODO: Add new state property
    const [ prepared, setPrepared ] = useState(false);
    ```

## Add the Effect Hook listener

1. Add the Effect Hook listener by adding the following code below the line which reads `TODO: Add the effect hook`:

    ```javascript
    // TODO: Add the effect hook
    useEffect(() => {
        setPrepared(recipe.ingredients.every(i => i.prepared));
    }, [recipe]);
    ```

    The code uses `setPrepared` to update `prepared` by using the [every](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/every/?azure-portal=true) method which returns a boolean based on every item matching the criteria we specify. In our case we are looking to see if every item is prepared; if not it will return false.

    The second parameter on `useEffect` is set to `[recipe]`. This provides the dependency to ensure our code **only** runs when changes occur to the `recipe` object.

## Add the display

1. Add the code to display the message to the user if the prep work is done by adding the following code below the line which reads `TODO: Add the prep work display`:

    ```javascript
    {/* TODO: Add the prep work display */}
    { prepared ? <h2>Prep work done!</h2> : <h2>Just keep chopping</h2>}
    ```

    We look at the `prepared` object; if it is true we display **Prep work done!**, otherwise it's **Just keep chopping**.

## Test the page

1. Save all files.
1. Return to your browser. Click refresh. Tap the ingredients until they are all marked as prepared (there is a line through them all). Notice the display updates at the bottom of the page.
