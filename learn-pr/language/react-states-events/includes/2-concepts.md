Properties (also called *props*) and state are two of the most important parts of any React application. In a typical React application, the user interacts with the page to change things on it. These changes might include filling out a form or tapping an item. So we need to ensure our application can respond to user requests.

## Props

*Props* are values passed to React components. These copies of the data are designed to allow the component to render itself. Props are *immutable* (read-only) values.

## State

*State* stores any data we expect to change during the application's life cycle. Changes might be values updated through a form, to-do items marked as completed, or updated server data that needs to be displayed on the page. Basically, if the value can change, it should be part of the application's state.

## Immutability

One of the tenets of React is the concept of *immutability*. Immutability means that values aren't updated but are rather set to new copies of data. 

By keeping state immutable, React can better determine what has changed, because the original values still exist. This continual use of new copies allows you to store history or apply other advanced functionality.
