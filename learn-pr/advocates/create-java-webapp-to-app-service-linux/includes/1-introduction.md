# Introduction

Java は誕生依頼様々な環境で動作してきました。特に、サーバ・サイドで Java は幅広く多くの場所で使われてきました。これに併せて、Java Web アプリケーションのフレーム・ワークも様々提供されてきました。たとえば JavaServer Pages(JSP)、Java Servlet, Struts, JavaServer Faces(JSF), Spring MVC のような Web フレームワークが今まで数多く提供されてきました。また実行環境として、Apache Tomcat は、1998年11月にプロジェクトを開始し、 Servlet, JSP の参照実装かつ OSS として提供され、多くの利用者から使われてきました。

このモジュールは、簡単な Java Web アプリケーションとして、Todo アプリケーションを作成し、Azure App Service 上で動かします。
Todo アプリケーションは、MVC フレームワークとして JSF を利用し、内部実装では PrimeFaces を利用します。  
JSF はコンポーネント・ベースのフレームワークで  Java の Web アプリケーションを作成する事ができます。
PrimeFaces は JSF の拡張 UI コンポーネントを提供し、これを利用する事でより簡単に Single Page Application (SPA) など Ajax に対応したリッチな画面を作成する事ができます。

![Java Todo Application Sample](../media/primefaces-todo-list.png)


## Learning objectives(学習の目的)

By the end of this module, you’ll be able to:

- Java(JSF) Web Application の作成
- JSF アプリケーションを Tomcat で稼働
- Azure App Services の Tomcat でアプリケーションを稼働

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=java-9121-yoterada) installed on your computer
- [JDK 11](https://docs.microsoft.com/azure/developer/java/fundamentals/java-jdk-long-term-support) and [Tomcat 9.0.x](https://tomcat.apache.org/download-90.cgi) installed on your computer
- Familiarity with editing text and code files in any text editor
- Basic familiarity with the HTTP protocol
