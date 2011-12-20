<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>Attempt to delete rows from table</title>
</head>
<body>
   <h1>Database has just SLIMMED DOWN!!</h1>

   <h4>Database Info:</h4>
   DataSource: <c:out value="${dbInfo}"/></br>

   <h4>Previous ItemCount:</h4>
       <p>
           <c:out value="${previousItemCount}"/></br>
       </p>

   <h4>New Slimmer ItemCount:</h4>
   <c:if test="${empty updatedItemCount}">
       <p>No Items found</p>
   </c:if>
   <c:if test="${updatedItemCount > previousItemCount}">
       <p>FAIL: Expected new current_items count to be lesser than previous current_items count</p>
       <c:out value="${updatedItemCount}"/></br>
   </c:if>
   <c:if test="${updatedItemCount <= previousItemCount}">
       <p>PASS: found fewer or equal number of items in current_items table</p>
       <c:out value="${updatedItemCount}"/></br>
   </c:if>
</body>
</html>