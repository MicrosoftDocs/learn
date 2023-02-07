Making a single computer secure is hard enough. Making files and computers on the internet secure is really difficult. Still, there are many ways to keep people secure on the internet. Let's look at a few of them.

## Single sign-on

In the cloud, many systems talk to each other. Let's suppose you're attending a school and sign into their computer system. Your school may provide access to a library that is a part of another school. You can have access to this library but would need to get to it securely.

One way to access this other library is to sign in to it separately. You would have a sign-in for your school and another sign-in for the library. This is secure, but it has problems. First, it means you have to set up two accounts. You'll have to remember the usernames and passwords for both. Second, the library may only want students at your (and other) schools to have access. In order to create a library account, you'll have to verify you're attending the school. This can take time and energy and can be costly for both the school and the library.

![Illustration of books in a library with a gap between them to show another library.](../media/library-portal.png)

It would be easier if the library could just "trust" the users that sign in to the school's system, wouldn't it? This is possible with modern tools. With a tool called *single sign-on,* the school can send students to the library and automatically sign them in. The library knows that anyone who was sent to them by the school is verified (authenticated). Of course, the student has to sign in to the school first. But once that's done, they can be "passed through" to the library.

## Trusted sources

Another way to make access easier but just as secure is for one organization to trust another because the second has done all the work to validate the user. You may have signed in to a movie service or online shop using your social media username and password. In this case, the shop trusts that the social media company checked you out and so trusts signed-in users that the social media company sends them.

This is how it works. Suppose you go to an online shop (we'll call it 'Munson's Pickles and Preserves Farm') and need to create an account. One of the options for creating a valid account is to use your social media (say LinkedIn) sign-in. When you choose this option, you're taken to LinkedIn to sign in. Once you successfully sign in, LinkedIn tells Munson's Pickles and Preserves Farm that you're a valid user and they should trust you. LinkedIn sends Munson's Pickles and Preserves Farm information that they can use to trust you now and in the future.

This approach saves Munson's Pickles and Preserves Farm from having to verify you since they can just trust LinkedIn. It also means you don't have to create a new sign-in. You just use your LinkedIn username and password for both LinkedIn and Munson's Pickles and Preserves Farm.
