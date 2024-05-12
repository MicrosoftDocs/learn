The final AI-powered feature in which Contoso Camping Store has integrated into their platform is a campfire song generator. Customers love to use the tool to generate unique songs to sing during their camping trips! However, we’ll want to ensure that the model doesn’t generate song lyrics to copyrighted music.

The Protected Material Detection (Text) tool matches known text content (i.e., song lyrics, articles, recipes, and selected web content). This tool can be used to identify, and block known text content from being displayed in the model’s output. Let’s test the model’s ability to detect copyrighted lyrics with the song *Take Me Home, Country Roads* by John Denver.

## Protected lyrics

1. In Content Safety Studio, select **Protected material detection**.
1. In the **Test** section, enter the following into the box:

    *Almost heaven, West Virginia*<br>
    *Blue ridge mountains, Shenandoah River*<br>
    *Life is old there, older than the trees*<br>
    *Younger than the mountains, blowing like a breeze*<br>

    *Country roads, take me home*<br>
    *To the place I belong*<br>
    *West Virginia, mountain mamma*<br>
    *Take me home, country roads*<br>

    *All my memories, gather round her*<br>
    *Miner's lady, stranger to blue water*<br>
    *Dark and dusty, painted on the sky*<br>
    *Misty taste of moonshine, teardrop in my eye*

1. Select **Run test**.

The model was about to detect that the output includes protected material! Feel free to complete additional tests for other song lyrics and explore additional content types.

## Bulk test

Like the image and text moderation tools, we can also run a bulk test on a collection of data. Let’s upload a dataset of multiple text records to validate whether the model can detect more copyrighted song lyrics. We’ve included *Take Me Home, Country Roads* in the dataset and lyrics to *This Land is Your Land* by Woody Guthrie. In addition, we’ve added AI-generated summaries of national parks. Each record in the dataset includes a label to indicate whether the content contains protected material.

1. Switch to the **Run a bulk test** tab.
1. In the **Select a sample or upload your own** section, click **Browse for a** **file**. Select the `bulk-test-sample-data.csv` file and upload.
1. In the **Dataset preview** section, browse through the **Records** and their corresponding **Label**. A **0** indicates that the content doesn’t contain protected material. A **1** indicates that the content contains protected material.
1. Select **Run test**.

Based on the results, was the model able to identify the protected materials?