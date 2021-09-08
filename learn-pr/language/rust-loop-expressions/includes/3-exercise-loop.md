In this exercise, you'll modify a car factory program to use a loop to iterate through the car orders.

The program declares several types of data to track information about the car orders. The `car_quality` function takes the car mileage as an input argument and determines if the car is new or used. The `main` function calls the `car_factory` function to fulfill orders for three cars. The program uses a few `if/else` conditions to prepare the orders. 

We'll update the `main` function to use a loop to process orders for 11 cars. To support greater variety in the orders, we'll add more `if/else` conditions.

Your challenge is to finish the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:
- Copy the code and edit it in your local development environment. 
- Open the code in a prepared Rust Playground.

In the sample code, look for the words `TO DO` to locate the sections to update.


## Load the current program

The first step is to get the existing program code.

1. Open the existing program code for editing. The code includes data type declarations, and definitions for the `car_quality`, `car_factory`, and `main` functions.

    Copy the following code and edit it in your local development environment,<br>
    or open the code in this prepared [Rust Playground][RustPlay-exercise].

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
        // Use the "mut" keyword so quality can be changed later
        let mut quality: (String, u32) = (String::from("New"), 0);

        // Use a conditional expression to check the miles
        // If the car has accumulated miles, then the car is used
        if miles > 0 {
            // Set the quality value for a used car
            quality = (String::from("Used"), miles);
        }

        // Return the completed tuple, no semicolon needed
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

    //////////////////////////////////////////////////

    fn main() {
        // Create car color array
        // 0 = Blue, 1 = Green, 2 = Red, 3 = Silver
        let colors = ["Blue", "Green", "Red", "Silver"];

        // Initialize counter variable
        let mut order = 1;
        
        // Declare the car type and initial values
        // - Declare "car" as mutable "Car" struct
        // - Declare "engine" as mutable "Transmission" enum
        // - When car has a hard top, "roof" = true
        let mut car: Car;
        let mut miles = 1000; // Start used cars with 1,000 miles
        let mut engine: Transmission;
        let roof = true;      // convertible = false | hard top = true

        //////////////////////////////////////////////////
            
        // Order 3 cars, one car for each type of transmission
        // Use "order" variable, initialize to 1, increment before each order
        // Index into "colors" array, vary color for the orders
        
        // Car order #1: Used
        engine = Transmission::Manual;
        car = car_factory(String::from(colors[order-1]), engine, roof, miles);
        println!("{}: {}, Hard top {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
        
        // Car order #2: Used
        order = order + 1;
        miles = miles + 1000;
        engine = Transmission::SemiAuto;
        car = car_factory(String::from(colors[order-1]), engine, roof, miles);
        println!("{}: {}, Hard top, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
    
        // Car order #3: New
        order = order + 1;
        miles = 0;
        engine = Transmission::Automatic;
        car = car_factory(String::from(colors[order-1]), engine, roof, miles);
        println!("{}: {}, Hard top, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);

        //////////////////////////////////////////////////

    }

    ```

1. Build the program. Make sure the code compiles and runs before you continue to the next section. You can ignore *warning* messages from the compiler.

You should see the following output:

```output
1: Used, Hard top Manual, Blue, 1000 miles
2: Used, Hard top, SemiAuto, Green, 2000 miles
3: New, Hard top, Automatic, Red, 0 miles
```


## Use a loop expression to repeat actions

The current program fulfills orders for three cars, and all cars have a hard top roof. Now we'll update the program to support more orders and use a greater variety of car options.

Our `main` function needs a loop expression to repeat actions to create each car order. We're going to order a total of 11 cars.

The primary action is to call the `car_factory` function to create each order. The function call expects a color for the car. We need to correct how we're indexing into the `colors` array, so we actually pass a color as expected.

Near the end of the loop, we'll adjust the values for some of the counting variables. 

1. In the `main` function, replace the statements between the lines of slashes `/////` with the following code:

    ```rust
        // Order 11 cars
        // TO DO: Replace "loop expression" - loop 11 times, use "order" variable
        loop expression {
            
            // Set car transmission type
            engine = Transmission::Manual;

            // Order the cars, New are even numbers, Used are odd numbers
            // TO DO: Fix indexing into `colors` array, vary color for the orders
            if index % 2 != 0 {
                car = car_factory(String::from(colors()), engine, roof, miles);
            } else { 
                car = car_factory(String::from(colors()), engine, roof, 0);
            }
            
            // Display car order details
            println!("{}: {}, Hard top, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);

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

1. We need a second counting variable to support our loop processing. Find the statement that initializes the `order` variable. Initialize a second variable named `index` and set it to 1.

1. Replace the `loop expression` with a loop statement to repeat the actions in the loop expression body 11 times. Use the `order` variable that you defined at the beginning of the `main` function, which is initialized to 1.

1. Fix the indexing into the `colors` array by correcting the `colors()` syntax. We need to pass a specific color like "Blue" to the `car_factory` function. The array has four elements, so we'll try to loop through them as we fulfill the orders. Use the `index` variable. We want to vary the color that we use for the orders. 

    > [!Tip]
    > Elements in an array start from index location 0. The value for the first element is at index location 0.

1. Near the end of the loop, increment the `order` variable by 1, and the `miles` variable by 1,000. Depending on how you specify numbers over 100, you might discover that in Rust, you can't use a comma `,` in an integer value.
        
1. Build your program. Make sure the code compiles without any errors. You can ignore any warning messages.


## Run the program

When the program is complete, you should see output similar to this example:
    
 ```output
1: Used, Hard top, Manual, Blue, 1000 miles
2: New, Hard top, Manual, Green, 0 miles
3: Used, Hard top, Manual, Red, 3000 miles
4: New, Hard top, Manual, Silver, 0 miles
5: Used, Hard top, Manual, Blue, 5000 miles
6: New, Hard top, Manual, Green, 0 miles
7: Used, Hard top, Manual, Red, 7000 miles
8: New, Hard top, Manual, Silver, 0 miles
9: Used, Hard top, Manual, Blue, 9000 miles
10: New, Hard top, Manual, Green, 0 miles
11: Used, Hard top, Manual, Red, 11000 miles
```

Right now, all the car orders are for manual transmission and a hard top roof. In the next exercise, we'll get more creative. We'll use more complex conditions, and implement a hash map to add variety to our orders and output.


## Solution

You can compare your program output to the solution for this exercise in this [Rust Playground][RustPlay-answer].


<!-- Links -->
[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=15708589114431702e84136d7dc09626?azure-portal=true
[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=856d172a4d546ea39087e30f11593e42?azure-portal=true
