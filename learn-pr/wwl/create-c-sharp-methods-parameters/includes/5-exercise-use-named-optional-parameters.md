

The C Sharp language allows the use of named and optional parameters. These types of parameters let you select which arguments you want to supply to the method, so you aren't restricted to the structure defined in the method signature.

Named arguments allow you to specify the value for a parameter using its name rather than position. Optional parameters allow you to omit those arguments when calling the method.

In this exercise, you'll learn how to use both named and optional parameters.

### Create an RSVP application

In this task, you'll create a brief application for guests to RSVP to an event. The guests will provide their party size and any allergies. You'll also add the option to restrict RSVPs to an invite-only guest list.

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Type the following code into the Visual Studio Code Editor:

    ```c#
    string[] guestList = {"Rebecca", "Nadia", "Noor", "Jonte"};
    string[] rsvps = new string[10];
    int count = 0;

    void RSVP(string name, int partySize, string allergies, bool inviteOnly) 
    {
        if (inviteOnly)
        {
            // search guestList before adding rsvp
        }

        rsvps[count] = $"Name: {name}, \tParty Size: {partySize}, \tAllergies: {allergies}";
        count++;
    }

    void ShowRSVPs()
    {
        Console.WriteLine("\nTotal RSVPs:");
        for (int i = 0; i < count; i++)
        {
            Console.WriteLine(rsvps[i]);
        }
    }
    ```

    In this code, you create variables to store the guest list and rsvps. The `RSVP` method appends guest information to the list, and the `ShowRSVPs` method displays the total RSVPs using the tab escape sequence to separate guest information.

1. Enter the following code in the `RSVP` method to search the guest list:

    ```c#
   if (inviteOnly)
    {
        bool found = false;
        foreach (string guest in guestList)
        {
            if (guest.Equals(name)) {
                found = true;
                break;
            }
        }
        if (!found)
        {
            Console.WriteLine($"Sorry, {name} is not on the guest list");
            return;
        }
    }
    ```

    In this code, you check to see if the given name is equal to any of the names on the guest list. If a match is found, you set `found` to true and break out of the `foreach` loop. If `found` is false, you display a message and use the `return` keyword to terminate the method.

1. Call your method by adding the following code above the `RSVP` method signature:

    ```c#
    RSVP("Rebecca", 1, "none", true);
    RSVP("Nadia", 2, "Nuts", true);
    RSVP("Linh", 2, "none", false);
    RSVP("Tony", 1, "Jackfruit", true);
    RSVP("Noor", 4, "none", false);
    RSVP("Jonte", 2, "Stone fruit", false);
    ShowRSVPs();
    ```

1. Save and run the code to observe the following output:

    ```Output
    Sorry, Tony is not on the guest list

    Total RSVPs:
    Name: Rebecca,  Party Size: 1,  Allergies: none
    Name: Nadia,    Party Size: 2,  Allergies: Nuts
    Name: Linh,     Party Size: 2,  Allergies: none
    Name: Noor,     Party Size: 4,  Allergies: none
    Name: Jonte,    Party Size: 2,  Allergies: Stone fruit
    ```

### Use named arguments

When calling a method that accepts many parameters, it can be tricky to understand what the arguments represent. Using named arguments can improve the readability of your code. Use a named argument by specifying the parameter name followed by the argument value. In this task, you'll practice using named arguments.

1. Locate the following line of code: `RSVP("Linh", 2, "none", false);`

1. Update the method call as follows:

    ```c#
    RSVP(name: "Linh", partySize: 2, allergies: "none", inviteOnly: false);
    ```

    Notice that you supply the name of the parameter, followed by a colon and the value. This syntax defines a named argument. It isn't necessary to name all of the arguments. For example, the following syntax is also valid:

   `RSVP("Linh", 2, allergies: "none", inviteOnly: false);`
   `RSVP("Linh", partySize: 2, "none", false);`

    Named arguments, when used with positional arguments, are valid if they're used in the correct position. Named arguments are also valid as long as they're not followed by any positional arguments. For example, including `"Linh"` and `2` at the end would be invalid:

    `RSVP(allergies: "none", inviteOnly: false, "Linh", 2);`

    If you entered this code, you would get the following error: `Named argument 'allergies' is used out-of-position but is followed by an unnamed argument`

1. Locate the following line of code: `RSVP("Tony", 1, "Jackfruit", true);`

1. Update the method call as follows:

    ```c#
    RSVP("Tony", inviteOnly: true, allergies: "Jackfruit",  partySize: 1);
    ```

    Notice that the named arguments don't have to appear in the original order. However, the unnamed argument `Tony` is a positional argument, and must appear in the matching position.

1. Save and run the code to observe the following output:

    ```Output
    Sorry, Tony is not on the guest list

    Total RSVPs:
    Name: Rebecca,  Party Size: 1,  Allergies: none
    Name: Nadia,    Party Size: 2,  Allergies: Nuts
    Name: Linh,     Party Size: 2,  Allergies: none
    Name: Noor,     Party Size: 4,  Allergies: none
    Name: Jonte,    Party Size: 2,  Allergies: Stone fruit
    ```

    Notice that using named arguments doesn't change the output.

### Declare optional parameters

A parameter becomes optional when it's assigned a default value. If an optional parameter is omitted from the arguments, the default value is used when the method executes. In this step, you'll make the parameters `partySize`, `allergies` and `inviteOnly` optional.

1. To define optional parameters, update the `RSVP` method signature as follows:

    ```c#
    void RSVP(string name, int partySize = 1, string allergies = "none", bool inviteOnly = true)
    ```

    Take a moment to observe the syntax. The parameters are still separated by commas, but the parameters `partySize`, `allergies`, and `inviteOnly` are each assigned to a value.

    Next, you'll update the calls to `RSVP` to apply the optional parameters.

1. Update your code to the following:

    ```c#
    RSVP("Rebecca");
    RSVP("Nadia", 2, "Nuts");
    RSVP(name: "Linh", partySize: 2, inviteOnly: false);
    RSVP("Tony", allergies: "Jackfruit", inviteOnly: true);
    RSVP("Noor", 4, inviteOnly: false);
    RSVP("Jonte", 2, "Stone fruit", false);
    ```

    In each method call, notice that the name is never omitted. When a method is called, all required arguments must always be included. However, any optional arguments can be omitted. 

    In this code, you removed the arguments `1, "none", true` from Rebecca's rsvp. Since these arguments match the default value, the result of Rebecca's rsvp is the same.

    You removed the `inviteOnly` argument from Nadia's rsvp. Since the default value of `inviteOnly` is `true`, the result of Nadia's rsvp is the same.

    You removed the `partySize` argument from Tony's rsvp. If Tony had an invitation, the default value of `partySize` would be used in the RSVP.

    You removed the `allergies` argument from both Linh and Noor's rsvps. Their rsvps will display the default value of `none` for "Allergies".

1. Save and run the code to observe the following output:

    ```Output
    Sorry, Tony is not on the guest list

    Total RSVPs:
    Name: Rebecca,  Party Size: 1,  Allergies: none
    Name: Nadia,    Party Size: 2,  Allergies: Nuts
    Name: Linh,     Party Size: 2,  Allergies: none
    Name: Noor,     Party Size: 4,  Allergies: none
    Name: Jonte,    Party Size: 2,  Allergies: Stone fruit
    ```

    Notice that the default values are used in place of omitted arguments, such as `partySize` and `allergies`.

## Recap

Here's what you've learned about optional and named arguments so far:

- Parameters are made optional by setting a default value in the method signature.
- Named arguments are specified with the parameter name, followed by a colon and the argument value.
- When combining named and positional arguments, you must use the correct order of parameters.