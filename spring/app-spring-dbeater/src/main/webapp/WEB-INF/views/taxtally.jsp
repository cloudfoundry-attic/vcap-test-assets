<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>Create a new DB VIEW</title>
</head>
<body>
    <h1>Create a new DB VIEW</h1>

    <h4>Database Info:</h4>
    DataSource: <c:out value="${dbInfo}"/></br>

    <h4>Current TaxItems:</h4>
    <c:if test="${not empty taxItems}">
        <p>
            <c:forEach var="taxItem" items="${taxItems}">
                <c:out value="${taxItem}"/></br>
            </c:forEach>
        </p>
    </c:if>
    <c:if test="${empty taxItems}">
        <p>No TaxItems found</p>
    </c:if>
</body>
</html>