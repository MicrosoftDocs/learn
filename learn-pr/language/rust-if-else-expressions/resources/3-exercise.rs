#[derive(PartialEq, Debug)]
// Declare Car struct to describe vehicle with four named fields
// TO DO: Replace "mileage" field from previous exercise with "age" field
// TO DO: "age" field should be tuple value of two fields: String, u32
struct Car {
    color: String,
    motor: Transmission,
    roof: bool,
    mileage: u32,
}

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
    // TO DO: Define "quality" 
    // - Set the value to a "New" car
    // - Set the mileage using the "miles" input argument    
    let quality: (String, u32);

    // TO DO: Return the completed tuple
    return 
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
    // TO DO: Replace the "mileage" field with an "age" field
    // TO DO: The "age" field calls the "car_quality" function with the "miles" input argument 
    let car = Car {
        color: color,
        motor: motor,
        roof: roof,
        mileage: miles
    };

    // Return new instance of "Car" struct
    return car
}

//////////////////////////////////////////////////

fn main() {
    // Create car color array
    // TO DO: Set the values: 0 = Blue, 1 = Green, 2 = Red, 3 = Silver
    let colors;
    
    // Declare the car type and initial values
    // TO DO: Create "car" as a "Car" struct
    // TO DO: Create "engine" as a "Transmission" enum
    let mut car: Car;
    let mut engine: Transmission;
    
    //////////////////////////////////////////////////

    // Order 3 cars, one car for each type of transmission
    // TO DO: Fix indexing into `colors` array, vary the color for each order

    // Car order #1: New, Manual, Hard top
    engine = Transmission::Manual;
    car = car_factory(String::from(colors<index>), engine, true, 0);
    println!("Car order 1: {}, Hard top = {}, {:?}, {}, {} miles", car.age.0, car.roof, car.motor, car.color, car.age.1);
    
    // Car order #2: New, Semi-automatic, Convertible
    // TO DO: Adjust the Transmission value syntax
    engine = Transmission.SemiAuto;
    car = car_factory(String::from(colors<index>), engine, false, 100);
    println!("Car order 2: {}, Hard top = {}, {:?}, {}, {} miles", car.age.0, car.roof, car.motor, car.color, car.age.1);

    // Car order #3: New, Automatic, Hard top
    engine = Transmission::Automatic;
    car = car_factory(String::from(colors<index>), engine, true, 200);
    println!("Car order 3: {}, Hard top = {}, {:?}, {}, {} miles", car.age.0, car.roof, car.motor, car.color, car.age.1);
}