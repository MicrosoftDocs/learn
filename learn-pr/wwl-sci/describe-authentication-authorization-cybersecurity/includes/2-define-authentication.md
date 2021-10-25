Authentication is the process of proving that a person is who they say they are.  When someone purchases an item with a credit card, they may be required to show an additional form of identification. This proves that they are the person whose name appears on the card. In this example, the user may show a driver’s license that serves as a form of authentication and proves their ID.

The same concept of authentication applies to digital devices. We experience this every time we try to log in to a computer.  A person enters their user ID that says who they are. But that's not enough to log them in to the computer. The next step is to prove they are the person identified by their user ID.  This is typically done by entering a password, which is a form of authentication.  

It's important to note that when someone logs in to their computer and authenticates, they're given access. The level of access that they're granted controls what they're allowed to do. It's determined by a concept called authorization that we'll cover later in this module.

## Authentication methods

Authentication can be divided into three types: *something you know*, *something you have*, and *something you are*.

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
  - Other forms of biometric ID.
  
Biometric identification is comprised of physical characteristics that uniquely identify an individual.

:::image type="content" source="../media/authentication-types.png" alt-text="Diagram showing the three different authentications types: something you know, something you have, something you are.":::

### Single-factor authentication

Single-factor authentication is a system where only one authentication type is used, making it the least secure but simplest method.

An example of a this system is when the user provides something they know, such as a password, to authenticate. Simple passwords are straightforward to remember but easy for criminals to hack. Complex passwords might seem more secure, but they'll be impossible to remember. It's more likely that someone will write down this type of password, making it much less secure.

Another single-factor authentication method is to use something you have. For example, using your cell phone to pay for an item. A tap-to-pay service authenticates the user through something that they have but doesn't require another verification method.

A biometric, something you are, can be used as a single-factor authentication method, but in some common scenarios, it's not necessarily more secure. Consider, for example, when you use a fingerprint to unlock your cell phone. You've probably known instances where the fingerprint might not be readily recognized, so you're given the option to enter a pin. This can make it easier for someone to guess. In most biometric cases, it's used in conjunction with another form of authentication.

Single-factor authentication is convenient but isn't suitable for a highly secure system.

### Multifactor authentication

Multifactor authentication is a system where two, or even three, authentication types are used. By providing *something that you know, something that you have*, and *something that you are*, the system's security is massively increased. For example, in a multifactor authentication system that uses two types of authentications, you might be asked for a password, and then a number is sent to your cell phone. You input this number, proving that you know the password and have your cell phone. This is a common approach when you use multifactor authentication to access an online bank account.

As mentioned earlier, biometric authentication is most often used in conjunction with another method of authentication. Consider the example of a bank that has a secured area where it keeps customers’ safety deposit boxes. Before someone can gain access, they're typically required to successfully enter both a password and a fingerprint scan.

Multifactor authentication is an important way users and organizations can improve security. It should be the default approach for authentication.
