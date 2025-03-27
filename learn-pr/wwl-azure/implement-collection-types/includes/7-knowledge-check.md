## Multiple Choice
What is the primary characteristic of a `HashSet<T>` in C#?
( ) It allows duplicate elements. {{Incorrect. `HashSet<T>` doesn't allow duplicate elements, making it ideal for scenarios requiring uniqueness.}}
( ) It stores elements as key/value pairs. {{Incorrect. Storing elements as key/value pairs is a characteristic of `Dictionary<TKey, TValue>`, not `HashSet<T>`.}}
(x) It ensures uniqueness of elements. {{Correct. `HashSet<T>` is designed to ensure that all elements are unique, which is its primary characteristic.}}

## Multiple Choice
A banking application needs to store customer IDs with their associated account details for quick retrieval. Which collection should be used?
( ) `List<Account>` {{Incorrect. `List<Account>` is suitable for ordered records but doesn't provide quick look-up by customer ID.}}
(x) `Dictionary<int, Account>` {{Correct. `Dictionary<int, Account>` is ideal for associating customer IDs with account details, enabling efficient look-up by key.}}
( ) `HashSet<Account>` {{Incorrect. `HashSet<Account>` ensures uniqueness but doesn't support key-based look-up, which is required in this scenario.}}

## Multiple Choice
Which of these collections in C# supports dynamic resizing and access to elements by index?
(x) List&#60;T&#62; {{Correct. List&#60;T&#62; supports dynamic resizing and allows access to elements by their index, making it versatile for various scenarios.}}
( ) `Dictionary<TKey, TValue>` {{Incorrect. `Dictionary<TKey, TValue>` stores elements as key/value pairs and doesn't provide index-based access.}}
( ) `HashSet<T>` {{Incorrect. `HashSet<T>` is designed for set operations and doesn't support index-based access or dynamic resizing.}}
