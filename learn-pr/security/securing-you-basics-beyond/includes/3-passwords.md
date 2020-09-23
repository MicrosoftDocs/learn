Let’s start with the basics. What are passwords and what are they for? In the scenarios we're discussing, a password is a secret that is the proof that you are the owner of the username you use when logging in to a service. Without the password, a username by itself will not give you access to an account.

## What are credentials?

Credentials are the combination of a username and a password. The username is the identifier of your user account, such as your email address or a name that you picked out. The password is the *secret* part of your credentials. Some accounts let you create a special username, different from your email address, and others may require that you use your personal email address. In any case, the username is not intended to be a secret, but the password is.

## How secret are your passwords?

Many passwords are not as secret as people think they are. There are currently *billions* of username and password combinations for sale, but there are even billions more available for free. Where did they all come from? Previous breaches. There are thousands of breaches every year, and those breaches expose all kinds of personal data, along with account information that often includes usernames and passwords.

What is a *data breach* and why should you care? A data breach takes place when information that shouldn't be public is stolen. This often happens as a result of a hacker taking advantage of flaws in a security system or simply just taking the data after a company accidentally exposes a database with no security settings turned on at all. That information can then be used for a variety of bad things, including identity theft, blackmail, harassment, and other crimes. Even an account you may not care about, such as an email account you don’t use anymore, could be used by an attacker to pretend to be you. They could send email with malware to your contacts or sign up for other accounts with your name. There are many other bad uses for stolen accounts.

> [!TIP]
> You can go to [HaveIBeenPwned](https://HaveIBeenPwned.com/?azure-portal=true) and see if one or more of your accounts has been leaked in one of the thousands of public data breaches. You can even check your old passwords to see if they have been exposed through a breach. If you find that your information shows up here, don’t worry. Just change the passwords for any identified accounts that show up, and store your new secrets in your password manager (which we will discuss shortly).

:::image type="content" source="../media/3-pwned.jpg" alt-text="Screenshot of the *have i been pwned* landing page with a field to enter your account email.":::

## Why is one great password not enough?

As you have seen, it is safe to assume that some of your data has already been stolen or leaked. If you use the same password across more than one service or website, an attacker could easily reuse that stolen password to access more of your accounts and data.

However, if you use different passwords for each of your accounts, if one password for one account is stolen, only that account is in danger, and you will only need to reset one password to re-secure the account. Compare that with having to change a re-used password for many different accounts each time there is a data breach, and you can see why having unique passwords can save you time.

But how do you remember a different password for every account? What if you have dozens or hundreds of accounts? How can you safely protect all those passwords? If you want to do it securely, there are a couple of good options:

- Write them all down in a notebook and store the notebook in a safe. This is secure because hackers usually won't be able to physically get to your safe and open it.
- Use a password manager. This is secure because password managers are designed solely to secure passwords. A password manager can't be opened without a key (the secret password or passphrase) known only to the person that owns it. Password managers have the added bonus of being convenient, making them more likely to be used.

Since storing a notebook of passwords in a safe is not convenient, the password manager is the better option for almost everybody who uses a computer and/or smartphone. A password manager will be your safest option, if you treat it carefully. In this case, *carefully* means that you should:

- Use a passphrase instead of a short password and
- Use *multi-factor authentication* to secure it even further.

Don’t worry about the *multi-factor authentication* yet. It’s not nearly as complicated as it sounds, and we will go over that a little later in this training.

## What's even better than a password?

What is a *passphrase* and how is it different from a password?

In the past, the recommendation for a strong password was to use eight characters, with at least one uppercase character, number, and a special character such as !, :, @, *, $, or #. The problem with this guidance is that it resulted in passwords that were easy for a hacker to crack and hard for people to remember. When creating a password, people were more likely to come up with the simplest password possible that met all of those rules. To make matters worse, people often reused those weak passwords for other accounts.

:::image type="content" source="../media/3-password-risks.png" alt-text="Visual table that presents 30 passwords you should never use, like abcdefg." lightbox="../media/3-password-risks-large.png":::

One famous example is the password *Pa$$w0rd*. In this example, you can meet all of the criteria, yet this password is high on the list of the top 1,000 most commonly used passwords. Hackers also have access to other password lists (for example, the top 1,000,000 most common passwords) that they simply plug into their password-cracking software. And if you think you have a password that has never been used, you should know that tools exist that will use a *brute force* attack, trying every combination of all characters in order to guess your passwords. Computers are good at guessing quickly, so be careful to not assume your password can never be guessed.

> [!TIP]
> How long does a password or passphrase need to be? Any password you use should be at least 15 characters long. You will find that in most cases, creating a passphrase that is at least 15 characters long is easy, especially if you use five words.

:::image type="content" source="../media/3-password-cracking.svg" alt-text="Chart estimating the time needed to crack a password based on length and the types of characters used. A ten-character password with a mix of symbols and numbers with upper- and lower-case letters is shown to take over a hundred years to crack." lightbox="../media/3-password-cracking-large.png":::

## Creating a secure and complex password/passphrase

What is better than any complicated, short password? A long, complicated password. Unfortunately, those tend to be difficult to type and beyond most of our ability to remember.

But there is another approach available that is easier to both type and remember: a *passphrase*. A passphrase is several randomly-chosen words used instead of a complex password. A classic example is "correct horse battery staple", immortalized in the web comic [XKCD #936](https://xkcd.com/936/?azure-portal=true).

That comic example shows how it is much easier for a computer to guess a short, complicated-looking password than a longer set of easy-to-remember words. And since you may have already memorized them, you can see that the passphrase words are much easier to remember than something long and complicated.

How can you make your own passphrase? One easy way is to pick any four words from objects in the room around you and add a fifth word, anywhere in the middle, representing something unique to you. You have created a fantastic passphrase. Take for example: *speaker card recyclable antenna sheetrock*. If you use a passphrase like that (be sure to create your own and don't reuse this example) to secure your password manager, you will be safe. If you add another word or a combination of numbers or other characters, you’ll be even better off. If you know any words in different language, you could add one of those as well.

Once you've made your own great passphrase with your own words and are ready to make sure all of your accounts have different, complicated passwords or passphrases, what's next? How can you conveniently keep track of them all, while still being secure?

## Password managers to the rescue!

In the past decade, *password managers* have been improved to make it easy and convenient for you to keep your accounts secure without having to memorize all your passwords. A password manager is a program that securely locks up all of your passwords until you need them, similar to a safe. You can access your passwords by using your one easy-to-remember and hard-to-crack passphrase. Password managers also encrypt your data, making it unusable to anyone who doesn't have the key to unlock, or *decrypt* the data.

First, you will need to find a trusted password manager. Here are five common, convenient, and highly rated password managers. They work in all browsers, on Windows, macOS, and most smartphones.

- 1Password
- LastPass
- Dashlane
- Bitwarden

All of these except 1Password have free plans you can use indefinitely. At the time of this writing, 1Password has a free trial for 30 days only.

To test any of these password managers, simply download the program to your computer or smartphone and give it a try. You should be able to use all except for 1Password for free, without a credit card, though most of them have some additional features available for a fee. Don't let that dissuade you. You can still have a very convenient, secure experience without paying for premium features. You should also consider installing your password manager's *browser extension* (the program that runs in your internet browser), because these extensions make logging in online while using that browser much more convenient, while still being secure.

## I’ve installed my password manager, what’s next?

Now that you have a password manager, you should change any simple or reused passwords to make sure they are complex (long, with a lot of variety) and not being used for more than one account each. While you're making updates, this is a great opportunity to change all your passwords and add those accounts to your password manager. Some password managers will generate long and complex passwords for you as you make changes. Good password managers will also record new entries or updates for you automatically, so you won’t have to enter that information twice.

With your accounts and passwords now stored securely, you'll be able to view and manage login information from just one place. Similarly, you can add and store other confidential information like addresses, credit card numbers, or your passport number.

Now things will be more convenient. For example, when you visit a website, your password manager can automatically fill in the username and password for you. As long as you unlock your vault with your passphrase, you can log into your other accounts automatically afterwards. If you are concerned about someone else being able to use your password manager if you step away from your computer, you can set your password manager to automatically lock itself after the amount of time that you set.

:::image type="content" source="../media/3-password-manager.svg" alt-text="Diagram showing a user's password manager that has access to multiple accounts, protected by a single key login." lightbox="../media/3-password-manager-large.png":::

When you're done using your online accounts, you can close or lock the password manager. This will make sure your passwords are unavailable to anyone else that you may share a computer with.

> [!TIP]
> If you are concerned about putting *every* password or passphrase in your password manager, don't worry. You can still keep some passphrases in your head, or written on a piece of paper that lives in a safe or lockbox. Just make sure that every password or passphrase you use is long and difficult to crack.

## More reasons to use a password manager

One of the best things about password managers is that you can have your data securely synchronized across multiple devices. For example, if you update a password on your laptop, it will also be updated in your phone app. When you log into that updated account using your phone, it will use the updated password.

If you are worried about whether the data is stored securely, you should also know that the data stored in the password managers recommended earlier can’t be accessed by anyone without knowing your passphrase. Even the companies who make those recommended password managers don't know what your passphrase is. This is by design. Since nobody else can know, you can be much more secure.

> [!TIP]
> You really don't want to be locked out of your password manager, especially since you should now have passwords that aren't re-used and that are so long and varied that you can't remember them. If you aren't sure if you can remember your new passphrase, you should write it down on a piece of paper and store it somewhere very safe. Once you're sure you can remember your passphrase, you can destroy the piece of paper. In the meantime, you have a backup plan for accessing your passwords.

Password managers can also allow you to share just one or a few of your passwords with family members, without having to share your main passphrase. You can even and provide an emergency access option to a trusted family member for all of the secured information, if you would like to have a backup plan.

Password managers are convenient, secure, simple to use, and will do most of the hard work for you. You will have to add your accounts, but that is an activity you only need to do once. After that, all you need to remember is your single passphrase to get access to all of your passwords.