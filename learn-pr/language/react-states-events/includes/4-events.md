Events allow you to run code in response to user actions in your application. Because JSX is built on JavaScript, XML, and HTML, adding event listeners looks relatively familiar. 

You add attributes to the HTML to indicate the name of the event you want to handle. If you want to use `alert` to display a message when a button is selected, for example, you could use the following code:

```javascript
class Demo extends React.Component {
    render() {
        <button onClick={ () => alert('Hello, world!') }>Click me!</button>
    }
}
```

As you might suspect, we can create a function to listen to an event as well. We add the function to our component. We then call it by using the same syntax we used for `alert`.

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
