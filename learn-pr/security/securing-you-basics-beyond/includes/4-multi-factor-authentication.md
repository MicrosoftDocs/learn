Let’s talk about *factors* and how *Two-Factor Authentication (2FA)* or *Multi-Factor Authentication (MFA)* can protect your accounts much better than just using a password.

Don’t worry! It’s not as complicated as it may sound. A *factor* in this scenario is just a type of secret. So using *Multi-Factor Authentication (MFA)* means using *more than one type of secret* to verify your identity. It’s another layer of security you can easily use to secure your accounts with more than just a password.

For example, to log into an account:
 
    1. You could enter your user name
        1. Your identity
    1. Then a password 
        1. Factor number one: something you know
    1. Then click an approval button on a special smartphone app
        1. Factor number two: something you have access to

In the example, *Multi-Factor Authentication (MFA)* was used to log into an account with one more factor, other than a password. 

## Putting the "multi" in Multi-Factor Authentication (MFA)

If you haven't guessed it already, *Multi-Factor Authentication (MFA)* refers to the use of multiple "factors" for validating and verifying your account whenever you log in. This can include typing in a code from a text message to your personal phone number, or possibly through a biometric factor like your fingerprint.

There are three general types of factors: 

- A thing you know:
    - Passwords, passphrases, PINs (Personal Identification Numbers)
- A thing you have:
    - Your smartphone or a special USB security device
- A thing you are (biometrics):
    - Your fingerprints or your face, often used as ways to unlock smartphones

So if you are using *Two-Factor Authentication (2FA)*, you need to use two different types of secrets, such as a password and a smartphone with an authenticator app installed.  Or you could use a password followed by your fingerprint getting scanned through a fingerprint reader on your laptop or smartphone.

For the next sections, we’ll refer to the shorthand of *MFA* for referencing *Multi-Factor Authentication*.

## Why MFA?

Why is MFA so important? As we mentioned earlier, several billions of records have been leaked over the last few years. Let’s assume one of your usernames and passwords has been leaked. If you don’t use MFA, a criminal could take that username and password combination to log into one of your accounts and do bad things.

This is where it gets good! Even if your username and password have been stolen or leaked, if you have MFA turned on, your account will still be safe. Why? Because nobody can log in without that last step! The thief may have your username and password, but not the other factor. It’s like another password, but one that isn’t stored with the information that was stolen. Most reputable sites now require you to enable MFA. Where you can, you should always be using MFA.

Unless you are an extremely special target of very capable criminals, those intending to abuse your username and password will not have access to your fingerprints, your phone, or your USB security devices. Just having an additional factor as a part of logging into any of your accounts introduces a layer of security that most criminals will not be able to work around. 

When the next breach occurs, and more usernames and passwords are exposed to the world, all you will need to do is change the passwords belonging to any leaked accounts, and keep using MFA. Know that in continuing to use MFA, you are ensuring your exposed usernames and passwords are useless without one of your devices. 

What is the most important thing you should secure using MFA? You guessed it! Your password manager! All reputable password managers allow you to set up MFA to keep your secrets as secure as possible. You should absolutely do this.

> [!TIP]
> You should always use MFA with any of your accounts. Don't like the idea of using an app on your smartphone? Yubico produces an easy-to-use device called a [Yubikey](https://www.yubico.com/products/). These can be used as personal security devices for supporting MFA-enabled accounts.

Here is another way of looking at MFA:

:::image type="content" source="../media/4-mfa.png" alt-text="MFA":::

How do you set up MFA? Follow the instructions for the account you want to secure. They should provide clear, easy-to-follow instructions, and most of them will allow you to use an authenticator app on your smartphone, like [Microsoft Authenticator](https://www.microsoft.com/en-us/account/authenticator). You can often find these settings in the details of your account. 

As other authenticator apps are available, you should use the one that works best for you. Any of these options should be good, and will add that important, extra layer of security.

Lastly, your account may only give you the option to use text messages to receive a *one-time code* for use with MFA. This works by generating a new code, each time you attempt to log in. Without verifying the code that was sent to you in a text message, the log in will not complete. While this is not as secure as using an authenticator application on your phone, as text messages can be intercepted, it is still much better than not using MFA at all. If that’s your only available option, you should still use it. 

If you enable MFA for every account you can, using any kind of MFA available, your accounts will always be more secure than they are without it, even if you already use a strong password or passphrase. Having two or more factors is greater than one, so you should always be using MFA wherever its supported.