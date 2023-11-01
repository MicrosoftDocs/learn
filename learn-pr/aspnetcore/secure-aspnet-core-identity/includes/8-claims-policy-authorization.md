In the previous unit, you added QR code functionality to enable multi-factor authentication. In this unit, you learn about authorization based on claims and policies. 

## Authorization vs. authentication

Everything you've learned about Identity so far has been about *authentication*. Authentication is a process in which a user is verified to be who they claim to be.

Consider a sign-in form. When you enter your username in the form, you're claiming to be **you**. The form *authenticates* you as the person you claim to be by verifying your password.

*Authorization* refers to the process that determines what an authenticated user is allowed to do. For example, an administration screen might be limited to users with a claim of `IsAdmin=True`. Since claims are associated with an identity, there can be no authorization without authentication.

## Claims and policy-based authorization

Claims are name-value pairs describing what the subject *is*, **not** what it can *do*! Claims are assigned by a trusted authority and are used to enforce authorization policies.

Consider a government-issued ID. The ID displays your attributes. These are claims. Interested parties can observe the ID, verify its source and authenticity, and make decisions based on the attributes. The decisions enforce a policy.

Look to bars and taverns for a more concrete example. Alice wants to purchase an adult beverage. The bartender examines Alice's credentials and observes the claim of her birth date. They then enforce a policy based on that birth date, and Alice is authorized to purchase the drink.

## Summary

In this unit, you learned the difference between authentication and authorization. You also learned how claims are used by policies for authorization. In the next unit, you can use Identity to store claims and apply policies for conditional access.
