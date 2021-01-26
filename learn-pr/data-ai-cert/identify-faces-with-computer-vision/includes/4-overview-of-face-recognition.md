The face detection API provides information about detected faces in an image, but isn't designed to identify or recognize a _specific_ face. However, the Face API provides this capability through a Facial recognition API.

*Facial recognition* is used in many areas, including security, natural user interfaces, image analysis, mobile apps, and robotics. 

The ability to use artificial intelligence to recognize and match faces is one of the more powerful aspects of the Face API.

:::image type="content" source="../media/4-face-recognition-concepts.png" alt-text="A group of related faces":::

## Face detection vs. Face recognition

Facial recognition builds on the facial detection API by analyzing the landmarks in two or more pictures to determine if the same face is present. There are four aspects which can be determined through this analysis.

1. Do two images of a face belong to the same person? This defines *verification*.
1. Does this person look like other people? This defines *similarity*.
1. Do all of these faces belong together? This defines *grouping*.
1. Who is this person in this group of people? This defines *identification*.
