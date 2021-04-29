Hooks are a common pattern in frameworks where values change or other events occur. In a centralized way, they inject your own code to run when state changes or at other stages in an application's life cycle.

## Effect Hook

In this unit, we'll focus on the *Effect* Hook. This Hook is raised whenever the state value is set. It's raised when the initial value and all subsequent updates are set. 

The Effect Hook allows you to run code in response to the setting of the value. The code you run can have side effects, so you can update values as needed.

## When to use the Effect Hook

You can use the Effect Hook whenever you need to centralize code to respond to a state change. Imagine a complex form that includes many values. You should typically disable the **Submit** button until the data that needs to be sent to the server is in a valid state. Let's say you have events for individual values that are changed in the data. After a user selects a country in your application, you need to retrieve a list of provinces from the server. 

You wouldn't want each event listener to examine the state to see if the data is ready to be sent to the server. This setup would be inefficient. Instead, you could use an Effect Hook. An Effect Hook can create one function that looks at the data. If the data is in a valid state, it can enable the **Submit** button.

## useEffect

To register a listener for the Effect Hook, use `useEffect`. `useEffect` accepts a parameter-less function to run when state changes.

```javascript
useEffect(() => {
    // code goes here
});
```

By default, `useEffect` runs whenever state is changed on any stateful object. You can provide a dependency to enable the Hook for only a particular group of objects.

```javascript
useEffect(() => {
    // code goes here
}, [ someStatefulObject ]);
