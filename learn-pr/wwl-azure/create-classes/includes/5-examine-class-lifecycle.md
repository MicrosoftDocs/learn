

When we define a class, we often encapsulate (or hide) many resources within the class. To use these resources, we need memory to be allocated to represent the type, also known as, class. Understanding how objects are instantiated, or bought to life, in your code and later taken out of memory, freeing up precious resources is helpful to know. This process of allocating and deallocating memory for your objects is called the Class Lifecycle.

When we create or *new* (or instantiate) an object and later no longer need it, the following things happen in the class lifecycle:
- Allocation of memory.
- Initialization or instantiation of the class.
- Deallocation to free memory.

## Allocation

During allocation, memory is allocated for the class containing the functionality you need to access.

## Instantiation

Objects require initialization to be performed before they can be used. Classes are initialized using a process called instantiation, where a constructor method within the class is accessed when put in memory using the new keyword. After instantiation, you can access the functionality of the class within your code.

## Deallocation

The common language runtime determines if a reference exists to an object, meaning that other objects in your code refer to it. If no references exist, the object goes into what is called garbage collection and is deallocated from memory. Today many common programming languages, including C#, handle deallocation for you using garbage collection. It's helpful to understand the concepts of deallocation and garbage collection so that you understand what is taking place under the hood when your objects are no longer being used.

## Garbage Collector

The Garbage Collector performs Deallocation. It frees the memory used by the object.  

&nbsp;
## Check your knowledge

## Multiple Choice
What is the difference between memory allocation/de-allocation and instantiation?
( ) They are the same. {{Incorrect. Although related, the allocation/de-allocation of memory and instantiation are not the same.}}
( ) Instatiation occurs before allocation. {{Incorrect. The allocation of memory occurs when you "new" or instantiate your objects.}}
(x) Allocation/de-allocation has to do with memory management for your objects and instantiation is about actually creating the objects. {{Correct! A roof is something that all houses have and would be appropriate for a house class to have.}}

## Multiple Choice
What is garbage collection?
( ) A a process of removing system level resources. {{Incorrect. Garbage collection has nothing to do with system resources, but with the freeing up of user defined objects in memory.}}
( ) When the garbage man collects the garbage at my home. {{Incorrect. Although certainly the form of garbage collection we are most used to, it does not apply to computer programming.}}
(x) Automatic Memory Management. {{Correct! Garbage collection is the automatic de-allocation of objects in memory when they are no longer being used.}}