<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>JPA based Guestbook</title>
    </head>

    <body>
	<h3>Sign in</h3>
        <form method="POST" action="guest.html">
            Name: <input type="text" name="name" />
            <input type="submit" value="Add" />
        </form>

        <hr />
	<h3>Guests signed in</h3>
        <ol name="Guests">
            <c:forEach items="${guests}" var="guest">
              <li><p>${guest}</p></li>
            </c:forEach>
        </ol>
        <hr />
     </body>
 </html>
