In this exercise, you'll modify the car factory program to use a loop to iterate through the car orders.

We'll update the `main` function to add a loop expression to process the full set of orders. The loop structure helps to reduce redundancy in the code. By simplifying the code, we can easily increase the order amount.

In the `car_factory` function, we'll add another loop to avoid a run-time panic on an out-of-bounds value.

Your challenge is to finish the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:
- Copy the code and edit it in your local development environment. 
- Open the code in a prepared Rust Playground.

> [!Note]
> In the sample code, look for the `todo!` macro. This macro indicates code that needs to be completed or updated.


## Load the program

If you closed your program code from the last exercise, you can reopen the code in this prepared [Rust Playground][RustPlay-exercise].

Be sure to rebuild your program and make sure it still runs without any compiler errors.


## Repeat actions with a loop expression

We need to update the program to support more orders. The current code structure uses redundant statements to support six orders. The redundancy is awkward and difficult to maintain. 

We can simplify the structure by using a loop expression to repeat the actions to create each order. With the simplified code, we can quickly create a large number of orders.

1. In the `main` function, **remove** the following statements. This code block defines and sets the `order` variable, calls the `car_factory` function and `println!` macro for the car orders, and inserts each order into the `orders` hash map.

    ```rust
        // Order 6 cars
        // - Increment "order" after each request
        // - Add each order <K, V> pair to "orders" hash map
        // - Call println! to show order details from the hash map
                
        // Initialize order variable
        let mut order = 1;
            
        // Car order #1: Used, Hard top
        car = car_factory(order, 1000);
        orders.insert(order, car);
        println!("Car order {}: {:?}", order, orders.get(&order));

        ...

        // Car order #6: Used, Hard top
        order = order + 1;
        car = car_factory(order, 4000);
        orders.insert(order, car);
        println!("Car order {}: {:?}", order, orders.get(&order));
    ```

1. Replace the removed statements with the following code block:

    ```rust
        // Start with zero miles
        let mut miles = 0;
        
        todo!("Add a loop expression to fulfill orders for 6 cars, initialize `order` variable to 1") {
        
            // Call car_factory to fulfill order
            // Add order <K, V> pair to "orders" hash map
            // Call println! to show order details from the hash map        
            car = car_factory(order, miles);
            orders.insert(order, car);
            println!("Car order {}: {:?}", order, orders.get(&order));
            
            // Reset miles for order variety
            if miles == 2100 {
                miles = 0;
            } else {
                miles = miles + 700;
            }
        }
    ```

1. Add a loop expression that repeats the actions to create orders for six cars. You'll need an `order` variable that's initialized to 1.

1. Build the program. Make sure the code compiles without any errors.

You should see output similar to this example:
            
```output
Car order 1: Some(Car { color: "Blue", motor: Manual, roof: true, age: ("New", 0) })
Car order 2: Some(Car { color: "Green", motor: SemiAuto, roof: false, age: ("Used", 700) })
Car order 3: Some(Car { color: "Red", motor: Automatic, roof: true, age: ("Used", 1400) })
Car order 4: Some(Car { color: "Silver", motor: SemiAuto, roof: false, age: ("Used", 2100) })
Car order 5: Some(Car { color: "Blue", motor: Manual, roof: true, age: ("New", 0) })
Car order 6: Some(Car { color: "Green", motor: Automatic, roof: true, age: ("Used", 700) })
```


## Increase car orders to 11

The program now uses a loop to fulfill orders for six cars. What happens if we order more than six cars?
    
1. Update the loop expression in the `main` function to order 11 cars:

    ```rust
        todo!("Update the loop expression to create 11 cars");
    ```

1. Rebuild the program. During runtime, the program panics!

    ```output
    Compiling playground v0.0.1 (/playground)
        Finished dev [unoptimized + debuginfo] target(s) in 1.26s
        Running `target/debug/playground`
    thread 'main' panicked at 'index out of bounds: the len is 4 but the index is 4', src/main.rs:34:29
    ```

Let's see how to solve this problem.


## Prevent run-time panic with a loop expression

In the `car_factory` function, we use an if/else expression to check the value of the `color` index for the `colors` array:

```rust
    // Prevent panic: Check color index for colors array, reset as needed
    // Valid color = 1, 2, 3, or 4
    // If color > 4, reduce color to valid index
    let mut color = order as usize;
    if color > 4 {        
        // color = 5 --> index 1, 6 --> 2, 7 --> 3, 8 --> 4
        color = color - 4;
    }
```

The `colors` array has four elements, and the valid `color` index range is 0 to 3. The conditional expression checks if the `color` index is greater than 4. (We don't check for `color` index equal to 4. Later in the function, when we index into the array to assign the car color, we subtract one from the index value: `color - 1`. A `color` value of 4 is processed as `colors[3]` into the array.)

The current if/else expression works well to prevent run-time panics when we order eight or fewer cars. But if we order 11 cars, the program panics on the ninth order. We need to adjust the expression to be more robust. To make this improvement, we'll use another loop expression.

1. In the `car_factory` function, replace the if/else conditional statement with a loop expression. Revise the following pseudocode statements to prevent a run-time panic if the `color` index value is greater than 4.

    ```rust
        // Prevent panic: Check color index, reset as needed
        // If color = 1, 2, 3, or 4 - no change needed
        // If color > 4, reduce to color to a valid index
        let mut color = order as usize;
        todo!("Replace `if/else` condition with a loop to prevent run-time panic for color > 4");
    ```

    > [!Tip]
    > In this case, the change from an if/else condition to a loop expression is actually very simple.

1. Build the program. Make sure the code compiles without any errors.

You should see the following output:

```output
Car order 1: Some(Car { color: "Blue", motor: Manual, roof: true, age: ("New", 0) })
Car order 2: Some(Car { color: "Green", motor: SemiAuto, roof: false, age: ("Used", 700) })
Car order 3: Some(Car { color: "Red", motor: Automatic, roof: true, age: ("Used", 1400) })
Car order 4: Some(Car { color: "Silver", motor: SemiAuto, roof: false, age: ("Used", 2100) })
Car order 5: Some(Car { color: "Blue", motor: Manual, roof: true, age: ("New", 0) })
Car order 6: Some(Car { color: "Green", motor: Automatic, roof: true, age: ("Used", 700) })
Car order 7: Some(Car { color: "Red", motor: Manual, roof: true, age: ("Used", 1400) })
Car order 8: Some(Car { color: "Silver", motor: SemiAuto, roof: false, age: ("Used", 2100) })
Car order 9: Some(Car { color: "Blue", motor: Automatic, roof: true, age: ("New", 0) })
Car order 10: Some(Car { color: "Green", motor: SemiAuto, roof: false, age: ("Used", 700) })
Car order 11: Some(Car { color: "Red", motor: Manual, roof: true, age: ("Used", 1400) })
```


## Solution

You can compare your program output to the solution for this exercise in this [Rust Playground][RustPlay-answer].


<!-- Links -->

[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=7037678c198874159604c3519030f811?azure-portal=true
[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=aedf6dccc1a53459e39075e53b5b69c0?azure-portal=true
