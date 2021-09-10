In this exercise, you'll add if/else test conditions to the car factory program to assign values based on expression results.

We'll revise the `car_quality` function to identify to the caller whether the ordered car is "New" or "Used." We'll add a conditional expression to check the mileage and update how the tuple value is assigned. In the `car_factory` function, we'll use several if/else expressions to control program flow and output. 

Your challenge is to finish the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:
- Copy the code and edit it in your local development environment. 
- Open the code in a prepared Rust Playground.

In the sample code, look for the words `TO DO` to locate the sections to update.


## Get the sample code

Start by opening the existing sample code in an editor.

1. Copy the following code and edit it in your local development environment, or open the code in this prepared [Rust Playground][RustPlay-exercise].

    ```rust
    #[derive(PartialEq, Debug)]
    // Declare Car struct to describe vehicle with four named fields
    struct Car { color: String, motor: Transmission, roof: bool, age: (String, u32) }

    #[derive(PartialEq, Debug)]
    // Declare enum for Car transmission type
    enum Transmission { Manual, SemiAuto, Automatic }

    //////////////////////////////////////////////////

    // Get the car quality by testing the value of the input argument
    // - miles (u32)
    // Create a tuple for the car quality with the age ("New" or "Used") and miles
    // Return a tuple with the arrow `->` syntax
    fn car_quality (miles: u32) -> (String, u32) {

        // Declare and initialize the return tuple value
        // For a new car, set the miles to 0
        // TO DO: Correct the "quality" declaration so the value is changeable    
        let quality: (String, u32) = (String::from("New"), miles);

        // TO DO: Add a conditional expression to check the miles
        // If the car has accumulated miles, then the car is used

        // Return the completed tuple
        return quality
    }

    //////////////////////////////////////////////////

    // Build a new "Car" using the values of four input arguments
    // - color (String)
    // - motor (Transmission enum)
    // - roof (boolean, true if the car has a hard top roof)
    // - miles (u32)
    // Call the car_quality(miles) function to get the car age
    // Return an instance of a "Car" struct with the arrow `->` syntax
    fn car_factory(color: String, motor: Transmission, roof: bool, miles: u32) -> Car {

        // TO DO: Call the car_quality(miles) function to help identify if the order is for a new or used car
        // - As part of the call, set the "quality" variable to the first element of the returned value
        let quality = car_quality(miles);

        // TO DO: Use an if/else conditional expression to describe the car to build
        // - Modify the first "if" condition to check if the order is for a used car
        // - Modify both "if" conditions for the "roof" to check if the order is for a hard top

        // Create a new "Car" instance as requested
        // - Bind first three fields to values of input arguments
        // - Bind "age" to tuple returned from car_quality(miles)
        let car = Car {
            color: color,
            motor: motor,
            roof: roof,
            age: car_quality(miles)
        };

        // Return new instance of "Car" struct, no semicolon needed
        return car
    }

    fn main() {
        // Car order #1: New, Manual, Hard top
        car_factory(String::from("Orange"), Transmission::Manual, true, 0);
        
        // Car order #2: Used, Semi-automatic, Convertible
        car_factory(String::from("Red"), Transmission::SemiAuto, false, 565);

        // Car order #3: Used, Automatic, Hard top
        car_factory(String::from("White"), Transmission::Automatic, true, 3000);
    }
    ```
 
1. Build the program. Make sure the code compiles before you continue to the next section.

    The code doesn't display any output yet, but it needs to compile without any errors. You can ignore *warning* messages from the compiler. The warnings are because you declared enum and struct definitions, but haven't used them yet.


## Update the car_quality function

The `car_quality` function takes car mileage as an input argument. The function creates a `quality` tuple value for a "New" car and stores the miles. It returns the tuple to the caller.

We need to update this function to set the `quality` value with the age of the ordered car: "New" or "Used." We'll add a conditional expression to check the mileage and update how the tuple value is assigned.

1. Fix the declaration of the `quality` tuple so the variable value can be changed.

    ```rust
        // TO DO: Correct the "quality" declaration so the value is changeable   
        let quality: (String, u32) = (String::from("New"), 0);
    ```

1. Add a conditional expression to check if the ordered car can have accumulated miles. You can use the following pseudocode as an example. Replace the `if <car has miles>` expression with valid `if/else` condition syntax.

    ```rust
        // TO DO: Add a conditional expression to check the miles
        // If the car has accumulated miles, then the car is used
        if <car has miles> {
            ...
        }
    ``` 

1. Complete the code to set the `quality` tuple values for a "Used" car. When a car is "New," we set the mileage to 0. When the car is "Used," we get the value from the `miles` input argument.

    ```rust
        if <car has miles> {
            // TO DO: Set the "quality" value to a "Used" car
            quality;
        }
    ```

1. Build the program. Make sure the code compiles before you continue to the next section.


## Update the car_factory function

The next step is to update the `car_factory` function. We'll use an if/else conditional expression to describe the car to build and display the results. The expression checks if the order is for a new or used car, and also determines the roof type.

1. In the `car_factory` function, adjust the definition for the `quality` variable. Set the value to the first element of the value returned from the call to the `car_quality(miles)` function.

    ```rust
            let quality = car_quality(miles);
    ```

1. Add a conditional expression to check if the order is for a used or new car. You can use the following pseudocode as an example. Replace the `if <the ordered car is Used or New>` expressions with valid `if/else` condition syntax.

    ```rust
        if <the ordered car is Used> {
            ...
        } else <the ordered car is New> {
            ...
        }
    ```

    > [!Tip]
    > You can check the value of the `quality` variable and use the *is equal to* operator `==`.

1. Inside each `if` expression, add a second conditional expression to check if the order is for a hard top roof. Start with the following code snippet and complete the pseudocode sections. You'll want to examine the `roof` variable. Replace the two `if <the ordered roof is a hard top>` expressions with valid `if/else` condition syntax.

    ```rust
            if <the ordered roof is a hard top> {
                println!("Prepare a used car: {:?}, {}, Hard top, {} miles", motor, color, miles);
            } else {
                println!("Prepare a used car: {:?}, {}, Convertible, {} miles", motor, color, miles);
            }
        ...
            if <the ordered roof is a hard top> {
                println!("Build a new car: {:?}, {}, Hard top, {} miles", motor, color, miles);
            } else {
                println!("Build a new car: {:?}, {}, Convertible, {} miles", motor, color, miles);
            }
    ```

    > [!Tip]
    > Test conditions yield a boolean result.

1. Build your program. Make sure the code compiles without any errors. You can ignore any warning messages.


## Run the program

When the program is complete, you should see output similar to this example:
    
```output
Build a new car: Manual, Orange, Hard top, 0 miles
Prepare a used car: SemiAuto, Red, Convertible, 565 miles
Prepare a used car: Automatic, White, Hard top, 3000 miles
```


## Solution

You can compare your program output to the solution for this exercise in this [Rust Playground][RustPlay-answer].


<!-- Links -->
<!-- [Rust-loops]: /learn/modules/rust-loop-expressions/index?azure-portal=true -->

[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=45ca994a26aceaec69453e81b8de78b8?azure-portal=true

[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=d348ed467e20aa2a39e5f04da0e58c3d?azure-portal=true
