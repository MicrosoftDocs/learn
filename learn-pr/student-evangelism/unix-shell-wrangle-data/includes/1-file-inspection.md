Have you ever wanted to take data from one format into another? It's likely that you have or that you will in the future. The process is called *data wrangling* and is a common task faced by developers. Before we learn how to wrangle data, we need some data files to work with.

As a developer, you'll often need to extract information from logs. In this module, we'll use NASA logs and the command line. To get started, you'll need to download the datasets to the sandbox environment.


### Sandbox activation

The process of signing in to activate the sandbox runs outside the learning module. You're automatically returned to the module after you sign in.

The sandbox is active for a limited amount of time. If you plan to complete this module in multiple sessions, consider using Cloud Shell in the Azure portal to test steps so your work isn't lost.


### Work with commands in Azure Cloud Shell

Follow these steps to work with exercise commands in Cloud Shell:

1. Copy a command by selecting **Copy** at the top right of the code block.
1. Use the copied command at the Cloud Shell prompt by selecting right-click > **Paste**.
1. Run the command by pressing Enter.


## Get the NASA datasets

To complete the practice exercises in this module, you need to load the NASA datasets.

1. Use the `mkdir` command to make a new directory named **data**.

    ```bash
    mkdir data
    ```

1. Use the `wget` command to download the log dataset into the data directory:

    ```bash
    wget -P data/ https://raw.githubusercontent.com/MicrosoftDocs/mslearn-data-wrangling-shell/main/NASA-logs-1995.txt
    ```

1. Use the `wget` command again to download the software API dataset into the data directory:

    ```bash
    wget -P data/ https://raw.githubusercontent.com/MicrosoftDocs/mslearn-data-wrangling-shell/main/NASA-software-API.txt
    ```

    Here's an example of the output from the `wget` command:

    ```output
    --2022-06-09 06:19:13--  https://raw.githubusercontent.com/MicrosoftDocs/mslearn-data-wrangling-shell/main/NASA-software-API.txt
    Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.108.133, 185.199.109.133, 185.199.110.133, ...
    Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.108.133|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 81115 (79K) [text/plain]
    Saving to: ‘data/NASA-software-API.txt’

    NASA-software-API.txt          100%[==========================================================>]  79.21K  --.-KB/s    in 0.001s  

    2022-06-09 06:19:13 (69.6 MB/s) - ‘data/NASA-software-API.txt’ saved [81115/81115]
    ```
     
1. Change to the new directory by using the `cd` command:

    ```bash
    cd data
    ```

1. Verify you have the correct files by using the `ls` command:

    ```bash
    ls
    ```

You should see two files: **NASA-software-API.txt** and **NASA-logs-1995.txt**.

The first file, NASA-software-API.txt, is an open dataset that lists all the software in use by NASA. For more information on the original dataset, see [NASA Open Source and General Resource Software API](https://data.nasa.gov/Management-Operations/NASA-Open-Source-And-General-Resource-Software-API/4tfb-za6v). The second dataset contains all the logged requests to the NASA Kennedy Space Center server.


## Peek into the contents of your files

Recall that in UNIX, by default, a terminal has three streams: an input stream and two output-based streams. The input stream is referred to as `stdin` for standard input and is mapped to the keyboard. The standard output stream, or `stdout`, generally prints to the terminal or might be consumed by another program or process. The other output stream, `stderr`, is primarily used for status reporting and usually prints to the terminal like `stdout`.

You might be wondering why you needed that refresher. In the following units, we'll be talking about programs and filters and their standard input and output. You'll need a basic understanding of how these items are related. All of this information will make more sense as you move forward in the module.

Before you jump into wrangling your data, it's useful to do some basic file inspection. You want to get an idea of what the raw data looks like.


### head and tail commands

The `head` and `tail` commands are used to examine the top (head) or bottom (tail) parts of a file. By default, both commands display 10 rows of content. If you want to display more or fewer rows, you can use the option flag `-n` to specify the number of rows to be printed to `stdout`.

We'll use the `tail` and `head` commands to display the last and first five rows of the NASA-software-API.txt file, respectively.

1. Enter the command `tail` with the `-n` flag to display the last five rows in the file:

    ```bash
    tail -n 5  NASA-software-API.txt
    ```

    Your output should look like this:

    ```output
    SSC-00393 SSC 2013-05-17T00:00:00.000 "General Public" "Software Suite to Support In-Flight Characterization of Remote Sensing Systems"
    SSC-00424 SSC 2013-09-06T00:00:00.000 "General Public" "SSC Site Status Mobile Application"
    GSC-14732-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Tool For Interactive Plotting, Sonification, And 3D Orbit Display (TIPSOD)"
    GSC-14730-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Space Physics Data Facility Web Services"
    GSC-14726-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Earth Observing System (EOS) Clearinghouse (ECHO)"
    ```

1. Enter the command `head` with the `-n` flag to display the first five rows in the file:

    ```bash
    head -n 5 NASA-software-API.txt
    ```

    Your output should look like this:

    ```output
    ARC-14136-1 ARC 2001-10-19T00:00:00.000 "Academic Worldwide" "Adaptive Relevance-Learning Software Component (ARNIE)"
    ARC-14293-1 ARC 2005-09-19T00:00:00.000 "Open Source" "Genetic Graphs (JavaGenes)"
    ARC-14297-1 ARC 2003-11-06T00:00:00.000 "General US" "Automated Domain Decomposition Software, PEGASUS Version 5.0"
    ARC-14379-1 ARC 2002-03-27T00:00:00.000 "General US" "Man-machine Integration Design And Analysis System (MIDAS)"
    ARC-14400-1 ARC 2001-01-29T00:00:00.000 "General US" "PLOT3D Version 4.0"
    ```

### nl filter

The `nl` filter reads lines from files or from `stdin`. The output is printed to `stdout`. By default, the filter `nl` counts lines in a file and uses a tab to separate the line number from the text.

- Enter the `nl` filter with the flag `-s` to use the equal sign `=` as a delimiter:

   ```bash
   nl -s = NASA-software-API.txt
   ```

   Your output should list each line in the file, and end with these lines:

   ```output
   ...
   697=SSC-00424 SSC 2013-09-06T00:00:00.000 "General Public" "SSC Site Status Mobile Application"
   698=GSC-14732-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Tool For Interactive Plotting, Sonification, And 3D Orbit Display (TIPSOD)"
   699=GSC-14730-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Space Physics Data Facility Web Services"
   700=GSC-14726-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Earth Observing System (EOS) Clearinghouse (ECHO)"
   ```

The `nl` filter has flags that allow you to change the increment value (`-i`), change the numbering format (`ln, rn, rz`), or change the starting number (`-v`).


### wc command

The word count command `wc` counts the number of lines, words (separated by white space), and characters in a file or from `stdin`. The output is printed to `stdout` and separated by tabs.

1. Enter the `wc` command to see the number of lines, words, and characters in the NASA-software-API.txt file:

   ```bash
   wc NASA-software-API.txt
   ```

   Your output should look like this:

   ```output
     703   8917   81115   NASA-software-API.txt
   ```

   You can see from the output that the file has 703 lines, 8,917 words, and 81,115 characters. Recheck the output from the previous command, `nl`. We see that the last printed line is:

   > `700=GSC-14726-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Earth Observing System (EOS) Clearinghouse (ECHO)"`

   Notice that the index of this line is 700 rather than 703, `700=GSC...`. What's happening here?

   The index value 700 happens because, by default, the command `nl` doesn't number empty lines.
 
1. Try the command `nl` again, but this time with the option flag `-b a` to count all the lines, including the empty ones:

   ```bash
   nl -b a NASA-software-API.txt
   ```

   The last line in the output should be:

   ```output
   ...
   703  GSC-14726-1 GSFC 2004-06-09T00:00:00.000 "Open Source" "Earth Observing System (EOS) Clearinghouse (ECHO)"
   ```

   The index value now matches the number of lines counted with the `wc` command, 703.
