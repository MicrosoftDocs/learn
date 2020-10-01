# Exercise Create JavaServer Faces Web App on Tomcat

You've been tasked with creating a simple Aapplication using the JavaServer Facess framework. The TODO application can add the new tasks and you can see the lists of all tasks and finaly you can mark the task as finished.
As part of that evaluation, you will build a web application and deploy it to Linux on Azure App Services Tomcat. 

## Create a Simple JSF Web app on Tomcat

下記の手順に従って JavaServer Faces の Web アプリケーションを構築し動作させます。

1. Maven プロジェクトの作成
1. Maven pom.xml ファイルの修正
1. Contexts and Dependency Injection (CDI) の有効化設定
1. JSF の有効化設定
1. index.jsp のファイル名を変更
1.   JSF Facelets の基本ページの作成
1.   JSF Backing Bean の作成
1.   ローカルの Tomcat 環境で実行

### 1. Maven プロジェクトの作成

下記のコマンドを実行してください。これにより Java Web アプリケーション用の Maven プロジェクトが作成されます。

   ```bash
   mvn archetype:generate \
   -DgroupId=com.microsoft.azure.samples \
   -DartifactId=azure-javaweb-app \
   -DarchetypeArtifactId=maven-archetype-webapp \
   -Dversion=1.0-SNAPSHOT \
   -DinteractiveMode=false
   ```

Maven プロジェクトを作成すると下記のファイルとディレクトリが作成されます。

   ```
├── pom.xml
└── src
    └── main
        ├── resources
        └── webapp
            ├── WEB-INF
            │   └── web.xml
            └── index.jsp
   ```

### 2. Maven pom.xml ファイルの修正

今回作成する Web アプリケーションは、JavaServer Faces を利用します。そこで JSF を利用するため、下記の依存ライブラリをプロジェクト内で利用できるようにします。

* Sevlet
* JavaServer Faces
* PrimeFaces
* Java Server Pages Tag Library (JSTL)
* Contexts and Dependency Injection (CDI) : Weld
* Bean Validation
* Jakarta JSON Binding
*  Lombok
*  JUnit

`pom.xml` ファイルを下記のように修正してください。  
コピー＆ペーストで全てを置き換えてください。

   ```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.microsoft.azure.samples</groupId>
  <artifactId>azure-javaweb-app</artifactId>
  <packaging>war</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>azure-javaweb-app Maven Webapp</name>
  <url>http://maven.apache.org</url>
  <properties>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
    <failOnMissingWebXml>false</failOnMissingWebXml>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
  </properties>
  <dependencies>
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>4.0.1</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>org.glassfish</groupId>
      <artifactId>javax.faces</artifactId>
      <version>2.4.0</version>
    </dependency>
    <dependency>
      <groupId>org.primefaces</groupId>
      <artifactId>primefaces</artifactId>
      <version>8.0</version>
    </dependency>
    <dependency>
      <groupId>org.jboss.weld.servlet</groupId>
      <artifactId>weld-servlet</artifactId>
      <version>2.4.8.Final</version>
    </dependency>
    <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <version>1.18.12</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.mockito</groupId>
      <artifactId>mockito-core</artifactId>
      <version>2.23.0</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <finalName>azure-javaweb-app</finalName>
  </build>
</project>
   ```

### 3. Contexts and Dependency Injection (CDI) の有効化設定

次に、Web アプリケーションで CDI を利用できるようにします。  
`src/main/WEB-INF` ディレクトリ配下に `beans.xml` を作成し下記の内容を記載してください。

   ```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://xmlns.jcp.org/xml/ns/javaee" 
　　xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
　　xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/beans_1_1.xsd" 
　　bean-discovery-mode="all"></beans>
   ```

### 4. JSF の有効化設定

次に、xhtml の拡張子を持つすべてのファイルを JSF の Facelets として認識するため、下記の設定を `WEB-INF` ディレクトリ配下にある `web.xml` に対して行ってください。

   ```
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="4.0" xmlns="http://xmlns.jcp.org/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd">

  <servlet>
    <servlet-name>Faces Servlet</servlet-name>
    <servlet-class>javax.faces.webapp.FacesServlet</servlet-class>
    <load-on-startup>1</load-on-startup>
  </servlet>

  <context-param>
    <param-name>primefaces.THEME</param-name>
    <param-value>nova-light</param-value>
  </context-param>

  <servlet-mapping>
    <servlet-name>Faces Servlet</servlet-name>
    <url-pattern>*.xhtml</url-pattern>
  </servlet-mapping>

  <welcome-file-list>
    <welcome-file>index.xhtml</welcome-file>
  </welcome-file-list>
</web-app>
   ```


### 5. index.jsp のファイル名を変更

JSF を動かすための環境設定が終わりましたので、これから実際に JSF のページを実装します。  
JSF の Web ページは上記の `web.xml` で設定したように、JSP ではなく XHTML ファイル形式で記述します。そこで、プロジェクト作成時に自動生成された `index.jsp` ファイル名を `index.xhtml` に変更してください。

   ```bash
mv index.jsp index.xhtml
   ```

### 6. JSF Facelets の基本ページの作成

`index.xhtml` に記載されている内容を一度すべて削除し、下記のコードをコピ＆ペーストで貼り付けてください。  

   ```xml
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:h="http://xmlns.jcp.org/jsf/html" xmlns:p="http://primefaces.org/ui">
<h:head>
    <title>Input Value Counter Sample</title>
</h:head>
<h:body>
    <h:form>
        <p:outputLabel value="Basic" /><br />
        <p:inputText value="#{indexcontroller.inputValue}" /><br />
        <p:commandButton update="ajaxUpdateText" value="Submit" action="#{indexcontroller.submitButtonAction()}" />
        <br />
        <p:outputLabel id="ajaxUpdateText" value="Input Value: #{indexcontroller.inputValue}" /><br />
    </h:form>
</h:body>

</html>
   ```


### 7. JSF Backing Bean の作成

次に、サーバ側のバックエンド処理を実装するためのバッキング・ビーンを作成します。  
バッキング・ビーンを作成するためのパッケージのディレクトリを `src/main` ディレクトリ配下に作成してください。

```bash
cd src/main
mkdir src/main/java
mkdir src/main/java/com
mkdir src/main/java/com/microsoft
mkdir src/main/java/com/microsoft/samples
```

次に `IndexController.java` ファイルを作成し、下記の JSF Backing Bean のコードをコピー＆ペーストしてください。

```java
package com.microsoft.samples;
import java.io.Serializable;

import javax.faces.view.ViewScoped;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;

@Named("indexcontroller")
@ViewScoped
public class IndexController implements Serializable{

	private static final long serialVersionUID = 8485377386286855408L;

	@Setter @Getter 
    private String inputValue;
    
    private int counter;
    
    public void submitButtonAction(){
        inputValue = inputValue + " : " + counter;
        counter++;
    }
}
```

上記で、プログラムの実装は完了です。  
プログラムを実装した後のディレクトリ構成は下記のようになります。

```
├── pom.xml
└── src
    └── main
        ├── java
        │   └── com
        │       └── microsoft
        │           └── samples
        │               └── IndexController.java
        ├── resources
        └── webapp
            ├── WEB-INF
            │   ├── beans.xml
            │   └── web.xml
            └── index.xhtml
```

### 8. ローカルの Tomcat 環境で実行

ソースコードをコンパイルし、ローカルにインストールした Tomcat の環境で実行します。  
下記のコマンドを実行してください。

#### 8.1 Compile and Package the Java Project

```bash
mvn clean package
```

#### 8.2 Copy the artifact to the Deployment Directory on Tomcat

```bash
cp target/azure-javaweb-app.war /$INSTALL_DIR/apache-tomcat-9.0.38/webapps/
```

#### 8.3 Start the Tomcat Server

```bash
$INSTALL_DIR/apache-tomcat-9.0.38/bin/startup.sh
```
Tomcat を実行した後、`http://localhost:8080/azure-javaweb-app/` にアクセスすると下記の画面が表示されます。

![JSF HelloWorld Page](../images/jsf-helloworld.png)

上記で、ローカルの Tomcat 環境で JSF の Web アプリケーションを実行できました。
