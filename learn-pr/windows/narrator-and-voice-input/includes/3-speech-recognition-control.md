Speech recognition, like speech synthesis, has come such a long way since its beginnings. It can be a useful tool for creating an accessible experience, though it's still not perfect.

In the next few units, you'll learn:
- That the general Windows speech recognition is geared towards dictation. It's usable, but slow at entering calculations.
- That a specific instance of a voice recognition system can interpret natural sounding input.
- That voice control is fun and helpful.
- That context is *needed* for speech recognition. Words such as "sine" and "sign" sound the same, only context tells them apart.
- That some permissions are needed before voice recognition will be enabled.

## Speech recognition

Make sure to have a headset with both microphone and speakers connected to your development computer. It's hard to test speech recognition without any speech to recognize.

### The default Windows speech recognition tool

Without making any further changes to our code, let's see how the Windows speech recognition tool works with our calculator.

1. In the Windows search bar, enter "speech recognition". Select **Start Speech Recognition** in the window that appears. You should see the small graphic that shows when the speech recognition system is on or off. Select the microphone icon so the **Listening** text appears.

![Windows is listening.](../media/windows-speech-recognition.png)

2. Run the calculator, ensure it's in focus, and try speaking a calculation. Notice how numbers need to be spoken singularly. 741 can't be spoken as "seven hundred and forty-one", but must be said as "seven", pause, "four", pause, "one". Say "times two", then "equals" to calculate the result.

3. Try speaking a decimal number: "3.14". Notice how you have to say the numbers slowly, and that "point" will correctly display decimal point.

4. The recognition system is aware of the **AutomationProperites.Name** entries you previously set. You can say "Sine" to trigger the **Sin** button, "to the power of" to trigger the **^** button, and so on.

5. Try saving numbers to the calculator memory (noting this is only available when the display contains only a number). Try turning the toggle switches on and off by speaking the header text.

6. To enter constants, first say "Show constants". Then, to select any constant and add it to the calculation say "double-click" before words that clearly identify the constant. For example, try "double-click feet to meters" and the constant value (0.3048) should be added to your calculation. Sometimes you have to say things several times to be clear!

> [!NOTE]
> If the speech recognizer is uncertain of which button you meant but there is a close match with two or more, it highlights those buttons with an associated number and gives you the option of saying one of the numbers followed by "OK".

Playing with the standard speech recognition shows its features and drawbacks quite well. For some apps, this may be all that's required or wanted. But for a calculator, you might say a whole sentence without any pauses, such as "what is four hundred and fifty-four divided by the arc cosine of zero point six six". This obviously does not match to individual buttons, so the default Windows recognition system can't be expected to handle it. If we want to improve this experience, we're going to need to get fancy.
