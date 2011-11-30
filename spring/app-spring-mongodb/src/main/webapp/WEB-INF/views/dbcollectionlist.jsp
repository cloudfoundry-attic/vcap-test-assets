<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Test Spring MongoDB</title>
    <link rel="stylesheet" href="static/css/main.css" type="text/css"></link>
    <link rel="stylesheet" href="static/css/colors.css" type="text/css"></link>
    <link rel="stylesheet" href="static/css/local.css" type="text/css"></link>
</head>
<body>
    <h1>Welcome to the spring mongodb Test</h1>
     <div>
        <a href="" title="Hello Spring MongoDB ${environmentName}" rel="home">Hello Spring MongoDB ${environmentName}</a>
     </div>

<p>Demonstration of using the 'cloud' namespace to create Spring beans backed by a MongoDB service bound to an application.</p>

<h2>The following services have been bound to this application:</h2>
<ul>
  <c:if test="${not empty services}">
    <c:forEach items="${services}" var="service">
        <li><p>${service}</p></li>
    </c:forEach>
  </c:if>
  <c:if test="${empty services}">
     <p>No Services found</p>
  </c:if>
</ul>
<h2>Previously, the number of items in the collection was:</h2>
<ul>
  <c:if test="${not empty previousItemCount}">
      <c:out value="${previousItemCount}"/></br>
  </c:if>
  <c:if test="${empty previousItemCount}">
     <p>No Previous Items found</p>
  </c:if>
</ul>
<h2>Currently, the updated number of items in the collection is:</h2>
<ul>
  <c:if test="${not empty updatedItemCount}">
      <c:out value="${updatedItemCount}"/></br>
  </c:if>
  <c:if test="${updatedItemCount <= previousItemCount}">
      <p>FAIL: Expected new Item count to be greater than previous item count</p>
      <c:out value="${updatedItemCount}"/></br>
  </c:if>
  <c:if test="${empty updatedItemCount}">
     <p>FAIL: No Current Items found</p>
  </c:if>
  <c:if test="${updatedItemCount >= previousItemCount}">
      <p>PASS: found new Items in collection</p>
      <c:out value="${updatedItemCount}"/></br>
  </c:if>
</ul>
<h2>The following Items have been stored in the database:</h2>
<ul>
  <c:if test="${not empty updatedItemCount}">
    <c:forEach items="${itemlist}" var="item">
        <li><p>${item}</p></li>
    </c:forEach>
  </c:if>
</ul>
</body>
</html>