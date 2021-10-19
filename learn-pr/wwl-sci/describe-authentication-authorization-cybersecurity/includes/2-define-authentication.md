Authentication is the process of proving someone is who they say they are.  For example, when someone purchases an item with a credit card, they may be required to show an additional form of identification to prove that they really are the person whose name appears on the credit card. In this example, the user may show a driver’s license.  The driver’s license serves as a form of authentication, proving the user is who they say they are.

The same concept of authentication applies to digital devices. We experience this every time we try to log in to a computer.  A user enters their user ID.  Their user ID says who they are, but that is not enough to actually log them into the computer.  The next step is to prove they are the person identified by their user ID.  This is typically done by entering a password.  The password is a form of authentication.  

It is important to note that when one logs in to their computer and authenticates, they get access to that computer.  The level of access that they are granted, what they are allowed to do, is determined by a concept called authorization that we will cover later in this module.

## Authentication methods

Authentication can be divided into three types, *something you know*, *something you have*, and *something you are*.

- Something you know includes:
  - Passwords
  - PIN numbers
  - Security questions
- Something you have includes:
  - Identity cards
  - USB keys
  - Computers
  - Cell phones
- Something you are includes:
  - A fingerprint
  - Facial recognition
  - Retinal scan
  - Other forms of biometric identification. Biometric identification comprises of physical characteristics that uniquely identify an individual.

:::image type="content" source="../media/authentication-types.png" alt-text="Diagram showing the three different authentications types: something you know, something you have, something you are.":::

### Single-factor authentication

Single-factor authentication is a system where only one authentication type is used. This is the least secure but simplest method.

An example of a single-factor authentication system is when the user provides something they know, such as a password, to authenticate. Simple passwords are easy to remember but also easy for criminals to hack. Complex passwords might seem more secure, but they will be impossible to remember and make it more likely for the user to write the password down, making them much less secure. Another single-factor authentication system method is using something you have. For example, using your cell phone to pay for something with a tap-to-pay service authenticates the user through something that the user has but does not require another verification method.

The use of a biometric, something you are, can be used as a single factor authentication method, but in scenarios you may commonly encounter, it is not necessarily more secure. Consider, for example, when you use a fingerprint to unlock your cell phone. You have probably encountered instances where the fingerprint may not be readily recognized so you are given the option to enter a pin, which can make it easier for someone to guess. In most cases where a biometric is used, it is used in conjunction with another form of authentication.

Single-factor authentication is implemented because of convenience but is not suitable for a highly secure system.

### Multi-factor authentication

Multi-factor authentication is a system where two, or even three, of the authentication types are used. By providing something that you know and something that you have, and something that you are, the security of the system is massively increased. For example, in a multi-factor authentication system that uses two types of authentications, you might be asked to provide a password, and then a number is sent to your cell phone. You then input this number, proving that you know your password and have your cell phone. This is a common approach when using multi-factor authentication to access your online bank account.

As mentioned earlier, biometric authentication is most often used in conjunction with another method of authentication. Consider the example of a bank that has a secured area where it keeps customers’ safety deposit boxes. Before someone can enter that secured area, they are typically required to successfully enter both a password and a fingerprint scan.

Multi-factor authentication is an important way users and organizations can improve security and should be the default approach for authentication.
