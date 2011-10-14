<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>Attempt to add 5M of data to table</title>
</head>
<body>
    <h1>Database has just GROWN!!</h1>

    <h4>Database Info:</h4>
    DataSource: <c:out value="${dbInfo}"/></br>

    <h4>Previous ItemCount:</h4>
        <p>
                <c:out value="${previousItemCount}"/></br>
        </p>


    <h4>New ItemCount:</h4>
        <p>
                <c:out value="${fatterItemCount}"/></br>
        </p>
    <c:if test="${empty fatterItemCount}">
        <p>No Items found</p>
    </c:if>
</body>
</html>