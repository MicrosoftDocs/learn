Custom text classification assigns labels, which in the Language service is a *class* that the developer defines, to text files. For example, a video game summary might be classified as "Adventure", "Strategy", "Action" or "Sports".

Custom text classification falls into two types of projects:

- **Single label classification** - you can assign only one class to each file. Following the above example, a video game summary could only be classified as "Adventure" or "Strategy".
- **Multiple label classification** - you can assign multiple classes to each file. This type of project would allow you to classify a video game summary as "Adventure" or "Adventure and Strategy".

When creating your custom text classification project, you can specify which project you want to build.

## Differences of single vs multiple label projects

Beyond the ability to put files into multiple classifications, the key differences with multiple label classification projects are tagging, considerations for improving your model, and the API payload for classification tasks.

### Tagging multiple label projects

In single label projects, each file is assigned one class during the tagging process; class assignment in the Language service only allows you to select one class.

When tagging multiple label projects, you can assign as many classes that you want per file. The impact of the added complexity means your data has to remain clear and provide a good distribution of possible inputs for your model to learn from.

Tagging data correctly for multiple label projects is one of the most important steps, and is directly coorelated with how well your model performs. The higher the quality, clarity, and variation of your data set is, the more accurate your model will be.

### Improving your model

Improving your model is covered in more depth in the next unit, but it's useful to consider the added difficulty of improving a multiple label project versus a single label project.

With a single label project, you can identify classes that aren't classified as well as others, and simply find more quality data to use in training your model. For multiple label projects, this becomes more complex due to the matrix of possible permutations of combined labels.

For example, let's your model is correctly classifying "Action" games and some "Action and Strategy" games, but failing at "Strategy" games. To improve your model, you'll want to find more high quality and varied summaries for both "Action and Strategy" games, as well at "Strategy" games to teach your model how to differentiate the two. This challenge increases exponentially with more possible classes your model is classifying into.

### API payload

When submitting a classification task, the API requires the JSON body to specify which task to execute. You'll learn more about the REST API in the next unit, but worth familiarizing yourself with parts of the required body.

Single label classification specifies a task of `customClassificationTasks`:

```json
{
    "tasks": {
        "customClassificationTasks":[
            {
                "parameters": {
                      "project-name": "<YOUR PROJECT>",
                      "deployment-name": "<YOUR MODEL>"
                }
            }
        ]
    },
    <...>
```

Multiple label classification specifies a task of `customMultiClassificationTasks`

```json
{
    "tasks": {
        "customMultiClassificationTasks":[
            {
                "parameters": {
                      "project-name": "<YOUR PROJECT>",
                      "deployment-name": "<YOUR MODEL>"
                }
            }
        ]
    },
    <...>
```


