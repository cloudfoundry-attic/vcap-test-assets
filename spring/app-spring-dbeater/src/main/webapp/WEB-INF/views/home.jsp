<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>CFQA Spring DBLimits Test</title>
</head>
<body>
    <h1>Welcome to the CFQA Spring DBLimits Test</h1>

    <h4>Database Info:</h4>
    DataSource: <c:out value="${dbInfo}"/></br>

    <h4>Current Items:</h4>
    <c:if test="${not empty items}">
        <p>
            <c:forEach var="item" items="${items}">
                <c:out value="${item}"/></br>
            </c:forEach>
        </p>
    </c:if>
    <c:if test="${empty items}">
        <p>No Items found</p>
    </c:if>
</body>
</html>