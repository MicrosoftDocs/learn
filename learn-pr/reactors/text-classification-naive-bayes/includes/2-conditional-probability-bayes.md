Naive Bayes is a convenient algorithm for spam detection because it doesn't require encoding complex rules. All it needs is training examples, of which there are plenty when it comes to email spam. Naive Bayes does all this through the use of [conditional probability](https://wikipedia.org/wiki/Conditional_probability?azure-portal=true).

## Conditional probability

Ordinary probability deals with the likelihood of isolated events occurring. For example, rolling a 6 on a fair six-sided die will occur, on average, on one out of six rolls. Mathematicians express this probability as $P({\rm die}=6)=\frac{1}{6}$.

Conditional probability concerns itself with the contingencies of interconnected events: what is the probability of event $A$ happening if event $B$ occurs. Mathematicians denote this as $P(A|B)$, or "the probability of $A$ given $B$."

In order to compute the probability of conditional events, we use the following equation:

$P(A \mid B)=\cfrac{P(A \cap B)}{P(B)}$

This equation is nice, but it assumes that we know the joint probability $P(A\cap B)$, which we often don't. Instead, we often need to know something about $A$ but all we can directly observe is $B$. For instance, when we want to infer whether an email is spam only by knowing the words it contains. For this, we need Bayes' law.

## Bayes' Law

Bayes' law takes its name from the eighteenth-century English statistician and philosopher Thomas Bayes, who described the probability of an event based solely on prior knowledge of conditions that might be related to that event thus:

$P(A \mid B)=\cfrac{P(B \mid A)P(A)}{P(B)}$

In words, Bayes' Law says that if I know the prior probabilities $P(A)$ and $P(B)$, in addition to the likelihood (even just an assumed likelihood) $P(B \mid A)$, I can compute the posterior probability $P(A \mid B)$. Let's apply this to spam.

:::image type="content" alt-text="A screenshot of an example spam email that has the title Reduce Debt by up to 60 Percent" source="../media/spam.png" loc-scope="azure":::

In order to use Bayesian probability on spam email messages like this one, consider it (and all other emails, spam or ham) to be bags of words. We don't care about word order or even word meaning. We just want to count the frequency of certain words in spam messages versus the frequency of those same words in valid email messages.

Let's say that, after having counted the words in hundreds of emails that we have received, we determine the probability of the word "debt" appearing in any kind of email message (spam or ham) to be 0.157, with the probability of "debt" appearing in spam messages being 0.309. Further more, let's say that we assume that there is a 50 percent chance that any given email message we receive is spam (for this example, we don't know either way what type of email it might be, so it's a coin flip). Mathematically, we could thus say:

- Probability that a given message is spam: $P({\rm S})=0.5$
- Probability that “debt” appears in a given message: $P({\rm debt})=0.157$
- Probability that “debt” appears in a spam message: $P({\rm debt} \mid {\rm S})=0.309$

Plugging this in to Bayes' law, we get the following probability that an email message containing the word "debt" is spam:

$P({\rm S} \mid {\rm debt})=\cfrac{P({\rm debt} \mid {\rm S})P({\rm S})}{P({\rm debt})}=\cfrac{(0.309)(0.5)}{0.157}=\cfrac{0.1545}{0.157}=0.984$

Thus if an email contains the word "debt," we calculate that it is 98.4 percent likely to be spam.

## What makes it naive

Our above calculation is great for looking at individual words, but emails contain several words that can give us clues to an email's relative likelihood of being spam or ham. For example, say we wanted to determine whether an email is spam given that it contains the words "debt" and "bills." We can begin by reasoning that the probability that an email containing "debt" and "bills" is spam is, if not equal, at least proportional to the probability of "debt" and "bills" appearing in known spam messages times the probability of any given message being spam:

$P({\rm S} \mid {\rm debt, bills}) \propto P({\rm debt, bills} \mid {\rm S})P({\rm S})$

> ![NOTE]
> The symbol ∝ represents proportionality rather than equality.

Now, if we assume that the occurrence of the words "debt" and "bills" are independent events, we can extend this proportionality:

$P({\rm S} \mid {\rm debt, bills}) \propto P({\rm debt} \mid {\rm S})P({\rm bills} \mid {\rm S})P({\rm S})$

We should state here that this assumption of independence is generally not true. Just look at the example spam message above. The probability that "bills" will appears in a spam message containing "debt" is probably quite high. However, assuming that the probabilities of words occurring in our email messages are independent is useful and works surprising well. This assumption of independence is the naive part of the Baysian probabilities that we will use in this section; expressed mathematically, the working assumption that will underpin the ML in this section is that for any collection of $n$ words:

$P({\rm S}\mid {\rm word_1}, {\rm word_2},\ldots, {\rm word}_n)=P({\rm S})P({\rm word_1}\mid {\rm S})P({\rm word_2}\mid {\rm S})\cdots P({\rm word}_n\mid {\rm S})$

> [!div class="alert is-tip"]
> ### Key takeaway
>
> We cannot emphasize enough that this chain rule expressed in the preceding equation—that the probability of a message being spam based on the words in it is equal to the product of the likelihoods of those individual words appearing in messages known to be spam—is not true. But it gets good results and, in the world of data science, fast and good enough always trump mathematical fidelity.
>
