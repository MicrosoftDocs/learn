

Knowing how to instantiate objects, or bring them to life, in your code and how to free up memory by removing them later is helpful. You must allocate memory for your objects before you can use them. The class lifecycle is the process of allocating and deallocating memory for your objects.

When you create or *new* an object (also known as instantiating an object) and later no longer need it, the following things happen in the class lifecycle:

- Allocation of memory
- Initialization or instantiation of the class
- Deallocation to free memory

## Allocation

During allocation, you allocate memory for the class containing the functionality you need to access.

## Instantiation

Objects require initialization before you can use them. You initialize classes using a process called instantiation. When you instantiate an object, you automatically call a constructor method within the class. If you pass parameters into the constructor, those parameters give the object the starting values it needs to do its job.

A class is instantiated and put in memory using the __new__ keyword. After instantiation, you can access the functionality of the class within your code.

## Deallocation

The Common Language Runtime (CLR) determines if a reference exists to an object, meaning that other objects in your code refer to it. If no references exist, the object goes into what is called garbage collection and is deallocated from memory. Today many common programming languages, including C#, handle deallocation for you using garbage collection. It's helpful to understand the concepts of deallocation and garbage collection so that you understand what is taking place under the hood when your objects are no longer being used.

## Garbage collector

The garbage collector performs Deallocation. When an object is no longer being referenced, it's said to have gone out of scope. And when an object goes out of scope, the garbage collector deletes it, freeing up the memory used by the object.