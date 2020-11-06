You've been tasked with creating a simple Aapplication using the JavaServer Facess framework. 
The TODO application can add the new tasks and you can see the lists of all tasks and finally you can mark the task as finished.
As part of that evaluation, you will build a web application and deploy it to Linux on Azure App Services Tomcat.

:::image type="content" source="../media/primefaces-todo-list.png" alt-text="My ToDo List App":::

## Exercise Create Todo web app with PrimeFaces

Follow the steps below to build and run a JavaServer Faces web application.

1. Create JSF Web Page
1. Create DataModel Class
1. Create DAO Class
1. Create Controller Class
1. Run in local Tomcat environment

### Creating a JSF Web Page

Copy and paste the code below into the index.xhtml file to create a View for your Todo application.

This View uses the components of `p:layout`,`p:layoutUnit`, `p:outputLabel`,`p:inputText`, `p:commandButton`, and `p:dataTable` explained in the previous section.

This page support the Ajax, and when the button of `Add Task` is pressed, `p:dataTable id="itemTables"` of DataTable, which is the reference by `update ="itemTables"` of `p:commandButton`, will be updated.

We have also added a new attribute to the DataTable, `selection ="#{todocontroller.selectedItems}"`. This allows you to select items in the table with checkboxes, and you can complete the task by selecting the checkbox and pressing the `Update Task` button.

   ```xml
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://xmlns.jcp.org/jsf/core"
      xmlns:h="http://xmlns.jcp.org/jsf/html" xmlns:ui="http://xmlns.jcp.org/jsf/facelets"
      xmlns:p="http://primefaces.org/ui">

<h:head>
    <title>TODO App</title>
</h:head>
<h:body>

    <p:layout fullPage="true">
        <p:layoutUnit style="background-color: black; position: relative; height: 100px;" position="north" size="100"
                      resizable="false" closable="false" collapsible="true">
            <div class="header-task" style="margin: 50px; padding: 20px;">
                <p:outputLabel
                        style="color: #808080; font-size: 2em; position: absolute;top: 50%; -webkit-transform : translateY(-50%); transform : translateY(-50%);"
                        value="My Tasks"/>
            </div>
        </p:layoutUnit>

        <p:layoutUnit position="center">
            <h:form id="updateForm">
                <div class="task-lists" style="margin: 50px; padding: 20px;">
                    <p:outputLabel value="My ToDo List" style="font-size: 3em;"/>
                    <p/>

                    <p:dataTable id="itemTables" var="item" value="#{todocontroller.todoItems}"
                                 disabledSelection="#{item.complete == true}"
                                 selection="#{todocontroller.selectedItems}" rowKey="#{item.name}" paginator="true"
                                 paginatorPosition="bottom" rows="20">

                        <p:column headerText="Name">
                            <h:outputText value="#{item.name}"/>
                        </p:column>
                        <p:column headerText="Category">
                            <h:outputText value="#{item.category}"/>
                        </p:column>
                        <p:column headerText="Complete" selectionMode="multiple" style="text-align:center"/>
                    </p:dataTable>

                    <div class="updatataks" style="margin: 15px">
                        <p:commandButton value="Update Task" id="updatatask" update="itemTables"
                                         action="#{todocontroller.buttonUpdateAction()}" style="margin-right:20px;"
                                         styleClass="ui-priority-primary"/>
                    </div>
                </div>

                <hr style="margin: 50px;"/>

                <div class="task-add" style="margin: 50px; padding: 20px;">
                    <h:panelGrid columns="2" cellpadding="5">
                        <p:outputLabel style="font-size: 1.4em;" value="Task Name :"/>
                        <p:inputText style="font-size: 1.4em;" id="name" value="#{todocontroller.name}"/>


                        <p:outputLabel style="font-size: 1.4em;" value="Task Category : "/>
                        <p:inputText style="font-size: 1.4em;" id="category" value="#{todocontroller.category}"/>
                    </h:panelGrid>
                    <p/>
                    <p:commandButton update="itemTables" value="Add Task" id="addtask"
                                     action="#{todocontroller.buttonAddAction()}"
                                     style="margin-right:20px;" styleClass="ui-priority-primary"/>
                </div>
            </h:form>
        </p:layoutUnit>
    </p:layout>
</h:body>
</html>
   ```

### Create DataModel Class

First, we will implement the data model classes in the `com.microsoft.samples.model` package.
Execute the following command to create a directory for the package.

```bash
mkdir src/main/java/com/microsoft/samples/model
```

Then create a `TodoItem.java` file inside the` com.microsoft.samples.model` package directory and copy and paste the code below.

   ```java
package com.microsoft.samples.model;

import java.io.Serializable;
import lombok.Data;

@Data
public class TodoItem implements Serializable {

    private static final long serialVersionUID = -8967340396649549045L;
    private Long id;
    private String category;
    private String name;
    private boolean complete;

    public TodoItem() {}

    public TodoItem( String name, String category) {
        this.category = category;
        this.name = name;
        this.complete = false;
    }

    public TodoItem(String name, String category, boolean complete) {
        this.name = name;
        this.category = category;
        this.complete = complete;
    }

    @Override
    public String toString() {
        return String.format(
                "TodoItem[id=%d, category='%s', name='%s', complete='%b']",
                id, category, name, complete);
    }
}
   ```

### Create DAO Class

Then we implement the class for Data Access in the `com.microsoft.samples.dao` package.
Execute the following command to create a directory for the package.

```bash
mkdir src/main/java/com/microsoft/samples/dao
```

Next, create a `TodoItemManagement.java` file inside the `com.microsoft.samples.dao` package directory and copy and paste the code below.

Normally, we will store, updates and retrieve the data from DataBase, in-memory grids, document databases, and so on. However, in this time, in order to implement the application as easily as possible, it is completed in the program without external reference, so we will implement it in Java List.

This class is annotated with `@ApplicationScoped`. Since the scope is valid for the entire Application, the data of `todoItems` handled here will be available from the start to the end of the application.

```java
package com.microsoft.azure.samples.dao;

import com.microsoft.azure.samples.model.TodoItem;
import javax.enterprise.context.ApplicationScoped;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@ApplicationScoped
public class TodoItemManagement {

    private CopyOnWriteArrayList<TodoItem> todoItems  = new CopyOnWriteArrayList<TodoItem>();

    public  CopyOnWriteArrayList<TodoItem> getTodoItems() {
        return todoItems;
    }

    public  void setTodoItems(CopyOnWriteArrayList<TodoItem> todoItems) {
        this.todoItems = todoItems;
    }

    public void addTodoItem(TodoItem item) {
        synchronized (this){
            int size = todoItems.size();
            long id = 0;
            if(size != 0){
                id = todoItems.get(size - 1).getId();
                id++;
            }
            item.setId(id);
            todoItems.add(item);
        }
    }

    public void updateTodoItem(List<TodoItem> items){
        items.stream().forEach(item -> {
            item.setComplete(true);
            synchronized (this) {
                todoItems.set(item.getId().intValue(), item);
            }
        });
    }

}
```

### Create Controller Class

Finally, we will implement the class for the controller in the `com.microsoft.samples.controller` package.
Execute the following command to create a directory for the package.

```bash
mkdir src/main/java/com/microsoft/samples/controller
```

Next, create a `TodoListController.java` file inside the `com.microsoft.samples.controller` package directory and copy and paste the code below.

The annotations `@ViewScoped` and `@Named` are added to this class. `@ViewScoped` is useful for creating SPA web pages with a scope that is valid until the screen is reloaded or screen transitions occur. Also, by adding the `@Named` annotation, you can refer to this class from Facelets (XHTML) using EL expressions.

In the implementation, we use `@Inject` to inject an instance of `TodoItemManagement`. And it is used to add the data (`buttonAddAction()`), refer the data(`getTodoItems()`), and update the data (`buttonUpdateAction()`). Each methods for DAO is implemented in the `TodoItemManagement` class.

We also added the `selectedItem` and `selectedItems` fields to allow each row in the table to be selected, and the `onRowSelect(SelectEvent<TodoItem> event)` and `onRowUnselect(UnselectEvent <TodoItem> event)` methods.
Each method can act on the event when the table is selected or not selected. No particular processing is performed in this implementation, but if this method is not defined, a compile error will occur, so be sure to implement these two methods.

```java
package com.microsoft.azure.controller;

import com.microsoft.samples.dao.TodoItemManagement;
import com.microsoft.samples.model.TodoItem;
import org.primefaces.event.SelectEvent;
import org.primefaces.event.UnselectEvent;

import lombok.Getter;
import lombok.Setter;

import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.Serializable;
import java.util.List;

@Named("todocontroller")
@ViewScoped
public class TodoListController implements Serializable {

    private static final long serialVersionUID = -1945255472338540370L;

    @Inject
    TodoItemManagement todoManagement;

    private List<TodoItem> todoItems;
    @Setter @Getter
    private TodoItem selectedItem;
    @Setter @Getter
    private List<TodoItem> selectedItems;
    @Setter @Getter
    private String name;
    @Setter @Getter
    private String category;


    public List<TodoItem> getTodoItems() {
        return todoManagement.getTodoItems();
    }

    public void buttonUpdateAction(){
        todoManagement.updateTodoItem(selectedItems);
    }

    public void buttonAddAction(){
        TodoItem addItem = new TodoItem(name, category, false);
        todoManagement.addTodoItem(addItem);
    }

    public void onRowSelect(SelectEvent<TodoItem> event) {
        FacesMessage msg = new FacesMessage("TodoItem Selected", event.getObject().getId().toString());
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }

    public void onRowUnselect(UnselectEvent<TodoItem> event) {
        FacesMessage msg = new FacesMessage("Car Unselected", event.getObject().getId().toString());
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
}
```

### Compile and Package the Java Project

If you completes the implementation of the program above.
You can compile the program. And execute the following command.

```bash
mvn clean package
```

### Run in local Tomcat environment

This is optional excercise. If you already installed the Apache Tomcat in your local environment. You will be able to This is optional excercise. If you already installed the Apache Tomcat in your local environment. You will be able to proceed to the following step. If you don't have the local environment, please proceed to the Next section.

#### Copy the artifact to the Deployment Directory on Tomcat

```bash
cp target/azure-javaweb-app.war /$INSTALL_DIR/apache-tomcat-9.0.39/webapps/
```

#### Start the Tomcat Server

```bash
$INSTALL_DIR/apache-tomcat-9.0.39/bin/startup.sh
```

After running Tomcat, access `http://localhost:8080/azure-javaweb-app/` and you will see the screen below.
Use the `Add Task` button to add a task, or use the `Update Task` to update the task.

:::image type="content" source="../media/primefaces-todo-list.png" alt-text="My ToDo List App Done":::

You have successfully run the Todo web application implemented in PrimeFaces in your local Tomcat environment.
