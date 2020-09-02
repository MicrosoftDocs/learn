Let’s start with the basics. What are passwords and what are they for? In the scenarios we're discussing, a password is a secret which is the proof that you are the owner of the username you use when logging in to a service. Without the password, a username by itself will not give you access to an account. Passwords become even more important later, because we can also use a second kind of password to get even more secure.

## What are credentials?

Credentials are the combination of a username and a password. The username is the identifier of your user account, such as your email address or a name that you picked out. The password is the *secret* part of your credentials. Some accounts let you create a special username, different from your email address, and others may require that you use your personal email address. In any case, the username is not intended to be a secret, but the password is.

## How secret are your passwords?

There are currently billions of username and password combinations for sale, but there are even billions more available for free. Where did they all come from? Previous breaches. There are thousands of breaches every year, and those breaches expose all kinds of personal data, along with account information including usernames and passwords.

What is a *breach* and why should you care? A breach is when information that is supposed to be kept private gets exposed to people who aren't authorized to access this information. That informaton can then used for a variety of bad things, including identity theft, blackmail, harassment, and other crimes. Even an account you may not care about, such as an email account you don’t use anymore, could be used by an attacker to pretend to be you. They could send email with malware to your contacts or sign up for other accounts with your name. Of course, there are many other bad uses for stolen accounts.

> [!TIP]
> You can go to [HaveIBeenPwned](https://HaveIBeenPwned.com/?azure-portal=true) and see if one or more of your accounts has been leaked in one of the thousands of public data breaches. You can even check your old passwords to see if they have been exposed through a breach. If you find that your information shows up here, don’t worry. Just change the passwords for any identified accounts that show up, and store your new secrets in your password manager (which we will discuss shortly).

:::image type="content" source="../media/3-pwned.jpg" alt-text="Screenshot of the homepage for *have i been pwned?*":::

## Why is one great password not enough?

As you have seen, it is safe to assume that some of your data has already been stolen or leaked. If you use the same password across more than one service or website, an attacker could easily reuse that stolen password to access more of your accounts and data.

However, if you use different passwords for each of your accounts, if that password for one account is stolen, only that account is in danger. Compare that with having to change every password for each of your accounts, if you used the same password for all your accounts.

But how do you remember a different password for every account? What if you have dozens or hundreds of accounts? How can you safely protect all those passwords? If you want to do it securely, there are a couple of good options:

- Write them all down in a notebook and store the notebook in a safe. Why is this secure? Because hackers usually can’t physically get to your safe and open it.
- Use a password manager. Why is this secure? Password managers are designed to be very secure, and can't be opened without the key (the secret password or passphrase) known only to the person that owns it. Password managers have the added bonus of being convenient, making them more likely to be used.

Since storing a notebook of passwords in a safe is not convenient, the password manager is the better option for almost everybody who uses a computer and/or smartphone. A password manager will be your safest option, if you treat it carefully. In this case, *carefully* means that you should:

- Use a passphrase instead of a short password and
- Use *multi-factor authentication* to secure it even further.

Don’t worry about the *multi-factor authentication* yet. It’s not nearly as complicated as it sounds, and we will go over that a little later in this training.

## What's even better than a password?

What is a *passphrase* and how is it different from a password?

In the past, the recommendation for a strong password was to use eight characters, with at least one uppercase character, number, and a special character such as !, :, @, *, $, or #. The problem with this guidance is that it resulted in passwords that were easy for a hacker to crack and hard for people to remember. So when someone had to create a password to meet those requirements, they were more likely to come up with the simplest password possible that met those rules. To make matters worse, people often reused those weak passwords for other accounts.

:::image type="content" source="../media/3-password-risks.png" alt-text="Diagram containing a list of common, high risk passwords.":::

One famous example is the password *Pa$$w0rd*. In this example, you can meet all of the criteria, yet this password is high on the list of the top 1,000 most commonly used passwords. Hackers also have access to other password lists (e.g. the top 1,000,000 most common), and can simply plug the into their password-cracking software. And in case you think you have a password that has never been used, you should know that tools exist that will use *brute force*, to try every combination of all characters in order to guess your passwords. Computers are good at guessing quickly, so be careful to not assume your password can never be guessed.

:::image type="content" source="../media/3-password-cracking.png" alt-text="Chart showcasing how quickly a password can be cracked, based on password length and the types of characters used.":::

## Creating a really secure and complex password/passphrase

What is better than any complicated, short password? A long, complicated password. Unfortunately, those tend to be difficult to type and beyond most of our ability to remember.

But there is another approach available that is easier to both type and remember: a *passphrase*. A passphrase is four or more randomly chosen words used in place of a password. A classic example is "correct horse battery staple", immortalized in the web comic [XKCD #936](https://xkcd.com/936/?azure-portal=true).

That comic example shows how it is much easier for a computer to guess a short, complicated-looking password than a longer set of easy-to-remember words. And since you may have already memorized them, you can see that the passphrase words are easier to remember than something long and complicated.

How can you make your own passphrase? One easy way is to pick any four words from objects in the room around you and add a fifth word, anywhere in the middle, representing something unique to you. You have just created a fantastic passphrase. Take for example: *speaker card recyclable antenna sheetrock*. If you use a passphrase like that (be sure to create your own and not reuse this example) to secure your password manager, you will be safe. If you add another word or a combination of numbers or other characters, you’ll be even better off. If you know any words in different language, you could add one of those as well.

Ok, once you've made your own great passphrase with your own words and are ready to make sure all of your accounts have different, complicated passwords or passphrases, what's next? How can you conveniently keep track of them all, while still being secure?

## Password managers to the rescue

In the past decade, *password managers* have been improved to make it easy and convenient for you to keep your accounts secure without having to memorize all your passwords. A password manager is a program that securely locks up all of your passwords until you need them, similar to a safe. You can access your passwords by using your one easy-to-remember and hard-to-crack passphrase. Password managers also encrypt the data stored in them, making it unusable to anyone if the files were somehow stolen. The secured data can't be accessed or understood without the passphrase to unlock the vault.

The first step is to research and select a trusted password manager. Here are five common, convenient, and highly rated password managers. They work in all browsers, on Windows, macOS, and most smartphones.

- 1Password
- LastPass
- Dashlane
- Bitwarden

All of these except 1Password have free plans you can use indefinitely. At the time of this writing, 1Password has a free trial for 30 days only.

To take any of these for a test run, simply download the application to your computer or smartphone and give it a try. Some of these are available for free, with added features available to paid versions. As these are commonly available with browser extensions, make sure to install the extension for your browser to make using them even simpler.

## I’ve installed my password manager, what’s next?

Now that you have a password manager, you should update all of your passwords to make sure they are complex and not being used for more than one account each. While you're making updates, this is a great opportunity to change all your passwords and add those accounts to your password manager. Some password managers will generate long and complex passwords for you as you make changes. Good password managers will also record new entries or updates for you automatically, so you won’t have to enter that information twice.

With your accounts and passwords now stored and secured, you'll be able to view and manage login information from just one place. Similarly, you can add and store other confidential information like addresses, credit card numbers, or your passport number.

Convenient, most of the steps from here onward are automated. For example, when you visit a website, your password manager can automatically fill in the username and password for you. As long as you unlock your vault with your passphrase, you can log into your other accounts automatically afterwards. If you are concerned about someone else being able to use your password manager if you step away from the computer, you can configure your password manager to automatically lock itself after a minute, or any amount of time you like.

:::image type="content" source="../media/3-password-manager.png" alt-text="Diagram showing a person using a password manager for accessing their accounts.":::

When you're done using your online accounts, you can simply close or lock the password manager. This will make sure your passwords are unavailable to anyone else that you may share a computer with.

## More reasons to use a password manager

One of the best things about password managers is that you can have your data securely synchronized across multiple devices. For example, if you update a password on your laptop, it will also be updated in your phone app.

If you are worried about whether the data is stored securely, you should also know that the data stored in the password managers recommended earlier can’t be accessed by anyone without knowing your passphrase. The companies behind the recommended password managers do not know what your passphrase is, as part of the design for securing a password manager.

Password managers can also allow you to share some passwords with family members, without having to share your passphrase. You can even and provide an emergency access option to a trusted family member for all of the secured information, if you would like to have a backup plan.

Password managers are convenient, secure, simple to use, and will do most of the hard work for you. You will have to add your accounts, but that is an activity you only need to do once. After that, all you need to remember is your master passphrase to get into your vault passwords.
