<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>Database tables may have been Modified!</title>
</head>
<body>
    <h1>Database tables may have been Modified!!</h1>

    <h4>Database Info:</h4>
    DataSource: <c:out value="${dbInfo}"/></br>

    <h4>Could we modify db tables?</h4>
        <p>
                <c:out value="${itemExists}"/></br>
        </p>

    <c:if test="${not empty allTables}">
        <p>
            <c:forEach var="table" items="${allTables}">
                <c:out value="${table}"/></br>
            </c:forEach>
        </p>
    </c:if>
    <c:if test="${empty allTables}">
        <p>No Tables found</p>
    </c:if>
</body>
</html>