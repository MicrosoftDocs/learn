
Object-oriented programming, OOP, is a programming paradigm. It has the idea of _grouping_ related data and functions into islands of information. These islands are known as objects.

Regardless of paradigm, programs use the same series of steps to solve problems:

1. **Data input**. Data is read from somewhere, could be a data storage like a file system or a database.
1. **Processing**. At this point, the data is being interpreted and possibly altered to be prepared for display.
1. **Data output**. Lastly the data is being presented so that it can be read and interacted with either by a physical user or by a system.

Lets try to define what OOP is by comparing it to another paradigm: procedural programming. Procedural programming sets out to solve a given problem by calling procedures, also known as functions or methods. Functions and variables are constructed to address the various phases described above.

The OOP paradigm is no different in that aspect, but what really makes it stand out is how it looks upon the world. Compared to procedural programming, OOP _takes a step_ back and tries to look at the bigger picture. Rather than just working on data, and taking it from one phase to the next, it tries to understand the world in which the data operates. It does so by _modeling_ what it sees.

### OOP Modeling, identify concepts

During this _modeling_ phase, you look at a description of a domain and try to analyze the text on what takes place. The first step is in identifying Actors. They are called Actors as they _act_ and performs an action, for example a printer (actor) prints (action). Once actors are identified, you look at _what_ they do, their behavior. Then you look at description of the actors and any data that's needed to carry out the action. Actors are made into objects, the traits are encoded as data on the objects and the behaviors are functions that also get added to the object.

The idea is then that data on objects, can be altered by calling functions on the objects themselves. There's also the notion that objects _interact_ with one another to achieve a tangible result.  

## Benefits of OOP

So why OOP, why not some other paradigm? Just to make it clear. OOP isn't better or worse than any other paradigm, there's pros and cons to everything, but it does have some nice benefits, and here are some of those benefits:

- **Data encapsulation**. Data encapsulation is about hiding data away from the rest of the system and only allows access to parts of it. The reason is data holds _state_ and that state can be made up of one or more variables. If these variables need to be changed at the same time, you need to protect them and only allow access via public methods, so that changes are made in a predictable way. OOP has mechanisms like access levels where data, that's on an object, can only be accessed by the object itself or can be made publicly available.
- **Simplicity**. Building large systems is a complex task, there are many problems to solve. Being able to break down the complexity into smaller problems, to objects, means you are able to _simplify_ the overall task.
- **Easy to modify**. When you rely on objects and model your system with it, it becomes easier to track down what parts of the system needs modifying, if you need to correct a bug or add a new feature for example.
- **Maintainability**. Maintaining code in general is hard, and it becomes harder over time. It requires discipline in the form of good naming and a clear and consistent architecture among other things. Using objects means it can be easier to locate a specific area of your code that needs maintaining.
- **Reusability**. An object's definition can be used many times in many parts of your system or potentially in other systems as well. Being able to reuse code means saving time and money, as you need to write less code and you reach your target faster.

## Model an OOP system

Software is often written to address a need to make something faster, more efficient, and less error prone. People simply can't compete with software when it comes to speeding up a process in certain cases. Using OOP is as much a modeling exercise as it's about writing the code to implement its logic. Modeling is about learning to identify the actors of it, the data needed, and what type of interaction that takes place. You can model a system just by reading a description of it.

### A case study, an invoice management system

Let's exemplify a manual flow that many companies struggle with, namely _invoice management_. Invoices are something many companies receive and that the company needs to pay on time, or there will be late fees, e.g wasted money. Before an invoice can be paid, it needs to be _processed_. It's common for an invoice to pass a few hands before it ends up being registered somewhere and payment is made. It usually starts with an initial sorting phase where the invoice is sent to the _correct_ department. Then it's checked for correctness followed by an approval by someone who has the proper authorization level. Lastly the invoice is being paid. If you are a small business, it might be the business owner that does all of the above. In a large company there might be a ton of people and process involved, and _invoice management_ becomes a complex activity.

What does this description have to do with OOP? If you were to take the above, which is often a manual flow, and turn that flow into written software, the first thing you would do is try to model the system. With the context of _invoice management_ you can start seeing actors (objects), behaviors, and data by just reading a description of the problem domain.

If you think about the described domain as having the phases, input, processing, and output, you can start to fill things in like the below table:

|Phase      |What                         |
|-----------|-----------------------------|
|Input      |Invoice                      |
|Processing |Sorting, Approval, Rejection |
|Output     |Payment                      |

The above table describes what goes on at each phase and you've been able to find the data, things that happen to the data, during processing, and what it ultimately ends up as, a payment. At this point, you can still solve it with any paradigm you like. How do you take it from here into OOP?  

### Finding objects, data and behavior

You find the different artifacts of your system by asking questions like _who interacts with whom_ or _who does what to whom_.

With such questions at the back of your mind, you come up with statements. Let's highlight the different artifacts in these statements so it becomes clear what parts are important to our system.

1. The _Mail service_ _delivers_ an _Invoice_ to the system.

1. The _Invoice_ is _sorted_ by either a _reference code_ or manually by a _Sorter_ to ensure it ends up in the correct department.

1. The _Invoice_ is _approved_ or _rejected_ by an _Approver_ based on factors like, for example,  correctness and size of the _amount_.

1. The _Invoice_ is _paid_ by a _Payment processor_, using the _payment information_ provided.

You can now extract objects, data, and behavior from the sentences and organize it in a table like so:

|Phase     | Object            |Behavior          | Data
|----------|-------------------|------------------|------------------------------|
|Input     | Mail service      | delivers         | Invoice                      |
|Input     | System            | receives         | Invoice                      |
|Processing| Sorters or System | sorts/routes     | Invoice(reference code)      |
|Processing| Approver          | approves/rejects | Invoice(amount)              |
|Output    | Payment processor | pays             | Invoice(payment information) |

A lot has happened to the initial description of the invoice management system. Actors (objects) have been found. Important data has been identified and _grouped_ with identified objects. Behavior has been found as well, which makes it clearer what actors (objects) interact with one another. Thereby you've been able to pinpoint _who_ does what behavior to _whom_. You've done an initial analysis at this point, a great start. But the question remains, how do you turn this analysis into code? The answer to that question is what we will be solving throughout this module.

> [!NOTE]
> An actual invoice management system is likely a lot more complex and could rely on much more data and logic. Being able to model a system this way means you have a structured approach to think about the problem.
