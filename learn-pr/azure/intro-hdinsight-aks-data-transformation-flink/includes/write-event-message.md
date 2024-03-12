Apache Flink provides an [Apache Kafka Connector](https://nightlies.apache.org/flink/flink-docs-release-1.16/docs/connectors/datastream/kafka/) for reading data from and writing data to Kafka topics with exactly once guarantees. 

The purpose of the following demo is to read a stream of real-time events from a Kafka topic using Apache Flink and write the messages into Azure Data Lake Storage Gen2. 

## Prerequisites 

- [Apache Flink cluster on HDInsight on AKS](/azure/hdinsight-aks/flink/flink-create-cluster-portal) 

- [Apache Kafka cluster on HDInsight](/azure/hdinsight/kafka/apache-kafka-get-started) 

  - You're required to ensure the network settings taken care as described on [Using Apache Kafka on HDInsight](/azure/hdinsight-aks/flink/process-and-consume-data). That's to make sure HDInsight on AKS and HDInsight clusters are in the same Virtual Network 

- Use MSI to access ADLS Gen2 

- IntelliJ for development. You can also download this precompiled jar: [FlinkKafkaDemo-1.0.jar](https://microsofteur-my.sharepoint.com/:u:/g/personal/nasalvac_microsoft_com/ESntHn2ZultAil6RYzgZfAgBYTPYIQaFTuNQGNdM-u9KFg?e=GeBCv0)

 
### Create cluster

1. Create an HDInsight Kafka Cluster under the same vnet of the Apache Flink cluster. 

 

1. Create the flinkdemo topic. To create a topic, use the following commands: 

    ```
    export PASSWORD='<your password>’ 
  
    
  
    export CLUSTER_NAME=$(curl -u admin:$PASSWORD -sS -G "http://headnodehost:8080/api/v1/clusters" | jq -r '.items[].Clusters.cluster_name') 
  
    
  
    export KAFKABROKERS=$(curl -sS -u admin:$PASSWORD -G https://$CLUSTER_NAME.azurehdinsight.net/api/v1/clusters/$CLUSTER_NAME/services/KAFKA/components/KAFKA_BROKER | jq -r '["\(.host_components[].HostRoles.host_name):9092"] | join(",")' | cut -d',' -f1,2); 
  
      
  
    export KAFKAZKHOSTS=$(curl -sS -u admin:$PASSWORD -G https://$CLUSTER_NAME.azurehdinsight.net/api/v1/clusters/$CLUSTER_NAME/services/ZOOKEEPER/components/ZOOKEEPER_SERVER | jq -r '["\(.host_components[].HostRoles.host_name):2181"] | join(",")' | cut -d',' -f1,2); 
  
    
  
    /usr/hdp/current/kafka-broker/bin/kafka-topics.sh --create --replication-factor 3 --partitions 8 --topic flinkdemo --zookeeper $KAFKAZKHOSTS   
    ```
  
   

1. Write records to the flinkdemo topic using the kafka-console-producer.sh 

    ```
    /usr/hdp/current/kafka-broker/bin/kafka-console-producer.sh --broker-list $KAFKABROKERS --topic flinkdemo  
    ```

1. Create the Maven project `pom.xml` on IntelliJ IDEA 
    ```
    <?xml version="1.0" encoding="UTF-8"?> 
    <project xmlns="http://maven.apache.org/POM/4.0.0" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"> 
        <modelVersion>4.0.0</modelVersion> 
    
        <groupId>contoso.example</groupId> 
        <artifactId>FlinkKafkaDemo</artifactId> 
        <version>2.0</version> 
    <properties> 
        <maven.compiler.source>1.8</maven.compiler.source> 
        <maven.compiler.target>1.8</maven.compiler.target> 
        <flink.version>1.17.0</flink.version> 
        <java.version>1.8</java.version> 
        <scala.binary.version>2.12</scala.binary.version> 
        <kafka.version>3.2.0</kafka.version> 
    </properties> 
    <dependencies> 
    <dependency> 
        <groupId>org.apache.flink</groupId> 
        <artifactId>flink-java</artifactId> 
        <version>${flink.version}</version> 
    </dependency> 
    <!-- https://mvnrepository.com/artifact/org.apache.flink/flink-streaming-java --> 
    <dependency> 
        <groupId>org.apache.flink</groupId> 
        <artifactId>flink-streaming-java</artifactId> 
        <version>${flink.version}</version> 
    </dependency> 
    <!-- https://mvnrepository.com/artifact/org.apache.flink/flink-clients --> 
    <dependency> 
        <groupId>org.apache.flink</groupId> 
        <artifactId>flink-clients</artifactId> 
        <version>${flink.version}</version> 
    </dependency> 
    <!-- https://mvnrepository.com/artifact/org.apache.flink/flink-connector-files --> 
    <dependency> 
        <groupId>org.apache.flink</groupId> 
        <artifactId>flink-connector-files</artifactId> 
        <version>${flink.version}</version> 
    </dependency> 
    <dependency> 
        <groupId>org.apache.flink</groupId> 
        <artifactId>flink-connector-kafka</artifactId> 
        <version>1.17.0</version> 
    </dependency> 
    </dependencies> 
    <build> 
    <plugins> 
        <plugin> 
            <groupId>org.apache.maven.plugins</groupId> 
            <artifactId>maven-assembly-plugin</artifactId> 
            <version>3.0.0</version> 
            <configuration> 
                <appendAssemblyId>false</appendAssemblyId> 
                <descriptorRefs> 
                    <descriptorRef>jar-with-dependencies</descriptorRef> 
                </descriptorRefs> 
            </configuration> 
            <executions> 
                <execution> 
                    <id>make-assembly</id> 
                    <phase>package</phase> 
                    <goals> 
                        <goal>single</goal> 
                    </goals> 
                </execution> 
            </executions> 
        </plugin> 
    </plugins> 
    </build> 
    </project> 
  
    ```

 

1. Program for ADLS Gen2 Sink KafkaSinkToGen2.java 
    ```
    package contoso.example; 
    import org.apache.flink.api.common.eventtime.WatermarkStrategy; 
    import org.apache.flink.api.common.serialization.SimpleStringEncoder; 
    import org.apache.flink.api.common.serialization.SimpleStringSchema; 
    import org.apache.flink.configuration.MemorySize; 
    import org.apache.flink.connector.file.sink.FileSink; 
    import org.apache.flink.connector.kafka.source.KafkaSource; 
    import org.apache.flink.connector.kafka.source.enumerator.initializer.OffsetsInitializer; 
    import org.apache.flink.core.fs.Path; 
    import org.apache.flink.streaming.api.datastream.DataStream; 
    import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment; 
    import org.apache.flink.streaming.api.functions.sink.filesystem.rollingpolicies.DefaultRollingPolicy; 
    
    import java.time.Duration; 
    
    public class KafkaSinkToGen2 { 
        public static void main(String[] args) throws Exception { 
            // 1. get stream execution env 
            StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment(); 
    
            // 1. read kafka message as stream input 
            String brokers = "10.0.0.4:9092,10.0.0.5:9092,10.0.0.7:9092"; 
            KafkaSource<String> source = KafkaSource.<String>builder() 
                    .setBootstrapServers(brokers) 
                    .setTopics("flinkdemo") 
                    .setGroupId("flink-kafkademo") 
                    .setStartingOffsets(OffsetsInitializer.earliest()) 
                    .setValueOnlyDeserializer(new SimpleStringSchema()) 
                    .build(); 
    
            DataStream<String> stream = env.fromSource(source, WatermarkStrategy.noWatermarks(), "Kafka Source"); 
            stream.print(); 
    
            // 3. sink to gen2 
            String outputPath  = "abfs://data@flinkdemo.dfs.core.windows.net/gen2sink"; 
            final FileSink<String> sink = FileSink 
                    .forRowFormat(new Path(outputPath), new SimpleStringEncoder<String>("UTF-8")) 
                    .withRollingPolicy( 
                            DefaultRollingPolicy.builder() 
                                    .withRolloverInterval(Duration.ofMinutes(2)) 
                                    .withInactivityInterval(Duration.ofMinutes(3)) 
                                    .withMaxPartSize(MemorySize.ofMebiBytes(5)) 
                                    .build()) 
    
  
                    .build(); 
    
            stream.sinkTo(sink); 
    
            // 4. run stream 
            env.execute("Kafka Sink To Gen2"); 
        } 
    } 
  
    ```

 

   >[!Important]
   > You need to change the code to reflect your flink and kafka cluster versions, kafka broker IP addresses and ADLS Gen 2 account details. 

 

1. Package the jar using IntelliJ and submit it to the Apache Flink cluster in the **Submit New Job** tab of the Apache Flink UI. 
  
    :::image type="content" source="../media/package-jar.png" alt-text="Screenshot shows package the jar using IntelliJ and submit it." border="true" lightbox="../media/package-jar.png":::

1. To confirm your code is working, check the storage account.  

    :::image type="content" source="../media/storage-account.png" alt-text="Screenshot shows users can review the job information in the Completed Jobs tab." border="true" lightbox="../media/storage-account.png":::

 
