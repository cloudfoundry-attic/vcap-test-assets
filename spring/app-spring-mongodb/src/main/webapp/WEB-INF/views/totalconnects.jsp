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

<p>Attempting Max Connections for Mongo Service.</p>

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
<h2>The number of connections made was:</h2>
<ul>
  <c:if test="${not empty totalConnections}">
      <c:out value="${totalConnections}"/></br>
  </c:if>
  <c:if test="${empty totalConnections}">
     <p>FAIL: No Connections were made....</p>
  </c:if>
</ul>
</body>
</html>