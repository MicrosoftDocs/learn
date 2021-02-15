Events allow you to execute code in response to user actions in your application. Because JSX is built on JavaScript and XML/HTML, adding event listeners will look relatively familiar. You add attributes to the HTML to indicate the name of the event you wish to handle. If we want to use `alert` to display a message when a button is clicked, we could use the following:

```javascript
class Demo extends React.Component {
    render() {
        <button onClick={ () => alert('Hello, world!') }>Click me!</button>
    }
}
```

As you might suspect, we can create a function to listen to an event as well. We add the function to our component, and call it using the same syntax we used for `alert`.

```javascript
class Demo extends React.Component {
    displayMessage() {
        alert('Hello, world!');
    }

    render() {
        <button onClick={ () => displayMessage() }>Click me!</button>
    }
}
```

We can also pass parameters into the event handler as needed.

```javascript
class Demo extends React.Component {
    displayMessage(message) {
        alert(message);
    }

    render() {
        <button onClick={ () => displayMessage('Clicked button!') }>Click me!</button>
    }
}
```
