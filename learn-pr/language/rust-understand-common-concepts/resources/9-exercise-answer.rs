use std::collections::HashMap;

fn fruit_basket() -> HashMap<String, u32> {
    let mut basket: HashMap<String, u32> = HashMap::new ();

    basket.insert(String::from("banana"), 2);
    basket.insert(String::from("orange"), 2);
    basket.insert(String::from("apple"), 2);
    
    return basket;
}

fn main() {

    let basket = fruit_basket();
    let kinds = basket.len();
    let pieces = basket.values().sum::<u32>();
    
    assert!(
        kinds >= 3,
        "basket must have at least three types of fruits"
    );
    
    assert!(
        pieces >= 5,
        "basket must have at least five fruits"
    );
    
    // Show our fruit basket
    println!("The basket has {} pieces of {} different kinds of fruit.", pieces, kinds);

}
