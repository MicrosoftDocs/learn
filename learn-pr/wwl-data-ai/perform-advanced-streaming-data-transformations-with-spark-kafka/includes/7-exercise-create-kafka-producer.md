Now that the Kafka and Spark clusters are deployed, lets add a Kafka producer to the Kafka head node. This producer is a stock price stimulator, which produces artificial stock prices.

## Download the sample

1.	In your internet browser, go to https://github.com/Azure/hdinsight-mslearn and download or clone the sample locally if you didn’t already do it in a previous module.
2.	Open the Spark Structured Streaming\python-producer-simulator-template.py file locally.

### Retrieve the Kafka broker URLs

Next, you need to retrieve the Kafka broker URLs by using ssh on the headnode and adding the URLs to the python file.  

1.	To connect to the primary head node of the Apache Kafka cluster, you need to ssh into the node. The Azure Cloud Shell in the Azure portal is the recommended way to connect. In the Azure portal, click the Azure Cloud Shell button   in the top toolbar, and select Bash. You can also use an ssh-enabled command prompt such as Git Bash.

2.	If you have not used the Azure Cloud Shell before, a notification stating that you have no storage mounted is displayed. Select your Azure subscription from the Subscription box, and click Create Storage.

3.	At the cloud prompt, paste the following command. Replace `sshuser` with the SSH user name. Replace `kafka-mslearn-stock` with the name of your Apache Kafka cluster, and note that you must include -ssh after the cluster name.

    ```bash
    ssh sshuser@kafka-mslearn-stock-ssh.azurehdinsight.net
    ```
4.	When you first connect to the cluster, your SSH client may display a warning that the authenticity of the host can't be established. When prompted type yes, and then press Enter to add the host to your SSH client's trusted server list.

5.	When prompted, enter the password for the SSH user.

    Once connected, you see information similar to the following text:

    ```output
        Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.15.0-1063-azure x86_64)

        * Documentation:  https://help.ubuntu.com
        * Management:     https://landscape.canonical.com
        * Support:        https://ubuntu.com/advantage

        * Overheard at KubeCon: "microk8s.status just blew my mind".

            https://microk8s.io/docs/commands#microk8s.status

        0 packages can be updated.
        0 updates are security updates.



        Welcome to Kafka on HDInsight.


        The programs included with the Ubuntu system are free software;
        the exact distribution terms for each program are described in the
        individual files in /usr/share/doc/*/copyright.

        Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
        applicable law.

        To run a command as administrator (user "root"), use "sudo <command>".
        See "man sudo_root" for details.
    ```
6.	Install [jq](https://stedolan.github.io/jq/), a command-line JSON processor. This utility is used to parse JSON documents, and is useful in parsing the host information. From the open SSH connection, enter following command to install `jq`:

    ```bash
    sudo apt -y install jq
    ```

7.	Set up password variable. Replace `PASSWORD` with the cluster login password, then enter the command:

    ```bash
    export password='PASSWORD'
    ```

8.	Extract the correctly cased cluster name. The actual casing of the cluster name may be different than you expect, depending on how the cluster was created. This command will obtain the actual casing, and then store it in a variable. Enter the following command:

    ```bash
    export clusterName=$(curl -u admin:$password -sS -G "http://headnodehost:8080/api/v1/clusters" | jq -r '.items[].Clusters.cluster_name')
	```

	This command has no response.

9.	To set an environment variable with Zookeeper host information, use the command below. The command retrieves all Zookeeper hosts, then returns only the first two entries. This is because you want some redundancy in case one host is unreachable.

    ```bash
    export KAFKAZKHOSTS=$(curl -sS -u admin:$password -G https://$clusterName.azurehdinsight.net/api/v1/clusters/$clusterName/services/ZOOKEEPER/components/ZOOKEEPER_SERVER | jq -r '["\(.host_components[].HostRoles.host_name):2181"] | join(",")' | cut -d',' -f1,2);
    ```

    > [!Note]  
    > This command requires Ambari access. If your cluster is behind an NSG, run this command from a machine that can access Ambari. 

    This command also has no response.

10.	To verify that the environment variable is set correctly, use the following command:

    ```bash
    echo $KAFKAZKHOSTS
    ```
    This command returns information similar to the following text:

    `zk0-kafka.eahjefxxp1netdbyklgqj5y1ud.ex.internal.cloudapp.net:2181,zk2-kafka.eahjefxxp1netdbyklgqj5y1ud.ex.internal.cloudapp.net:2181`

11.	To set an environment variable with Apache Kafka broker host information, use the following command:

    ```bash
    export KAFKABROKERS=$(curl -sS -u admin:$password -G https://$clusterName.azurehdinsight.net/api/v1/clusters/$clusterName/services/KAFKA/components/KAFKA_BROKER | jq -r '["\(.host_components[].HostRoles.host_name):9092"] | join(",")' | cut -d',' -f1,2);
    ```

    > [!Note]  
    > This command requires Ambari access. If your cluster is behind an NSG, run this command from a machine that can access Ambari. 

    This command has no output. 

12.	To verify that the environment variable is set correctly, use the following command:

    ```bash
    echo $KAFKABROKERS
    ```

   	 This command returns information similar to the following text:

    `wn1-kafka.eahjefxxp1netdbyklgqj5y1ud.cx.internal.cloudapp.net:9092,wn0-kafka.eahjefxxp1netdbyklgqj5y1ud.cx.internal.cloudapp.net:9092`

13.	Copy one of the Kafka broker values returned in the previous step into the python-producer-simulator-template.py file on line 19, and include single quotes around the value, for example:

    ```
    kafkaBrokers = ['wn1-kafka.eahjefxxp1netdbyklgqj5y1ud.cx.internal.cloudapp.net:9092']
    ```
14.	Save the python-producer-simulator-template-simulator-template.py file.

15.	Back in the ssh connection window, use the following command to create a topic. 
    ```
    /usr/hdp/current/kafka-broker/bin/kafka-topics.sh --create --replication-factor 3 --partitions 8 --topic stockVals --zookeeper $KAFKAZKHOSTS
    ```

This command connects to Zookeeper using the host information stored in $KAFKAZKHOSTS. It then creates an Apache Kafka topic named stockVals, to match the topic name in python-producer-simulator-template.py.


### Copy the python file to the head node and run the file to stream data


1.	In a new git window, navigate to the location of the python-producer-simulator-template.py file, and copy the file from your local computer to the primary head node using the following command. Replace `kafka-mslearn-stock` with the name of your Apache Kafka cluster, and note that you must include -ssh after the cluster name. 

    ```bash
    scp python-producer-simulator-template.py sshuser@kafka-mslearn-stock-ssh.azurehdinsight.net:
    ```

    When asked if you want to continue connecting, type yes. Then at the prompt, enter the password for the cluster. After the file transfers, the following output is displayed.

    ```bash
    python-producer-simulator-template.py    100% 1896    71.9KB/s   00:00
    ```

2.	Now switch back to the Azure command prompt where you retrieved the broker information and run the following command to install Kafka:

    ```
    sudo pip install kafka-python
    ```

    After the Kafka installs successfully, the following output is displayed.

    ```
    Installing collected packages: kafka-python
    Successfully installed kafka-python-1.4.7
    ```
3.	In the same window, install requests using the following command:

    ```bash
    sudo apt-get install python-requests
    ```

4.	When asked “After this operation, 4,327 kB of additional disk space will be used. Do you want to continue? [Y/n]” type y. 

    When requests installs successfully, output similar to the following is displayed.

    ```
    Setting up python-urllib3 (1.13.1-2ubuntu0.16.04.3) ...
    Setting up python-requests (2.9.1-3ubuntu0.1) ...
    ```

5.	In the same window, use the following command to run the python file

    ```
    python python-producer-simulator-template.py
    ```

    You should see output similar to the following:

    ```bash
    No loops argument provided. Default loops are 1000
    Running in simulated mode
    [
    {
        "symbol": "MSFT",
        "size": 355,
        "price": 147.205,
        "time": 1578029521022
    },
    {
        "symbol": "BA",
        "size": 345,
        "price": 352.607,
        "time": 1578029521022
    },
    {
        "symbol": "JNJ",
        "size": 58,
        "price": 142.043,
        "time": 1578029521022
    },
    {
        "symbol": "F",
        "size": 380,
        "price": 8.545,
        "time": 1578029521022
    },
    {
        "symbol": "TSLA",
        "size": 442,
        "price": 329.342,
        "time": 1578029521022
    },
    {
        "symbol": "BAC",
        "size": 167,
        "price": 32.921,
        "time": 1578029521022
    },
    {
        "symbol": "GE",
        "size": 222,
        "price": 11.115,
        "time": 1578029521022
    },
    {
        "symbol": "MMM",
        "size": 312,
        "price": 174.643,
        "time": 1578029521022
    },
    {
        "symbol": "INTC",
        "size": 483,
        "price": 54.978,
        "time": 1578029521022
    },
    {
        "symbol": "WMT",
        "size": 387,
        "price": 120.355,
        "time": 1578029521022
    }
    ]
    stockVals
    2
    0
    stockVals
    1
    0
    stockVals
    3
    0
    stockVals
    2
    1
    stockVals
    7
    0
    stockVals
    7
    1
    stockVals
    1
    1
    stockVals
    4
    0
    stockVals
    4
    1
    stockVals
    1
    2
    ```
This output provides the simulated stock prices for the stocks listed in the python-producer-simulated-template.py file, followed by the topic, partition, and offset of the message in the topic. You can see that each time the producer is triggered (every second), a new batch of stock prices is generated and each new message is added to a partition at a certain offset.