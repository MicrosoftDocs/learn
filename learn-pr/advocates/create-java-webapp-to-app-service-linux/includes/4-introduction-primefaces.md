In this module, we'll create a `Todo` application and learn about its PrimeFaces components.

:::image type="content" source="../media/primefaces-todo-list.png" alt-text="My ToDo List App":::

## PrimeFaces Component in the Application

Let's look at the PrimeFaces components that we 'll use to create your Todo application.

### PrimeFaces Layout

`PrimeFaces Layout` creates a layout for the entire screen. PrimeFaces allows you to configure various layouts. For example, if you want to create headers, footers, menus that you often see in general web pages, you can easily configure the screen layout by using the `p:layout`, `p:layoutUnit` tags like below.
In the Todo Application, we'll use the `position="north"` and `position="center"` tags.

```xml
<p:layout fullPage="true">
    <p:layoutUnit position="north" size="50">
        <h:outputText value="Top content." />
    </p:layoutUnit>
    <p:layoutUnit position="south" size="100">
        <h:outputText value="Bottom content." />
    </p:layoutUnit>
    <p:layoutUnit position="west" size="300">
        <h:outputText value="Left content" />
    </p:layoutUnit>
    <p:layoutUnit position="east" size="200">
        <h:outputText value="Right Content" />
    </p:layoutUnit>
    <p:layoutUnit position="center">
        <h:outputText value="Center Content" />
    </p:layoutUnit>
</p:layout>
```

:::image type="content" source="../media/primeafces-layout.png" alt-text="PrimeFaces Layout":::

### PrimeFaces OutputLabel, InputText, CommandButton

In the next section we'll discuss the `p:outputLabel`,`p:inputText`, `p:commandButton` tags as show in the below example:

   ```xml
    <h:form>
        <p:outputLabel id="out" value="My Tasks" />
        <p:inputText id="name" value="#{todocontroller.name}" />
        <p:commandButton id="addtask" value="Add Task"  
            action="#{todocontroller.buttonAddAction()}"
            styleClass="ui-priority-primary" />
    </h:form>
   ```

#### p:outputLabel

`p:outputLabel` is a component for displaying text and is an extension of the standard outputLabel of JSF. Since `value ="My Tasks"` and a static character string are described here, `My Tasks` is also displayed on the screen, but if you want to change the character string to be outputted dynamically, you can replace it with the EL expression `#{todocontroller.name}` and binding it to the backing bean field as described in `p:inputText`.

#### p:inputText

`p:inputText` is a component for working with input text fields and extends the standard `inputText` component of JSF.
The EL expression `#{todocontroller.name}` binds the value to the field defined in the corresponding backing bean (TodoListController) class, and the value entered by the user can now be referenced by `name` from other code.

#### p:commandButton

`p:commandButton` is a component for displaying buttons and extends the standard `commandButton` component of JSF. When the button is pressed, the EL expression `#{todocontroller.buttonAddAction()` described in `action` is executed. Specifically, the `buttonAddAction()` method defined in the corresponding backing bean (TodoListController) class is invoked.
You can also execute the process with Ajax by adding `update=" target-id"` to the button's attribute.

#### Backing Beans for JSF pages

An implementation example of the Backing Bean corresponding to the above Facelets(XHTML) is shown below.
The content entered in `p:inputText` can be bound to `name` of instance field in the `TodoListController` class and handled in the program. Also, when a button is pressed with `p:commandButton`, then the `buttonAddAction()` method of the `TodoListController` class is invoked to print the value entered by the user in `name` on the standard output.

   ```java
import lombok.Getter;
import lombok.Setter;
import javax.faces.view.ViewScoped;
import javax.inject.Named;
import java.io.Serializable;

@Named("todocontroller")
@ViewScoped
public class TodoListController implements Serializable {

    @Setter @Getter
    private String name;

    public void buttonAddAction(){
        System.out.println("Input Value is " name);
        // write some command action
    }
}
   ```

After you create the XHTML and Backing Bean, the following screen will be displayed:

:::image type="content" source="../media/primeafces-in-out-button.png" alt-text="PrimeFaces Input Output Button":::

### PrimeFaces DataTable

`p:dataTable` is a component for displaying HTML tables, which is an extension of a standard JSF table. You can use the Paginator function by adding the `paginator` attribute. Here, the transition function of Paginator is placed at the bottom of the table and is set with `paginatorPosition="bottom"` attribute, and five items that can be displayed on the screen by default because we configured it with `rows="5"`.  

The display items in the table use `todoItems`, which is defined in the `TodoListController` class. You can refer each element in the List by using `var="item"`. For example, `#{item.name}` and `#{item.category}` are used to display each value of the `TodoItem` instance in the List.

```xml
    <h:form>
        <p:dataTable id="itemTables" var="item" 
            value="#{todocontroller.todoItems}" paginator="true"
            paginatorPosition="bottom" rows="5">

            <p:column headerText="Name">
                <h:outputText value="#{item.name}" />
            </p:column>
            <p:column headerText="Category">
                <h:outputText value="#{item.category}" />
            </p:column>

        </p:dataTable>
    </h:form>
```

The implementation example of the `TodoListController` class is described below.
In this example, the `@PostConstruct init()` method is used to generate dummy `List <TodoItem>` data when this instance is created.
In our code, dummy data is generated at startup, so it displays some contents by default.

```java
import com.microsoft.samples.model.TodoItem;
import lombok.Getter;
import lombok.Setter;
import javax.annotation.PostConstruct;
import javax.faces.view.ViewScoped;
import javax.inject.Named;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Named("todocontroller")
@ViewScoped
public class TodoListController implements Serializable {

    private static final long serialVersionUID = 8118071083254011575L;

    @Setter @Getter
    private List<TodoItem> todoItems;

    @PostConstruct
    public void init(){
        TodoItem item1 = new TodoItem("App Services","Azure",false);
        TodoItem item2 = new TodoItem("Azure Kubernetes Service","Azure",false);
        TodoItem item3 = new TodoItem("JEP 359","Java",false);
        TodoItem item4 = new TodoItem("JEP 368","Java",false);
        TodoItem item5 = new TodoItem("MicroProfile","Java",false);
        TodoItem item6 = new TodoItem("Spring Boot","Java",false);
        TodoItem item7 = new TodoItem("Jakarta EE","Java",false);

        todoItems = new ArrayList<>();
        todoItems.add(item1);
        todoItems.add(item2);
        todoItems.add(item3);
        todoItems.add(item4);
        todoItems.add(item5);
        todoItems.add(item6);
        todoItems.add(item7);
    }
}
```

The implementation of the `TodoItem` class is described below.
We'll use this class to manage the display of data.
We use the `@Data` annotation of `Project Lombok`, so our Setter/Getter method is automatically added for all fields and `toString()`, `equals (Object o)`, and `hashCode()` methods will be overridden by default.

```java
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

    public TodoItem(String name, String category, boolean complete) {
        this.name = name;
        this.category = category;
        this.complete = complete;
    }

    public TodoItem( String name, String category) {
        this.category = category;
        this.name = name;
        this.complete = false;
    }

    @Override
    public String toString() {
        return String.format(
                "TodoItem[id=%d, category='%s', name='%s', complete='%b']",
                id, category, name, complete);
    }
}
```

After you execute the above DataTable, the following screen will be displayed:

:::image type="content" source="../media/primefaces-datatable.png" alt-text="PrimeFaces DataTable":::

In this section, we discussed how to use PrimeFaces Components.  
In the next section, we'll create your `Todo` Application by using the above PrimeFaces components.
