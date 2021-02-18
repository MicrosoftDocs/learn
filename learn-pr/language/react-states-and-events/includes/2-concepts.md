Properties (or props) and state are two of the most important parts of any React application. The typical expectation of the React application is the user will interact with the page to change things on it. This might be through filling out a form or tapping on an item. As such, we need to ensure our application is able to respond to user requests.

## Props

Props are values passed to React components. They are copies of the data, designed for the component to render itself. Props are immutable (read-only) values.

## State

State stores any data we expect to change during the application's lifecycle. This might be through values updated through a form, todo items marked as completed, or data updated on the server which we now need to display on the page. Basically, if the value is going to change it should be part of the application's state.

## Immutability

One of the tenets of React is the concept of immutability, which means values aren't updated but rather set to new copies of data. By keeping state immutable, React is able to better determine what has changed (since the original values still exist). Always using new copies allows you to store history or implement other advanced functionality.
