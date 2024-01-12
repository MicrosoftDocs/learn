Delegates and events are distinct in their functions, but they often work together. A delegate is a variable that holds a method instead of data. Events often use delegates. In this scenario, for example, when the user selects a button it calls the associated function, or delegate.

Suppose you want something to occur every time a specific event occurs in your program. The user may trigger the event by clicking on a button. The system itself can also trigger a system event, such as when a log file reaches a specific size.

You can make that "thing" occur by associating an event with a delegate. In this arrangement, a "listener" listens for an event. When the event occurs, the event calls the associated delegate and executes the method it contains.

In this module, you'll focus on reviewing how to create and use events and how to connect them to the new UI elements, as you continue to build the Langton's Ant code.