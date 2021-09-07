#[derive(PartialEq, Debug)]
// Declare Car struct to describe vehicle with four named fields
// Corrected code: "mileage" u32 field removed, "age" tuple field added
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
    // Corrected code: Use the "mut" keyword so quality can be changed later
    let mut quality: (String, u32) = ("New".to_string(), 0);

    // Use a conditional expression to check the miles
    // If the car has accumulated miles, then the car is used
    if miles > 0 {
        // Corrected code: Set the quality value for a used car
        quality = ("Used".to_string(), miles);
    }

    // Corrected code: Return the completed tuple, no semicolon needed
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

    // Add an if/else conditional expression to describe the car to build
    // Call car_quality(miles) to help determine if order is for a new or used car
    // Corrected code: Assign "quality" to the first element of the return value
    // Corrected code: Check if the order is for a new or used car
    // Corrected code: Check if the "roof" is hard top or convertible
    let quality = car_quality(miles).0;
    if quality == "Used" {
        if roof {
            println!("Preparing a used car: {:?}, {}, Hard top", motor, color);
        } else {
            println!("Preparing a used car: {:?}, {}, Convertible", motor, color);
        }
    } else {
        if roof {
            println!("Building a new car: {:?}, {}, Hard top", motor, color);
        } else {
            println!("Building a new car: {:?}, {}, Convertible", motor, color);
        }
    }

    // Create a new "Car" instance as requested
    // - Bind first three fields to values of input arguments
    // Corrected code: "mileage" is replaced with "age"
    // Corrected code: - Bind "age" to tuple returned from car_quality(miles)
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
    // Corrected code: 0 = Blue, 1 = Green, 2 = Red, 3 = Silver
    let colors = ["Blue", "Green", "Red", "Silver"];

    // Initialize counter variable
    let mut order = 1;
    
    // Declare the car type and initial values
    // Corrected code: Declare "car" as mutable "Car" struct
    // Corrected code: Declare "engine" as mutable "Transmission" enum
    // Corrected code: When car has hard top, "roof" = true
    let mut car: Car;
    let mut miles = 1000; // Start used cars with 1,000 miles
    let mut engine: Transmission;
    let roof = true;      // convertible = false | hard top = true

    //////////////////////////////////////////////////
        
    // Order 3 cars, one car for each type of transmission
    // Use "order" variable, initialize to 0, increment before each order
    // Corrected code: Index into `colors` array, vary color for the orders
    
    // Car order #1: Used
    engine = Transmission::Manual;
    car = car_factory(colors[order-1].to_string(), engine, roof, miles);
    println!("{}: {}, Hard top, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
    
    // Car order #2: Used
    order = order + 1;
    miles = miles + 1000;
    // Corrected code: Transmission value syntax
    engine = Transmission::SemiAuto;
    car = car_factory(colors[order-1].to_string(), engine, roof, miles);
    println!("{}: {}, Hard top, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
 
    // Car order #3: New
    order = order + 1;
    // Corrected code: Set miles to zero to order a New car
    miles = 0;
    engine = Transmission::Automatic;
    car = car_factory(colors[order-1].to_string(), engine, roof, miles);
    println!("{}: {}, Hard top, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
}
