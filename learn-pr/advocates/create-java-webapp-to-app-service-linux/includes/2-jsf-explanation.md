

## What is JavaServer Faces(JSF)

JavaServer Faces (JSF) is a Java Based Web Application Framework. It is one of the technology in Java EE Platform Enterprise Edition (Java EE) specification.
JSF is Component Based application Framework. The state of the UI component is saved when the client requests a new page and is restored when a response to the request is returned. Initially, JSF used Java Server Pages (JSP) as its screen display technology, but since 2.0, Facelets, which is closer to ordinary HTML, has been used.


### JSF Basic Functionality

JSF applications are roughly divided into the following two functions.

- **Facelets** : Facelets is an XHTML-based template engine that describes screen layouts
- **BakingBean** : Java class that binds to Facelets and sets and processes values

`Facelets` is an XHTML-based template engine that describes screen layouts, written by XHTML. XHTML conforms to the Document Type Definition (DTD) defined in W3C and is described as a file with a xhtml extension.
JSF 2.3 is available for Jakarta EE 8 based applications.

`BackingBean` is a Java class that binds to the parameter of the Facelets and sets and processes values. In order to implement the back end process on the server side, it is necessary to implement Facelets and the corresponding backing bean.  
Until Java EE 6, it was used to implement the Backing Bean with JSF Managed Bean however it is used to create Backing Beaan with Contexts and Dependency Injection(CDI) since Java EE 7.

## Create JSF Page with PrimeFaces

JSF can create its own extended web components.
This time, we will use PrimeFaces as a component of JSF provided by 3rd Party to create rich web applications more easily.
To use PrimeFaces, write a dedicated XML namespace (`xmlns: p`) in XHTML as shown below. This makes the various UI components of PrimeFaces available.

In the example below, the `p:outputLabel`,` p:inputText`, and `p:commandButton` tags are used to display labels, input fields, and buttons, respectively.

```xml
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html" 
      xmlns:p="http://primefaces.org/ui" >
    <h:head>
        <title>Input Value Counter Sample</title>
    </h:head>
    <h:body>
        <h:form>
            <p:outputLabel value="Basic"/><br/>
            <p:inputText value="#{indexcontroller.inputValue}"/><br/>
            <p:commandButton value="Submit" action="#{indexcontroller.submitButtonAction()}"/><br/>
        </h:form>
    </h:body>
</html>
```

Writing the above XHTML code, the following screen will be displayed.

:::image type="content" source="../media/simple-jsf-facelets-primefaces-ajax.png" alt-text="JSF Facelets Sample":::

### PrimeFaces Ajax Support

JSF supports Ajax application creation by default. Therefore, it is possible to dynamically update a part of the screen without refreshing the screen.
PrimeFaces makes use of the `update` attribute to make it easier to implement the Ajax support provided by JSF. Specify which component should be update with the target ID. In the example below, the `update ="ajaxUpdateText"` attribute is added to `p:commandButton`, so the `<div id ="ajaxUpdateText">` part is updated when the button is pressed. The `id` specified here can be specified for any HTML component.

```xml
<div id="ajaxUpdateText">
...
</div>

<p:commandButton update="ajaxUpdateText" 
   value="Submit" action="#{indexcontroller.submitButtonAction()}"/>
```

## JSF Backing Bean

The backing bean is a Java class that implements the backend processing associated with the JSF View.
Here, we will create a backing bean (IndexController) corresponding to the above XHTML. `@Named` annotations can be used for configuring JavaServer Faces applications and it can be referenced from JSF Facelets (XHTML).

If you write `<p: inputText value ="#{indexcontroller.inputValue}"/>` in Facelets, the Input Text field will be displayed on the screen. The entered value is bound to the `inputValue` defined in the `IndexController` class.

Also, if you write `<p:commandButton value ="Submit" action="#{indexController.submitButtonAction()}"/>`, the HTML button will be displayed. When the button is pressed, it invoke the `submitButtonAction()` method defined in the `IndexController` class.

```java
import java.io.Serializable;

import javax.faces.view.ViewScoped;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;

@Named("indexcontroller")
@ViewScoped
public class IndexController implements Serializable {

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

In this way, JSF allows the View (Facelets) and Controller (Backing Bean) that make up the screen to be implemented separately.

## Additional resources

In addition to the above, JSF has many useful functions such as data validation and conversion, composite multiple components, template function, and support for Ajax and WebSocket.
For more information, please visit `http://www.javaserverfaces.org/`.
