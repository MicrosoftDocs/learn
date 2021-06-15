Now we'll add a bit more complexity to the car factory program that we worked on in the last two exercises.

We'll use a hash map with key, value pairs to track some details about the car orders, and also use that structure to display output. We'll expand on the use of conditional expressions and learn how to combine conditions. Once again, your challenge is to finish the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:
- Copy the code and edit it in your local development environment. 
- Open the code in a prepared Rust Playground.

In the sample code, look for the words `TO DO` to locate the sections to update.

> [!Note]
> If you closed your program code from the last exercise, you can re-open the code in this prepared [Rust Playground][RustPlay-exercise].
> Be sure to rebuild your program and make sure it still runs without any compiler errors.


## Add a hash map to track order details

The first change we'll make is to add a hash map with <K, V> pairs. We'll track how many orders we have for new versus used cars, and how many customers are requesting manual versus automatic transmission. 

We define the hash map at the beginning of our `main` function, and initialize some variables for tracking the counts.

1. In the code from the last exercise, locate the beginning of the `main` function.

1. Copy the following code to the very beginning of the function, right after the opening curly brace `{`:

    ```rust
        // Initialize a hash map for car orders
        // - Keys: New or Used, Values: integer
        // - Keys: Manual or Automatic, Values: integer
        // TO DO: Fix syntax to create the "orders" hash map
        use std::collections::HashMap;
        let mut orders: HashMap<String, u32> = HashMap;
        let (mut new_cars, mut used_cars) = (1, 1);
        let (mut manual, mut auto) = (1, 1);
    ```

1. Fix the syntax issues in the statement that creates the `orders` hash map.

    > [!Tip]
    > You're creating a hash map from scratch, so you probably want to use the `new()` method.

1. Build the program. Make sure the code compiles before you continue to the next section. You can ignore warning messages from the compiler.


## Add conditional expression to assign engine type

Next, we'll add a more robust way to assign the engine type based on the current order number. We'll also set up a condition where we can swap the roof value from "Closed roof" (true) to "Convertible" (false). By using these constructs, we can add a little variety to our car orders.

1. Locate the `engine = Transmission::Manual;` statement and associated comment in the `main` function:

    ```rust
        // Set car transmission type
        engine = Transmission::Manual;
    ```

1. Replace the two lines of code with the following code block:

    ```rust
        // Set car transmission type, make some roofs convertible
        // TO DO: Add conditional expression
        // TO DO: Check order number, set engine type, fix syntax
        // TO DO: If order % 3 equals 0, engine is "Automatic"
        // TO DO: If order % 2 equals 0, engine is "SemiAuto" | else, engine is "Manual"
        // When order % 3, swap roof type for fun!
        if order % 3 equals 0 {
            engine = Automatic;
            roof = !roof;
        } else order % 2 equals 0 {
            engine = SemiAuto;
        } else {
            engine = Manual;
        }
    ```

    This new code uses a conditional expression to check the current order number. We'll test if the current order number is evenly divisible by 3 or 2. Depending on the result, in the expression body, we'll assign a different engine transmission type. When the order number is evenly divisible by 3, we'll also swap the roof value (true -> false, or false -> true).

1. There are a few corrections to make in this new code so it will pass compilation.

    1. Check the syntax in the conditional expressions. Is `equals` a valid keyword in this context?
    1. Make sure all required keywords are present. Any condition before a final `else` condition must begin with the `if` keyword.
    1. The way in which the `engine` value is set isn't correct. In which enum are these values defined?

1. Rebuild the program. If there are no compiler errors, you should see output similar to the following example. Your orders should now have a variety of transmission types.

    ```output
    1: Used, Closed roof, Manual, Blue, 1000 miles
    2: New, Closed roof, SemiAuto, Green, 0 miles
    3: Used, Closed roof, Automatic, Red, 3000 miles
    ...
    10: New, Closed roof, SemiAuto, Green, 0 miles
    11: Used, Closed roof, Manual, Red, 11000 miles
    ```


## Add values to the hash map

The next step is to actually use our hash map to track data. We'll add several statements throughout the program.

1. We'll add a few statements in the code block where we assigned the engine type.

    1. For the first condition, where we test `order % 3`, add the following statements inside the expression body. Place these statements after the `engine` assignment and before the `roof` value swap:
    
        ```rust
            // ADD <K, V> pair to hash map
            orders("Automatic".to_string(), auto);
            auto = auto + 1;
        ```

    1. Inside the expression body for the final `else` condition, add the following statements after the `engine` assignment:
    
        ```rust
            // ADD <K, V> pair to hash map
            orders("Manual".to_string(), manual);
            manual = manual + 1;
        ```

1. If you try to build your program now, you'd see some compiler errors. There's a syntax problem in each statement that adds the <K, V> pair to the `orders` hash map. Do you see it? Go ahead and fix the issue in both statements.

    > [!Tip]
    > We can't assign values to the `orders` hash map directly. We need to use a method to do the insertions.

1. Now we'll add a few more hash map assignment statements. Locate the `if index % 2 != 0` statement in the `main` function. We'll substitute several statements with the code block in the next step.

    Locate these statements:

    ```rust
        // Order the cars, New are even numbers, Used are odd numbers
        // Corrected code: Index into `colors` array, vary color for the orders
        if index % 2 != 0 {
            car = car_factory(colors[index-1].to_string(), engine, roof, miles);
        } else { 
            car = car_factory(colors[index-1].to_string(), engine, roof, 0);
        }
    ```

1. Replace the statements shown in the previous step with the following code block:

    ```rust
        // ADD hash map functionality
        // Order the cars, New are even numbers, Used are odd numbers
        // Corrected code: Index into `colors` array, vary color for the orders
        // TO DO: Fix syntax to add car age to "orders" hash map
        if index % 2 != 0 {
            car = car_factory(colors[index-1].to_string(), engine, roof, miles);
            // ADD <K, V> pair to hash map
            orders.insert("Used", used_cars);
            used_cars = used_cars + 1;
        } else { 
            car = car_factory(colors[index-1].to_string(), engine, roof, 0);
            // ADD <K, V> pair to hash map
            orders.insert("New", new_cars);
            new_cars = new_cars + 1;
        }
    ```

1. There's another syntax problem in each statement that adds the <K, V> pair to the `orders` hash map. This issue's a little different than last time. It has to do with how the keys are provided to the `.insert()` method. Be sure to fix the issue in both statements.

Now your program should compile without errors, but the output hasn't changed yet. We added data to our hash map, but we haven't added statements to show the hash map output. Let's do that next.


## Print car details and hash map values

Our last step is to print the details of our car orders and view the values we stored in the hash map. We'll add another complex conditional expression to help us parse the data for printing.

1. Locate the following `println!` statement and comment in the `main` function:

    ```rust
        // Display car order details
        println!("{}: {}, Closed roof, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
    ```

1. Replace these two lines of code with the following code block:

    ```rust
        // Display car order details by roof type and age of car
        // TO DO: Add conditional expressions
        // TO DO: Print output based on four conditions, correct the syntax
        // TO DO: Used & closed roof, New & closed roof, Used convertible, New convertible
        if used cars with closed roofs {
            println!("{}: {}, {:?}, Closed roof, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1); 
        } if new cars with closed roofs {
            println!("{}: {}, {:?}, Closed roof, {}", order, car.age.0, car.motor, car.color); 
        } if convertible used cars {
            println!("{}: {}, {:?}, Convertible, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1); 
        } if convertible new cars {
            println!("{}: {}, {:?}, Convertible, {}", order, car.age.0, car.motor, car.color); 
        }
    ```

    In this code block, we add a complex conditional expression to parse the car values for printing. However, the expressions are written in pseudo code!

1. Replace each pseudo code expression, such as "used cars with closed roofs," with the correct Rust keywords and syntax.

    > [!Tip]
    > To figure out the type of roof, you'll want to examine the value of the `roof` field in the `car` struct.
    > To know if the order is for a used or new car, you can check the mileage in the `age` field of the `car` struct.

1. Finally, let's add a statement at the very end of our program to view the values in our hash map:

   ```rust
        // TO DO: Display output from hash map, fix the syntax
        // Display the hash map of car orders, show <K, V> pairs
        println!("\nCar orders: {} {}", orders.keys, orders.values);
    }
    ```

1. Unsurprisingly, there are a few more syntax issues to fix in this last statement. Do you see them?

    > [!Tip]
    > How do we access keys and values in a hash map?<br>
    > Do we need to use special notation in the `println!` macro to show the values?

1. After you finish the corrections, rebuild the program. Make sure there are no compiler errors. You're ready to test your car factory!


## Run the program

When the program is complete, you should see output similar to this example:

```output
1: Used, Manual, Closed roof, Blue, 1000 miles
2: New, SemiAuto, Closed roof, Green
3: Used, Automatic, Convertible, Red, 3000 miles
4: New, SemiAuto, Convertible, Silver
5: Used, Manual, Convertible, Blue, 5000 miles
6: New, Automatic, Closed roof, Green
7: Used, Manual, Closed roof, Red, 7000 miles
8: New, SemiAuto, Closed roof, Silver
9: Used, Automatic, Convertible, Blue, 9000 miles
10: New, SemiAuto, Convertible, Green
11: Used, Manual, Convertible, Red, 11000 miles

Car orders: {"Manual": 4, "New": 5, "Used": 6, "Automatic": 3}
```


## Solution

You can compare your program output to the solution for this exercise in this [Rust Playground][RustPlay-answer].


<!-- Links -->
[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=193c6ae24f21b9b229f1f32da7c45bfd?azure-portal=true
[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=5f603bcd135c6b800c7b6e84b84cfce4?azure-portal=true
