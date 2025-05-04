In addition to detecting and analyzing faces, you can use the Azure AI Vision Face service to compare and recognize faces.

> [!IMPORTANT]
> Usage of facial recognition, comparison, and verification requires approval through a **[Limited Access policy](https://aka.ms/cog-services-limited-access)**.

## Verifying faces

When a face is detected by the Face service, a unique ID is assigned to it and retained in the service resource for 24 hours. The ID is a GUID, with no indication of the individual's identity other than their facial features.

While the detected face ID is cached, subsequent images can be used to compare the new faces to the cached identity and determine if they're *similar* (in other words, they share similar facial features) or to *verify* that the same person appears in two images.

![Diagram of a detected face matched in two images.](../media/face-matching.png)

This ability to compare faces anonymously can be useful in systems where it's important to confirm that the same person is present on two occasions, without the need to know the actual identity of the person. For example, by taking images of people as they enter and leave a secured space to verify that everyone who entered leaves.

## Identifying faces

For scenarios where you need to positively identify individuals, you can train a facial recognition model using face images.

To train a facial recognition model with the Face service:

1. Create a **Person Group** that defines the set of individuals you want to identify (for example, *employees*).
2. Add a **Person** to the **Person Group** for each individual you want to identify.
3. Add detected faces from multiple images to each **person**, preferably in various poses. The IDs of these faces will no longer expire after 24 hours (so they're now referred to as *persisted* faces).
4. Train the model.

![Diagram of person groups containing Person records with persisted faces.](../media/person-groups.png)

The trained model is stored in your Face (or Azure AI Services) resource, and can be used by client applications to:

- *Identify* individuals in images.
- *Verify* the identity of a detected face.
- Analyze new images to find faces that are *similar* to a known, persisted face.

> [!Tip]
> To learn more about using face verification and identification to implement a facial recognition solution, see **[Face recognition](/azure/ai-services/computer-vision/concept-face-recognition)** in the Azure AI Vision Face documentation.
