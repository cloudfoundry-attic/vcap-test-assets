<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>Checking Database Count</title>
</head>
<body>
    <h1>Checking Database Count</h1>

    <h4>Database Info:</h4>
    DataSource: <c:out value="${dbInfo}"/></br>

    <h4>Current ItemCount:</h4>
        <p>
                <c:out value="${currentItemCount}"/></br>
        </p>
    <c:if test="${not empty currentItemCount}">
        <p>PASS: ${currentItemCount} items found</p>
    </c:if>
    <c:if test="${empty currentItemCount}">
        <p>No Items found</p>
    </c:if>
</body>
</html>