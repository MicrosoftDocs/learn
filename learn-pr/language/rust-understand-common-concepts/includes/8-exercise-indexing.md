In this exercise, you'll use collections and compound data types to expand on the car factory.

We'll use a tuple to track car quality with two values that are related, but have different data types. We'll create a new function named `car_quality` that returns this tuple to the calling this function. Our `main` function will use a loop expression to repeat actions to create each car order. And along the way, we'll use a few conditional expressions to test results and make assignments. 

Your challenge is to finish the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:
- Copy the code and edit it in your local development environment. 
- Open the code in a prepared Rust Playground.

In the sample code, look for the words `TO DO` to locate the sections to update.


## Update the Car struct to have a tuple field

Your first task is to change the `Car` struct definition. We're going to move the `mileage` field into a tuple field named `age`. Along with the mileage value, the `age` tuple needs another field to identify if the car is new or used.

1. Open the first block of sample code.

    Copy the following code and edit it in your local development environment, or open the code in this prepared [Rust Playground][RustPlay-exercise].

    ```rust
    #[derive(PartialEq, Debug)]
    // Declare Car struct to describe vehicle with four named fields
    // TO DO: Replace the "mileage" field from the previous exercise with an "age" field
    // TO DO" The "age" field should hold tuple value of two fields: String, u32
    struct Car {
        color: String,
        motor: Transmission,
        roof: bool,
        mileage: u32,
    }

    #[derive(PartialEq, Debug)]
    // Declare enum for Car transmission type
    enum Transmission { Manual, SemiAuto, Automatic }
    ```

1. Correct the declaration of the `Car` struct.

    1. Remove the `mileage` field.
    1. Add a tuple field named `age` to hold the car mileage and the text "New" or "Used" to describe the car quality.
    
    > [!Tip]
    > The `String` data type can be used for the "New" and "Used" values.
 
1. Build the program. Make sure the code compiles before you continue to the next section.

    The code doesn't display any output yet, but it needs to compile without any errors. You can ignore *warning* messages from the compiler. The warnings are because you declared enum and struct definitions, but haven't used them yet.


## Create the car_quality function

Next, we'll add code for a new function named `car_quality`. This function will take the car mileage as an input argument. Based on the mileage, we'll determine if the car is new or used. We'll create a tuple to hold the mileage and car quality. The function will return the tuple to the caller.

1. Add the following code block to your existing code. You can add the new code at the top of the file or at the bottom.

    ```rust
    // Get the car quality by testing the value of the input argument
    // - miles (u32)
    // Create a tuple for the car quality with the age ("New" or "Used") and miles
    // Return a tuple with the arrow `->` syntax
    fn car_quality (miles: u32) -> (String, u32) {

        // Declare and initialize the return tuple value
        // For a new car, set the miles to 0
        // TO DO: Correct the quality declaration so we can change the values later
        let quality: (String, u32) = ("New".to_string(), 0);

        // Use a conditional expression to check the miles
        // If the car has accumulated miles, then the car is used
        if miles > 0 {
            // TO DO: Add the code to set the quality value for a used car
            quality;
        }

        // TO DO: Return the completed tuple
        return 
    }
    ```

1. Fix the syntax error in the declaration for the `quality` tuple. We need to be able to change the values in the tuple when we run the program.
 
1. Complete the code to set the `quality` tuple values for a used car. When a car is "New," we set the mileage to 0. When the car is "Used," we get the value from the `miles` input argument.

1. Update the `return` statement at the end of the function, so it sends the completed tuple back to the caller.

1. Build your program. Make sure the code compiles before you continue to the next section. The code doesn't display any output yet, but it needs to compile without any errors.


## Update the car_factory function

The next step is to update the car_factory function from the previous exercise. We need to support the tuple returned from the `car_quality` function. We updated the definition of the `Car` struct, so we need to adjust the function body to correctly process the data.

1. Add the following code block to your existing code. You can add the new code at the top of the file or at the bottom.

    ```rust
    // Build a new "Car" using the values of four input arguments
    // - color (String)
    // - motor (Transmission enum)
    // - roof (boolean, true if the car has closed roof)
    // - miles (u32)
    // Call the car_quality(miles) function to get the car age
    // Return an instance of a "Car" struct with the arrow `->` syntax
    fn car_factory(color: String, motor: Transmission, roof: bool, miles: u32) -> Car {
    
        // Create a new "Car" instance as requested
        // - Bind first three fields to values of input arguments
        // TO DO: Replace the "mileage" field from the previous exercise with an "age" field
        // TO DO" The "age" field calls the "car_quality" function with the "miles" input argument 
        let car = Car {
            color: color,
            motor: motor,
            roof: roof,
            mileage: miles
        };
    
        // Return new instance of "Car" struct
        return car
    }
    ```

1. Correct the initialization of the `car` variable.

    1. Remove the `mileage` field.
    1. Add a field named `age`. This field should call the `car_quality` function with the `miles` input argument
 
1. Build the program. Make sure the code compiles before you continue to the next section.


## Set main function variables

Now we're ready to start working on our `main` function. The first step is to define variables we'll use throughout the program:

- An array for car colors
- A struct for each car order
- An enum to describe the Transmission type
- An integer to hold the number of car miles
- A boolean to describe the type of roof
- Some integer variables for counting

1. Add the following code block for the `main` function to your existing code. You can add the new code at the top of the file or at the bottom.

    ```rust
    fn main() {
        // Create car color array
        // TO DO: Set the values: 0 = Blue, 1 = Green, 2 = Red, 3 = Silver
        let colors;
    
        // Initialize variables
        let (mut index, mut order) = (1, 1);
        
        // Declare the car type and initial values
        // TO DO: Create "car" as a "Car" struct
        // TO DO: Create "engine" as a "Transmission" enum
        // TO DO: Initialize "roof" to the value when the car has a hard top
        let car = Car;
        let mut miles = 1000; // Start used cars with 1,000 miles
        let mut roof;  // convertible = false | hard top = true
        let engine = Transmission;
        
    }
    ```

1. Complete the definition for the `colors` array variable. A car can be one of four colors: Blue, Green, Red, or Silver.

1. Fix the declaration syntax for the `car` struct and `engine` enum variables. At this point in the program, we need to define the data type structure, but not add any specific values.

    > [!Tip]
    > Don't forget to create both variables as changeable.

1. Initialize the `roof` boolean and set it to the value that shows the car has a hard top.

1. Build your program. Make sure the code compiles without any errors before you continue to the next section.


## Use a loop expression for repeated actions

Our `main` function needs a loop expression to repeat actions needed to create each car order. We're going to order a total of 11 cars.

The primary action is to call the `car_factory` function to create each order. The function call expects a color for the car. We need to correct how we're indexing into the `colors` array, so we actually pass a color as expected.

Near the end of the loop, we'll adjust the values for some of the counting variables. 

1. Add the following code block to your `main` function. Place this code after the definitions you added in the last step, and before the closing curly brace `}` for the function.

    ```rust
        // Order 11 cars
        // TO DO: Replace "loop expression" - loop 11 times, use "order" variable
        loop expression {
            
            // Set car transmission type
            engine = Transmission::Manual;

            // Order the cars, New are even numbers, Used are odd numbers
            // TO DO: Fix indexing into `colors` array, vary color for the orders
            if index % 2 != 0 {
                car = car_factory(colors().to_string(), engine, roof, miles);
            } else { 
                car = car_factory(colors().to_string(), engine, roof, 0);
            }
            
            // Display car order details
            println!("{}: {}, Closed roof, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);

            // Change values for next loop
            // TO DO: Increment "order" by 1, and "miles" by 1,000
            order;
            miles;
            
            // Adjust the index for the car details
            // Order 11 cars, use index range of 0 -- 4, then repeat from 0
            if index < 4 {
                index = index + 1;
            } else {
                index = 1;
            }
        }
    ```

1. Replace the `loop expression` with a loop statement to repeat the actions in the loop expression body 11 times. Use the `order` variable that you defined at the beginning of the `main` function, which is initialized to 0.

1. Fix the indexing into the `colors` array by correcting the `colors()` syntax. We need to pass a specific color like "Blue" to the `car_factory` function. The array has four elements, so we'll try to loop through them as we fulfill the orders. Use the `index` variable. We want to vary the color that we use for the orders. 

    > [!Tip]
    > Elements in an array start from index location 0. The value for the first element is at index location 0.

1. Near the end of the loop, increment the `order` variable by 1, and the `miles` variable by 1,000. Depending on how you specify numbers over 100, you might discover that in Rust, you can't use a comma `,` in an integer value.
        
1. Build your program. Make sure the code compiles without any errors. You can ignore any warning messages.


## Run the program

When the program is complete, you should see output similar to this example:
    
 ```output
1: Used, Closed roof, Manual, Blue, 1000 miles
2: New, Closed roof, Manual, Green, 0 miles
3: Used, Closed roof, Manual, Red, 3000 miles
4: New, Closed roof, Manual, Silver, 0 miles
5: Used, Closed roof, Manual, Blue, 5000 miles
6: New, Closed roof, Manual, Green, 0 miles
7: Used, Closed roof, Manual, Red, 7000 miles
8: New, Closed roof, Manual, Silver, 0 miles
9: Used, Closed roof, Manual, Blue, 9000 miles
10: New, Closed roof, Manual, Green, 0 miles
11: Used, Closed roof, Manual, Red, 11000 miles
```

Right now, all our car orders are for manual transmission and a closed roof. In the next exercise, we'll get more creative and use some complex conditions and hash maps to add variety to our orders and output.

You can compare your program output to the solution for this exercise in this [Rust Playground][RustPlay-answer].


<!-- Links -->
[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=193c6ae24f21b9b229f1f32da7c45bfd?azure-portal=true

[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=d348ed467e20aa2a39e5f04da0e58c3d?azure-portal=true
