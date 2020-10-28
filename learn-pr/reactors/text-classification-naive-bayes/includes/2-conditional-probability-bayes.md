<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

Naive Bayes is a convenient algorithm for spam detection because it doesn't require encoding complex rules. All it needs is training examples. There are plenty of examples for email spam. Naive Bayes does this work by using [conditional probability](https://wikipedia.org/wiki/Conditional_probability?azure-portal=true).

## Conditional probability

Ordinary probability deals with the likelihood of isolated events occurring. For example, rolling a 6 on a fair six-sided die will occur, on average, on one out of six rolls. Mathematicians express this probability as $P({\rm die}=6)=\frac{1}{6}$.

Conditional probability concerns itself with the contingencies of interconnected events: what is the probability of event $A$ happening if event $B$ occurs. Mathematicians denote this as $P(A|B)$, or the probability of $A$ given $B$.

To compute the probability of conditional events, we use the following equation:

$P(A \mid B)=\cfrac{P(A \cap B)}{P(B)}$

This equation assumes that we know the joint probability $P(A\cap B)$, and we often don't. Instead, we often need to know something about $A$, but all we can directly observe is $B$. For instance, we want to infer whether an email is spam by knowing only the words it contains. For this, we need Bayes' law.

## Bayes' law

Bayes' law takes its name from the 18th-century English statistician and philosopher Thomas Bayes. He described the probability of an event based solely on prior knowledge of conditions that might be related to that event:

$P(A \mid B)=\cfrac{P(B \mid A)P(A)}{P(B)}$

In other words, Bayes' law says that if I know the prior probabilities $P(A)$ and $P(B)$, in addition to the likelihood (even just an assumed likelihood) $P(B \mid A)$, I can compute the posterior probability $P(A \mid B)$. Let's apply this to spam.

:::image type="content" source="../media/spam.png" alt-text="Screenshot of an example spam email that has the title Reduce Debt by up to 60 Percent." loc-scope="Azure":::

To use Bayesian probability on spam email messages like this one, consider it (and all other emails, whether spam or ham) to be bags of words. (*Ham* is email that is *not* spam, although it might appear to be at first.) We don't care about word order, or even word meaning. We just want to count the frequency of certain words in spam messages versus the frequency of those same words in valid email messages.

Let's say that after we've counted the words in hundreds of emails we've received, we determine the probability of the word _debt_ appearing in any kind of email message (spam or ham) to be 0.157. We determine the probability of _debt_ appearing in spam messages to be 0.309. Furthermore, let's assume a 50 percent chance that any email message we receive is spam. (For this example, we don't know either way what type of email it might be, so it's a coin flip.) Mathematically, we can then say:

- Probability that a given message is spam: $P({\rm S})=0.5$
- Probability that _debt_ appears in a given message: $P({\rm debt})=0.157$
- Probability that _debt_ appears in a spam message: $P({\rm debt} \mid {\rm S})=0.309$

Plugging this in to Bayes' law, we get the following probability that an email message that contains the word _debt_ is spam:

$P({\rm S} \mid {\rm debt})=\cfrac{P({\rm debt} \mid {\rm S})P({\rm S})}{P({\rm debt})}=\cfrac{(0.309)(0.5)}{0.157}=\cfrac{0.1545}{0.157}=0.984$

If an email contains the word _debt_, we then calculate that it's 98.4 percent likely to be spam.

## What makes it naive

The preceding calculation is great for looking at individual words, but an email can contain several words that can give us clues to its relative likelihood of being spam or ham. For example, say we want to determine whether an email is spam, given that it contains the words _debt_ and _bills_. We can begin by reasoning that the probability that an email containing _debt_ and _bills_ is spam is, if not equal, at least proportional to the probability of _debt_ and _bills_ appearing in known spam messages times the probability of any given message being spam:

$P({\rm S} \mid {\rm debt, bills}) \propto P({\rm debt, bills} \mid {\rm S})P({\rm S})$

> [!NOTE]
> The symbol ∝ represents proportionality rather than equality.
If we assume that the occurrences of the words _debt_ and _bills_ are independent events, we can extend this proportionality:
>
> $P({\rm S} \mid {\rm debt, bills}) \propto P({\rm debt} \mid {\rm S})P({\rm bills} \mid {\rm S})P({\rm S})$

We should state here that this assumption of independence is generally not true. Look at the preceding example spam message. The probability that _bills_ will appear in a spam message that contains _debt_ is probably high. However, assuming that the probabilities of words occurring in our email messages are independent is useful and works well. 

This assumption of independence is the naive part of the Bayesian probabilities that we'll use in this section. Expressed mathematically, the working assumption that will underpin the machine learning in this section is that for any collection of $n$ words:

$P({\rm S}\mid {\rm word_1}, {\rm word_2},\ldots, {\rm word}_n)=P({\rm S})P({\rm word_1}\mid {\rm S})P({\rm word_2}\mid {\rm S})\cdots P({\rm word}_n\mid {\rm S})$

> [!div class="alert is-tip"]
> ### Key takeaway
>
> We can't emphasize enough that the chain rule expressed in the preceding equation—that the probability of a message being spam based on the words in it is equal to the product of the likelihoods of those individual words appearing in messages known to be spam—is _not_ true. But it gets good results. In the world of data science, fast and good enough always trump mathematical fidelity.
>