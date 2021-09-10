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
    // Use "order" variable, initialize to 0, increment before each order
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

    // SECOND VERSION OF MAIN BODY

    //////////////////////////////////////////////////

    // Create car color array
    // 0 = Blue, 1 = Green, 2 = Red, 3 = Silver
    let colors = ["Blue", "Green", "Red", "Silver"];

    // Initialize two counter variables, set both to 1
    // TO DO: Add second variable named "index"
    let mut order = 1;
        
    // Declare the car type and initial values
    // - Declare "car" as mutable "Car" struct
    // - Declare "engine" as mutable "Transmission" enum
    // - When car has a hard top, "roof" = true
    let mut car: Car;
    let mut miles = 1000; // Start used cars with 1,000 miles
    let mut engine: Transmission;
    let roof = true;      // convertible = false | hard top = true

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
}
