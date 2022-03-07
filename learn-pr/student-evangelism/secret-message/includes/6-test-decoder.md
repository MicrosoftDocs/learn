Here's the secret message that you need to decipher:

![Graphic of the encoded secret message.](../media/encoded-secret-message.png)

After our analysis in this module, here's what you need to do to decode the message:
1. The word "Ncevy" needs to be shifted by 13.
1. The word "gpvsui" needs to be shifted by 25.
1. The word "ugflgkg" needs to be shifted by -18.
1. The word "wjmmf" needs to be shifted by -1.

## Add print statements

Just like when you tested your `lasso_word()` function on the word "terra" and shifted it by 13, you can add `print()` statements to the bottom of your <b>decrypt.py</b> file to print all the decoded words.

```python
print( "Shifting Ncevy by 13 gives: \n" + lasso_word( "Ncevy", 13 ) )
print( "Shifting gpvsui by 25 gives: \n" + lasso_word( "gpvsui", 25 ) )
print( "Shifting ugflgkg by -18 gives: \n" + lasso_word( "ugflgkg", -18 ) )
print( "Shifting wjmmf by -1 gives: \n" + lasso_word( "wjmmf", -1 ) )
```

Now select the **Run** button. You should see the final clue to the meeting location and date to find the hidden treasure! 
