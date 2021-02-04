You have an application that's working with some basic features. However, there's one we're missing: the ability to transfer money to another account. This challenge consists of adding that functionality plus another feature that we think will add value to our existing API.

## Implement the transfer method

To create the transfer method, here is what you should keep in mind:

1. First, you need to implement the ability to transfer money to another account. In this case, you have to initialize the program with at least two accounts and not just one, as we did previously.
1. Because you're going to add a new method in the core package, start by creating the test case to make sure you write the proper logic to transfer money. Pay close attention to how you communicate between functions and pointers.
1. Your transfer method should receive the amount of money you want to transfer and an account object where you'll add the funds. Ensure you reuse the deposit and withdraw methods to avoid repetition (especially for the error handling).
1. Lastly, remember you can't transfer money to another account if you don't have enough funds.

## Modify the statement endpoint to return a JSON object

At this point, the `/statement` endpoint returns a string that if you want to expose as an API is not going to be useful. Modify the endpoint to return the account object in a JSON format, like this:

```output
"{\"Name\":\"John\",\"Address\":\"Los Angeles, California\",\"Phone\":\"(555) 314 8947\",\"Number\":1001,\"Balance\":0}"
```

However, we'd like you to make this change expecting that anyone who uses your core package might want to implement a different statement method to change the output. So you need to make the proper changes to make your core package extensible. In other words, you need to do the following:

1. Create an interface with a `Statement() string` function
1. Create a new `Statement()` function in your core package that receives the interface you created as a parameter. This function should call the `Statement()` method that your structs already have. When you do this, you'll be allowed to create your custom `Account` struct and your custom `Statement()` method. You can go back to the structs (embedding) and interfaces module to remember how to do this.

Happy coding!
