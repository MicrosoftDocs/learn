You can add a strong layer of security to your account credentials. Let's review how *multifactor authentication*, sometimes called *two-factor authentication*, can help protect your accounts much better than just using a password or passphrase.

## Types of factors

Having complex and unique passwords and passphrases is a great step toward securing your accounts, but it doesn't protect you if a company has a data breach and exposes your password. For this type of scenario, you can improve your accounts' security even more by using multifactor authentication.

Let's begin with *factors*. A factor in this scenario is just a type of secret. Using multifactor authentication means using *more than one type of secret* to verify your identity. It's like having another type of password required to sign in, after you provide the first password.

There are three general types of factors:

- *A thing you know*: A password, passphrase, or personal identification number (PIN).
- *A thing you have*: Your smartphone or a special USB security device.
- *A thing you are*: Biometric information such as your fingerprint or your face (often used as a way to unlock a smartphone).

Let's look at an example of using multifactor authentication to sign in to an account:

- You enter your username. This is your identity.
- You enter your password. This is the first factor, something you know.
- You tap an approval button on a smartphone app. The phone and the app are the second factor, something you have.

In the example, you used multifactor authentication to sign in to an account with two factors: a password and an app on a physical device you had in your possession.

:::image type="content" source="../media/4-multi-factor-authentication.png" alt-text="Flow chart depicting the steps to sign in to an account by using a password and an additional factor for authentication, such as a personal device or biometric information.":::

## Why multifactor authentication?

Why is multifactor authentication so important? As we mentioned earlier, billions of records have been leaked over the last few years. Let's assume one of your username/password combinations has been leaked. If you don't use multifactor authentication, a criminal can take that username and password, sign in to one of your accounts, and do bad things.

This is where multifactor authentication increases the security of your account. Even if your username and password have been stolen, *if you have multifactor authentication turned on*, your account information should still be safe. Why? Because nobody can sign in without that last step. The thief might have your username and password, but not the other factor. It's like another password, but one that's not stored with other information that's often stolen.

Many reputable services now encourage or even require you to turn on multifactor authentication. Even if they don't, you should turn on and use multifactor authentication wherever you can.

Unless you're a special target of very capable criminals, anyone who wants to abuse your username and password won't have access to your fingerprints, your phone, or your USB security device. Just having an additional factor as a part of signing in to an account adds a layer of security that most criminals won't be able to work around.

When the next data breach occurs and more usernames and passwords are exposed to the world, all you'll need to do is change the passwords for those accounts. Depending on the type of breach or attack, if you have multifactor authentication turned on, your data should still be secure.

What's the most important thing you should secure by using multifactor authentication? Your password manager! All reputable password managers allow you to set up multifactor authentication to keep your secrets as secure as possible.

## Apps and other options for multifactor authentication

How do you set up multifactor authentication? Follow the instructions for the account that you want to secure. Any account should provide clear, easy-to-follow instructions. Most accounts will show you how to set up and use an authenticator app on your smartphone, such as [Microsoft Authenticator](https://www.microsoft.com/en-us/account/authenticator/?azure-portal=true). If you're not sure where to start, look in your account's security settings for terms like "MFA" (for multifactor authentication), "2FA" (for two-factor authentication), or "multi-step verification."

Your account might require a specific authenticator application, or it might give you the option to choose from several. Use the option that works best for you.

> [!TIP]
> If you don't like the idea of using an app on your smartphone, Yubico makes an easy-to-use device called a [YubiKey](https://www.yubico.com/products/?azure-portal=true). A personal security device like that can support accounts where multifactor authentication is enabled.

An account might only give you the option to use text messages to receive a *one-time code* for use with multifactor authentication. This system works by generating a new code each time you try to sign in. It isn't as secure as using an authenticator application on your phone, because text messages can be intercepted, but it's better than not using multifactor authentication at all. If that's your only available option, you should use it.

If you enable multifactor authentication on all accounts that provide it, those accounts will be more secure than they'd be with just a strong password or passphrase. The extra security is worth the extra few seconds it will take to sign in.
