

When we define a class, we often encapsulate (or hide) many resources within the class. To use these resources, we need memory to be allocated to represent the type, also known as, class. Understanding how objects are instantiated, or bought to life, in your code and later taken out of memory, freeing up precious resources is helpful to know. This process of allocating and deallocating memory for your objects is called the Class Lifecycle.

When we create or *new* (or instantiate) an object and later no longer need it, the following things happen in the class lifecycle:
- Allocation of memory.
- Initialization or instantiation of the class.
- Deallocation to free memory.

##Allocation

During allocation, memory is allocated for the class containing the functionality you need to access.

##Instantiation

Objects require initialization to be performed before they can be used. Classes are initialized using a process called instantiation, where a constructor method within the class is accessed when put in memory using the new keyword. After instantiation, you can access the functionality of the class within your code.

##Deallocation

The common language runtime determines if a reference exists to an object, meaning that other objects in your code refer to it. If no references exist, the object goes into what is called garbage collection and is deallocated from memory. Today many common programming languages, including C#, handle deallocation for you using garbage collection. It's helpful to understand the concepts of deallocation and garbage collection so that you understand what is taking place under the hood when your objects are no longer being used.

##Garbage Collector

The Garbage Collector performs Deallocation. It frees the memory used by the object.

Question: What is the difference between allocation and instantiation?

Additional Reading

- Garbage Collection: Automatic Memory Management in the Microsoft .NET Framework\
- Garbage Collection
 